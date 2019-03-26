Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A89C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955C52075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYUTOnyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfCZOQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:16:05 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33016 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCZOQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:16:05 -0400
Received: by mail-it1-f194.google.com with SMTP id v8so2924400itf.0;
        Tue, 26 Mar 2019 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEOjZYpKMejJbkDAYqurrvWQBSNTI1zmr7mLx7VYA7s=;
        b=AYUTOnyNaTkS5ye7/E64ftAWe2vIMEKHy1UPw3CU4ImWHPkKzINenbGs8Cn82bO35M
         +mtHvNrgMxE6INjEI91E8IIVsLHH26VZNKc+Wk8gCsBs4hUNk3rkCpDJn8duKw22HSu+
         fEKOVdjKmvCzTqqlCDq9OlJhLXUlydNnWBBwCPa6K37Nu+7w/b3wXzzNnSqJ5EMdXARZ
         RwTPKFQtY3aQ7AJRh5VFNv0PNtZyXdvbAdiVmKKjPANqEYDdNzu1BKibtLla0b3HH46H
         E2YfT9iQz4G1gkkLSqQSlL/z5k5gAZ/Up90DxsC8ZTDlxHpporVnY+xnVF5gFzkFWMsP
         EU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEOjZYpKMejJbkDAYqurrvWQBSNTI1zmr7mLx7VYA7s=;
        b=T3kSOYO2O4W3EmpS4LxdD3CFUUvyYUVlovsQz9vswrk7HGq4hnzTXvqeyLX1jv8Sy+
         h6sjPyHuyYeBwcUg+A8EeANJTTtaIcVdWWUhROtn2/7NBeFodgm+MGk/htwBBY2pHG8H
         AXKkCNHR8+DAhEslfWCGpRjcAPeQz7h85mEjED+r/WswuQfW+F1MzpA2xyQOrfDLgDCG
         iHi4HfzOoJIFrgGdePYiu5Z3eTOlKql2NtYv7OpvtKgchHFOXQhkseKbwXTWOnYu/v4r
         y9hAz9XyclrM4JIu3pOjBO/EVj9tNrVSUs00MKPq2sEqIOFB0Ybj9e/F+kWEVMsy+LNs
         jqZg==
X-Gm-Message-State: APjAAAXVf90HiI+p2pbbh/S/DfvGNL5Q7vDp9/BQu7rA6wvumfnc2hzs
        ynGMsp1CgoJk6ltUPKy9bwPAmk39I0NtHeDsYnc=
X-Google-Smtp-Source: APXvYqz8afjv4V4Fd8d3RJB/qI9pOzRABqX9RNuOO+b8tmwTLXqHpwKzP8RhdHdmy9tfTEFhgJIEeiehaBGxYEM2Ud8=
X-Received: by 2002:a24:4e11:: with SMTP id r17mr7140880ita.168.1553609764179;
 Tue, 26 Mar 2019 07:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190322133105.5945-1-brgl@bgdev.pl> <20190322133105.5945-4-brgl@bgdev.pl>
In-Reply-To: <20190322133105.5945-4-brgl@bgdev.pl>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 26 Mar 2019 09:15:53 -0500
Message-ID: <CAHCN7xJLp37dkpTR=ehBntQwD+s5G7M6srmKL-gYEmgDQLv6uw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: da850-evm: enable cpufreq
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 8:31 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Enable cpufreq-dt support for da850-evm. The cvdd is supplied by the
> tps6507 pmic with configurable output voltage, so all operating points
> can be enabled.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-evm.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index f04bc3e15332..a0a1b3dccf37 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -191,6 +191,18 @@
>         };
>  };
>
> +&cpu {
> +       cpu-supply = <&vdcdc3_reg>;
> +};
> +
> +&opp_375 {
> +       status = "okay";
> +};
> +
> +&opp_456 {
> +       status = "okay";
> +};

I pulled part number for the processor used in the da850evm that Logic
PD produces, and it shows a imit of 375MHz.  I cross-referenced the
processor part number with the description from a distributor, and the
part number also lists 375MHz, so I think we should leave 456
disabled.

adam
> +
>  &sata {
>         status = "okay";
>  };
> --
> 2.20.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
