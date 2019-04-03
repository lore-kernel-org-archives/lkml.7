Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB37C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF772147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfDCHac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:30:32 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18868 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725936AbfDCHac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:30:32 -0400
X-IronPort-AV: E=Sophos;i="5.60,303,1549900800"; 
   d="scan'208";a="58369011"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Apr 2019 15:30:29 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 3E5CE4C8B03D;
        Wed,  3 Apr 2019 15:30:28 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 3 Apr 2019 15:30:31 +0800
Date:   Wed, 3 Apr 2019 15:30:23 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Dave Young <dyoung@redhat.com>
CC:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Borislav Petkov <bp@alien8.de>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190403073023.GF1555@localhost.localdomain>
References: <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402120319.GA7605@dhcp-128-65.nay.redhat.com>
 <20190403053459.GD1555@localhost.localdomain>
 <20190403055340.GA11976@dhcp-128-65.nay.redhat.com>
 <20190403063911.GA2579@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190403063911.GA2579@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 3E5CE4C8B03D.ADED7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 02:39:11PM +0800, Dave Young wrote:
>> Actually I got some different kexec test results.
>> 
>> Yesterday, with my installed kernel (based on git head several weeks
>> ago), kexec kernel panics.
>> 
>> Then I tried latest mainline with git pull, everything works, (with or
>> without the patch, and can not reproduce the bug this patch is fixing)
>> 
>> Today, test again, kexec reboot hangs (with or without your patch), but
>> kdump works always (with or without the patch)
>> 
>> It is weird to me. Probably I need find out why I can not reproduce the
>> bug this patch is addressing first.
>> 
>> earlyprintk seems not working for me anymore, it is not easy to debug on
>> laptop now.
>> 
>> But the patch itself is clear, I think it should be good.  There might be
>> other things broken.
>
>Disable your immovable mem code then everything works for me.  There
>might be something wrong in the code.  Also "nokaslr" does not help, it
>should be another problem 

If "nokaslr" doesn't help, so I think
>+      /*num_immovable_mem = count_immovable_mem_regions();*/
also doesn't help. I think the problem is from get_rsdp_addr().

You test it in your laptop, I only tested in Qemu guest.
I have no laptop avaliable, so I will look for a physical machine
to test it.

Thanks,
Chao Fan

>
>diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
>index 2e53c056ba20..e760c9159662 100644
>--- a/arch/x86/boot/compressed/kaslr.c
>+++ b/arch/x86/boot/compressed/kaslr.c
>@@ -416,7 +416,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
> 	handle_mem_options();
> 
> 	/* Enumerate the immovable memory regions */
>-	num_immovable_mem = count_immovable_mem_regions();
>+	/*num_immovable_mem = count_immovable_mem_regions();*/
> 
> #ifdef CONFIG_X86_VERBOSE_BOOTUP
> 	/* Make sure video RAM can be used. */
>diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
>index c0d6c560df69..1bc6f46d3aa7 100644
>--- a/arch/x86/boot/compressed/misc.c
>+++ b/arch/x86/boot/compressed/misc.c
>@@ -352,7 +352,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
> 	boot_params->hdr.loadflags &= ~KASLR_FLAG;
> 
> 	/* Save RSDP address for later use. */
>-	boot_params->acpi_rsdp_addr = get_rsdp_addr();
>+/*	boot_params->acpi_rsdp_addr = get_rsdp_addr(); */
> 
> 	sanitize_boot_params(boot_params);
> 
>
>


