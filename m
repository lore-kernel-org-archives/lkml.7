Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741D3C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8D0208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJor99eA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfECN3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:29:50 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40854 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfECN3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:29:48 -0400
Received: by mail-vs1-f67.google.com with SMTP id e207so3569966vsd.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=stZ6FrbCQvENNToP29H4XLypQxhEfxxBik6rsVzltL8=;
        b=hJor99eADGSy7BH75aOvVzj0ISYuIOrwHZoUVPqlMyNRoUpV36K2HLahXqIzcfcGwZ
         ts+L8RnjERJ4ofCuGghatZ5aYv2DI0gbeAyxH/v1jakPNZQzspui1vmpR1hA1QPrH2rZ
         smTrAfXcR8qYJpnO8Iy6TshnBG06EQ+0gb5Tkf1ULj68GZA34n7YN7IU8swba5aDLIPM
         p1guNy+mbn87KVGMPgHwlJQRD+Cov6aHKHiF+Q7dvNwbEycwv7UACOu12iWYgRlqXS7H
         /EwNCq4m2nWUssyiHMvvx9fr1NzgOTG6Uvj+t7kR+V049fXJwYvKyPwmuuxV+vFapvtQ
         U1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=stZ6FrbCQvENNToP29H4XLypQxhEfxxBik6rsVzltL8=;
        b=ZmGP2RDaXt7+/1PXKOJV1wG1GqEPOB3Jri9ynMnpHFrN6r3IkbnKC/jD4ZJRiaRGQS
         QXPgM+ublFSBbla9V7LaFHtRL0jrIhKZsHqlhBYteG4ttD5zT6ZpzaxV/Vt4OpbnYx1b
         HQXSVGLQFUgz5TxV0Q4WyNVJWsbZafMkbtQDyccchhpBEreHFj5lC5cg1hUP98uwCbf2
         9Pgm7zPk1FtpykaWNVsOYSlmpVLLd0ARAgyFOvYRtwO51sNexU8c4ScL4ApQK9dRvvTr
         tRWCBFupf/1DhrwsqV43BiBROkczviCZ7XL95A3+96O32pRKucL33ssf8Bjx8JSujy79
         tTCQ==
X-Gm-Message-State: APjAAAXfIlzk/9XSng9VE2psg19xCOPs26cIxYGxG7xynCKvdVJeYu69
        WHLVbNKSR0xSC3vQsoHwFk/yYAAEyOVCiXuW8UcjyA==
X-Google-Smtp-Source: APXvYqwwVgRZj147HHgDwpNYnaxqQgwtO2KsWndKtml3VjSfKsFGlg5s7RTXQTvJWWXIwsM5QQ/aSTyuE/FwXvSdFBc=
X-Received: by 2002:a67:84d1:: with SMTP id g200mr5558816vsd.34.1556890187183;
 Fri, 03 May 2019 06:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190501203621.GA11352@embeddedor>
In-Reply-To: <20190501203621.GA11352@embeddedor>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 May 2019 15:29:10 +0200
Message-ID: <CAPDyKFr0KrUCuBpYyypKiUsin98XaYOVUx8MuDEpxvm6knxrzw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: usdhi6rol0: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 May 2019 at 22:36, Gustavo A. R. Silva <gustavo@embeddedor.com> w=
rote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> In file included from drivers/mmc/host/usdhi6rol0.c:9:
> drivers/mmc/host/usdhi6rol0.c: In function =E2=80=98usdhi6_timeout_work=
=E2=80=99:
> ./include/linux/device.h:1483:2: warning: this statement may fall through=
 [-Wimplicit-fallthrough=3D]
>   _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mmc/host/usdhi6rol0.c:1689:3: note: in expansion of macro =E2=80=
=98dev_err=E2=80=99
>    dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->wait);
>    ^~~~~~~
> drivers/mmc/host/usdhi6rol0.c:1691:2: note: here
>   case USDHI6_WAIT_FOR_CMD:
>   ^~~~
> drivers/mmc/host/usdhi6rol0.c:1711:3: warning: this statement may fall th=
rough [-Wimplicit-fallthrough=3D]
>    usdhi6_sg_unmap(host, true);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/mmc/host/usdhi6rol0.c:1716:2: note: here
>   case USDHI6_WAIT_FOR_DATA_END:
>   ^~~~
>   CC [M]  drivers/isdn/hisax/hisax_isac.o
> drivers/mmc/host/usdhi6rol0.c: In function =E2=80=98usdhi6_stop_cmd=E2=80=
=99:
> drivers/mmc/host/usdhi6rol0.c:1338:6: warning: this statement may fall th=
rough [-Wimplicit-fallthrough=3D]
>    if (mrq->stop->opcode =3D=3D MMC_STOP_TRANSMISSION) {
>       ^
> drivers/mmc/host/usdhi6rol0.c:1343:2: note: here
>   default:
>   ^~~~~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied for next, thanks!

I took the liberty to clean up the comments, avoiding to break 80
chars per line.

Kind regards
Uffe


> ---
> Changes in v2:
>  - Turn multiple line comments into single line comments.
>  - Fix additional fall-through warning.
>
>  drivers/mmc/host/usdhi6rol0.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.=
c
> index cd8b1b9d4d8a..f0cc5e0dbf79 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1339,7 +1339,7 @@ static int usdhi6_stop_cmd(struct usdhi6_host *host=
)
>                         host->wait =3D USDHI6_WAIT_FOR_STOP;
>                         return 0;
>                 }
> -               /* Unsupported STOP command */
> +               /* fall through - Unsupported STOP command */
>         default:
>                 dev_err(mmc_dev(host->mmc),
>                         "unsupported stop CMD%d for CMD%d\n",
> @@ -1687,7 +1687,7 @@ static void usdhi6_timeout_work(struct work_struct =
*work)
>         switch (host->wait) {
>         default:
>                 dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->w=
ait);
> -               /* mrq can be NULL in this actually impossible case */
> +               /* fall through - mrq can be NULL in this actually imposs=
ible case */
>         case USDHI6_WAIT_FOR_CMD:
>                 usdhi6_error_code(host);
>                 if (mrq)
> @@ -1709,10 +1709,7 @@ static void usdhi6_timeout_work(struct work_struct=
 *work)
>                         host->offset, data->blocks, data->blksz, data->sg=
_len,
>                         sg_dma_len(sg), sg->offset);
>                 usdhi6_sg_unmap(host, true);
> -               /*
> -                * If USDHI6_WAIT_FOR_DATA_END times out, we have already=
 unmapped
> -                * the page
> -                */
> +               /* fall through - If USDHI6_WAIT_FOR_DATA_END times out, =
we have already unmapped the page */
>         case USDHI6_WAIT_FOR_DATA_END:
>                 usdhi6_error_code(host);
>                 data->error =3D -ETIMEDOUT;
> --
> 2.21.0
>
