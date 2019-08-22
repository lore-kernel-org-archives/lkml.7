Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921F6C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 03:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCE221848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 03:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfHVDsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 23:48:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:55579 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbfHVDsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 23:48:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 20:48:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,415,1559545200"; 
   d="scan'208";a="180245773"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 21 Aug 2019 20:48:16 -0700
Received: from [10.226.38.83] (rtanwar-mobl.gar.corp.intel.com [10.226.38.83])
        by linux.intel.com (Postfix) with ESMTP id 2D8B4580258;
        Wed, 21 Aug 2019 20:48:09 -0700 (PDT)
Subject: Re: [PATCH] x86/apic: Update virtual irq base for DT/OF based system
 as well
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tony.luck@intel.com,
        x86@kernel.org, alan@linux.intel.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
References: <20190821081330.1187-1-rahul.tanwar@linux.intel.com>
 <alpine.DEB.2.21.1908211028030.2223@nanos.tec.linutronix.de>
 <7b4db9f3-21da-5b5e-e219-0170e812a015@linux.intel.com>
 <alpine.DEB.2.21.1908211235180.2223@nanos.tec.linutronix.de>
 <20190821123451.GY30120@smile.fi.intel.com>
 <alpine.DEB.2.21.1908211510390.2223@nanos.tec.linutronix.de>
 <20190821164738.GA30120@smile.fi.intel.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <140d2be4-6e26-5e4a-e2f1-689fb47e85fd@linux.intel.com>
Date:   Thu, 22 Aug 2019 11:48:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190821164738.GA30120@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

On 22/8/2019 12:47 AM, Andy Shevchenko wrote:
>> For DT we can actually avoid that completely. See below.
>>
>> For ACPI not unfortunately as the stupid GSI mapping is hard coded.
> The below works better for my case, so, if you are going with that
> Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
>
> 8<-------------
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -2438,7 +2438,13 @@ unsigned int arch_dynirq_lower_bound(uns
>   	 * dmar_alloc_hwirq() may be called before setup_IO_APIC(), so use
>   	 * gsi_top if ioapic_dynirq_base hasn't been initialized yet.
>   	 */
> -	return ioapic_initialized ? ioapic_dynirq_base : gsi_top;
> +	if (!ioapic_initialized)
> +		return gsi_top;
> +	/*
> +	 * For DT enabled machines ioapic_dynirq_base is irrelevant and not
> +	 * updated. So simply return @from if ioapic_dynirq_base == 0.
> +	 */
> +	return ioapic_dynirq_base ? : from;
>   }
>   
>   #ifdef CONFIG_X86_32


I have also tested above and it works fine. In fact, my first patch to

resolve it during internal review was exactly on similar lines. So if

you are going to add above then i will stop following up on this

topic further. Thanks.


Regards,

Rahul

