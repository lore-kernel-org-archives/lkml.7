Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33A5C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D50D2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KvSUr3dZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfDSTJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:09:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42186 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbfDSTJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:09:02 -0400
Received: from zn.tnic (p200300EC2F112E0081C1838BC39E212C.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:81c1:838b:c39e:212c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 261A21EC0513;
        Fri, 19 Apr 2019 16:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555683598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eOp/ySOqHIMhpte/mJe3u1Zx4rYSYksGeMB7N2WQHHk=;
        b=KvSUr3dZjOYEW2cN7Z7qdy1pvJR4XtfLReq6g0Mpo/ceNzhES0cByjesayV3ajJm8IQLsl
        gc0ul2nUCYDTShPum8+7PY3yANpcrLg5Lul9sM9vN3i70sQuyNUx6m/euxFXQp503333CC
        He51Jt9MdDESEfOK2c4PtnceiCcCUG8=
Date:   Fri, 19 Apr 2019 16:19:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kairui Song <kasong@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, indou.takao@jp.fujitsu.com,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        msys.mizuma@gmail.com, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH] x86/boot: Disable RSDP parsing temporarily
Message-ID: <20190419141952.GE10324@zn.tnic>
References: <20190419101733.GA10324@zn.tnic>
 <20190419105014.GE11060@MiWiFi-R3L-srv>
 <CACPcB9fwvxmVcD4ttP8p9X0=J+Oev9RUrgNzuu6LZFQCZ7AS1w@mail.gmail.com>
 <20190419113413.GC10324@zn.tnic>
 <CACPcB9emLPEWCvpdExGvD_S_b3RWrrgK2uCx07HZjj5yUh6Y_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPcB9emLPEWCvpdExGvD_S_b3RWrrgK2uCx07HZjj5yUh6Y_g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

thinking about this more, we believe it is too late in the release cycle
to keep experimenting so the only thing left to do is the below.

This should bring the situation back to what it was before, at 5.0
times, and we'll have plenty of time now to address and properly fix all
the outstanding issues.

---
From: Borislav Petkov <bp@suse.de>

The original intention to move RDSP parsing very early, before KASLR
does its ranges selection, was to accommodate movable memory regions
machines (CONFIG_MEMORY_HOTREMOVE) to still be able to do memory
hotplug.

However, that broke kexec'ing a kernel on EFI machines because depending
on where the EFI systab was mapped, on at least one machine it isn't
present in the kexec mapping of the second kernel, leading to a triple
fault in the early code.

Fixing this properly requires significantly involved surgery and we
cannot allow ourselves to do that, that close to the merge window.

So disable the RSDP parsing code temporarily until it is fixed properly
in the next release cycle.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: indou.takao@jp.fujitsu.com
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: kasong@redhat.com
Cc: Kees Cook <keescook@chromium.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: msys.mizuma@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
---
 arch/x86/boot/compressed/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index c0d6c560df69..5a237e8dbf8d 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -352,7 +352,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	boot_params->hdr.loadflags &= ~KASLR_FLAG;
 
 	/* Save RSDP address for later use. */
-	boot_params->acpi_rsdp_addr = get_rsdp_addr();
+	/* boot_params->acpi_rsdp_addr = get_rsdp_addr(); */
 
 	sanitize_boot_params(boot_params);
 
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
