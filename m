Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89271C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53ADE21901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MS+1z7NY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbfGYCM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:12:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45649 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387963AbfGYCM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:12:58 -0400
Received: from [IPv6:2607:fb90:a50f:a2e4:79d3:e330:d97b:7c5f] ([IPv6:2607:fb90:a50f:a2e4:79d3:e330:d97b:7c5f])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x6P2Cb5J798886
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 24 Jul 2019 19:12:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x6P2Cb5J798886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564020758;
        bh=rKZOqY1F2ebJKkhtINtyKy+Q8fRNkAOwK+MA5F5XPx0=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=MS+1z7NYShCCJlmRufhxhrQcnJLhkgCd0Mdpqisei3dpSAf5eG+w3Y2/PQq8KaYON
         41JZH0P+OPlhJVF9U/kuTxEAV0bMPy0bN3O1JEVJnodpT8GD2oPAmQkqM+72iFu78y
         TiZh0PoR1znC7bHyjdN37myQoe9KynLLxr+PGDdKG9wQXz+o7lICTwBeKjjwPhgeuA
         pH5j7nwzvOfGbC7ftmUcRt98E0SSvsGF8fIbu2G17QeE6CFWUROQexJSiWvBFAAehs
         4F7AFRt+wNnNlsjeO/NI0h+sU4acp63el11b4UWHELuYnCtJ3eLUY6DegGN0UDv1Y6
         Z4ESc3ZlD49oQ==
Date:   Wed, 24 Jul 2019 19:12:33 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190724231528.32381-2-jhubbard@nvidia.com>
References: <20190724231528.32381-1-jhubbard@nvidia.com> <20190724231528.32381-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] x86/boot: clear some fields explicitly
To:     john.hubbard@gmail.com
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
From:   hpa@zytor.com
Message-ID: <B7DC31CA-E378-445A-A937-1B99490C77B4@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 24, 2019 4:15:28 PM PDT, john=2Ehubbard@gmail=2Ecom wrote:
>From: John Hubbard <jhubbard@nvidia=2Ecom>
>
>Recent gcc compilers (gcc 9=2E1) generate warnings about an
>out of bounds memset, if you trying memset across several fields
>of a struct=2E This generated a couple of warnings on x86_64 builds=2E
>
>Because struct boot_params is __packed__, normal variable
>variable assignment will work just as well as a memset here=2E
>Change three u32 fields to be cleared to zero that way, and
>just memset the _pad4 field=2E
>
>This clears up the build warnings for me=2E
>
>Signed-off-by: John Hubbard <jhubbard@nvidia=2Ecom>
>---
> arch/x86/include/asm/bootparam_utils=2Eh | 11 +++++------
> 1 file changed, 5 insertions(+), 6 deletions(-)
>
>diff --git a/arch/x86/include/asm/bootparam_utils=2Eh
>b/arch/x86/include/asm/bootparam_utils=2Eh
>index 101eb944f13c=2E=2E4df87d4a043b 100644
>--- a/arch/x86/include/asm/bootparam_utils=2Eh
>+++ b/arch/x86/include/asm/bootparam_utils=2Eh
>@@ -37,12 +37,11 @@ static void sanitize_boot_params(struct boot_params
>*boot_params)
> 	if (boot_params->sentinel) {
> 		/* fields in boot_params are left uninitialized, clear them */
> 		boot_params->acpi_rsdp_addr =3D 0;
>-		memset(&boot_params->ext_ramdisk_image, 0,
>-		       (char *)&boot_params->efi_info -
>-			(char *)&boot_params->ext_ramdisk_image);
>-		memset(&boot_params->kbd_status, 0,
>-		       (char *)&boot_params->hdr -
>-		       (char *)&boot_params->kbd_status);
>+		boot_params->ext_ramdisk_image =3D 0;
>+		boot_params->ext_ramdisk_size =3D 0;
>+		boot_params->ext_cmd_line_ptr =3D 0;
>+
>+		memset(&boot_params->_pad4, 0, sizeof(boot_params->_pad4));
> 		memset(&boot_params->_pad7[0], 0,
> 		       (char *)&boot_params->edd_mbr_sig_buffer[0] -
> 			(char *)&boot_params->_pad7[0]);

The problem with this is that it will break silently when changes are made=
 to this structure=2E

So, that is a NAK from me=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
