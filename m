Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DBAC28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0925223AC6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559141188;
	bh=8rorXxnzSizFaq/FwdOra1IJYD1LwqZRGLVPZflpURU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Oa2oXbuLD0Et0mnY3EgKDamrD5kM7O/BPdTb22IPBY+Zr0XOCskAtxH++WYUT4O02
	 Rj4v0UQUNm2VX3KdCVihyBJen+xD1TlYcS4yLM1onfFZfjbiQD5Olz+nps2rsIDoN4
	 5S5FrEmq6LVxBxHIYN4tQ/HK8JEap825AKz1pKUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfE2Oq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:46:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfE2Oq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:46:27 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDBA123ABA;
        Wed, 29 May 2019 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559141186;
        bh=8rorXxnzSizFaq/FwdOra1IJYD1LwqZRGLVPZflpURU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ChjW1N1j0JLE1k+6PI9oRVCzrm0/6xRkmhZMyeTJiffjNss00ok4MLacKMa3US1rx
         FN6/LJ31a97fa8G5S3LutlyDmu8cEB6Lm/KdhgnODWeKxs1hm23F35PNDM5Mwk4708
         9DKoVs51KUk90xiw83kAhL3spQ+sPr7jJkVV7S2w=
Received: by mail-lj1-f182.google.com with SMTP id e13so2719077ljl.11;
        Wed, 29 May 2019 07:46:25 -0700 (PDT)
X-Gm-Message-State: APjAAAWgJCxU0p/Z2v4j5PbvnL/kZeguBzqiXVIi4zrjxxYLQxaC33Jn
        fPCBOQi0PiD4+vN5Bp4MIJSfdZRcepu2uprPIF0=
X-Google-Smtp-Source: APXvYqxtJA+YU8qUOjC0WysP9KRgGAX0/VOWIsIUq8MPRay9hybngeVcKiAzZaJtnygTzi7YGPErKMp9WeCpZWwBji4=
X-Received: by 2002:a2e:9cc4:: with SMTP id g4mr59526686ljj.47.1559141178602;
 Wed, 29 May 2019 07:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPf=nPrmw6Vzi_=LmO=dVsV4Gvoc-q75XP2FBEgm9Gxv0A@mail.gmail.com>
 <20190527022258.32748-1-matheus@castello.eng.br> <20190527022258.32748-4-matheus@castello.eng.br>
In-Reply-To: <20190527022258.32748-4-matheus@castello.eng.br>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 29 May 2019 16:46:07 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd2F6iy0ZqYf+X2k=eQ=tY1zG4gVbrr68XqE9+w4HK6dw@mail.gmail.com>
Message-ID: <CAJKOXPd2F6iy0ZqYf+X2k=eQ=tY1zG4gVbrr68XqE9+w4HK6dw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] power: supply: max17040: Config alert SOC low
 level threshold from FDT
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2019 at 04:46, Matheus Castello <matheus@castello.eng.br> wrote:
>
> For configuration of fuel gauge alert for a low level state of charge
> interrupt we add a function to config level threshold and a device tree
> binding property to set it in flatned device tree node.
>
> Now we can use "maxim,alert-low-soc-level" property with the values from
> 1% up to 32% to configure alert interrupt threshold.
>
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/power/supply/max17040_battery.c | 52 +++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index b7433e9ca7c2..2f4851608cfe 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -29,6 +29,9 @@
>  #define MAX17040_DELAY         1000
>  #define MAX17040_BATTERY_FULL  95
>
> +#define MAX17040_ATHD_MASK             0xFFC0
> +#define MAX17040_ATHD_DEFAULT_POWER_UP 4
> +
>  struct max17040_chip {
>         struct i2c_client               *client;
>         struct delayed_work             work;
> @@ -43,6 +46,8 @@ struct max17040_chip {
>         int soc;
>         /* State Of Charge */
>         int status;
> +       /* Low alert threshold from 32% to 1% of the State of Charge */
> +       u32 low_soc_alert_threshold;
>  };
>
>  static int max17040_get_property(struct power_supply *psy,
> @@ -99,6 +104,28 @@ static void max17040_reset(struct i2c_client *client)
>         max17040_write_reg(client, MAX17040_CMD, 0x0054);
>  }
>
> +static int max17040_set_low_soc_threshold_alert(struct i2c_client *client,
> +       u32 level)
> +{
> +       int ret;
> +       u16 data;
> +
> +       /* check if level is between 1% and 32% */
> +       if (level > 0 && level < 33) {
> +               level = 32 - level;
> +               data = max17040_read_reg(client, MAX17040_RCOMP);
> +               /* clear the alrt bit and set LSb 5 bits */
> +               data &= MAX17040_ATHD_MASK;
> +               data |= level;
> +               max17040_write_reg(client, MAX17040_RCOMP, data);
> +               ret = 0;
> +       } else {
> +               ret = -EINVAL;
> +       }

This is unusual way of handling error... when you parse DTS, you
accept any value for "level" (even incorrect one). You validate the
value later when setting it and show an error... however you ignore
the error of max17040_write_reg() here... This is correct but looks
unusual.

Best regards,
Krzysztof
