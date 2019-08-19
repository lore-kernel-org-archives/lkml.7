Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF90C3A589
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 00:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9FE21852
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 00:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfHSAKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 20:10:07 -0400
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:45244 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbfHSAKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 20:10:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id D6149610D;
        Mon, 19 Aug 2019 00:10:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: turn43_3ae3061cdff51
X-Filterd-Recvd-Size: 8603
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon, 19 Aug 2019 00:10:04 +0000 (UTC)
Message-ID: <25b7370f49c47608fe488791b268b0336cab3a1e.camel@perches.com>
Subject: Re: [PATCH v2] toshiba: Add correct printk log level while emitting
 error log
From:   Joe Perches <joe@perches.com>
To:     Rishi Gupta <gupt21@gmail.com>, jonathan@buzzard.org.uk
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 18 Aug 2019 17:10:03 -0700
In-Reply-To: <1566113671-8743-1-git-send-email-gupt21@gmail.com>
References: <c3f3f8394a018bab44081b00563ab3aa4b1aca22.camel@perches.com>
         <1566113671-8743-1-git-send-email-gupt21@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-08-18 at 13:04 +0530, Rishi Gupta wrote:
> The printk functions are invoked without specifying required
> log level when printing error messages. This commit replaces
> all direct uses of printk with their corresponding pr_err/info/debug
> variant.

Mostly I wonder if CONFIG_TOSHIBA needs to exist anymore.
Does this driver need to be in kernel at all?

So two options below:

Option 1: If it does still need to exist:

> diff --git a/drivers/char/toshiba.c b/drivers/char/toshiba.c
[]
> @@ -373,7 +373,7 @@ static int tosh_get_machine_id(void __iomem *bios)
>  		   value. This has been verified on a Satellite Pro 430CDT,
>  		   Tecra 750CDT, Tecra 780DVD and Satellite 310CDT. */
>  #if TOSH_DEBUG

Please remove all references to TOSH_DEBUG
and the #ifdef and #endif

> -		printk("toshiba: debugging ID ebx=0x%04x\n", regs.ebx);
> +		pr_debug("toshiba: debugging ID ebx=0x%04x\n", regs.ebx);
>  #endif
>  		bx = 0xe6f5;
>  
> @@ -417,7 +417,7 @@ static int tosh_probe(void)
>  
>  	for (i=0;i<7;i++) {
>  		if (readb(bios+0xe010+i)!=signature[i]) {
> -			printk("toshiba: not a supported Toshiba laptop\n");
> +			pr_err("toshiba: not a supported Toshiba laptop\n");
>  			iounmap(bios);
>  			return -ENODEV;
>  		}
> 

And add and use #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
and remove the embedded "toshiba: " prefix from formats.

---
diff --git a/drivers/char/toshiba.c b/drivers/char/toshiba.c
index 0bdc602f0d48..1fd9db56d6d1 100644
--- a/drivers/char/toshiba.c
+++ b/drivers/char/toshiba.c
@@ -43,8 +43,9 @@
  * the Copyright (Computer Programs) Regulations 1992 (S.I. 1992 No.3233).
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #define TOSH_VERSION "1.11 26/9/2001"
-#define TOSH_DEBUG 0
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -372,9 +373,9 @@ static int tosh_get_machine_id(void __iomem *bios)
 		   a different value! For the time being I will just fudge the
 		   value. This has been verified on a Satellite Pro 430CDT,
 		   Tecra 750CDT, Tecra 780DVD and Satellite 310CDT. */
-#if TOSH_DEBUG
-		printk("toshiba: debugging ID ebx=0x%04x\n", regs.ebx);
-#endif
+
+		pr_debug("debugging ID ebx=0x%04x\n", regs.ebx);
+
 		bx = 0xe6f5;
 
 sh		/* now twiddle with our pointer a bit */
@@ -417,7 +418,7 @@ static int tosh_probe(void)
 
 	for (i=0;i<7;i++) {
 		if (readb(bios+0xe010+i)!=signature[i]) {
-			printk("toshiba: not a supported Toshiba laptop\n");
+			pr_notice("not a supported Toshiba laptop\n");
 			iounmap(bios);
 			return -ENODEV;
 		}
@@ -433,7 +434,7 @@ static int tosh_probe(void)
 	/* if this is not a Toshiba laptop carry flag is set and ah=0x86 */
 
 	if ((flag==1) || ((regs.eax & 0xff00)==0x8600)) {
-		printk("toshiba: not a supported Toshiba laptop\n");
+		pr_notice("not a supported Toshiba laptop\n");
 		iounmap(bios);
 		return -ENODEV;
 	}
@@ -486,7 +487,7 @@ static int __init toshiba_init(void)
 	if (tosh_probe())
 		return -ENODEV;
 
-	printk(KERN_INFO "Toshiba System Management Mode driver v" TOSH_VERSION "\n");
+	pr_info("Toshiba System Management Mode driver v" TOSH_VERSION "\n");
 
 	/* set the port to use for Fn status if not specified as a parameter */
 	if (tosh_fn==0x00)

---

Option 2: And if it's really dead hardware maybe:
---
 arch/x86/Kconfig                    |  16 --
 drivers/char/Makefile               |   1 -
 drivers/char/toshiba.c              | 523 ------------------------------------
 drivers/platform/x86/toshiba_acpi.c |   1 -
 drivers/video/fbdev/neofb.c         |  27 --
 include/linux/toshiba.h             |  15 --
 6 files changed, 583 deletions(-)
 delete mode 100644 drivers/char/toshiba.c
 delete mode 100644 include/linux/toshiba.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d685677d90f0..f35cdb6e5a77 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1252,22 +1252,6 @@ config X86_VSYSCALL_EMULATION
 	 Disabling this option saves about 7K of kernel size and
 	 possibly 4K of additional runtime pagetable memory.
 
-config TOSHIBA
-	tristate "Toshiba Laptop support"
-	depends on X86_32
-	---help---
-	  This adds a driver to safely access the System Management Mode of
-	  the CPU on Toshiba portables with a genuine Toshiba BIOS. It does
-	  not work on models with a Phoenix BIOS. The System Management Mode
-	  is used to set the BIOS and power saving options on Toshiba portables.
-
-	  For information on utilities to make use of this driver see the
-	  Toshiba Linux utilities web site at:
-	  <http://www.buzzard.org.uk/toshiba/>;.
-
-	  Say Y if you intend to run this kernel on a Toshiba portable.
-	  Say N otherwise.
-
 config I8K
 	tristate "Dell i8k legacy laptop support"
 	select HWMON
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index fbea7dd12932..496d1ba4ea51 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -27,7 +27,6 @@ obj-$(CONFIG_HPET)		+= hpet.o
 obj-$(CONFIG_EFI_RTC)		+= efirtc.o
 obj-$(CONFIG_XILINX_HWICAP)	+= xilinx_hwicap/
 obj-$(CONFIG_NVRAM)		+= nvram.o
-obj-$(CONFIG_TOSHIBA)		+= toshiba.o
 obj-$(CONFIG_DS1620)		+= ds1620.o
 obj-$(CONFIG_HW_RANDOM)		+= hw_random/
 obj-$(CONFIG_PPDEV)		+= ppdev.o
diff --git a/drivers/char/toshiba.c b/drivers/char/toshiba.c
deleted file mode 100644
index 0bdc602f0d48..000000000000
diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index a1e6569427c3..1b894419b13a 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -43,7 +43,6 @@
 #include <linux/miscdevice.h>
 #include <linux/rfkill.h>
 #include <linux/iio/iio.h>
-#include <linux/toshiba.h>
 #include <acpi/video.h>
 
 MODULE_AUTHOR("John Belmonte");
diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
index b770946a0920..4b22876137cb 100644
--- a/drivers/video/fbdev/neofb.c
+++ b/drivers/video/fbdev/neofb.c
@@ -64,9 +64,6 @@
 #include <linux/fb.h>
 #include <linux/pci.h>
 #include <linux/init.h>
-#ifdef CONFIG_TOSHIBA
-#include <linux/toshiba.h>
-#endif
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -1287,18 +1284,6 @@ static int neofb_blank(int blank_mode, struct fb_info *info)
 		lcdflags = 0;			/* LCD off */
 		dpmsflags = NEO_GR01_SUPPRESS_HSYNC |
 			    NEO_GR01_SUPPRESS_VSYNC;
-#ifdef CONFIG_TOSHIBA
-		/* Do we still need this ? */
-		/* attempt to turn off backlight on toshiba; also turns off external */
-		{
-			SMMRegisters regs;
-
-			regs.eax = 0xff00; /* HCI_SET */
-			regs.ebx = 0x0002; /* HCI_BACKLIGHT */
-			regs.ecx = 0x0000; /* HCI_DISABLE */
-			tosh_smm(&regs);
-		}
-#endif
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:		/* hsync off */
 		seqflags = VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
@@ -1328,18 +1313,6 @@ static int neofb_blank(int blank_mode, struct fb_info *info)
 		seqflags = 0;			/* Enable sequencer */
 		lcdflags = ((par->PanelDispCntlReg1 | tmpdisp) & 0x02); /* LCD normal */
 		dpmsflags = 0x00;	/* no hsync/vsync suppression */
-#ifdef CONFIG_TOSHIBA
-		/* Do we still need this ? */
-		/* attempt to re-enable backlight/external on toshiba */
-		{
-			SMMRegisters regs;
-
-			regs.eax = 0xff00; /* HCI_SET */
-			regs.ebx = 0x0002; /* HCI_BACKLIGHT */
-			regs.ecx = 0x0001; /* HCI_ENABLE */
-			tosh_smm(&regs);
-		}
-#endif
 		break;
 	default:	/* Anything else we don't understand; return 1 to tell
 			 * fb_blank we didn't aactually do anything */
diff --git a/include/linux/toshiba.h b/include/linux/toshiba.h
deleted file mode 100644
index 2e0b7dd1b57b..000000000000


