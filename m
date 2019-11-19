Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E3BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 07:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A14421850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 07:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfKSHov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 02:44:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:21883 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfKSHov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 02:44:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 23:44:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="289520851"
Received: from xshen14-mobl.ccr.corp.intel.com (HELO [10.238.129.70]) ([10.238.129.70])
  by orsmga001.jf.intel.com with ESMTP; 18 Nov 2019 23:44:47 -0800
Subject: Re: [PATCH] x86/resctrl: Fix potential lockdep warning
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        Xiaochen Shen <xiaochen.shen@intel.com>
References: <1573079796-11713-1-git-send-email-xiaochen.shen@intel.com>
 <20191113114334.GA1647@zn.tnic>
 <ec0f21ce-17a8-5038-4e69-565a28ca041d@intel.com>
 <20191118150240.GF6363@zn.tnic>
From:   Xiaochen Shen <xiaochen.shen@intel.com>
Message-ID: <d986fe19-29ab-a6c9-b3c8-96e95a7fba4e@intel.com>
Date:   Tue, 19 Nov 2019 15:44:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20191118150240.GF6363@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/2019 23:02, Borislav Petkov wrote:
> On Sun, Nov 17, 2019 at 12:13:20AM +0800, Xiaochen Shen wrote:
>> Actually this fix covers all the cases of an audit of the calling paths
>> of rdt_last_cmd_{clear,puts,printf}(), to make sure we only have the
>> lockdep_assert_held() in places where we are sure that it must be held.
> 
> That's kinda what I suggested, isn't it?
> 
> All I meant was, not to have a
> 
> 	rdtgroup_kn_lock_live()
> 
> call in the code as this function does *not* unconditionally grab the
> rdtgroup_mutex. And then call a function which unconditionally checks
> whether the mutex is held.
> 

Hi Boris,

Thank you for your good suggestion. I will try to follow up if we could 
improve the code in call sites of rdtgroup_kn_lock_live() in separate patch.

In my opinion, the potential lockdep issues in all call sites of 
rdt_last_cmd_{clear,puts,...}() have been fixed in this patch.

Thank you.

-- 
Best regards,
Xiaochen
