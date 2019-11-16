Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699E1C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC8921823
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbfKPQN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:13:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:22745 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbfKPQNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 11:13:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2019 08:13:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,312,1569308400"; 
   d="scan'208";a="214979599"
Received: from xshen14-mobl.ccr.corp.intel.com (HELO [10.254.215.65]) ([10.254.215.65])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2019 08:13:21 -0800
Subject: Re: [PATCH] x86/resctrl: Fix potential lockdep warning
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        Xiaochen Shen <xiaochen.shen@intel.com>
References: <1573079796-11713-1-git-send-email-xiaochen.shen@intel.com>
 <20191113114334.GA1647@zn.tnic>
From:   Xiaochen Shen <xiaochen.shen@intel.com>
Message-ID: <ec0f21ce-17a8-5038-4e69-565a28ca041d@intel.com>
Date:   Sun, 17 Nov 2019 00:13:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20191113114334.GA1647@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Thank you for your kind code review. Please find my comments inline.

On 11/13/2019 19:44, Borislav Petkov wrote:
> On Thu, Nov 07, 2019 at 06:36:36AM +0800, Xiaochen Shen wrote:
>> rdtgroup_cpus_write() and mkdir_rdt_prepare() call
>> rdtgroup_kn_lock_live() -> kernfs_to_rdtgroup() to get 'rdtgrp', and
>> then call rdt_last_cmd_xxx() functions which will check if
> 
> Write those names like this:
> 
> rdt_last_cmd_{clear,puts,...} but not with an "xxx" which confuses
> people unfamiliar with the code.

OK. I got it. rdt_last_cmd_{clear,puts,printf}().

> 
>> rdtgroup_mutex is held/requires its caller to hold rdtgroup_mutex.
>> But if 'rdtgrp' returned from kernfs_to_rdtgroup() is NULL,
>> rdtgroup_mutex is not held and calling rdt_last_cmd_xxx() will result
>> in a lockdep warning.
> 
> That's more of a self-incurred lockdep warning. You can't be calling
> lockdep_assert_held() after a function which doesn't always grab the
> mutex. Looks like the design needs changing here...

Actually this fix covers all the cases of an audit of the calling paths
of rdt_last_cmd_{clear,puts,printf}(), to make sure we only have the
lockdep_assert_held() in places where we are sure that it must be held.
Please find more background details as below.

> 
>> Remove rdt_last_cmd_xxx() in these two paths. Just returning error
>> should be sufficient to report to the user that the entry doesn't exist
>> any more.
> 
> ... or that.
> 
> In any case, you should consider fixing such patterns in the code as it
> looks sub-optimal from where I'm standing.

I would like to provide more of the background details in the commit
comment in v2 patch:

-------------------
x86/resctrl: Fix potential lockdep warning

rdt_last_cmd_{clear,puts,printf}() call lockdep_assert_held() to assert
that rdtgroup_mutex is held.

During internal review of some other changes we found that there are
code paths that call rdt_last_cmd_{clear,puts}() when the rdtgroup_mutex
is not held.

An audit of calling sequences identified two different cases in
rdtgroup_kn_lock_live() which both returning NULL:
1.'rdtgrp' returned from kernfs_to_rdtgroup() is NULL, rdtgroup_mutex
is not held.
2.'rdtgrp' is being deleted, rdtgroup_mutex is held.

Checking all call sites of rdt_last_cmd_{clear,puts,printf}() found two
code paths where rdtgroup_mutex is not held: rdtgroup_cpus_write() and
mkdir_rdt_prepare().

Fix by removing rdt_last_cmd_{clear,puts}() in these two paths. Just
returning error should be sufficient to report to the user that the
entry doesn't exist any more.

Fixes: 94457b36e8a5 ("x86/intel_rdt: Add diagnostics when writing the 
cpus file")
Fixes: cfd0f34e4cd5 ("x86/intel_rdt: Add diagnostics when making 
directories")
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
-------------------
Updated commit comment to provide additional context on how these were
found.

> 
> Thx.
> 

-- 
Best regards,
Xiaochen
