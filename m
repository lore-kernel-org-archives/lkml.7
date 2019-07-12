Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EADC742CA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A8721019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XzmdUZ1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfGLP5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:57:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43325 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfGLP5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:57:12 -0400
Received: from [IPv6:2601:646:8600:3281:4501:6781:c7ce:2878] ([IPv6:2601:646:8600:3281:4501:6781:c7ce:2878])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x6CFupr53480184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 12 Jul 2019 08:56:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x6CFupr53480184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562947015;
        bh=0Ve+yG3uaVMCO27iKj29VEVpxeHgGM2Sv8NdJ11gjDE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=XzmdUZ1QaJrOXoC1U8mVajBB03oao8GSugWbzSWg7SvA+iBte2MpUZG7+G9UDpPIV
         jNNRyJdekkavhwyvRAE4El72IsDVuhDhUf1KUpyLLQbzXF2UvzWBX4vUK0xblRWHVU
         2UIIzOuh55TcKL/c7f/50vYz/7PwPlAd0tBuMNdVDFK00k4VUUGxn00BfpHdzDlwVD
         pEUdMyo6AK+Y/tZPr00Hw4FBCD+u8y3iNOCjHxFTCqW4TGLws7Cj9NJ4yq0PPPBkbD
         aZgA2nXtx1qCLzkid5OwCaPI6nxWx3arQhdSSki8LT+FqPhMqlSly170G7z6Hxr+6g
         8XOkPuLOo4Aiw==
Date:   Fri, 12 Jul 2019 08:56:44 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190704163612.14311-3-daniel.kiper@oracle.com>
References: <20190704163612.14311-1-daniel.kiper@oracle.com> <20190704163612.14311-3-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] x86/boot: Introduce the setup_indirect
To:     Daniel Kiper <daniel.kiper@oracle.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
CC:     bp@alien8.de, corbet@lwn.net, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com,
        ross.philipson@oracle.com, tglx@linutronix.de
From:   hpa@zytor.com
Message-ID: <143DFBDE-E604-48E0-8072-6DB68E3E83C1@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 4, 2019 9:36:11 AM PDT, Daniel Kiper <daniel=2Ekiper@oracle=2Ecom> =
wrote:
>The setup_data is a bit awkward to use for extremely large data
>objects,
>both because the setup_data header has to be adjacent to the data
>object
>and because it has a 32-bit length field=2E However, it is important that
>intermediate stages of the boot process have a way to identify which
>chunks of memory are occupied by kernel data=2E
>
>Thus we introduce a uniform way to specify such indirect data as
>setup_indirect struct and SETUP_INDIRECT type=2E
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
>   - add setup_indirect usage example
>     (suggested by Eric Snowberg and Ross Philipson)=2E
>---
>Documentation/x86/boot=2Erst            | 38
>++++++++++++++++++++++++++++++++++-
> arch/x86/include/uapi/asm/bootparam=2Eh | 11 +++++++++-
> 2 files changed, 47 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/x86/boot=2Erst b/Documentation/x86/boot=2Erst
>index a934a56f0516=2E=2E23d3726d54fc 100644
>--- a/Documentation/x86/boot=2Erst
>+++ b/Documentation/x86/boot=2Erst
>@@ -73,7 +73,7 @@ Protocol 2=2E14:	BURNT BY INCORRECT COMMIT
>ae7e1238e68f2a472a125673ab506d49158c188
> 		(x86/boot: Add ACPI RSDP address to setup_header)
> 		DO NOT USE!!! ASSUME SAME AS 2=2E13=2E
>=20
>-Protocol 2=2E15:	(Kernel 5=2E3) Added the kernel_info=2E
>+Protocol 2=2E15:	(Kernel 5=2E3) Added the kernel_info and setup_indirect=
=2E
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> =2E=2E note::
>@@ -827,6 +827,42 @@ Protocol:	2=2E09+
>   sure to consider the case where the linked list already contains
>   entries=2E
>=20
>+  The setup_data is a bit awkward to use for extremely large data
>objects,
>+  both because the setup_data header has to be adjacent to the data
>object
>+  and because it has a 32-bit length field=2E However, it is important
>that
>+  intermediate stages of the boot process have a way to identify which
>+  chunks of memory are occupied by kernel data=2E
>+
>+  Thus setup_indirect struct and SETUP_INDIRECT type were introduced
>in
>+  protocol 2=2E15=2E
>+ =20
>+  struct setup_indirect {
>+    __u32 type;
>+    __u32 reserved;  /* Reserved, must be set to zero=2E */
>+    __u64 len;
>+    __u64 addr;
>+  };
>+
>+  The type member is itself simply a SETUP_* type=2E However, it cannot
>be
>+  SETUP_INDIRECT since making the setup_indirect a tree structure
>could
>+  require a lot of stack space in something that needs to parse it and
>+  stack space can be limited in boot contexts=2E
>+
>+  Let's give an example how to point to SETUP_E820_EXT data using
>setup_indirect=2E
>+  In this case setup_data and setup_indirect will look like this:
>+
>+  struct setup_data {
>+    __u64 next =3D 0 or <addr_of_next_setup_data_struct>;
>+    __u32 type =3D SETUP_INDIRECT;
>+    __u32 len =3D sizeof(setup_data);
>+    __u8 data[sizeof(setup_indirect)] =3D struct setup_indirect {
>+      __u32 type =3D SETUP_E820_EXT;
>+      __u32 reserved =3D 0;
>+      __u64 len =3D <len_of_SETUP_E820_EXT_data>;
>+      __u64 addr =3D <addr_of_SETUP_E820_EXT_data>;
>+    }
>+  }
>+
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Field name:	pref_address
> Type:		read (reloc)
>diff --git a/arch/x86/include/uapi/asm/bootparam=2Eh
>b/arch/x86/include/uapi/asm/bootparam=2Eh
>index b05318112452=2E=2Eaaaa17fa6ad6 100644
>--- a/arch/x86/include/uapi/asm/bootparam=2Eh
>+++ b/arch/x86/include/uapi/asm/bootparam=2Eh
>@@ -2,7 +2,7 @@
> #ifndef _ASM_X86_BOOTPARAM_H
> #define _ASM_X86_BOOTPARAM_H
>=20
>-/* setup_data types */
>+/* setup_data/setup_indirect types */
> #define SETUP_NONE			0
> #define SETUP_E820_EXT			1
> #define SETUP_DTB			2
>@@ -10,6 +10,7 @@
> #define SETUP_EFI			4
> #define SETUP_APPLE_PROPERTIES		5
> #define SETUP_JAILHOUSE			6
>+#define SETUP_INDIRECT			7
>=20
> /* ram_size flags */
> #define RAMDISK_IMAGE_START_MASK	0x07FF
>@@ -47,6 +48,14 @@ struct setup_data {
> 	__u8 data[0];
> };
>=20
>+/* extensible setup indirect data node */
>+struct setup_indirect {
>+	__u32 type;
>+	__u32 reserved;  /* Reserved, must be set to zero=2E */
>+	__u64 len;
>+	__u64 addr;
>+};
>+
> struct setup_header {
> 	__u8	setup_sects;
> 	__u16	root_flags;

This needs actual implementation; we can't advertise it until the kernel k=
nows how to consume the data! It probably should be moved to after the 3/3 =
patch=2E

Implementing this has two parts:

1=2E The kernel needs to be augmented so it can find current objects via i=
ndirection=2E

2=2E And this is the main reason for this in the first place: the early co=
de needs to walk the list and map out the memory areas which are occupied s=
o it doesn't clobber anything; this allows this code to be generic as oppos=
ed to having to know what is a pointer and what size it might point to=2E

(The decompressor didn't need this until kaslr entered the picture, but no=
w it does, sadly=2E)

Optional/future enhancements that might be nice:

3=2E Add some kind of description (e=2Eg=2E foo=3Du64 ; bar=3Dstr ; baz=3D=
blob) to make it possible to write a bootloader that can load these kinds o=
f objects without specific enabling=2E

4=2E Add support for mapping initramfs fragments  this way=2E

5=2E Add support for passingload-on-boot kernel modules=2E

6=2E =2E=2E=2E ?

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
