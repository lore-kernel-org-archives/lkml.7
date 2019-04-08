Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5A0C282DE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEA8208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDHDe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 23:34:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:8355 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfDHDe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 23:34:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Apr 2019 20:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,323,1549958400"; 
   d="scan'208";a="147375363"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Apr 2019 20:34:56 -0700
Subject: Re: [RFC PATCH v2 2/3] arch/x86/acrn: Use HYPERVISOR_CALLBACK_VECTOR
 for Acrn upcall vector
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Jason Chen CJ <jason.cj.chen@intel.com>
References: <1553576023-6434-1-git-send-email-yakui.zhao@intel.com>
 <1553576023-6434-3-git-send-email-yakui.zhao@intel.com>
 <alpine.DEB.2.21.1904052101270.1802@nanos.tec.linutronix.de>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <349e2fb7-9ce8-c1c3-a9a0-a83d0ea857fa@intel.com>
Date:   Mon, 8 Apr 2019 11:33:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904052101270.1802@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月06日 03:07, Thomas Gleixner wrote:
> On Tue, 26 Mar 2019, Zhao Yakui wrote:
>> diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
>> index d9069bb..a8f4d08 100644
>> --- a/arch/x86/include/asm/hardirq.h
>> +++ b/arch/x86/include/asm/hardirq.h
>> @@ -37,7 +37,8 @@ typedef struct {
>>   #ifdef CONFIG_X86_MCE_AMD
>>   	unsigned int irq_deferred_error_count;
>>   #endif
>> -#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN)
>> +#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN) ||\
>> +		defined(CONFIG_ACRN_GUEST)
> 
> ..
> 
>> @@ -134,7 +134,8 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>>   		seq_printf(p, "%10u ", per_cpu(mce_poll_count, j));
>>   	seq_puts(p, "  Machine check polls\n");
>>   #endif
>> -#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN)
>> +#if IS_ENABLED(CONFIG_HYPERV) || defined(CONFIG_XEN) ||\
>> +		defined(CONFIG_ACRN_GUEST)
>>   	if (test_bit(HYPERVISOR_CALLBACK_VECTOR, system_vectors)) {
>>   		seq_printf(p, "%*s: ", prec, "HYP");
>>   		for_each_online_cpu(j)
> 
> This starts to become unreadable. Please create a new config symbol:
> 
>       config X86_HV_CALLBACK_VECTOR
>       	def_bool
> 
> and select if from HYPERV, XEN and your new thing. That wants to be a
> separate preparatory patch at the beginning of the series please.

Thanks for the suggestion.
Sure. One new config will be added in next version.


> 
> Thanks,
> 
> 	tglx
> 
