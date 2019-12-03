Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6B7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E195206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t31lF0y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfLCKxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:53:47 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36308 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCKxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:53:47 -0500
Received: by mail-oi1-f194.google.com with SMTP id c16so2860244oic.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 02:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hh33m20eFdMMbq7j0e07H2jRKSTT4mxBLnwnFIeSa8c=;
        b=t31lF0y0WLFdwupPTjUdLJ33Wkx25/tF8Z0n6Hs6PM5Clydb8Qw/+82RZoHIfgjuEZ
         5Y0imTG2QyPc6C/pflui+ovcCd8mxAHpBCkO6LlQL2Ei6QhhWr9UUR1ptUjg2GKD7nrA
         Z2lFLiN2KTMJZDFDMAoP1SiO6Ie5euPSDs7/XRiSaZ8iEpSt9WTKnwDRyfRnt+B9EYaf
         9qeW8z/0rr7Ps3IuBvavpEdE7BkU8fGBSPIWRbJmrF5OLQyZReSeMMndfc/Ksx2ZVsi4
         z4VjOFPu+X0ZaHITd26Aq3J+AptA9ekOYNofnbh7vvp/Rc5eqGK1gC3HPxZGEZIxmH44
         TskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hh33m20eFdMMbq7j0e07H2jRKSTT4mxBLnwnFIeSa8c=;
        b=OYRFFjowpBEfrVHUBCvhymJYSHUVLhNtOnsriZi2+Ja6ZdPaPvzNcz0lththWDTTlH
         V0gMGgPBa5yPHHKF1YymMOSnUd/x0h4Uqwl8lDtiO4xUJW+BCeEm8Y/QFFBLyAc5iaiK
         wULfkIjwSU316JmXJKoeha0nOlV8CmrGaoprLqxA/xmnRfw1ATlTpyPrdsoGp2S1rYi+
         NAd2fX1lDzbi4zXsyJc1LIM+jSiTgH6ZwC/2Sfe0/b6/NxF/ydp+i1Dkc0WTfIBOpno5
         EB+GmZasS15adCTBWIbYngEL83pYlzjlTXZzWgtStSdSwMeQrcDph+AK0HaEcbUQBdvJ
         B8cA==
X-Gm-Message-State: APjAAAVpWZLGQQG+O+i+IL60XCEKf0kMsO1ieX3G43GsK29ArJJopxeB
        9592kdtyXk1FD83a/MZyGaEHqBzqZnZCsGPKB2w=
X-Google-Smtp-Source: APXvYqytXVz+zSgAtVajnF9NHWzmpVpNZikwlrDKDDbBg6hGX3hIe91ZgxM7mbIAdbl3C8pnbvkQveUdPGuIDEcqSUU=
X-Received: by 2002:a54:4601:: with SMTP id p1mr2867534oip.50.1575370426070;
 Tue, 03 Dec 2019 02:53:46 -0800 (PST)
MIME-Version: 1.0
References: <MN2PR02MB5727000CBE70BAF31F60FEE4AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
 <20191203084134.tgzir4mtekpm5xbs@pengutronix.de> <MN2PR02MB57272E3343CA62ADBA0F97E5AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
 <614898763.105471.1575364223372.JavaMail.zimbra@nod.at> <CALgLF9KPAk_AsecnTMmbdF5qbgqXe7HNOrNariNVbhSr6FVN2g@mail.gmail.com>
 <20191203104558.vpqav3oxsydoe4aw@pengutronix.de>
In-Reply-To: <20191203104558.vpqav3oxsydoe4aw@pengutronix.de>
From:   naga suresh kumar <nagasureshkumarrelli@gmail.com>
Date:   Tue, 3 Dec 2019 16:23:34 +0530
Message-ID: <CALgLF9+H-8BdZ0BkmpcEL8B1G1cpPsC+=5oqz6ErnTOhnG7yZQ@mail.gmail.com>
Subject: Re: ubifs mount failure
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Richard Weinberger <richard@nod.at>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        siva.durga.paladugu@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

Tested this patch. and it worked.
Thanks for your quick response.

On Tue, Dec 3, 2019 at 4:16 PM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> On Tue, Dec 03, 2019 at 04:06:12PM +0530, naga suresh kumar wrote:
> > Hi Richard,
> >
> > On Tue, Dec 3, 2019 at 2:40 PM Richard Weinberger <richard@nod.at> wrot=
e:
> > >
> > > ----- Urspr=C3=BCngliche Mail -----
> > > > Von: "Naga Sureshkumar Relli" <nagasure@xilinx.com>
> > > > https://elixir.bootlin.com/linux/v5.4/source/fs/ubifs/sb.c#L164
> > > > we are trying to allocate 4325376 (~4MB)
> > >
> > > 4MiB? Is ->min_io_size that large?
> > if you see https://elixir.bootlin.com/linux/latest/source/fs/ubifs/sb.c=
#L164
> > The size is actually ALIGN(tmp, c->min_io_size).
> > Here tmp is of 4325376 Bytes and min_io_size is 16384 Bytes
>
> 'tmp' contains bogus values. Try this:
>
> ----------------------------8<--------------------------------
>
> From 34f687fce189085f55706b4cddcb288a08f4ee06 Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Tue, 3 Dec 2019 11:41:20 +0100
> Subject: [PATCH] ubifs: Fix wrong memory allocation
>
> In create_default_filesystem() when we allocate the idx node we must use
> the idx_node_size we calculated just one line before, not tmp, which
> contains completely other data.
>
> Fixes: c4de6d7e4319 ("ubifs: Refactor create_default_filesystem()")
> Reported-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  fs/ubifs/sb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
> index a551eb3e9b89..6681c18e52b8 100644
> --- a/fs/ubifs/sb.c
> +++ b/fs/ubifs/sb.c
> @@ -161,7 +161,7 @@ static int create_default_filesystem(struct ubifs_inf=
o *c)
>         sup =3D kzalloc(ALIGN(UBIFS_SB_NODE_SZ, c->min_io_size), GFP_KERN=
EL);
>         mst =3D kzalloc(c->mst_node_alsz, GFP_KERNEL);
>         idx_node_size =3D ubifs_idx_node_sz(c, 1);
> -       idx =3D kzalloc(ALIGN(tmp, c->min_io_size), GFP_KERNEL);
> +       idx =3D kzalloc(ALIGN(idx_node_size, c->min_io_size), GFP_KERNEL)=
;
>         ino =3D kzalloc(ALIGN(UBIFS_INO_NODE_SZ, c->min_io_size), GFP_KER=
NEL);
>         cs =3D kzalloc(ALIGN(UBIFS_CS_NODE_SZ, c->min_io_size), GFP_KERNE=
L);
>
> --
> 2.24.0
>
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

Thanks,
Naga Sureshkumar Relli.
