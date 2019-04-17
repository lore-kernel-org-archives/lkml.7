Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591CAC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F22204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df51FEzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbfDQRJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:09:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43747 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQRJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:09:29 -0400
Received: by mail-io1-f68.google.com with SMTP id x3so21157747iol.10;
        Wed, 17 Apr 2019 10:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bl1k/2Ow+1MIZ3va3HH95vWhThaYGxFJLCOy/YeDWqc=;
        b=Df51FEzg2+mn8RTe6BeDUB0wjqLKHuzwJR5s33RHfgM9i+T8uRyKO9TKQijB6+M2gW
         JUsR9OdvG1dRhbUFnLMJQHDPkyjkjcHSZZM381gI4jEKSNGimHl1KRPF+2xgVEokEwba
         e/PHC5C0xeGYZKTkML77BBEvttzKYMUzBoDQM37CWsBBGVfQGTjVIWGZ/Ixf/5aYlDP7
         R5mXEKH+Z8dbsO7YU3yrm595FaJbUFhEhBWjCd8DjdRqEKi/c5WOBzfj9mnfO43wvFcM
         9Pnq2nEa4rU2GAvoDujMiN5aZ2n/uLf4jAbbqfwA3MtbsTX7oZkgKvtKmA6kT//uBLgi
         HqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bl1k/2Ow+1MIZ3va3HH95vWhThaYGxFJLCOy/YeDWqc=;
        b=m9iU6gWrf0wc8vA5oJZlNWTi3FQO8msud3OOpD9c8whl4sCrCqE1TAQN8z2yRnLGYz
         3D+fPfP+ayzlrUIBfaCBe9h5YYlet+3jqsxeFnmGuZcjbOBkTmS1lkh5QvqK2vGQyz5X
         PGzSgquM0QxGkaMIjkOfMmSfXeUWCuFqc5+TLKaCMYXFBRcjZa9XJ2Eg3HV39p71wb2P
         niCZjUDOr7V/N+j8X18Bg6I+m2OUCEgoi3F/Rhi8q545Pv2+dXK1jZP3X6QWPPJwk6Ob
         GAj/7C+5HQsQjgIixOj6LLVgUxTsPcR0OgtFfF0M68WstwV+yXavmyeYWI/Kx370XqjD
         RhYw==
X-Gm-Message-State: APjAAAVt1Q5mC/u/3wu+M5459bM7VHXcJGQitztPNekm0OYY463T6LNr
        +xEzBNIohMntpeEqW7tA3zIrVhNkVHptHjlABX8=
X-Google-Smtp-Source: APXvYqz6kmxieLVsAlWppp7WYkws+rqBkJQDPOx19ZiJJZxedDAXJA5I1kvT8tkdtm6L069tTf0Ia725klgqSJrM0uU=
X-Received: by 2002:a5e:8e03:: with SMTP id a3mr5234885ion.126.1555520968370;
 Wed, 17 Apr 2019 10:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190417152701.23391-1-brgl@bgdev.pl> <20190417152701.23391-5-brgl@bgdev.pl>
In-Reply-To: <20190417152701.23391-5-brgl@bgdev.pl>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 17 Apr 2019 12:09:17 -0500
Message-ID: <CAHCN7xKVaYqd5LLvRx7i8ik+JnTFdpexZf2WXt0R2N1W1skOJA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] ARM: dts: da850-evm: enable cpufreq
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 10:27 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Enable cpufreq-dt support for da850-evm. The cvdd is supplied by the
> tps65070 pmic with configurable output voltage. By default da850-evm
> boards support frequencies up to 375MHz so enable this operating
> point.

Have you done any testing with the LCD on any of the devices you have?

I enabled the ondemand governor, and I got a bunch of splat from the
LCD controller:

tilcdc 1e13000.display: effective pixel clock rate (50000000Hz)
differs from the calculated rate (54000000Hz)
tilcdc 1e13000.display: tilcdc_crtc_irq(0x00000161): FIFO underflow
tilcdc 1e13000.display: tilcdc_crtc_irq(0x00000161): FIFO underflow
... [ snip]
tilcdc 1e13000.display: effective pixel clock rate (50000000Hz)
differs from the calculated rate (54000000Hz)
tilcdc 1e13000.display: effective pixel clock rate (50000000Hz)
differs from the calculated rate (54000000Hz)
tilcdc 1e13000.display: tilcdc_crtc_irq(0x00000161): FIFO underflow

It appears to go on forever.  I don't necessarily want to hold it up,
but I don't know the clocking system well enough to know where to go
investigate it.  I can certainly live without ondemand.  Using
userspace as the default governor is fine for me for now.

adam
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Adam Ford <aford173@gmail.com>
> ---
>  arch/arm/boot/dts/da850-evm.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index f04bc3e15332..f94bb38fdad9 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -191,6 +191,19 @@
>         };
>  };
>
> +&cpu {
> +       cpu-supply = <&vdcdc3_reg>;
> +};
> +
> +/*
> + * The standard da850-evm kits and SOM's are 375MHz so enable this operating
> + * point by default. Higher frequencies must be enabled for custom boards with
> + * other variants of the SoC.
> + */
> +&opp_375 {
> +       status = "okay";
> +};
> +
>  &sata {
>         status = "okay";
>  };
> --
> 2.21.0
>
