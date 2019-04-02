Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70292C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404512171F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfDBKHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:07:37 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:63022 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729765AbfDBKHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:07:37 -0400
X-IronPort-AV: E=Sophos;i="5.60,300,1549900800"; 
   d="scan'208";a="58293286"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Apr 2019 18:07:35 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id CD3604CD7914;
        Tue,  2 Apr 2019 18:07:35 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 2 Apr 2019 18:07:39 +0800
Date:   Tue, 2 Apr 2019 19:06:36 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
CC:     Borislav Petkov <bp@alien8.de>, "bhe@redhat.com" <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190402110635.GC1555@localhost.localdomain>
References: <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402094149.GB1555@localhost.localdomain>
 <20190402095350.GA20733@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190402095350.GA20733@jeru.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: CD3604CD7914.ABBAE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 09:53:51AM +0000, Junichi Nomura wrote:
>On Tue, Apr 02, 2019 at 05:41:49PM +0800, Chao Fan wrote:
>> [   77.989030] kexec_core: Starting new kernel
>> early console in extract_kernel
>> input_data: 0x000000017f6033b1
>> input_len: 0x00000000008412d4
>> output: 0x000000017e000000
>> output_len: 0x0000000001e15844
>> kernel_total_size: 0x0000000001e2c000
>> trampoline_32bit: 0x000000000009d000
>> booted via startup_64()
>> 
>> 
>> Physical KASLR disabled: no suitable memory region!
>> ------
>> 
>> I am not sure whether I have done the right test.
>> This guest is booted from EFI. Here we can see the kexeced kernel
>> has completed the compressed boot stage. So I think your PATCH works.
>
>Thanks for testing.  If your test bed doesn't boot even with the patch,
>you could check what was found as RSDP with a debug patch like below.

Oh no, it booted. I just put the compressed stag log.

Thanks,
Chao Fan

>
>diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
>--- a/arch/x86/boot/compressed/misc.c
>+++ b/arch/x86/boot/compressed/misc.c
>@@ -379,6 +379,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
> 	debug_putaddr(output);
> 	debug_putaddr(output_len);
> 	debug_putaddr(kernel_total_size);
>+	debug_putaddr(boot_params->acpi_rsdp_addr);
> 
> #ifdef CONFIG_X86_64
> 	/* Report address of 32-bit trampoline */
>
>


