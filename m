Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4159C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D239206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHAUq9CJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfLPSbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:31:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46505 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730365AbfLPSbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:31:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so4169492pgb.13;
        Mon, 16 Dec 2019 10:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=q6wgY7fQy1m4FBOYKfnwYqVpu2I96z7LmDo1JYpVKmA=;
        b=oHAUq9CJWPu2x9rms0fDdTAm6ul0RPmQhldrsN5OLylWRT0QAkNMoiBg+qldjqhuVE
         pC01WYcRZcqbql2Xk1TZeLGh/t9abXxANyNKi6ScykT5hqJ6VQHqIoyeOhIiNsnNxpmS
         gYVIr9ogXexsFc5vP2kdujTRDAnuhVX8OcC9sEQ3WCLX2/0G6DBgAMnxj4EZpxH1fsiJ
         h8Ue9p1vYopiP2M3k2mG90lwVZbF4bPwEoIWprXHXcRoHTevhwMdiHw/kN99BtaNLFV9
         8WPiL2i0bskE5hz4kpEgdKG2o9zplIG0/a6L5jR8VjF6CCUgEF6hvVUUVjElXwucWa7n
         fatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=q6wgY7fQy1m4FBOYKfnwYqVpu2I96z7LmDo1JYpVKmA=;
        b=jbi2ICbbxcMiGyE7fkzeyiNIjORZHo/VI8XIHIng9mAUg6Gbs2BFM3SGOa7KuQZ66n
         uONJKdr2nrtvNaB2gmvhycPov+CvcjqURAsuVM4imhTI61nMV2/1u2stXP1YBQQjofU2
         IeMWvMTnQuNusiPhkwY6BYBbrp/oQX2InswApC0nywEQup63/54gFmJDG5nt79NC+1ac
         b7eC+tKE7Z5CfCwqM4uP8RnTs/ZirrurmyCNOpHp9Jt25FHa0n1nEf57lnpdm3YG0v2l
         YM4o4tu+JG0j+9LhyABlVQqWNorV639P7XL7YXRvWicdrJFwP8x+5HVudTwxuQldRG/y
         DuZg==
X-Gm-Message-State: APjAAAVUY3efypcKyRyhbFhzhd+bt10liHxrIqrNp/PX/AI0mN5L+bdB
        DG8PzjCvvgufWtJZy05brEbBe6jh0dvBXqTAWUBNnQ==
X-Google-Smtp-Source: APXvYqxsNamYDluy4MU6SGf4xgUn04QcfrEm+7mgsyXt1Aa1RCnnLKK8DURIStGo/unIqvJuRCAO2zGEMOPD6Nn2h30=
X-Received: by 2002:a63:364d:: with SMTP id d74mr19952282pga.408.1576521103641;
 Mon, 16 Dec 2019 10:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20191216174747.111154704@linuxfoundation.org> <20191216174815.749524432@linuxfoundation.org>
In-Reply-To: <20191216174815.749524432@linuxfoundation.org>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 16 Dec 2019 19:31:31 +0100
Message-ID: <CAN8YU5NrEbJx3yxBNoRWnwUiAYWffDp6gEcCcGUK+g4zjbHwEg@mail.gmail.com>
Subject: Re: [PATCH 4.19 106/140] iio: ad7949: kill pointless
 "readback"-handling code
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Something nasty seems happening here: it looks like the commit message
and the actual diff have nothing to do one wrt the other; the commit
message is from one of my patches, the diff is against some unrelated
file.

Il giorno lun 16 dic 2019 alle ore 19:05 Greg Kroah-Hartman
<gregkh@linuxfoundation.org> ha scritto:
>
> From: Meng Li <Meng.Li@windriver.com>
>
> [ Upstream commit c270bbf7bb9ddc4e2a51b3c56557c377c9ac79bc ]
>
> The device could be configured to spit out also the configuration word
> while reading the AD result value (in the same SPI xfer) - this is called
> "readback" in the device datasheet.
>
> The driver checks if readback is enabled and it eventually adjusts the SPI
> xfer length and it applies proper shifts to still get the data, discarding
> the configuration word.
>
> The readback option is actually never enabled (the driver disables it), so
> the said checks do not serve for any purpose.
>
> Since enabling the readback option seems not to provide any advantage (the
> driver entirely sets the configuration word without relying on any default
> value), just kill the said, unused, code.
>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/edac/altera_edac.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 56de378ad13dc..c9108906bcdc0 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -600,6 +600,7 @@ static const struct regmap_config s10_sdram_regmap_cfg = {
>         .reg_read = s10_protected_reg_read,
>         .reg_write = s10_protected_reg_write,
>         .use_single_rw = true,
> +       .fast_io = true,
>  };
>
>  static int altr_s10_sdram_probe(struct platform_device *pdev)
> --
> 2.20.1
>
>
>
