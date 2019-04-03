Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8B3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570E22082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfDCJj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:39:57 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:28488 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725956AbfDCJj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:39:56 -0400
X-IronPort-AV: E=Sophos;i="5.60,304,1549900800"; 
   d="scan'208";a="58379933"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Apr 2019 17:39:55 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 8E2F54C8B03D;
        Wed,  3 Apr 2019 17:39:52 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 3 Apr 2019 17:39:56 +0800
Date:   Wed, 3 Apr 2019 17:39:47 +0800
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
Message-ID: <20190403093947.GJ1555@localhost.localdomain>
References: <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402120319.GA7605@dhcp-128-65.nay.redhat.com>
 <20190403053459.GD1555@localhost.localdomain>
 <20190403055340.GA11976@dhcp-128-65.nay.redhat.com>
 <20190403072141.GE1555@localhost.localdomain>
 <20190403080846.GB2579@dhcp-128-65.nay.redhat.com>
 <20190403082305.GG1555@localhost.localdomain>
 <20190403090210.GH1555@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190403090210.GH1555@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 8E2F54C8B03D.AC983
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 05:02:11PM +0800, Chao Fan wrote:
>On Wed, Apr 03, 2019 at 04:23:06PM +0800, Chao Fan wrote:
>>On Wed, Apr 03, 2019 at 04:09:16PM +0800, Dave Young wrote:
>>>On 04/03/19 at 03:21pm, Chao Fan wrote:
>>>> On Wed, Apr 03, 2019 at 01:53:40PM +0800, Dave Young wrote:
>>>> >On 04/03/19 at 01:35pm, Chao Fan wrote:
>>>> >> On Tue, Apr 02, 2019 at 08:03:19PM +0800, Dave Young wrote:
>>>> >> >On 04/01/19 at 12:08am, Junichi Nomura wrote:
>[...]
>>>> >
>>>> >It is weird to me. Probably I need find out why I can not reproduce the
>>>> >bug this patch is addressing first.
>>>> 
>>>> Hmm, is your laptop booted from EFI or legacy BIOS?
>>>
>>>EFI booted.
>>>
>>>> >
>>>> >earlyprintk seems not working for me anymore, it is not easy to debug on
>>>> >laptop now.
>>>> 
>>>> Another computer can help print the console message.
>>>> I remeber you are good at debug on two computers.
>>>
>>>I used to use earlyprintk, but seems earlyprintk can not work so early.
>>>So I only can try to comment out code manually.
>>
>>Ah, I got it. If you want to use earlyprintk to print message of
>>get_rsdp_addr(), you should change some code.
>>Because get_rsdp_addr() is called before earlyprintk initialed.
>>
>>I am still testing, but in my debug stage, I change like this:
>>diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
>>index c0d6c560df69..dbbe8d9a5792 100644
>>--- a/arch/x86/boot/compressed/misc.c
>>+++ b/arch/x86/boot/compressed/misc.c
>>@@ -352,7 +352,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>>        boot_params->hdr.loadflags &= ~KASLR_FLAG;
>>
>>        /* Save RSDP address for later use. */
>>-       boot_params->acpi_rsdp_addr = get_rsdp_addr();
>>
>>        sanitize_boot_params(boot_params);
>>
>>@@ -368,6 +367,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>>        cols = boot_params->screen_info.orig_video_cols;
>>
>>        console_init();
>>+       boot_params->acpi_rsdp_addr = get_rsdp_addr();
>>        debug_putstr("early console in extract_kernel\n");
>>
>>        free_mem_ptr     = heap;        /* Heap */
>>
>>Call this function after console_init().
>>That will make earlyprintk works.
>>
>>>
>>>It seems to be still some bug in early acpi code because if I 
>>>return 0 in get rsdp function it just works.
>>>
>>>This guess make sense to me for now:
>>>1. nokaslr does not work because it may only avoid randomization, but it
>>>does not avoid running the early acpi parsing code.
>>>
>>>2. kexec does not work without the patch we talked about, because I just
>>>reproduced Junichi reported bug, sometimes hang, or reset, it is
>>>understandable.
>>>
>>>3. kexec does not work with the patch, so there is still bugs in the
>>>code. 
>>>
>>>So several things to do is:
>>>
>>>Fix 1. (separate issue),  Baoquan or either of you may want to fix it :)
>>
>>For 1, I think it's not needed to fix. Since not only KASLR needs RSDP.
>>So nokaslr should not stop the acpi parsing code.
>>>
>>>Fix 3.  need more debugging, have you or Junichi run tests on more real
>>>hardware, maybe it is easier to reproduce on real hardware, I'm glad to
>>>help to try test patch or provide any help. 
>>
>>I am still testing in real hardware.
>
>Hi Dave,
>
>I find a Fujitsu Desktop PC to test it.
>Without this PATCH, it failed to kexec and kdump.
>With this PATCH, it succeed to kexec.
>But failed to kdump. From the log, I think it didn't jump to the second
>kernel, just reboot after panic. I have not figured out what's the
>problem, but it seems not caused by this PATCH.

I comment out this line:
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index c0d6c560df69..4d826abe659c 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -352,7 +352,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
        boot_params->hdr.loadflags &= ~KASLR_FLAG;

        /* Save RSDP address for later use. */
-       boot_params->acpi_rsdp_addr = get_rsdp_addr();
+       //boot_params->acpi_rsdp_addr = get_rsdp_addr();

        sanitize_boot_params(boot_params);

Kdump also failed to jump to the second kernel and just hang.
So I think it's another issue. As for this PATCH, I think it works.
So for now, we only find your laptop will meet the problem, so maybe
you can debug for more information.

Thanks,
Chao Fan

>So I still think this PATCH works for the Fujitsu Desktop PC.
>
>As for your issue, I think there may be some problems related to specified
>hardware. Are you using a Lenovo laptop?
>
>And I am not sure how Nomura tested it.
>
>Thanks,
>Chao Fan
>
>>
>>Thanks,
>>Chao Fan
>>
>>>
>>>Thanks
>>>Dave
>>>
>>>


