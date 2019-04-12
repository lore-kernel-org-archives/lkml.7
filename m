Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97714C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A00C20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfDLAid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 20:38:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:43293 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbfDLAid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 20:38:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 17:38:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,339,1549958400"; 
   d="scan'208";a="135075776"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2019 17:38:31 -0700
Subject: Re: [RFC PATCH v3 2/4] x86: Add the support of ACRN guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        Jason Chen CJ <jason.cj.chen@intel.com>
References: <1554711131-21514-1-git-send-email-yakui.zhao@intel.com>
 <1554711131-21514-3-git-send-email-yakui.zhao@intel.com>
 <20190408143952.GF15689@zn.tnic>
 <ab54d5a4-4f4c-9401-2e98-f0ac09d023b1@intel.com>
 <20190411134900.GG30080@zn.tnic>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <222b3a4a-6706-ed11-a8cf-9e6f516cc7fe@intel.com>
Date:   Fri, 12 Apr 2019 08:36:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190411134900.GG30080@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月11日 21:49, Borislav Petkov wrote:
> On Wed, Apr 10, 2019 at 05:15:48PM +0800, Zhao, Yakui wrote:
>> Currently the x2apic is not enabled in the first step.
>> Next step it needs to check the cpu info reported by ACRN hypervisor to
>> determine whether the x2apic should be supported.
> 
> What "cpu info"? CPUID or something ACRN-specific?

It is based on CPUID.
The low-level ACRN hypervisor can return the different output of CPUID 
when several linux guests executes the CPUID instruction. Then it can 
control whether x2apic is supported in one linux guest.

So we will leverage the X86_FEATURE_X2APIC bit from CPUID to indicate 
whether the x2apic is supported in linux guest when ACRN hypervisor is 
detected.
Is this fine to you?

Thanks
> 
