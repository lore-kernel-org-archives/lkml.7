Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B13C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FF720C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437294AbfHIQUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:20:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:33507 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437153AbfHIQUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:20:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 09:20:15 -0700
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="203968184"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.6.227]) ([10.251.6.227])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/AES256-SHA; 09 Aug 2019 09:20:14 -0700
Subject: Re: [PATCH V2 09/10] x86/resctrl: Pseudo-lock portions of multiple
 resources
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <c0095fd15488d87be06deddf43abb4a2834dc7e6.1564504902.git.reinette.chatre@intel.com>
 <20190807152511.GB24328@zn.tnic>
 <e9145623-bf5a-b96c-d802-7b61caa406e0@intel.com>
 <20190808084416.GC20745@zn.tnic>
 <a69981df-80f5-d8cf-e118-2ee639dcdb77@intel.com>
 <20190809073807.GC2152@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <cdfbc993-6e73-5045-518f-51be2172675d@intel.com>
Date:   Fri, 9 Aug 2019 09:20:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809073807.GC2152@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 8/9/2019 12:38 AM, Borislav Petkov wrote:
> On Thu, Aug 08, 2019 at 01:13:46PM -0700, Reinette Chatre wrote:
>> There is a locking order dependency between cpu_hotplug_lock and
>> rdtgroup_mutex (cpu_hotplug_lock before rdtgroup_mutex) that has to be
>> maintained. To do so in this flow you will find cpus_read_lock() in
>> rdtgroup_schemata_write(), so quite a distance from where it is needed.
>>
>> Perhaps I should add a comment at the location where the lock is
>> required to document where the lock is obtained?
> 
> Even better - you can add:
> 
> 	lockdep_assert_cpus_held();
> 
> above it which documents *and* checks too. :-)
> 

Will do.

Thank you

Reinette
