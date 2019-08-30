Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48772C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8FD22CEA
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="VG0l1vYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfH3B2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:28:24 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45937 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfH3B2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:28:24 -0400
Received: by mail-yw1-f68.google.com with SMTP id n69so1827400ywd.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 18:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1NLtIL4mp2qHTi5hOVwYkkuVD4cT9jE/SqJqjf/988o=;
        b=VG0l1vYyTezDPmlCvZndRIN9LUTbWs54StnMoM5QDy30R0ucZcLzwxswfDoZtpnlOK
         1Cn9bB+eo4i0CRn4cIw+rkjxoattmez+qzoUIwYTnUwZ3PrFjH+lSqxGM91y3T/L34PQ
         PfUfgNwwPbaHkWk+jPiQLcVFmTLRnk6rBWI9J+dmL5xrFrcvgcTKZTVqfTpBOEGW2g44
         7S7FxyM9Q82HBm0zDP68iNu7Hqv6I19hJhprYadc8KLBGhokzbTe/k3V/E2GtBx4H1E+
         +6pZI0RNf392b8ubW4W6QhPl7i/M2W8TIlUBUF4Jc3Ddz9hn+VqKeomr1VwbGFgMINpx
         YRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1NLtIL4mp2qHTi5hOVwYkkuVD4cT9jE/SqJqjf/988o=;
        b=q6TFCf6x7Zd3yC8viAUvD2RYhbtyINPaz6tlxKRwEHkL+jQUj1qyy3sqOH52HwqY6x
         51FnqzMd2Rch9EbSWC3cAu5Dc+EK6Jtdbgsbcd3581UgCtERwvMYdp0CjmLtQey1kg4J
         TEapl0h4raX0Tm9LCgYBez2ukTOVybCpn2oJJ908mqWswWuagZ9F9+s2dr9nUusM+ed2
         Ra91ibXmzA+sne+OhkoHjdvoS1/YcuT/j8p6SX2l/HQJLJYdIwuSfyk3qjBjhQEUPe5T
         teuNX1KTGCYV9oF7rjeIyYydE/C3QiixR9CMpXjXwsobNoWrhzTUVHA1cmdTa+4w+qd+
         qNKw==
X-Gm-Message-State: APjAAAWARNfHeHk2BIjszmLCCJ7QMmRyCN4JsAcgCAy1SYnj9Me3D4oX
        fHEPdgCAKyIh/x8o1fyGgimDrh57kZTmF/ePN5uacQ==
X-Google-Smtp-Source: APXvYqxkzIoMrgZQcoeF5OyznXISdWtNE6TK2VXrJ5iLriqjHOYy8eIx/6czv4xAZj/ROALVBLVs+udVCrq/v//vKKQ=
X-Received: by 2002:a81:6a8a:: with SMTP id f132mr9756614ywc.358.1567128503715;
 Thu, 29 Aug 2019 18:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190813105359eucas1p2c4fecf74be23d3e7739a61c55050bc89@eucas1p2.samsung.com>
 <20190813105337.3065-1-a.swigon@partner.samsung.com>
In-Reply-To: <20190813105337.3065-1-a.swigon@partner.samsung.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 29 Aug 2019 21:28:12 -0400
Message-ID: <CAOg9mSTCwb6fd0SfWYgVGoQ9gsSjPGNYwBDHMV3b9hBzGFHQgg@mail.gmail.com>
Subject: Re: [PATCH] orangefs: Add octal zero prefix
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devel@lists.orangefs.org, LKML <linux-kernel@vger.kernel.org>,
        Martin Brandenburg <martin@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for catching this, I added this patch on top of Linux 5.3-rc6 and
ran xfstests on orangefs with no regressions.

Acked-by: Mike Marshall <hubcap@omnibond.com>

-Mike



On Tue, Aug 13, 2019 at 6:54 AM Artur =C5=9Awigo=C5=84
<a.swigon@partner.samsung.com> wrote:
>
> This patch adds a missing zero to mode 755 specification required to
> express it in octal numeral system.
>
> Reported-by: =C5=81ukasz Wrochna <l.wrochna@samsung.com>
> Signed-off-by: Artur =C5=9Awigo=C5=84 <a.swigon@partner.samsung.com>
> ---
>  fs/orangefs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
> index 1dd710e5f376..3e7cf3d0a494 100644
> --- a/fs/orangefs/namei.c
> +++ b/fs/orangefs/namei.c
> @@ -224,7 +224,7 @@ static int orangefs_symlink(struct inode *dir,
>         struct orangefs_object_kref ref;
>         struct inode *inode;
>         struct iattr iattr;
> -       int mode =3D 755;
> +       int mode =3D 0755;
>         int ret;
>
>         gossip_debug(GOSSIP_NAME_DEBUG, "%s: called\n", __func__);
> --
> 2.17.1
>
