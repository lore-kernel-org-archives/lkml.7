Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F37C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EE820868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2c9pLon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfEVUaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:30:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35762 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfEVUaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:30:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id q15so3546055wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sC3y19sKHEp/s8yyLY2YBtsOBxNiD5rQEEH0tqDB6yI=;
        b=G2c9pLon27AIci+0l2Y7s2L5FjbKg/u155sKOM/AN4igPsIl9bFZu3YqzEmBLe2VSN
         jHsDIKHucWAF/zth90hQq32UkNdkYA7ed9UEGoIrR/CIcXp+iFZnHkHPV4UM5Volvnqi
         46Nze78L1H+qEAfI+Dz/5o87tLIHVm0zg2YAsHIBczNqDfBq4T3yL41T4+7uiVUdGlbY
         IUFK1J0gdszsfaTDCNd/5oPee21k+bEgfJuEpcZPpFXWXgAMm3UU+F8PjFw54wbtIHIn
         rSmEnD+X8P8LJqpgCA8pDtcUh9qnbJiqDAPYWk5HcW9ypjDRLDybNDJY925eksQ5myGF
         UoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sC3y19sKHEp/s8yyLY2YBtsOBxNiD5rQEEH0tqDB6yI=;
        b=METrEAZTcOTm00gAQaA55Oo+HNsrgc+GGzgI1yRXnEG08AQ4aIJdAiqlDb0bPG2Z/Z
         rePdtWkQiXm3X+T0RUeDDswfyCrLaFIAcMBUhLn9gsDcjfMhRK1FSNlGQheZEAPN+Y11
         49fpRDQGpJ06OuF7AMNBrFVGTyhZ/dlIOkoaL1aR//0C/jzyFlg8df1qw0x1xp2SnMWc
         3C8JUgIeuB36ffTLGleQU4a95DFszb/CCIaX++Ww/wU/+fRWEBE9hl269h0M0PboShn8
         32gTIn52HLyQBwkn+MSePmsaMGUGZ0rXtzS6CgTyuI9+VUPaxwLxLczkTZFe/+4n63Kw
         dXRA==
X-Gm-Message-State: APjAAAX8boxKoIwWaFtwpBEDfYA5km8qqzt5M2G4GY0J3XBTZEjPElNv
        FsmrShgj9tZkoAfPlMGglLOIunBv/uUzlPKBXg0=
X-Google-Smtp-Source: APXvYqzCDttVuV3S2Hs69NFBc6cY/CTgyKkTj/VXvMkOP87zNSUd8S3GBhOIbmhzikh84BFtb4/QMkOM++lNettVBII=
X-Received: by 2002:a1c:4087:: with SMTP id n129mr9133575wma.14.1558557019332;
 Wed, 22 May 2019 13:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190522000753.13300-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20190522000753.13300-1-chris.packham@alliedtelesis.co.nz>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 22 May 2019 22:30:08 +0200
Message-ID: <CAFLxGvzvAdhmNOaNmPCRXUR9GGgaQ1n2HuRLLCb4Nj-tUrm5yQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: concat: refactor concat_lock/concat_unlock
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 2:08 AM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> concat_lock() and concat_unlock() only differed in terms of the mtd_xx
> operation they called. Refactor them to use a common helper function and
> pass mtd_lock or mtd_unlock as an argument.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  drivers/mtd/mtdconcat.c | 41 +++++++++--------------------------------
>  1 file changed, 9 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
> index cbc5925e6440..9514cd2db63c 100644
> --- a/drivers/mtd/mtdconcat.c
> +++ b/drivers/mtd/mtdconcat.c
> @@ -451,7 +451,8 @@ static int concat_erase(struct mtd_info *mtd, struct erase_info *instr)
>         return err;
>  }
>
> -static int concat_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> +static int __concat_xxlock(struct mtd_info *mtd, loff_t ofs, uint64_t len,
> +                          int (*mtd_op)(struct mtd_info *mtd, loff_t ofs, uint64_t len))
>  {
>         struct mtd_concat *concat = CONCAT(mtd);
>         int i, err = -EINVAL;
> @@ -470,7 +471,7 @@ static int concat_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>                 else
>                         size = len;
>
> -               err = mtd_lock(subdev, ofs, size);
> +               err = mtd_op(subdev, ofs, size);
>                 if (err)
>                         break;
>
> @@ -485,38 +486,14 @@ static int concat_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>         return err;
>  }
>
> -static int concat_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> +static int concat_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>  {
> -       struct mtd_concat *concat = CONCAT(mtd);
> -       int i, err = 0;
> -
> -       for (i = 0; i < concat->num_subdev; i++) {
> -               struct mtd_info *subdev = concat->subdev[i];
> -               uint64_t size;
> -
> -               if (ofs >= subdev->size) {
> -                       size = 0;
> -                       ofs -= subdev->size;
> -                       continue;
> -               }
> -               if (ofs + len > subdev->size)
> -                       size = subdev->size - ofs;
> -               else
> -                       size = len;
> -
> -               err = mtd_unlock(subdev, ofs, size);
> -               if (err)
> -                       break;
> -
> -               len -= size;
> -               if (len == 0)
> -                       break;
> -
> -               err = -EINVAL;
> -               ofs = 0;
> -       }
> +       return __concat_xxlock(mtd, ofs, len, mtd_lock);
> +}
>
> -       return err;
> +static int concat_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> +{
> +       return __concat_xxlock(mtd, ofs, len, mtd_unlock);
>  }
>
>  static void concat_sync(struct mtd_info *mtd)

Not sure if it passing a function pointer is worth it. bool is_lock would
also do it. But this is a matter of taste, I guess. :)

Reviewed-by: Richard Weinberger <richard@nod.at>

-- 
Thanks,
//richard
