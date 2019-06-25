Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917C5C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6925D208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561494425;
	bh=4DjDMXCFMiEPojnFZTh8l0f8w6EVPLy4ezbvE1XggGw=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=Jc40CCoTgXuuHmx0ku2p/xdOkHjbyEdu+swOYDCeasjCTG+2X3fBbcW9vQNBxjSc8
	 oeipYr95SNbFUd86HeGrnsCdkS60djLCGPgEd4K5poSPbWw6l66sBJWSXK3v+rgcc2
	 GGldBETirQU1GR7bomhVIo14vRnDH2HY2IAJ2wso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfFYU1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:27:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfFYU1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:27:03 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9A9B208CB;
        Tue, 25 Jun 2019 20:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561494422;
        bh=4DjDMXCFMiEPojnFZTh8l0f8w6EVPLy4ezbvE1XggGw=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=HGnMUm36tBd89ZCYMpakSYGFEW5Ra8p8ujQXGTZBj7wplR2/DDy55cLSCmDONvdHY
         zvRbTWOTcuq+e3106aW7m2laV8C4uUGsBk5uzvJeZKwhWPPPmBSq+savdLyIs9SkPO
         50vQuTR/sLQeXqmcCO0A4QBjA4XFwhvT87/QcdKc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190620150013.13462-6-narmstrong@baylibre.com>
References: <20190620150013.13462-1-narmstrong@baylibre.com> <20190620150013.13462-6-narmstrong@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC/RFT 05/14] soc: amlogic: meson-clk-measure: protect measure with a mutex
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        Neil Armstrong <narmstrong@baylibre.com>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 13:27:01 -0700
Message-Id: <20190625202702.B9A9B208CB@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Neil Armstrong (2019-06-20 08:00:04)
> In order to protect clock measuring when multiple process asks for
> a mesure, protect the main measure function with mutexes.
>=20
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/soc/amlogic/meson-clk-measure.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogi=
c/meson-clk-measure.c
> index 19d4cbc93a17..c470e24f1dfa 100644
> --- a/drivers/soc/amlogic/meson-clk-measure.c
> +++ b/drivers/soc/amlogic/meson-clk-measure.c
> @@ -11,6 +11,8 @@
>  #include <linux/debugfs.h>
>  #include <linux/regmap.h>
> =20
> +static DEFINE_MUTEX(measure_lock);
> +
>  #define MSR_CLK_DUTY           0x0
>  #define MSR_CLK_REG0           0x4
>  #define MSR_CLK_REG1           0x8
> @@ -360,6 +362,10 @@ static int meson_measure_id(struct meson_msr_id *clk=
_msr_id,
>         unsigned int val;
>         int ret;
> =20
> +       ret =3D mutex_lock_interruptible(&measure_lock);

Why interruptible?

> +       if (ret)
> +               return ret;
> +
>         regmap_write(priv->regmap, MSR_CLK_REG0, 0);
> =20
>         /* Set measurement duration */
