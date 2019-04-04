Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05122C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF322075D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDDDAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:00:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfDDDAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:00:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB51B307E054;
        Thu,  4 Apr 2019 03:00:45 +0000 (UTC)
Received: from localhost (ovpn-12-46.pek2.redhat.com [10.72.12.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ABAAC84D87;
        Thu,  4 Apr 2019 03:00:41 +0000 (UTC)
Date:   Thu, 4 Apr 2019 11:00:37 +0800
From:   "bhe@redhat.com" <bhe@redhat.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Borislav Petkov <bp@alien8.de>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190404030037.GT7627@MiWiFi-R3L-srv>
References: <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402120319.GA7605@dhcp-128-65.nay.redhat.com>
 <20190403053459.GD1555@localhost.localdomain>
 <20190403055340.GA11976@dhcp-128-65.nay.redhat.com>
 <20190403072141.GE1555@localhost.localdomain>
 <20190403080846.GB2579@dhcp-128-65.nay.redhat.com>
 <20190403082305.GG1555@localhost.localdomain>
 <20190403090210.GH1555@localhost.localdomain>
 <c8613886-7014-cbd2-788f-a4f29bb5b4a5@ce.jp.nec.com>
 <20190404025234.GA12658@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404025234.GA12658@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 04 Apr 2019 03:00:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/19 at 10:52am, Dave Young wrote:
> On 04/04/19 at 01:23am, Junichi Nomura wrote:
> > Hi Dave and Chao,
> > 
> > On 4/3/19 6:02 PM, Chao Fan wrote:
> > > On Wed, Apr 03, 2019 at 04:23:06PM +0800, Chao Fan wrote:
> > >> On Wed, Apr 03, 2019 at 04:09:16PM +0800, Dave Young wrote:
> > >>> Fix 3.  need more debugging, have you or Junichi run tests on more real
> > >>> hardware, maybe it is easier to reproduce on real hardware, I'm glad to
> > >>> help to try test patch or provide any help. 
> > >>
> > >> I am still testing in real hardware.
> > > 
> > > Hi Dave,
> > > 
> > > I find a Fujitsu Desktop PC to test it.
> > > Without this PATCH, it failed to kexec and kdump.
> > > With this PATCH, it succeed to kexec.
> > > But failed to kdump. From the log, I think it didn't jump to the second
> > > kernel, just reboot after panic. I have not figured out what's the
> > > problem, but it seems not caused by this PATCH.
> > > So I still think this PATCH works for the Fujitsu Desktop PC.
> > > 
> > > As for your issue, I think there may be some problems related to specified
> > > hardware. Are you using a Lenovo laptop?
> > > 
> > > And I am not sure how Nomura tested it.
> > 
> > I've tested 3 different models of EFI-booted baremetal servers with both
> > normal kexec and panic kexec.  So far as I've tried Linus's v5.1-rc3,
> > the problem always reproduced without the patch and disappears with the patch.
> 
> Hmm, both of my two laptops (Thinkpad T480s and T420) failed to boot with kexec.
> 
> I will see if I can find something, but it may need more time because
> early console does not work especially after kexec.

Dave, can you try below patch to print debugging message and hang kernel
to check the outputting? The hang is necessary, otherwise later printk
printking will overwrite it.

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index c0d6c560df69..68119547c4aa 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -351,9 +351,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	/* Clear flags intended for solely in-kernel use. */
 	boot_params->hdr.loadflags &= ~KASLR_FLAG;
 
-	/* Save RSDP address for later use. */
-	boot_params->acpi_rsdp_addr = get_rsdp_addr();
-
 	sanitize_boot_params(boot_params);
 
 	if (boot_params->screen_info.orig_video_mode == 7) {
@@ -370,6 +367,10 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	console_init();
 	debug_putstr("early console in extract_kernel\n");
 
+	error("Hang kernel for kexec debugging");
+	/* Save RSDP address for later use. */
+	boot_params->acpi_rsdp_addr = get_rsdp_addr();
+
 	free_mem_ptr     = heap;	/* Heap */
 	free_mem_end_ptr = heap + BOOT_HEAP_SIZE;
 
