Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389B7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D0721915
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCIt3zQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfCUKrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:47:06 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36789 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfCUKrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:47:05 -0400
Received: by mail-ua1-f66.google.com with SMTP id e15so1762494uam.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 03:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3ChEvxbyg9d8p9ed5G1+OcDExE2Z5zUwNdg4YoYomrg=;
        b=QCIt3zQAFa1KIyGLztp0mP4cUlOdzvPPiK3Xa9HqXSAqtfbQi2Ve77wzf2EsZjdyKz
         3qB20SxjdN4+Q6f2X+Y8GT1bef/uqjmgsyOJ5IRy69/6S3QkaN3P4BBYAAGsC6HuQ47o
         fUTUVtFGFx19AGB54/eYaM67AGx/7QPw5T68tnfqrxsVgiP9WQh7YKz9Gb7dXtN8SXvb
         ORjHH3QZtLAGl04UT9pP7NP1QzE5YpJ3YNwSJQdiL6IznZ1a/DmAr5j2pDP8NzeclSTC
         BF0lf6cWu1iOQh60Z2H89jQAoe5ANpqfLIOzOmzbJyL8Qu7x6rY2emqfNWiQW6PnT+Do
         EDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3ChEvxbyg9d8p9ed5G1+OcDExE2Z5zUwNdg4YoYomrg=;
        b=YJ5UvLWlkSkUYKOod4Q6nd24bL94Ez0H5/OK19p3ZUdKJSH0jb19xosblOwROLO9+z
         CIUq7EP3TBE4FnJQZ8fmogkUk7/QJw4VYpOvvcv3s/vQbpmLmjAdLRG22cnRL+fOl4OP
         QLgz2058rQDnggzc4OeBgTquHS0UcfsdwvqILJj+wwCuuYCLQKmfAByGZvH3prSC803y
         HpyvsMoWhY9+A8wQLpQ6YoS4+y8K9BkoMjsH/5WOx3jPTDDJ7S55u1kJS6L3VaTwuucf
         dCvNFKCflH1v6rCTXDzEALVjTAJ+wDluWFU5FoS2YWcYljqaVtrGjnSPj2nvy8z1IS3W
         fzAg==
X-Gm-Message-State: APjAAAUTf6EZOGJEYWTLxLn56ZX49g1lW3osKIuBu+eRYyCK3I+aeIl2
        bA1TpBTQjStN3oBiQ7d/LpWimbEet3mwC791d7lpuQ==
X-Google-Smtp-Source: APXvYqxlqh9p63R06ZOWFIuir1/jvPegMqJDVzUlXawBzoF/nexJkbnE6RK8LnhZZdY52vu+aDC3BmYo27vVVXHjaIo=
X-Received: by 2002:ab0:20a6:: with SMTP id y6mr1258945ual.98.1553165224212;
 Thu, 21 Mar 2019 03:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190320200010.GA14527@embeddedor>
In-Reply-To: <20190320200010.GA14527@embeddedor>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Mar 2019 11:46:28 +0100
Message-ID: <CAPDyKFq7Qcp+WZazg2CiB_nBV7Bsmns2aD-Na_k72Kk9sf9X2g@mail.gmail.com>
Subject: Re: [PATCH] mmc: usdhi6rol0: mark expected switch fall-throughs
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

On Wed, 20 Mar 2019 at 21:02, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
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
> ---
>  drivers/mmc/host/usdhi6rol0.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.=
c
> index cd8b1b9d4d8a..b9712ac96be5 100644
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
> @@ -1688,6 +1688,7 @@ static void usdhi6_timeout_work(struct work_struct =
*work)
>         default:
>                 dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->w=
ait);
>                 /* mrq can be NULL in this actually impossible case */
> +               /* fall through */

Please make this one comment.

>         case USDHI6_WAIT_FOR_CMD:
>                 usdhi6_error_code(host);
>                 if (mrq)
> @@ -1713,6 +1714,7 @@ static void usdhi6_timeout_work(struct work_struct =
*work)
>                  * If USDHI6_WAIT_FOR_DATA_END times out, we have already=
 unmapped
>                  * the page
>                  */
> +               /* fall through */

Ditto.

>         case USDHI6_WAIT_FOR_DATA_END:
>                 usdhi6_error_code(host);
>                 data->error =3D -ETIMEDOUT;
> --
> 2.21.0
>

Kind regards
Uffe
