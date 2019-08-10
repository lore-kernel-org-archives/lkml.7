Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6CBC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89008208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwYjtk9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfHJTxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 15:53:49 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40902 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfHJTxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 15:53:49 -0400
Received: by mail-vs1-f68.google.com with SMTP id a186so10611606vsd.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 12:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7WHZ0iMjd+y5AxcpJPPv9/Si0IhWcZrpj60zl/nubnc=;
        b=JwYjtk9Er6QiAGFKksCHmtjgunBpUCUyEpSEhT97xuJsGUpeGEXerinV3lutAkJ6GW
         vwEhaVRZ3qcWU35DlOtK7jM58biKlDAhJwwAAbMwFqLFSVcz/T0JcbZIW0aYE4QoXlgU
         T0THitnvvZIwMDIVmTGE218t0xpU40oiL8JCPiIUbZgQyDXDEmbPRne3qyCB+2cF81l6
         yxT/bsCTjllYmZ/dljdF3tkf6tmL2eKb9PIz6WlunUUy1UF+02VdOImort+wc+mQmNDs
         CV9JbhEdjm/7RdoPHN5mtZUIAVwJcrtRdPIqsdmAX2rCwD88GnQp8MzmZ+FUWHbbChJk
         Fpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7WHZ0iMjd+y5AxcpJPPv9/Si0IhWcZrpj60zl/nubnc=;
        b=LKLX9U1CgZWHPCnWsFgVGMW2fgojUJvFBfDE5qOUeRpuwNj6Vy0JhyzrK91kjQciAM
         3ak8LMKbK8pW2ZBsWSCYFLyLgZGEoMD6JMtxioN/F6OsRDKXh/hrdGwxDfiK4oBB9+7f
         yfogccOURgz17ATZWgS3uh/8QEUFP86wqriF4SFg7ZU0pvfusOH4mvwWGLYV9XaJuzmg
         x6vDRd2lrEV3Jmyg9Vvo/YL0MFrmsuOyxxJoVUxgwpJzYjCRYGa3hlSDq8Ecz8dgTBZZ
         Z5kd+tlbPIBKVnkdRRjIVoGtHa6r6PCNgLiNtIJJzphtdenWdC6x4QuAKgBz8utfVgjZ
         1/DQ==
X-Gm-Message-State: APjAAAV+IaXrnkZg5FCaUbK+M83+lzjhdpCyVqAUOtSspDWezUEn2WlA
        JlzF7M4tITgsjMPdZ1Vi9oGcH9qObRXT0KeHwJM=
X-Google-Smtp-Source: APXvYqzrHeuOxmth4tU/7yLbE618cFdFWZToMJadZdpNsejf89DvMaLfvT/XK8esuOZbHBUY3RkcHJP+nWyL+ihQWJ8=
X-Received: by 2002:a67:79d4:: with SMTP id u203mr17584811vsc.85.1565466827820;
 Sat, 10 Aug 2019 12:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190711012915.5581-1-yuchao0@huawei.com>
In-Reply-To: <20190711012915.5581-1-yuchao0@huawei.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Sun, 11 Aug 2019 04:53:37 +0900
Message-ID: <CAD14+f3fiY8m7f91-ohHUj8ThMeYF7+Q=DU8c2c_8PTis8t-mw@mail.gmail.com>
Subject: Re: [PATCH v2] f2fs: improve print log in f2fs_sanity_check_ckpt()
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

I think we'll all appreciate if v1.13.0 gets tagged :)
I believe the current dev branch has been in good shape for quite some time=
 now.

Thanks.


2019=EB=85=84 7=EC=9B=94 11=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 10:31, =
Chao Yu <yuchao0@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> As Park Ju Hyung suggested:
>
> "I'd like to suggest to write down an actual version of f2fs-tools
> here as we've seen older versions of fsck doing even more damage
> and the users might not have the latest f2fs-tools installed."
>
> This patch give a more detailed info of how we fix such corruption
> to user to avoid damageable repair with low version fsck.
>
> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - add fixing patch's title in log suggested by Jaegeuk.
>  fs/f2fs/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1a6d82d558e4..47dae7c3ae4f 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2696,7 +2696,9 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi=
)
>
>         if (__is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG) &&
>                 le32_to_cpu(ckpt->checksum_offset) !=3D CP_MIN_CHKSUM_OFF=
SET) {
> -               f2fs_warn(sbi, "layout of large_nat_bitmap is deprecated,=
 run fsck to repair, chksum_offset: %u",
> +               f2fs_warn(sbi, "using deprecated layout of large_nat_bitm=
ap, "
> +                         "please run fsck v1.13.0 or higher to repair, c=
hksum_offset: %u, "
> +                         "fixed with patch: \"f2fs-tools: relocate chksu=
m_offset for large_nat_bitmap feature\"",
>                           le32_to_cpu(ckpt->checksum_offset));
>                 return 1;
>         }
> --
> 2.18.0.rc1
>
