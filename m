Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E74CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49374206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RA++pnfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfLCTJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:09:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46751 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfLCTJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:09:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so5060093wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 11:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RgM6aRu1VoXAsJhtsKrEwRnmsLudyDcKIfYzB5q/ENA=;
        b=RA++pnfQwShG7t7eeG40JlPYoxkhxadW+dqsRuZCr/BhsDQCK9o5hB2E2bpg7qTKJ/
         9oekQYEXIUArmnqXmnVfJCY1Rr0MsY5B6JuafbGy+3RLUBtJPB73BaIqi8js28QsqL7i
         myoThZneq3PVu4p8XIUv14JEac3KKFYj0yPxTZcCE47r+uTlItCTKf/Z56R7zaIFIHAr
         XOM0QSpGFXG9CIo5HaS4BsaqPWtRALjNFrbubckDom/x57LESokOTQdg0RIUQ3EpJJ4Q
         xLiSA/iHgJXh34dm5KfLml+XMkyhQpl/X8WozhlLKc1amJKekI/i53DgwFUa4UXfO8J+
         uqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RgM6aRu1VoXAsJhtsKrEwRnmsLudyDcKIfYzB5q/ENA=;
        b=Bq0VF9j45oUcMKqiKhT9qONpWUYYl4ohfSpUhoTodmBYNDaITfSpjjzF+W+LPsPxkc
         LzLmWp87QMTTay2OI06M2U1VlBPdTkRu+iEn8PZ2kPVLMRjVxnOh8oVX+2K6cJS0WTj7
         vyKhCPdBFbpKw7TU7Idyy6vgcnoClq0v4NSbjYlyeg56BER+7Pgdqg8o4j6ZOsFhrjql
         Mr9xOgOBZJN3GT7ugltqDo/5eRQYb/9vXpb6MlsC2wHDrCHc8wBO0gWUDtH9DlV8ng0T
         W/pJPW2Knq+Aool2yM9dMT4SmfgxWXms2ZvUSLtNFUutbJk0C7+WBIpNe8QeBGfoZOMr
         ytIg==
X-Gm-Message-State: APjAAAXUaJ6oJ+xIgkfJ/pBseQlvc35N9m5Zv05vxOY2A0nuy9yI15a4
        YKi5Wlxbh2RRKBgDXhG0ciPwdEj0WSlgzzZm0S4=
X-Google-Smtp-Source: APXvYqxGAfIQu4FpQhh634WKvpxzJjRIZ8l9v/+EYTu9HrUxNxqBPtaD1Y7gBXDf+NcLNtGGrUlJj+9hB7NeQDFgQ9E=
X-Received: by 2002:a5d:480b:: with SMTP id l11mr7069833wrq.129.1575400139644;
 Tue, 03 Dec 2019 11:08:59 -0800 (PST)
MIME-Version: 1.0
References: <MN2PR02MB5727000CBE70BAF31F60FEE4AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
 <20191203084134.tgzir4mtekpm5xbs@pengutronix.de> <MN2PR02MB57272E3343CA62ADBA0F97E5AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
 <614898763.105471.1575364223372.JavaMail.zimbra@nod.at> <CALgLF9KPAk_AsecnTMmbdF5qbgqXe7HNOrNariNVbhSr6FVN2g@mail.gmail.com>
 <20191203104558.vpqav3oxsydoe4aw@pengutronix.de>
In-Reply-To: <20191203104558.vpqav3oxsydoe4aw@pengutronix.de>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 3 Dec 2019 20:08:48 +0100
Message-ID: <CAFLxGvywFxSrDLLGnLDW6+rMLVUA9Yoi=3sn7wdxqWMydy-w0g@mail.gmail.com>
Subject: Re: ubifs mount failure
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     naga suresh kumar <nagasureshkumarrelli@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        siva durga paladugu <siva.durga.paladugu@xililnx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 11:46 AM Sascha Hauer <s.hauer@pengutronix.de> wrote=
:
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

Oh, looks good! Thanks for fixing, Sascha!

Thanks,
//richard
