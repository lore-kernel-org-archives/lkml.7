Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE75C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E932071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577728519;
	bh=M0/ttevZTgcpcd8Idxm8eB8MLA1mcc9lSUmyIBKekxU=;
	h=In-Reply-To:References:From:Cc:To:Subject:Date:List-ID:From;
	b=fksdes/jSzsxoLj83yPCSqaDi7GwYFyWpPvz0ywd9Sj6BWw4T1VoPKTQ/IDOGrO6a
	 wuAzdzZWmIb0/eLaWNTXRiMyOlwro4x9OaTcEX0LkVa5/h4/4R+KUKYfjAFkUaGjPV
	 LQnTev7LEn3flAQSNjiXunLU45v8V/KJnjYBwQoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfL3RzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:55:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfL3RzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:55:18 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2CC620718;
        Mon, 30 Dec 2019 17:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577728517;
        bh=M0/ttevZTgcpcd8Idxm8eB8MLA1mcc9lSUmyIBKekxU=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=PaPnzyQ4K1+//4jh3fQIEplyIXxWomxNeON0szeoPODwiO0npd4DwEsATRV9V493m
         IWeBVU/XnBiY5/Ng7ZdmFgKvFcb0hiKgftL20nXixmj9KxVtIZrfkccv/PtEV2F0Zo
         Vl5MKT2iJx8zVwmjKyFBIDnGEspt0Dz8HcTekciU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191226221354.11957-1-sboyd@kernel.org>
References: <20191226221354.11957-1-sboyd@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: Warn about critical clks that fail to enable
User-Agent: alot/0.8.1
Date:   Mon, 30 Dec 2019 09:55:17 -0800
Message-Id: <20191230175517.D2CC620718@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-12-26 14:13:54)
> If we don't warn here users of the CLK_IS_CRITICAL flag may not know
> that their clk isn't actually enabled because it silently fails to
> enable. Let's drop a big WARN_ON in that case so developers find these
> problems faster.
>=20
> Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>=20
> I suspect that this may start warning for other users. Let's see
> and revert in case it doesn't work.
>=20
>  drivers/clk/clk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 772258de2d1f..6a9a66dfdeaa 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3427,13 +3427,13 @@ static int __clk_core_init(struct clk_core *core)
>                 unsigned long flags;
> =20
>                 ret =3D clk_core_prepare(core);
> -               if (ret)
> +               if (WARN_ON(ret))

We should probably just print the clk name that failed to be critically
enabled with a pr_warn(). The traceback pointing to this location will
be really hard to understand otherwise.

>                         goto out;
> =20
>                 flags =3D clk_enable_lock();
>                 ret =3D clk_core_enable(core);
>                 clk_enable_unlock(flags);
> -               if (ret) {
> +               if (WARN_ON(ret)) {
>                         clk_core_unprepare(core);
>                         goto out;
>                 }
>=20
> base-commit: 12ead77432f2ce32dea797742316d15c5800cb32
> --=20
> Sent by a computer, using git, on the internet
>=20
