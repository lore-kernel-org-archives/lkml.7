Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA07C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572CF20700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfDCGjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:39:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfDCGjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:39:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D03885550;
        Wed,  3 Apr 2019 06:39:19 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82A2D5C582;
        Wed,  3 Apr 2019 06:39:15 +0000 (UTC)
Date:   Wed, 3 Apr 2019 14:39:11 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Borislav Petkov <bp@alien8.de>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190403063911.GA2579@dhcp-128-65.nay.redhat.com>
References: <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402120319.GA7605@dhcp-128-65.nay.redhat.com>
 <20190403053459.GD1555@localhost.localdomain>
 <20190403055340.GA11976@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403055340.GA11976@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 03 Apr 2019 06:39:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/19 at 01:53pm, Dave Young wrote:
> On 04/03/19 at 01:35pm, Chao Fan wrote:
> > On Tue, Apr 02, 2019 at 08:03:19PM +0800, Dave Young wrote:
> > >On 04/01/19 at 12:08am, Junichi Nomura wrote:
> > >> Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
> > >> boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
> > >> in the early parsing code tries to search RSDP from EFI table but
> > >> that will crash because the table address is virtual when the kernel
> > >> was booted by kexec.
> > >> 
> > >> In the case of kexec, physical address of EFI tables is provided
> > >> via efi_setup_data in boot_params, which is set up by kexec(1).
> > >> 
> > >> Factor out the table parsing code and use different pointers depending
> > >> on whether the kernel is booted by kexec or not.
> > >> 
> > >> Fixes: 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in boot_params")
> > >> Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
> > >> Acked-by: Baoquan He <bhe@redhat.com>
> > >> Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> > >> Cc: Borislav Petkov <bp@suse.de>
> > >> Cc: Dave Young <dyoung@redhat.com>
> > [...]
> > >
> > >I failed to kexec reboot on my laptop, kernel panics too quick,  I'm not sure this is
> > >caused by your patch though.
> > >
> > >Actually there are something probably i915 changes break kexec,  the
> > >above test is with "nomodeset" which should work.
> > >
> > >Let me do more testing and update here tomorrow.
> > >
> > 
> > Hi Dave,
> > 
> > Last day I was testing the normal kexec, today I have tested the kdump
> > issue. Since the kdump has set "nokaslr" to cmdline, so I drop from
> > KDUMP_COMMANDLINE_APPEND
> > And it booted OK, so the PATCH works in both normal kexec and kdump.
> > 
> 
> Actually I got some different kexec test results.
> 
> Yesterday, with my installed kernel (based on git head several weeks
> ago), kexec kernel panics.
> 
> Then I tried latest mainline with git pull, everything works, (with or
> without the patch, and can not reproduce the bug this patch is fixing)
> 
> Today, test again, kexec reboot hangs (with or without your patch), but
> kdump works always (with or without the patch)
> 
> It is weird to me. Probably I need find out why I can not reproduce the
> bug this patch is addressing first.
> 
> earlyprintk seems not working for me anymore, it is not easy to debug on
> laptop now.
> 
> But the patch itself is clear, I think it should be good.  There might be
> other things broken.

Disable your immovable mem code then everything works for me.  There
might be something wrong in the code.  Also "nokaslr" does not help, it
should be another problem 

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 2e53c056ba20..e760c9159662 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -416,7 +416,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	handle_mem_options();
 
 	/* Enumerate the immovable memory regions */
-	num_immovable_mem = count_immovable_mem_regions();
+	/*num_immovable_mem = count_immovable_mem_regions();*/
 
 #ifdef CONFIG_X86_VERBOSE_BOOTUP
 	/* Make sure video RAM can be used. */
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index c0d6c560df69..1bc6f46d3aa7 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -352,7 +352,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	boot_params->hdr.loadflags &= ~KASLR_FLAG;
 
 	/* Save RSDP address for later use. */
-	boot_params->acpi_rsdp_addr = get_rsdp_addr();
+/*	boot_params->acpi_rsdp_addr = get_rsdp_addr(); */
 
 	sanitize_boot_params(boot_params);
 
