Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39E4C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14162081B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbfGYHWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:22:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45389 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYHWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:22:20 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqY4p-0000Pt-AL; Thu, 25 Jul 2019 09:22:11 +0200
Date:   Thu, 25 Jul 2019 09:22:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     hpa@zytor.com
cc:     john.hubbard@gmail.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 1/1] x86/boot: clear some fields explicitly
In-Reply-To: <B7DC31CA-E378-445A-A937-1B99490C77B4@zytor.com>
Message-ID: <alpine.DEB.2.21.1907250848050.1791@nanos.tec.linutronix.de>
References: <20190724231528.32381-1-jhubbard@nvidia.com> <20190724231528.32381-2-jhubbard@nvidia.com> <B7DC31CA-E378-445A-A937-1B99490C77B4@zytor.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019, hpa@zytor.com wrote:
> On July 24, 2019 4:15:28 PM PDT, john.hubbard@gmail.com wrote:
> >From: John Hubbard <jhubbard@nvidia.com>
> >
> >Recent gcc compilers (gcc 9.1) generate warnings about an
> >out of bounds memset, if you trying memset across several fields
> >of a struct. This generated a couple of warnings on x86_64 builds.
> >
> >Because struct boot_params is __packed__, normal variable
> >variable assignment will work just as well as a memset here.
> >Change three u32 fields to be cleared to zero that way, and
> >just memset the _pad4 field.
> >
> >This clears up the build warnings for me.
> >
> >Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> >---
> > arch/x86/include/asm/bootparam_utils.h | 11 +++++------
> > 1 file changed, 5 insertions(+), 6 deletions(-)
> >
> >diff --git a/arch/x86/include/asm/bootparam_utils.h
> >b/arch/x86/include/asm/bootparam_utils.h
> >index 101eb944f13c..4df87d4a043b 100644
> >--- a/arch/x86/include/asm/bootparam_utils.h
> >+++ b/arch/x86/include/asm/bootparam_utils.h
> >@@ -37,12 +37,11 @@ static void sanitize_boot_params(struct boot_params
> >*boot_params)
> > 	if (boot_params->sentinel) {
> > 		/* fields in boot_params are left uninitialized, clear them */
> > 		boot_params->acpi_rsdp_addr = 0;
> >-		memset(&boot_params->ext_ramdisk_image, 0,
> >-		       (char *)&boot_params->efi_info -
> >-			(char *)&boot_params->ext_ramdisk_image);
> >-		memset(&boot_params->kbd_status, 0,
> >-		       (char *)&boot_params->hdr -
> >-		       (char *)&boot_params->kbd_status);
> >+		boot_params->ext_ramdisk_image = 0;
> >+		boot_params->ext_ramdisk_size = 0;
> >+		boot_params->ext_cmd_line_ptr = 0;
> >+
> >+		memset(&boot_params->_pad4, 0, sizeof(boot_params->_pad4));
> > 		memset(&boot_params->_pad7[0], 0,
> > 		       (char *)&boot_params->edd_mbr_sig_buffer[0] -
> > 			(char *)&boot_params->_pad7[0]);
> 
> The problem with this is that it will break silently when changes are
> made to this structure.

That's not really the worst problem. Changes to that struct which touch any
of the to be cleared ranges will break anyway if not handled correctly in
the sanitizer function.

What's worse is that the patch is broken.  It 'clears' the build warnings,
but not all the fields which have been cleared before:

It removes the clearing of the range between kbd_status and hdr without any
replacement. It neither clears edid_info.

The above approach is doomed and if we have to handle this GCC0.1 madness
then this needs to be done smarter. Something like the completely untested
thing below.

Thanks,

	tglx

8<--------------
diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index 101eb944f13c..f5bc4c01b66b 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -9,6 +9,18 @@
  * add completing #includes to make it standalone.
  */
 
+struct boot_params_clear {
+	unsigned int	offs;
+	unsigned int	len;
+};
+
+#define BOOT_PARAM_CLEAR(start, end)				\
+{								\
+	.offs	= offsetof(struct boot_params, start),		\
+	.len	= offsetof(struct boot_params, end) -		\
+		  offsetof(struct boot_params, start),		\
+}
+
 /*
  * Deal with bootloaders which fail to initialize unknown fields in
  * boot_params to zero.  The list fields in this list are taken from
@@ -20,7 +32,19 @@
  */
 static void sanitize_boot_params(struct boot_params *boot_params)
 {
-	/* 
+	const struct boot_params_clear toclear[] = {
+		BOOT_PARAM_CLEAR(acpi_rdsp_addr, _pad3),
+		BOOT_PARAM_CLEAR(ext_ramdisk_image, efi_info),
+		BOOT_PARAM_CLEAR(kbd_status, hdr),
+		BOOT_PARAM_CLEAR(_pad7, edd_mbr_sig_buffer),
+		BOOT_PARAM_CLEAR(_pad8, eddbuf),
+		{
+			.offs	= offsetof(struct boot_params, _pad9),
+			.len	= sizeof(boot_params->_pad9),
+		},
+	}
+
+	/*
 	 * IMPORTANT NOTE TO BOOTLOADER AUTHORS: do not simply clear
 	 * this field.  The purpose of this field is to guarantee
 	 * compliance with the x86 boot spec located in
@@ -36,20 +60,11 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 	 */
 	if (boot_params->sentinel) {
 		/* fields in boot_params are left uninitialized, clear them */
-		boot_params->acpi_rsdp_addr = 0;
-		memset(&boot_params->ext_ramdisk_image, 0,
-		       (char *)&boot_params->efi_info -
-			(char *)&boot_params->ext_ramdisk_image);
-		memset(&boot_params->kbd_status, 0,
-		       (char *)&boot_params->hdr -
-		       (char *)&boot_params->kbd_status);
-		memset(&boot_params->_pad7[0], 0,
-		       (char *)&boot_params->edd_mbr_sig_buffer[0] -
-			(char *)&boot_params->_pad7[0]);
-		memset(&boot_params->_pad8[0], 0,
-		       (char *)&boot_params->eddbuf[0] -
-			(char *)&boot_params->_pad8[0]);
-		memset(&boot_params->_pad9[0], 0, sizeof(boot_params->_pad9));
+		char *p = (char *) boot_params;
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(toclear); i++)
+			memset(p + toclear[i].start, 0, toclear[i].len);
 	}
 }
 

