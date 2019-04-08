Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917A5C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5774F213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxOwvrKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfDHWfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:35:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44871 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfDHWfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:35:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id y7so2677373wrn.11;
        Mon, 08 Apr 2019 15:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=V4R+3dQh95hwJSsO8hhhpWrQd2X7Bmm0cjMWwjqnvJ8=;
        b=sxOwvrKIS900T1u1lm3jZY276LdWVTUY1BPwZffMexJmer4DItZPL1rNrboROzzazh
         8nHWp7BPxSrjVU6UArVxNu2Qna5wV1RWR6gZ6XwzW3h8J1MRcLexE14h2Np3WWn1nm/G
         StDqZIeMeN89X69QFdblaX/zzlEdlkrQrVjB3qbZgajE0TCTDrYMRWjoH3Wb+NnxCNqx
         P28XJfzyHZtgAFpZbeV7vhErONBPQXPFAtSb2/4zk7QMSimjxyOCRPmxtBoMjKb+c143
         RpWQuM1P//ITCA8ICdo8prWJ2ElNRG6+O3raqcNtPP0RwRyEDuYJlywhtT01VAv+EViP
         8zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=V4R+3dQh95hwJSsO8hhhpWrQd2X7Bmm0cjMWwjqnvJ8=;
        b=nGa1YRmo+C75zIk7PV7+Uoq5UgEq5OHW9+4z9aRpWn6y0BjldDjHq03W3TIWbkQN3/
         AS0H+xc0R1Z9sHP0WwLhu5f213Cq4ZfzoEQy8ol6xrbilBf/uq70ZMGXERLSyvOr+ORx
         HRj+R0bEB8NFrkQ3D2IU4YXm4dKSoXt5s79b8oOM6EcmDp+Etq91DoAspFKqIW5VgTN+
         V9RmcUpT9H03WmgVfvIh8wWEh3GsnvIg+9oUQEszvELjjtBGlN4TMLeTmhd353BWwAW3
         8eazaUE3F4/rX9hDBf+n0LTR3nuVHORy4wz57Xfs8bIdugw1Nrik2MGQ4vHppUI8ibA0
         QtWw==
X-Gm-Message-State: APjAAAXLtqZ2Z8U9NGwBCGvy7q7yXZ8UYa4Toy6sCCeaLFCOF4NCsI3H
        KfPV+bFzFP5Xac6uzwj4m4iyea1b5lyh/Q==
X-Google-Smtp-Source: APXvYqx48H3nHFDjXUlECAojoV7TEwgQPBGUMSZadi2gqr9yK3r64aVbWV2/Dkl7UXpNgo8KgpIaFw==
X-Received: by 2002:adf:dc8e:: with SMTP id r14mr12111570wrj.118.1554762937378;
        Mon, 08 Apr 2019 15:35:37 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id a23sm9700880wmm.46.2019.04.08.15.35.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Apr 2019 15:35:36 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Mark Brown <broonie@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        <linux-rockchip@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: rockchip: Revert "set min/max speed"
Date:   Tue, 09 Apr 2019 00:35:34 +0200
MIME-Version: 1.0
Message-ID: <e9f5512c-238e-4da2-9caf-63c6be9b92be@gmail.com>
In-Reply-To: <20190407005759.2425-1-vicencb@gmail.com>
References: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
 <20190407005759.2425-1-vicencb@gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, April 7, 2019 2:57:59 AM CEST, Vicente Bergas wrote:
> This reverts
> commit 420b82f84294 ("spi: rockchip: set min/max speed")
> commit 74b7efa82b11 ("spi: rockchip: precompute rx sample delay")
> The former breaks bursts of writes of 48 bytes or more.
> Both patches touch the same part of the file and it is not trivial to
> only revert the first. Reverting both just results in an easy to fix
> conflict.
>
> Tested-by: Vicente Bergas <vicencb@gmail.com>
> Signed-off-by: Vicente Bergas <vicencb@gmail.com>
> ---
>  drivers/spi/spi-rockchip.c | 80 ++++++++++++++++++++++----------------
>  1 file changed, 46 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 3912526ead66..682f3567a8c8 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> ...

Hi Mark,
please, disregard this patch. It is the result of bisecting a bug which
may not be deterministically reproducible, so, the bisection point is
random.
Emil is helping me in the debug process, which is still ongoing.

Hi Emil,
yes, the platform is RK3399. Doing tests on the Sapphire board, but it is
also reproducible on gru-kevin. I prefer not testing on the chromebook
because when it fails it becomes unbootable (a brick) and need to take it
apart to connect an external programmer.

Now testing your suggestion:
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -720,5 +720,4 @@ static int rockchip_spi_probe(struct platform_device *)
        if (master->dma_tx && master->dma_rx) {
                rs->dma_addr_tx =3D mem->start + ROCKCHIP_SPI_TXDR;
                rs->dma_addr_rx =3D mem->start + ROCKCHIP_SPI_RXDR;
-               master->can_dma =3D rockchip_spi_can_dma;
        }
so far so good, but let me some time to make sure the results are
deterministic.
Now it works without dma and without the assigned-clock* props in the dts.

If that proves to fix the issue, which would be the next debugging step?

Regarding the spidev: if the spi1 dts is
&spi1 { status =3D "okay"; /* and nothing else */ };
then the /sys/bus/spi/devices directory is empty, so, it cant be bound.
What i am doing wrong?

Regards,
  Vicen=C3=A7.

