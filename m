Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D15CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80CB21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="YhCGJSwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394264AbfJYGRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:17:19 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46682 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731951AbfJYGRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:17:19 -0400
Received: by mail-yw1-f68.google.com with SMTP id l64so397941ywe.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 23:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t+yDxeJ4XXUfVCaR59MeudlF/U+2+GZcUOdyGt0CB5Q=;
        b=YhCGJSwQ9TTQBhhxucTYrDeV7z+w9I4hUnYYPbd+7CnpCsv8I7IlwAawleMov14EjE
         O1+66T5zWP10fsVWw/L5bnnqPSe18Xmlb2/JrQazfMXXw8IzjAXfMDx7hkfb15x3DYlW
         0ox+91Ik+iusEB1287w0Z+O6rC5G2rB/YQyUhZtQI8tPgIigbE+H05iZChfrrzZ6FGdD
         rE/o4WO1Bvx3YOngvu4G+r6hiawznP/abvCwc2IMb7V4L2RfEN0LT/W9z8v+ipcfuCwZ
         vTQj0qSh/OWFbGIeC/mndONFr9JRtr/oey0JTge08cI+I47h8/jX2U1OEaKIc4o4jCOb
         T/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t+yDxeJ4XXUfVCaR59MeudlF/U+2+GZcUOdyGt0CB5Q=;
        b=DDaJUffpjRTwuRCrduf/FvjXUntIxSFpL+29sAUOBp99I4ahSVCl4V4Y7uR6Gs0Zla
         yKYNIkPtSkzbWYaPtvU5+0bM2Q09C9FH/RngvPpb9F0RyLO94sh/piq6P/WioJb7sojH
         6xglXRD7QgOyOGpSDDBdeEapLrNk+vvH+BV3A+Awq2J4vR/aQws+E6B73t65aJ6EE/KL
         RhecVoV5wNfy8cX8ILzTG29Vf7sTbMO8m8XwoGfgiJm/xkX0ZtTylpdJ8CSfzi0co0Hc
         9sAQhbmKoKk6h6sqSD8fqDNKqWHX4aApIu7G63OTxH5a17kEw9AU7BAdBTyhWusM+wvm
         MFQA==
X-Gm-Message-State: APjAAAX0aQ9WJ26bIhOxS1oeKABtgJrJoZHIYYyNepQSAdJP5L2gpDb3
        bwHwJMn/6Mn9bYtxnmJQ2LlgXLwGJW2DhiTMtsfcbEJo1AV7tw==
X-Google-Smtp-Source: APXvYqzEPTSM0KLSa5ajm2bHgWPz/RmODhHm+90VIwPxzUzt8CiapNVzJecVKlMg4ztUfUT6uzEbKgJ/XjfdXEkmS/g=
X-Received: by 2002:a81:25d7:: with SMTP id l206mr896584ywl.36.1571984236754;
 Thu, 24 Oct 2019 23:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <051fa6cf19fac4ae7029ac9e85fe12caa29b4011.1570530267.git.michal.simek@xilinx.com>
In-Reply-To: <051fa6cf19fac4ae7029ac9e85fe12caa29b4011.1570530267.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Fri, 25 Oct 2019 08:17:05 +0200
Message-ID: <CAHTX3d+b0fFdGwT9fN-GP_3JA3wPYVGFakfgXQod+CsN7skdnQ@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Increase max dtb size to 64K from 32K
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <james.morris@microsoft.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 8. 10. 2019 v 12:24 odes=C3=ADlatel Michal Simek <michal.simek@xili=
nx.com> napsal:
>
> From: Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>
>
> This patch increases max dtb size to 64K from 32K. This fixes the issue  =
of
> kernel hang with larger dtb of size greater than 32KB.
>
> Signed-off-by: Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com=
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/microblaze/kernel/head.S        | 2 +-
>  arch/microblaze/kernel/vmlinux.lds.S | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/microblaze/kernel/head.S b/arch/microblaze/kernel/head.=
S
> index f264fdcf152a..7d2894418691 100644
> --- a/arch/microblaze/kernel/head.S
> +++ b/arch/microblaze/kernel/head.S
> @@ -99,7 +99,7 @@ big_endian:
>  _prepare_copy_fdt:
>         or      r11, r0, r0 /* incremment */
>         ori     r4, r0, TOPHYS(_fdt_start)
> -       ori     r3, r0, (0x8000 - 4)
> +       ori     r3, r0, (0x10000 - 4)
>  _copy_fdt:
>         lw      r12, r7, r11 /* r12 =3D r7 + r11 */
>         sw      r12, r4, r11 /* addr[r4 + r11] =3D r12 */
> diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kerne=
l/vmlinux.lds.S
> index e1f3e8741292..71072c5cf61f 100644
> --- a/arch/microblaze/kernel/vmlinux.lds.S
> +++ b/arch/microblaze/kernel/vmlinux.lds.S
> @@ -46,7 +46,7 @@ SECTIONS {
>         __fdt_blob : AT(ADDR(__fdt_blob) - LOAD_OFFSET) {
>                 _fdt_start =3D . ;                /* place for fdt blob *=
/
>                 *(__fdt_blob) ;                 /* Any link-placed DTB */
> -               . =3D _fdt_start + 0x8000;        /* Pad up to 32kbyte */
> +               . =3D _fdt_start + 0x10000;       /* Pad up to 64kbyte */
>                 _fdt_end =3D . ;
>         }
>
> --
> 2.17.1
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
