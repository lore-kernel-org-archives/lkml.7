Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6055C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9187920820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WhvzkP+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDJVq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:46:59 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38125 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfDJVq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:46:58 -0400
Received: by mail-ua1-f67.google.com with SMTP id t15so1320504uao.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lq4+RxT8k6KGTV+dt1jcaoPACyMOT5GrI4v17X71x+0=;
        b=WhvzkP+OOJLUbpjVXtK0ScHPtIQfCI0xvx1j0Oxq5S52VQNE4EyoYzc7E4T4KvnZjG
         YFfpTjo7DdTi8E0QHrIIWghFNmfuPpQRZXCE+T58c5TWnoz2LRYqYFkCZd4SX8wy3fDi
         mAy9AU866AgWj5Yk8cSVP6dE8799V45Zvjvyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lq4+RxT8k6KGTV+dt1jcaoPACyMOT5GrI4v17X71x+0=;
        b=Nx3n38/z5t2kNb/DZY+kC9ofpEgYoZa6/h7guHwn972ddYxUElFOW8NLfaPu/jQ1Ak
         HYcVPTKSmJWoQqIkWsaU3z/CXhzXnoF28c5QA5x8FjpiEIU8SZVmk3H/IR5kE/CtjrTp
         uaqihKBpIs+2fCMVmM3kDcqDX2EGrgjojShBFrREelwAPh7pQQ7W7vwVqtVOCF/OAqnV
         O1cZwYO1VD38WzXVUSA9e3Cva+TAoxC+4ezno3SBNTaYioV4F2VPS7HF+v1Zk7V50EZy
         p1HCIzLcUEGorRECp1GHTh9D2FikVWLlk3ghDIOOZxJFQCJ+xckLP/PgN73WdUWYl+la
         FgQA==
X-Gm-Message-State: APjAAAXcUhG1mdJcOqluZ5mtVauNT+osufZTJ99DPTMRKyiKyF/ylS0c
        OY2MPogV8YUMf7k/IdEHh/Opw7/+ijo=
X-Google-Smtp-Source: APXvYqzD9oOtuDe74CnE5keXgkKU7N/2n4n+T3PP2FmLiUG/NliuYbVEE7gBRqizAhAbhqxtVeGlGw==
X-Received: by 2002:a9f:3fce:: with SMTP id m14mr24442045uaj.96.1554932817596;
        Wed, 10 Apr 2019 14:46:57 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id w184sm20935202vkd.0.2019.04.10.14.46.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 14:46:56 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id i207so2271724vsd.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:46:56 -0700 (PDT)
X-Received: by 2002:a67:7816:: with SMTP id t22mr24729535vsc.115.1554932816316;
 Wed, 10 Apr 2019 14:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190208180911.GA32525@embeddedor>
In-Reply-To: <20190208180911.GA32525@embeddedor>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 14:46:45 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJkrpGd+WWRx3C2Njp6jZ4UKU0KqinjqmTO8fxyfo7oOw@mail.gmail.com>
Message-ID: <CAGXu5jJkrpGd+WWRx3C2Njp6jZ4UKU0KqinjqmTO8fxyfo7oOw@mail.gmail.com>
Subject: Re: [PATCH] mtd: phram: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Joern Engel <joern@lazybastard.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 10:17 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> drivers/mtd/devices/phram.c: In function =E2=80=98parse_num64=E2=80=99:
> drivers/mtd/devices/phram.c:149:11: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
>      shift +=3D 10;
>      ~~~~~~^~~~~
> drivers/mtd/devices/phram.c:150:4: note: here
>     case 'M':
>     ^~~~
> drivers/mtd/devices/phram.c:151:11: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
>      shift +=3D 10;
>      ~~~~~~^~~~~
> drivers/mtd/devices/phram.c:152:4: note: here
>     case 'k':
>     ^~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/mtd/devices/phram.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
> index 9ee04b5f9311..8a8627c30aed 100644
> --- a/drivers/mtd/devices/phram.c
> +++ b/drivers/mtd/devices/phram.c
> @@ -147,8 +147,10 @@ static int parse_num64(uint64_t *num64, char *token)
>                         switch (token[len - 2]) {
>                         case 'G':
>                                 shift +=3D 10;
> +                               /* fall through */
>                         case 'M':
>                                 shift +=3D 10;
> +                               /* fall through */
>                         case 'k':
>                                 shift +=3D 10;
>                                 token[len - 2] =3D 0;
> --
> 2.20.1
>


--=20
Kees Cook
