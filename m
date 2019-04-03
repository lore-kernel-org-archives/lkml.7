Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A13C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FF420882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZpOHbMU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDCGUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:20:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34562 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfDCGUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:20:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so7625653pfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 23:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eswEeBpURF8MK9rTWMzPQTjtTLoyZ0taU9MBItrI6/Y=;
        b=ZpOHbMU0Y/tLIBOuo186iTJOT7p7IpaYm3rPqbtMgInnl1lMoKnlYbkup0QfMauQrq
         xhz71NytQBdxF7jm5VIbMmKikxByqOgQdNy+L+Uq7aIHnRajS2Ambxtxsm9uc9O6s7F6
         CPTRVzOps0S3GVtpRILiS4Sj0WYl/o/o3eX36FeWepvA8qozIFLjLZ7upjVvpFZXXNXS
         SNjPgccKTS9l+IJjfhPWvt9MV5W8ZETIOCpdfQomqzEbv4o7VpRijqYVOYN5efqWyDCZ
         qcQjjtn2W1V3JFP6/NKbHx1vVuTfrkhvhB/yRCq7q/Ci8m3CvYCkZ9MUlkg1s9sg5RWx
         sM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eswEeBpURF8MK9rTWMzPQTjtTLoyZ0taU9MBItrI6/Y=;
        b=f9V8EilS5iiAuJjbmcemi7xu/o6mpo0vzLMPrliyN3iJ78YG8gOnHb8+oBnGEKLSFy
         bwzNck6I92YD9ERQoFJ5oP18Ynww8UreRdlyCX70CynB1TbTex672JOwiWaWU6OogQN6
         YBGPpL1ZU68ufMqUktEKsFS6+CcI3MciyAToOSGScWu8hITMIN6mUjhpsIDpkHTv0NzY
         1PZLaXE5n4DUTsx+Y6T1c/qobUH/0RHIjZ/HMy8pGwtyTsLGIe+LpCIZ1AdEwjagqf74
         qE0ew3nr+/zbCxHZedHj8xwBRBkF0p/mL5h/kWkWwUNpop3A250CpyRn1NnVBtyHtg5S
         3/7g==
X-Gm-Message-State: APjAAAXu1zzTY4tZ1biiS7SeSDG/toxaS12JXx2aafqutd/Yp0MXJ5cZ
        VNEIiyKByAK15pcMIrN2L8P7hw==
X-Google-Smtp-Source: APXvYqwAuTuOjv3qb20cyiLVTTuUVm+CQ7XnpfHgKiTKUjmCjIj1nDap5c2HbWvRfQdL3gVA3fTTMg==
X-Received: by 2002:a63:b811:: with SMTP id p17mr40659296pge.219.1554272445288;
        Tue, 02 Apr 2019 23:20:45 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id i31sm29457766pgi.36.2019.04.02.23.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 23:20:44 -0700 (PDT)
Date:   Wed, 3 Apr 2019 07:19:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH v11 1/8] mfd: regulator: clk: split rohm-bd718x7.h
Message-ID: <20190403061916.GL4187@dell>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <81d7136a77a2786c122a1cbf3289c96c51ded79f.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81d7136a77a2786c122a1cbf3289c96c51ded79f.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Matti Vaittinen wrote:

> Split the bd718x7.h to ROHM common and bd718x7 specific parts
> so that we do not need to add same things in every new ROHM
> PMIC header. Please note that this change requires changes also
> in bd718x7 sub-device drivers for regulators and clk.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk-bd718x7.c             |  6 +++---
>  drivers/mfd/rohm-bd718x7.c            | 23 ++++++++++++-----------
>  drivers/regulator/bd718x7-regulator.c | 25 +++++++++++++------------
>  include/linux/mfd/rohm-bd718x7.h      | 22 ++++++++--------------
>  include/linux/mfd/rohm-generic.h      | 20 ++++++++++++++++++++
>  5 files changed, 56 insertions(+), 40 deletions(-)
>  create mode 100644 include/linux/mfd/rohm-generic.h

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
