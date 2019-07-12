Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D58CC742D1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C812080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="t2z1wjH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfGLQEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:04:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47935 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfGLQEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:04:43 -0400
Received: from [IPv6:2601:646:8600:3281:4501:6781:c7ce:2878] ([IPv6:2601:646:8600:3281:4501:6781:c7ce:2878])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x6CG4VhD3484128
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 12 Jul 2019 09:04:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x6CG4VhD3484128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562947472;
        bh=5PPW2vutxKC5VoseGuX+50LhjnKt0Wvb59i0hQHJhGo=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=t2z1wjH+nMlOkNWTK/FWi9wVkMptnEiumxTGGmTfYrKxnkk00QM4ebNmy/Dp/t/9b
         pfJu9N25mACXVbtVAfKwtuuCic8diCAb3jdLVGdfcn4K+ShK21sA2FU/3KX1XH/bNo
         linb6LOENxOhZvYPErpbwN7SOikfweBGh4x0b9KntsGec297+oCPCzFiCLHafqhdsX
         fHCO6ieP17IfGJ+QEuu6XQRA7aSIUUrGnjRh8NkpsZd5EAO8NlJDggNTarUCLBDo+V
         uUoiscG7BjjIu7zBVorvbEKFhAYazEmEdmLKa1wurPs4REs3AegLBEYb4EPWm6u+vv
         g+xN4+6qzlrcQ==
Date:   Fri, 12 Jul 2019 09:04:23 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190704163612.14311-2-daniel.kiper@oracle.com>
References: <20190704163612.14311-1-daniel.kiper@oracle.com> <20190704163612.14311-2-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] x86/boot: Introduce the kernel_info
To:     Daniel Kiper <daniel.kiper@oracle.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
CC:     bp@alien8.de, corbet@lwn.net, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com,
        ross.philipson@oracle.com, tglx@linutronix.de
From:   hpa@zytor.com
Message-ID: <5633066F-01BE-437D-A564-150FD48B6D92@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 4, 2019 9:36:10 AM PDT, Daniel Kiper <daniel=2Ekiper@oracle=2Ecom> =
wrote:
>The relationships between the headers are analogous to the various data
>sections:
>
>  setup_header =3D =2Edata
>  boot_params/setup_data =3D =2Ebss
>
>What is missing from the above list? That's right:
>
>  kernel_info =3D =2Erodata
>
>We have been (ab)using =2Edata for things that could go into =2Erodata or
>=2Ebss for
>a long time, for lack of alternatives and -- especially early on --
>inertia=2E
>Also, the BIOS stub is responsible for creating boot_params, so it
>isn't
>available to a BIOS-based loader (setup_data is, though)=2E
>
>setup_header is permanently limited to 144 bytes due to the reach of
>the
>2-byte jump field, which doubles as a length field for the structure,
>combined
>with the size of the "hole" in struct boot_params that a protected-mode
>loader
>or the BIOS stub has to copy it into=2E It is currently 119 bytes long,
>which
>leaves us with 25 very precious bytes=2E This isn't something that can be
>fixed
>without revising the boot protocol entirely, breaking backwards
>compatibility=2E
>
>boot_params proper is limited to 4096 bytes, but can be arbitrarily
>extended
>by adding setup_data entries=2E It cannot be used to communicate
>properties of
>the kernel image, because it is =2Ebss and has no image-provided content=
=2E
>
>kernel_info solves this by providing an extensible place for
>information about
>the kernel image=2E It is readonly, because the kernel cannot rely on a
>bootloader copying its contents anywhere, but that is OK; if it becomes
>necessary it can still contain data items that an enabled bootloader
>would be
>expected to copy into a setup_data chunk=2E
>
>This patch does not bump setup_header version in arch/x86/boot/header=2ES
>because it will be followed by additional changes coming into the
>Linux/x86 boot protocol=2E
>
>Suggested-by: H=2E Peter Anvin <hpa@zytor=2Ecom>
>Signed-off-by: Daniel Kiper <daniel=2Ekiper@oracle=2Ecom>
>Reviewed-by: Eric Snowberg <eric=2Esnowberg@oracle=2Ecom>
>Reviewed-by: Ross Philipson <ross=2Ephilipson@oracle=2Ecom>
>---
>v2 - suggestions/fixes:
>   - rename setup_header2 to kernel_info,
>     (suggested by H=2E Peter Anvin),
>   - change kernel_info=2Eheader value to "InfO" (0x4f666e49),
>   - new kernel_info description in Documentation/x86/boot=2Erst,
>     (suggested by H=2E Peter Anvin),
>   - drop kernel_info_offset_update() as an overkill and
>     update kernel_info offset directly from main(),
>     (suggested by Eric Snowberg),
>   - new commit message
>     (suggested by H=2E Peter Anvin),
>   - fix some commit message misspellings
>     (suggested by Eric Snowberg)=2E
>---
>Documentation/x86/boot=2Erst             | 89
>++++++++++++++++++++++++++++++++++
> arch/x86/boot/Makefile                 |  2 +-
> arch/x86/boot/compressed/Makefile      |  4 +-
> arch/x86/boot/compressed/kernel_info=2ES | 12 +++++
> arch/x86/boot/header=2ES                 |  1 +
> arch/x86/boot/tools/build=2Ec            |  5 ++
> arch/x86/include/uapi/asm/bootparam=2Eh  |  1 +
> 7 files changed, 111 insertions(+), 3 deletions(-)
> create mode 100644 arch/x86/boot/compressed/kernel_info=2ES
>
>diff --git a/Documentation/x86/boot=2Erst b/Documentation/x86/boot=2Erst
>index 08a2f100c0e6=2E=2Ea934a56f0516 100644
>--- a/Documentation/x86/boot=2Erst
>+++ b/Documentation/x86/boot=2Erst
>@@ -68,8 +68,25 @@ Protocol 2=2E12	(Kernel 3=2E8) Added the xloadflags
>field and extension fields
> Protocol 2=2E13	(Kernel 3=2E14) Support 32- and 64-bit flags being set i=
n
> 		xloadflags to support booting a 64-bit kernel from 32-bit
> 		EFI
>+
>+Protocol 2=2E14:	BURNT BY INCORRECT COMMIT
>ae7e1238e68f2a472a125673ab506d49158c1889
>+		(x86/boot: Add ACPI RSDP address to setup_header)
>+		DO NOT USE!!! ASSUME SAME AS 2=2E13=2E
>+
>+Protocol 2=2E15:	(Kernel 5=2E3) Added the kernel_info=2E
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>+=2E=2E note::
>+     The protocol version number should be changed only if the setup
>header
>+     is changed=2E There is no need to update the version number if
>boot_params
>+     or kernel_info are changed=2E Additionally, it is recommended to
>use
>+     xloadflags (in this case the protocol version number should not
>be
>+     updated either) or kernel_info to communicate supported Linux
>kernel
>+     features to the boot loader=2E Due to very limited space available
>in
>+     the original setup header every update to it should be considered
>+     with great care=2E Starting from the protocol 2=2E15 the primary wa=
y
>to
>+     communicate things to the boot loader is the kernel_info=2E
>+
>=20
> Memory Layout
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>@@ -207,6 +224,7 @@ Offset/Size	Proto		Name			Meaning
> 0258/8		2=2E10+		pref_address		Preferred loading address
> 0260/4		2=2E10+		init_size		Linear memory required during initialization
> 0264/4		2=2E11+		handover_offset		Offset of handover entry point
>+0268/4		2=2E15+		kernel_info_offset	Offset of the kernel_info
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> =2E=2E note::
>@@ -855,6 +873,77 @@ Offset/size:	0x264/4
>=20
>   See EFI HANDOVER PROTOCOL below for more details=2E
>=20
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>+Field name:	kernel_info_offset
>+Type:		read
>+Offset/size:	0x268/4
>+Protocol:	2=2E15+
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>+
>+  This field is the offset from the beginning of the kernel image to
>the
>+  kernel_info=2E It is embedded in the Linux image in the uncompressed
>+  protected mode region=2E
>+
>+
>+The kernel_info
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+The relationships between the headers are analogous to the various
>data
>+sections:
>+
>+  setup_header =3D =2Edata
>+  boot_params/setup_data =3D =2Ebss
>+
>+What is missing from the above list? That's right:
>+
>+  kernel_info =3D =2Erodata
>+
>+We have been (ab)using =2Edata for things that could go into =2Erodata o=
r
>=2Ebss for
>+a long time, for lack of alternatives and -- especially early on --
>inertia=2E
>+Also, the BIOS stub is responsible for creating boot_params, so it
>isn't
>+available to a BIOS-based loader (setup_data is, though)=2E
>+
>+setup_header is permanently limited to 144 bytes due to the reach of
>the
>+2-byte jump field, which doubles as a length field for the structure,
>combined
>+with the size of the "hole" in struct boot_params that a
>protected-mode loader
>+or the BIOS stub has to copy it into=2E It is currently 119 bytes long,
>which
>+leaves us with 25 very precious bytes=2E This isn't something that can
>be fixed
>+without revising the boot protocol entirely, breaking backwards
>compatibility=2E
>+
>+boot_params proper is limited to 4096 bytes, but can be arbitrarily
>extended
>+by adding setup_data entries=2E It cannot be used to communicate
>properties of
>+the kernel image, because it is =2Ebss and has no image-provided
>content=2E
>+
>+kernel_info solves this by providing an extensible place for
>information about
>+the kernel image=2E It is readonly, because the kernel cannot rely on a
>+bootloader copying its contents anywhere, but that is OK; if it
>becomes
>+necessary it can still contain data items that an enabled bootloader
>would be
>+expected to copy into a setup_data chunk=2E
>+
>+It is recommended to not store large data chunks, e=2Eg=2E strings,
>directly in the
>+kernel_info struct=2E Such data should be placed outside of it and
>pointed from
>+the kernel_info structure using offsets from the beginning of the
>structure,
>+the kernel_info=2Eheader field=2E
>+
>+
>+Details of the kernel_info Fields
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D
>+Field name:	header
>+Offset/size:	0x0000/4
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+  Contains the magic number "InfO" (0x4f666e49)=2E
>+
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D
>+Field name:	size
>+Offset/size:	0x0004/4
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+  This field contains the size of the kernel_info including
>kernel_info=2Eheader=2E
>+  It should be used by the boot loader to detect supported fields in
>the kernel_info=2E
>+
>=20
> The Image Checksum
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
>index e2839b5c246c=2E=2Ec30a9b642a86 100644
>--- a/arch/x86/boot/Makefile
>+++ b/arch/x86/boot/Makefile
>@@ -87,7 +87,7 @@ $(obj)/vmlinux=2Ebin: $(obj)/compressed/vmlinux FORCE
>=20
> SETUP_OBJS =3D $(addprefix $(obj)/,$(setup-y))
>=20
>-sed-zoffset :=3D -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW]
>\(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entr=
y\|input_data\|_end\|_ehead\|_text\|z_=2E*\)$$/\#define
>ZO_\2 0x\1/p'
>+sed-zoffset :=3D -e 's/^\([0-9a-fA-F]*\) [ABCDGRSTVW]
>\(startup_32\|startup_64\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entr=
y\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_=2E*\)$$/\#define
>ZO_\2 0x\1/p'
>=20
> quiet_cmd_zoffset =3D ZOFFSET $@
>       cmd_zoffset =3D $(NM) $< | sed -n $(sed-zoffset) > $@
>diff --git a/arch/x86/boot/compressed/Makefile
>b/arch/x86/boot/compressed/Makefile
>index 6b84afdd7538=2E=2Efad3b18e2cc3 100644
>--- a/arch/x86/boot/compressed/Makefile
>+++ b/arch/x86/boot/compressed/Makefile
>@@ -72,8 +72,8 @@ $(obj)/=2E=2E/voffset=2Eh: vmlinux FORCE
>=20
> $(obj)/misc=2Eo: $(obj)/=2E=2E/voffset=2Eh
>=20
>-vmlinux-objs-y :=3D $(obj)/vmlinux=2Elds $(obj)/head_$(BITS)=2Eo
>$(obj)/misc=2Eo \
>-	$(obj)/string=2Eo $(obj)/cmdline=2Eo $(obj)/error=2Eo \
>+vmlinux-objs-y :=3D $(obj)/vmlinux=2Elds $(obj)/kernel_info=2Eo
>$(obj)/head_$(BITS)=2Eo \
>+	$(obj)/misc=2Eo $(obj)/string=2Eo $(obj)/cmdline=2Eo $(obj)/error=2Eo \
> 	$(obj)/piggy=2Eo $(obj)/cpuflags=2Eo
>=20
> vmlinux-objs-$(CONFIG_EARLY_PRINTK) +=3D $(obj)/early_serial_console=2Eo
>diff --git a/arch/x86/boot/compressed/kernel_info=2ES
>b/arch/x86/boot/compressed/kernel_info=2ES
>new file mode 100644
>index 000000000000=2E=2E3f1cb301b9ff
>--- /dev/null
>+++ b/arch/x86/boot/compressed/kernel_info=2ES
>@@ -0,0 +1,12 @@
>+/* SPDX-License-Identifier: GPL-2=2E0 */
>+
>+	=2Esection "=2Erodata=2Ekernel_info", "a"
>+
>+	=2Eglobal kernel_info
>+
>+kernel_info:
>+        /* Header=2E */
>+	=2Eascii	"InfO"
>+        /* Size=2E */
>+	=2Elong	kernel_info_end - kernel_info
>+kernel_info_end:
>diff --git a/arch/x86/boot/header=2ES b/arch/x86/boot/header=2ES
>index 850b8762e889=2E=2Eec6a25a43148 100644
>--- a/arch/x86/boot/header=2ES
>+++ b/arch/x86/boot/header=2ES
>@@ -557,6 +557,7 @@ pref_address:		=2Equad LOAD_PHYSICAL_ADDR	# preferred
>load addr
>=20
> init_size:		=2Elong INIT_SIZE		# kernel initialization size
> handover_offset:	=2Elong 0			# Filled in by build=2Ec
>+kernel_info_offset:	=2Elong 0			# Filled in by build=2Ec
>=20
># End of setup header
>#####################################################
>=20
>diff --git a/arch/x86/boot/tools/build=2Ec b/arch/x86/boot/tools/build=2E=
c
>index a93d44e58f9c=2E=2E55e669d29e54 100644
>--- a/arch/x86/boot/tools/build=2Ec
>+++ b/arch/x86/boot/tools/build=2Ec
>@@ -56,6 +56,7 @@ u8 buf[SETUP_SECT_MAX*512];
> unsigned long efi32_stub_entry;
> unsigned long efi64_stub_entry;
> unsigned long efi_pe_entry;
>+unsigned long kernel_info;
> unsigned long startup_64;
>=20
>/*----------------------------------------------------------------------*=
/
>@@ -321,6 +322,7 @@ static void parse_zoffset(char *fname)
> 		PARSE_ZOFS(p, efi32_stub_entry);
> 		PARSE_ZOFS(p, efi64_stub_entry);
> 		PARSE_ZOFS(p, efi_pe_entry);
>+		PARSE_ZOFS(p, kernel_info);
> 		PARSE_ZOFS(p, startup_64);
>=20
> 		p =3D strchr(p, '\n');
>@@ -410,6 +412,9 @@ int main(int argc, char ** argv)
>=20
> 	efi_stub_entry_update();
>=20
>+	/* Update kernel_info offset=2E */
>+	put_unaligned_le32(kernel_info, &buf[0x268]);
>+
> 	crc =3D partial_crc32(buf, i, crc);
> 	if (fwrite(buf, 1, i, dest) !=3D i)
> 		die("Writing setup failed");
>diff --git a/arch/x86/include/uapi/asm/bootparam=2Eh
>b/arch/x86/include/uapi/asm/bootparam=2Eh
>index 60733f137e9a=2E=2Eb05318112452 100644
>--- a/arch/x86/include/uapi/asm/bootparam=2Eh
>+++ b/arch/x86/include/uapi/asm/bootparam=2Eh
>@@ -86,6 +86,7 @@ struct setup_header {
> 	__u64	pref_address;
> 	__u32	init_size;
> 	__u32	handover_offset;
>+	__u32	kernel_info_offset;
> } __attribute__((packed));
>=20
> struct sys_desc_table {

I should like to make make things a bit more stringent: additional data sh=
ould be made offsets from the kernel_info structure *and they should live i=
n the =2Erodata=2Ekernel_info section*=2E We should add a size field for th=
e entire =2Ekernel_info section, thus ensuring it is a single self-containe=
d blob=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
