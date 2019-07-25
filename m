Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5BAC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007332190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6YactpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbfGYN3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:29:40 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44675 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGYN3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:29:40 -0400
Received: by mail-yb1-f196.google.com with SMTP id a14so18478255ybm.11;
        Thu, 25 Jul 2019 06:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVu+S23Gv1yOG6EQW2R8cxaCUo15rcMvxts6vU6HpEM=;
        b=Z6YactpJLSqzGorrC5H61mi+l2QDXmU1tZuYDEI4NstQVWsVHXQIMtHqQoictB+Azy
         ikHoEzDoCHZLvq4Z8h4Dd1NWOVVPmB72iN0V9akY4Qc87f3pMAbqYEs6o7o+OOfoUsMl
         ihbURjjk8nvW64kY3mt3oqHZlPI0pD7dpOi8O+14EY2Mo9atEheCddRoMN/VjabuPuHK
         z8MlICk2z7UgWItSjhRpppOTgU7LJ4bm/TPw5BZr0Dn4iG9SInOI+wNw09lwqf1wiJk2
         n4bDsOx/ZY0yPuwCDU7NxFlQmCLMSvjnb+JDn7e/oH/VNjQbkh6QfW/0GW1SUClqd9G7
         RARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVu+S23Gv1yOG6EQW2R8cxaCUo15rcMvxts6vU6HpEM=;
        b=AkIpYmVqpip7yj/jkhInpMP1JFIJlPiQrR10p34/FwIrvsuW3YpHgewAZDlWc8Z/5p
         vBF+IIMSVmlBATPjRkoy+B5oVFm1WFpvGMWjNv/Mm+fyD/aXSHLphB+yel/ZHoNrtwo8
         k9RAi9GYfpLx45XNi5V7s+h6aGHAwMHKEyL0qRdIk9mCWbWroKAjjPEOqadmAhrGRqCL
         VVYISplBQkwJc4yyfzxgMoDgdxOcwsbDeuqaIHVaz/Dit7uTWtL4+jKU51lpmmY0NT3j
         Fl1OIXQ/EXXfXiPrfwL4gRcn5yoagxZy0AjcbM2Mb1V1y7mixDjQUD3pJIyH2jOU4rTN
         BZOQ==
X-Gm-Message-State: APjAAAXw8ocBlElBteBbJxx7VfynSA5tmDf6OIXaSkkefLkF/ZxuUl+4
        SgvVeg/s/miRUrUZ5gIhEs1ajhO1wIoGk9eGstY=
X-Google-Smtp-Source: APXvYqz7f1Ci0npqtyBiHcAFyrc/Uu1/8h6eibamhHeSo/YFbsxEEaq9E+39K305A1gpp77D8WQiAhCH6Xt1m1ZVsGE=
X-Received: by 2002:a25:aaea:: with SMTP id t97mr52207466ybi.126.1564059845729;
 Thu, 25 Jul 2019 06:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190725085732.15674-1-baijiaju1990@gmail.com>
In-Reply-To: <20190725085732.15674-1-baijiaju1990@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 25 Jul 2019 16:03:54 +0300
Message-ID: <CAOQ4uxg1f3rgnc4sitF82FMftROHkubk+3s9=v1Bf47m-zVYBw@mail.gmail.com>
Subject: Re: [PATCH] fs: overlayfs: Fix a possible null-pointer dereference in ovl_free_fs()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 3:48 PM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> In ovl_fill_super(), there is an if statement on line 1607 to check
> whether ofs->upper_mnt is NULL:
>     if (!ofs->upper_mnt)
>
> When ofs->upper_mnt is NULL and d_make_root() on line 1654 fails,
> ovl_free_fs() on line 1683 is executed.
> In ovl_free_fs(), ofs->upper_mnt is used on line 224:
>     ovl_inuse_unlock(ofs->upper_mnt->mnt_root);
>
> Thus, a possible null-pointer dereference may occur.
>
> To fix this bug, ofs->upper_mnt is checked before being used in
> ovl_free_fs().
>
> This bug is found by a static analysis tool STCheck written by us.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  fs/overlayfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index b368e2e102fa..1d7c3d280834 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -220,7 +220,7 @@ static void ovl_free_fs(struct ovl_fs *ofs)
>         if (ofs->workdir_locked)
>                 ovl_inuse_unlock(ofs->workbasedir);
>         dput(ofs->workbasedir);
> -       if (ofs->upperdir_locked)
> +       if (ofs->upperdir_locked && ofs->upper_mnt)
>                 ovl_inuse_unlock(ofs->upper_mnt->mnt_root);
>         mntput(ofs->upper_mnt);
>         for (i = 0; i < ofs->numlower; i++) {
> --

Can you teach STCheck to know that if upperdir_locked is only set this way:
        ofs->upper_mnt = upper_mnt;

        err = -EBUSY;
        if (ovl_inuse_trylock(ofs->upper_mnt->mnt_root)) {
                ofs->upperdir_locked = true;

Then upperdir_locked implies ofs->upper_mnt != NULL?

Whether or not this patch should be applied is not my call,
but the title "possible null-pointer dereference" is certainly not true.

Thanks,
Amir.
