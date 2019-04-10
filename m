Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304C1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E949B20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M3PkFBip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfDJVrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:47:20 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33049 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfDJVrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:47:20 -0400
Received: by mail-vk1-f195.google.com with SMTP id x194so927927vke.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QXiJ2lj9JMynWfUKN3oco9k+HtXMmTEkaf5hOpFuSF0=;
        b=M3PkFBipDHKGS5UOcLR0+UhlihZ24+1iPN5mHuqvm0Od6lBF8iUekWEXKlR03/hZ9M
         nGSioiCcJNj1f6zI3xHdrsc5tCVC+K0LM8KWyvM7Vwc1P+mb5hYsptfrS095OGOBJVLO
         YShxXzd9fG9ZqI8fPEfeuhZxAaliAEIpo9IAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QXiJ2lj9JMynWfUKN3oco9k+HtXMmTEkaf5hOpFuSF0=;
        b=Z7Cp+QzjXbQC89gKKta0jiQoO9Ic3wyAIy+rzMW+lItVbuB+t1BvLGCz4OSoxuJTM6
         gVy1nRdeF+rAT/zAOrBbEgJh8M0na+IvX1GX9IbfFaP8Msa4d0lR8eViFxucc2fMDr99
         74xSg1u27uxEkzxsW0yiVGiMabTEWcsAfHoqIdsrtllEFtA4+8YGitWK98896TpJgN1v
         rgRpVJ5jpFgaZcE2YYhxs5LSJoHBZ11hoFxspsSlsFXaqpoRgZomG0yXyRCBlaS7bQuP
         r0JzZQ5i9wc5DDPNK1DzN3DDbH9GZIXQxcg1D38rMpdJD2VZt5u7Vuw91w4TNKBWg8dB
         OBrQ==
X-Gm-Message-State: APjAAAVtGbxp9voEH79vAgVoE3KYQ2KaVsSoAwH4Rug+4IWTK8ma0/E1
        6CSJ/kd7iR0JnxnBIjLiiJrzlUu528U=
X-Google-Smtp-Source: APXvYqx2TEAqt9y9pbjpQ3QaXfuBD7KkgJ+FkUt6ZSzIo71BXcGSEXrxS14s9Wjdb8bQAtdoHUhYXQ==
X-Received: by 2002:a1f:1384:: with SMTP id 126mr24665723vkt.71.1554932838045;
        Wed, 10 Apr 2019 14:47:18 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id j71sm29544522vsd.0.2019.04.10.14.47.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 14:47:17 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id n4so2288525vsm.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:47:16 -0700 (PDT)
X-Received: by 2002:a67:7e12:: with SMTP id z18mr1959700vsc.82.1554932836399;
 Wed, 10 Apr 2019 14:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190208181210.GA8388@embeddedor>
In-Reply-To: <20190208181210.GA8388@embeddedor>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 14:47:05 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+_CGq=69qAaZz1zYpHx-khRT+VSLtARkU+8txBkdzk2A@mail.gmail.com>
Message-ID: <CAGXu5j+_CGq=69qAaZz1zYpHx-khRT+VSLtARkU+8txBkdzk2A@mail.gmail.com>
Subject: Re: [PATCH] mtd: lpddr_cmds: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
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

On Fri, Feb 8, 2019 at 10:12 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> drivers/mtd/lpddr/lpddr_cmds.c: In function =E2=80=98chip_ready=E2=80=99:
> drivers/mtd/lpddr/lpddr_cmds.c:319:6: warning: this statement may fall th=
rough [-Wimplicit-fallthrough=3D]
>    if (mode =3D=3D FL_READY && chip->oldstate =3D=3D FL_READY)
>       ^
> drivers/mtd/lpddr/lpddr_cmds.c:322:2: note: here
>   default:
>   ^~~~~~~
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
>  drivers/mtd/lpddr/lpddr_cmds.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mtd/lpddr/lpddr_cmds.c b/drivers/mtd/lpddr/lpddr_cmd=
s.c
> index b13557fe52bd..76a4c73e100e 100644
> --- a/drivers/mtd/lpddr/lpddr_cmds.c
> +++ b/drivers/mtd/lpddr/lpddr_cmds.c
> @@ -318,6 +318,7 @@ static int chip_ready(struct map_info *map, struct fl=
chip *chip, int mode)
>                 /* Only if there's no operation suspended... */
>                 if (mode =3D=3D FL_READY && chip->oldstate =3D=3D FL_READ=
Y)
>                         return 0;
> +               /* fall through */
>
>         default:
>  sleep:
> --
> 2.20.1
>


--=20
Kees Cook
