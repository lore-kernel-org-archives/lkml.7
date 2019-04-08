Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E07C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7864D20879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 03:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDHDiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 23:38:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:46469 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfDHDiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 23:38:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Apr 2019 20:38:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,323,1549958400"; 
   d="scan'208";a="147375917"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Apr 2019 20:38:19 -0700
Subject: Re: [RFC PATCH v2 1/3] arch/x86: add the support of ACRN guest
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Jason Chen CJ <jason.cj.chen@intel.com>
References: <1553576023-6434-1-git-send-email-yakui.zhao@intel.com>
 <1553576023-6434-2-git-send-email-yakui.zhao@intel.com>
 <alpine.DEB.2.21.1904052051330.1802@nanos.tec.linutronix.de>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <2b46c1d6-b578-d105-2e61-8b7ec88232ed@intel.com>
Date:   Mon, 8 Apr 2019 11:36:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904052051330.1802@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月06日 03:01, Thomas Gleixner wrote:
> Zhao,
> 
> On Tue, 26 Mar 2019, Zhao Yakui wrote:
> 
> Vs. the Subject line: arch/x86: add the support of ACRN guest
> 
> The proper prefix for x86 is surprisingly 'x86:' not 'arch/x86:'. Also
> please start the first word after the colon with an upper case letter.
> 
>> ACRN is one open-source hypervisour, which is maintained by Linux
> 
> s/one/an/
> 
>> foundation.
> 
> by the Linuxfoundation.
> 
>> This is to add the para-virtualization support so that
>> it allows the Linux guest to run on acrn-hypervisor.
>>
>> This adds x86_hyper_acrn into supported hypervisors array, which enables
>> Linux ACRN guest running on ACRN hypervisor. It is restricted to X86_64.
> 
> Please do not use 'This is to add' or 'This adds'. Just say:
> 
> Add ....
>   
>> v1->v2: Change the CONFIG_ACRN to CONFIG_ACRN_GUEST, which makes it easy to
>> understand.
>>          Remove the export of x86_hyper_acrn.
> 
> Thanks for having the version changes documented, but please put them after
> the '---' line below and add another '---' before the diffstat. These
> changes are not part of the final change log and if they are below then I
> don't have to strip them manually.
> 

Sure.
It will be updated.

>> Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
>> Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
>> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
>> ---
>>   arch/x86/Kconfig                  |  8 ++++++++
>>   arch/x86/include/asm/hypervisor.h |  1 +
>>   arch/x86/kernel/cpu/Makefile      |  1 +
>>   arch/x86/kernel/cpu/acrn.c        | 35 +++++++++++++++++++++++++++++++++++
>>   arch/x86/kernel/cpu/hypervisor.c  |  4 ++++
>>   5 files changed, 49 insertions(+)
>>   create mode 100644 arch/x86/kernel/cpu/acrn.c
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index c1f9b3c..d73225e 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -842,6 +842,14 @@ config JAILHOUSE_GUEST
>>   	  cell. You can leave this option disabled if you only want to start
>>   	  Jailhouse and run Linux afterwards in the root cell.
>>   
>> +config ACRN_GUEST
>> +	bool "ACRN Guest support"
>> +	depends on X86_64 && PARAVIRT
> 
> Why does this select PARAVIRT? The current patches are not implementing
> anything of the paravirt functionality. Which part of paravirtualization
> are you going to provide?

Thanks for your nice and careful review.
Yes. The CONFIG_PARAVIRT is not required.
It will be removed.

> 
> Thanks,
> 
> 	tglx
> 
