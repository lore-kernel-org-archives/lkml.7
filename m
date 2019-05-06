Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4028FC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0679620675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RPhHfxdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEFUHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 16:07:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:33119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfEFUHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 16:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557173211;
        bh=VfXx558+VlXRqC6DuXAeELbx2WcCU2gN6wItdaEoRMo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RPhHfxddCJFmIOSCNTyDwTmir7mgKx3V9W5KMnGXU2y0SEaPFQaBtvOxYxryrMuEO
         79PUrFQTFk+kuPjgvG2myUXlMHb4lh5LzsvysBPlYKJDEm6kGbwER4YiDtTfAnJ9Kr
         5jRfC6IWjajGuMKK3G3fMD9k96+PQifJOTcwXTtg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.60] ([84.118.159.3]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPUlV-1hJb100BOL-004lQR; Mon, 06
 May 2019 22:06:51 +0200
Subject: Re: [U-Boot] [v4 PATCH] RISCV: image: Add booti support
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Tom Rini <trini@konsulko.com>, Karsten Merker <merker@debian.org>,
        Alexander Graf <agraf@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Joe Hershberger <joe.hershberger@ni.com>,
        Lukas Auer <lukas.auer@aisec.fraunhofer.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>,
        u-boot@lists.denx.de
References: <20190506181134.9575-1-atish.patra@wdc.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <251ea152-6407-02e2-076c-7ee377f6181d@gmx.de>
Date:   Mon, 6 May 2019 22:06:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506181134.9575-1-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6RckYc5U0Da60ys01K5KqNxlDxGQyIskoQPgUx44VHgouWNQQYL
 06Ft9i2dc+rcS6etF364TAEy8yyDQ077msAf1ABtFwpKSWn5fww6XAEmBWRgtgOBMWFse3W
 aaUIRZk9CWaPW4DzPscPWepC7ie85sej3lNl4PVdlf7z3/Ca1NTp27GnuR8fw3S5JAfynVj
 bDzxugY0ne8f/zHkq/v3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GYBYyni7Hq8=:mclJuPMFIlvJXe9GlanYzP
 4Jr5AW87UQ2nYL7idRcNJWUNrrRI3iuSqMV8EvrLDAuchcJDmGro+iJE9cU4YcZR2czkqI/lc
 sAqHU+KJC1ZctqX7dgZJH9OMNmvlk+LLDWk7dhEyN7ztFHX4hegTLNNPuAKGKsUSP3DXnzJ2b
 ym2l6QpnQ/qyFdHOymvT9L57WxPTOazqIYJhJrpMECcVCVUEl1Ev8I/f4/V5W8hCVLMkKbxoI
 FC7LgUaEaladubdvgyQkqLdI9m3qDPhMGJE5iJ87bN/dAoRu2TQ+l9TREIZYZy5KKjn1GllCU
 YdNCO0HzZSI1w1h9k97ohgWGdABa5IcCJrWxVjKjCVP4EH50/cNCPigtkXbM2feNVLHbQUjm1
 IrnyTEtbKly+JHa8G+LAx6pSFMM50rFCTVAuQKFHAAdlBESbjgfyLq0ClsfGTr0eb5pLlEUKe
 IHeQilL12A6Yu3byW77ZujPaRBQ+coIFTH5og9+xTWuJ+x3h8gWdePdlQvFXVYVL07fGcTp2X
 oT4PrJx5TDkoBMCvGn3sTscXdG3iQhyf99ot4aUagh+ULAkDqyyPnjjIvOVg6DsqF9pIsepfA
 2Ie2R76YnRwgu6s0EyvT+h/BvCtyxnW89EGDlYe9MmGs+UBGE+X/OTZ14ca1bKsccHukC7vyU
 j+8DlpNZh6zCsyLYHszhIY0IrZ7FU74kHZNd3oDLS1mxvYTFkP3DNxJIz1ZtgcnZ7gAbFOqRO
 KmE5BskuvIBYg/kNiLZA76wa0xg1xiih+5JQg55MKmWeNCMRZZkfae20Ed1XimgNSGrFyqVCs
 FHKUyMj6aYLR1HPDJYV2Et6NlPstfEpCPCa52exnRBt8lmPiAZO+lfxJmoVGsCAtqdvyEjH67
 /eaLAUdDukAfs4GYzVmD3kiJfGvd6oeAuq3msSszn8SLOXjjnYajTW9upn9Bs33dem9o1kHmg
 QOnyWpgKF/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 8:11 PM, Atish Patra wrote:
> This patch adds booti support for RISC-V Linux kernel. The existing
> bootm method will also continue to work as it is.
>
> It depends on the following kernel patch which adds the header to the
> flat Image. Gzip compressed Image (Image.gz) support is not enabled with
> this patch.
>
> https://patchwork.kernel.org/patch/10925543/
>
> Tested on HiFive Unleashed and QEMU.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Tested-by: Karsten Merker <merker@debian.org>
> ---
> Changes from v3->v4
> 1. Rebased on top of master to avoid git am errors.
>
> Changes from v2->v3
> 1. Updated the image header structure as per kernel patch.
> 2. Removed Image.gz support as it will be added as separate RFC patch.
> ---
>   arch/riscv/lib/Makefile |  1 +
>   arch/riscv/lib/image.c  | 55 +++++++++++++++++++++++++++++++++++++++++
>   cmd/Kconfig             |  2 +-
>   cmd/booti.c             |  8 ++++--
>   4 files changed, 63 insertions(+), 3 deletions(-)
>   create mode 100644 arch/riscv/lib/image.c
>
> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> index 1c332db436a9..6ae6ebbeafda 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -7,6 +7,7 @@
>   # Rick Chen, Andes Technology Corporation <rick@andestech.com>
>
>   obj-$(CONFIG_CMD_BOOTM) +=3D bootm.o
> +obj-$(CONFIG_CMD_BOOTI) +=3D bootm.o image.o
>   obj-$(CONFIG_CMD_GO) +=3D boot.o
>   obj-y	+=3D cache.o
>   obj-$(CONFIG_RISCV_RDTIME) +=3D rdtime.o
> diff --git a/arch/riscv/lib/image.c b/arch/riscv/lib/image.c
> new file mode 100644
> index 000000000000..d063beb7dfbe
> --- /dev/null
> +++ b/arch/riscv/lib/image.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> + * Authors:
> + *	Atish Patra <atish.patra@wdc.com>
> + * Based on arm/lib/image.c
> + */
> +
> +#include <common.h>
> +#include <mapmem.h>
> +#include <errno.h>
> +#include <linux/sizes.h>
> +#include <linux/stddef.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/* ASCII version of "RISCV" defined in Linux kernel */
> +#define LINUX_RISCV_IMAGE_MAGIC 0x5643534952
> +
> +struct linux_image_h {
> +	uint32_t	code0;		/* Executable code */
> +	uint32_t	code1;		/* Executable code */
> +	uint64_t	text_offset;	/* Image load offset */
> +	uint64_t	image_size;	/* Effective Image size */
> +	uint64_t	res1;		/* reserved */
> +	uint64_t	res2;		/* reserved */
> +	uint64_t	res3;		/* reserved */
> +	uint64_t	magic;		/* Magic number */
> +	uint32_t	res4;		/* reserved */
> +	uint32_t	res5;		/* reserved */
> +};
> +
> +int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
> +		bool force_reloc)
> +{
> +	struct linux_image_h *lhdr;
> +
> +	lhdr =3D (struct linux_image_h *)map_sysmem(image, 0);
> +
> +	if (lhdr->magic !=3D LINUX_RISCV_IMAGE_MAGIC) {
> +		puts("Bad Linux RISCV Image magic!\n");
> +		return -EINVAL;
> +	}
> +
> +	if (lhdr->image_size =3D=3D 0) {
> +		puts("Image lacks image_size field, error!\n");
> +		return -EINVAL;
> +	}
> +	*size =3D lhdr->image_size;
> +	*relocated_addr =3D gd->ram_base + lhdr->text_offset;
> +
> +	unmap_sysmem(lhdr);
> +
> +	return 0;
> +}
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 069e0ea7300b..4e11e0f404c8 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -223,7 +223,7 @@ config CMD_BOOTZ
>
>   config CMD_BOOTI
>   	bool "booti"
> -	depends on ARM64
> +	depends on ARM64 || RISCV
>   	default y
>   	help
>   	  Boot an AArch64 Linux Kernel image from memory.
> diff --git a/cmd/booti.c b/cmd/booti.c
> index 04353b68eccc..5e902993865b 100644
> --- a/cmd/booti.c
> +++ b/cmd/booti.c
> @@ -77,7 +77,11 @@ int do_booti(cmd_tbl_t *cmdtp, int flag, int argc, ch=
ar * const argv[])
>   	bootm_disable_interrupts();
>
>   	images.os.os =3D IH_OS_LINUX;
> +#ifdef CONFIG_RISCV_SMODE
> +	images.os.arch =3D IH_ARCH_RISCV;
> +#elif CONFIG_ARM64
>   	images.os.arch =3D IH_ARCH_ARM64;
> +#endif
>   	ret =3D do_bootm_states(cmdtp, flag, argc, argv,
>   #ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
>   			      BOOTM_STATE_RAMDISK |
> @@ -92,7 +96,7 @@ int do_booti(cmd_tbl_t *cmdtp, int flag, int argc, cha=
r * const argv[])
>   #ifdef CONFIG_SYS_LONGHELP
>   static char booti_help_text[] =3D
>   	"[addr [initrd[:size]] [fdt]]\n"
> -	"    - boot arm64 Linux Image stored in memory\n"
> +	"    - boot arm64/riscv Linux Image stored in memory\n"

Why would you repeat the short description? Just remove this line.


>   	"\tThe argument 'initrd' is optional and specifies the address\n"
>   	"\tof an initrd in memory. The optional parameter ':size' allows\n"
>   	"\tspecifying the size of a RAW initrd.\n"
> @@ -107,5 +111,5 @@ static char booti_help_text[] =3D
>
>   U_BOOT_CMD(
>   	booti,	CONFIG_SYS_MAXARGS,	1,	do_booti,
> -	"boot arm64 Linux Image image from memory", booti_help_text
> +	"boot arm64/riscv Linux Image image from memory", booti_help_text

%s/Image image/image/

"arm64/riscv" is distracting. If I am on RISC-V I cannot boot an ARM64
image here. Remove the reference to the architecture, please.

Best regards

Heinrich

>   );
>

