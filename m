Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA842C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C6920850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dTWG1Ka8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDAKTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:19:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46628 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfDAKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:19:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so4514433pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=isWCtOGJ5Ynbhczddu295wUNFHtoyfeH1sAsyYI/1MI=;
        b=dTWG1Ka8oTnidJZlucTXXAlJFWwTlhnsJ4ECRAbhrIhvN51W5Hp1CVUlDTbu7Cgnz2
         KfddahhRAgyBGTJ9UzXxCpdgFDq9JGTLFHxoc36G3rmiyO+oRDcqtZNW6oePX3JGg2Fu
         BLiZyXkZWFreB5Zmgg/YY0eKJzngrjwE4L8iOyI037HE9QAm7jr8A6h3CUaGcLNULEuo
         toTouzi+/PsgduFqvW+K0zuF2U+jgWpL7dXZ7CvY2GAJ14I7+VbrY/W5alhN3DPcrZlp
         4jSnbziwnC8Yh//pKVJ9AI3eNk0ivMXl8V+P1Au/qCYlPX0zKovOY5o85v6CSsI+rnAW
         Hhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=isWCtOGJ5Ynbhczddu295wUNFHtoyfeH1sAsyYI/1MI=;
        b=ZlvQumPukDjW3juxJwi01ATbIrTI6jcuG5H5lQL6mCE5pkL6Ih5cM95IQdM5vY6z9T
         ttDhMpdmhStgDYGJJps0oomZpcHTnQqJbTzHQS3gi7U2gTja0Fbo86EeTFnu+dSeKg6v
         85pYke0jmIqwcy5EWSm53jDdbmWfNNc+H5kQkq8ViHTe0ddJyADeTQl+GQ9JU+x30pO9
         4W/WDjvU9OTpfpSVaiOdKCisSJuY/T0yHnjEFH22wEHRNNhBZHRhIC1ZBc8Q/VOB2zxQ
         mbB9ehfvgZJNVtzrpD9jrYoP9v1leeswiFchSM7fg1ntvtmuKZ5F3ffy6qetpqaMHavG
         iPsQ==
X-Gm-Message-State: APjAAAV6ZxjxP+FSbarWoccfPgG6RuEOfeJIhlnad1pL+nwCwBJ8PrzU
        UYSpKOCyHSRh1t9wN9zCBwfGKg==
X-Google-Smtp-Source: APXvYqx1UwYe/CbEKMy7JpOZRstv4FiE/U03gbkssVnlGPeMQdcbe90O04ihzac978msmgMQ9tAE7w==
X-Received: by 2002:a62:e50a:: with SMTP id n10mr38800990pff.55.1554113980363;
        Mon, 01 Apr 2019 03:19:40 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id h187sm7289160pfc.52.2019.04.01.03.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:19:39 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:19:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v4 0/9] Introduce STMFX I2C Multi-Function eXpander
Message-ID: <20190401101934.GC4187@dell>
References: <1551260094-32570-1-git-send-email-amelie.delaunay@st.com>
 <b3cdddb0-8177-600c-7108-9a16e9067190@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3cdddb0-8177-600c-7108-9a16e9067190@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019, Amelie DELAUNAY wrote:

> Hi,
> 
> A gentle ping on this series (mfd + pinctrl patches, DT patches will be 
> taken in STM32 soc tree).

I currently have over 100 reviews in my backlog.

Please be patient.  You are on the list.

> On 2/27/19 10:34 AM, Amelie Delaunay wrote:
> > This series adds support for STMicroelectronics Multi-Function eXpander
> > (STMFX), used on some STM32 discovery and evaluation boards.
> > 
> > STMFX is an STM32L152 slave controller whose firmware embeds the following
> > features:
> > - I/O expander (16 GPIOs + 8 extra if the other features are not enabled),
> > - resistive touchscreen controller,
> > - IDD measurement.
> > 
> > I2C stuff and chip initialization is based on an MFD parent driver, which
> > registers STMFX features MFD children.
> > 
> > ---
> > Changes in v4:
> > - mfd: move registers #define into the header
> > - mfd: merge stmfx and stmfx_ddata structures into one stmfx structure
> > - mfd: change stmfx_chip_init/exit and stmfx_irq_init/exit args: use
> >    i2c_client struct and i2c_get_clientdata
> > - mfd: fix typos
> > - mfd: add MFD cells for IDD and TS features
> > - pinctrl: rework registers #define
> > - dts: add STMFX support on stm32mp157c-ev1
> > Changes in v3:
> > - fix MFD interrupt bindings
> > - fix drivers/mfd/stmfx.c:103:8: warning: 'mask' may be used uninitialized
> >    in this function
> > Changes in v2:
> > - move to MFD parent driver for i2c stuff and chip initialization
> > - improve regmap configuration
> > - take advantage of the use of gpio-ranges
> > 
> > Amelie Delaunay (9):
> >    dt-bindings: mfd: Add ST Multi-Function eXpander (STMFX) core bindings
> >    mfd: Add ST Multi-Function eXpander (STMFX) core driver
> >    dt-bindings: pinctrl: document the STMFX pinctrl bindings
> >    pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
> >    ARM: dts: stm32: add STMFX support on stm32746g-eval
> >    ARM: dts: stm32: add joystick support on stm32746g-eval
> >    ARM: dts: stm32: add orange and blue leds on stm32746g-eval
> >    ARM: dts: stm32: add STMFX support on stm32mp157c-ev1
> >    ARM: dts: stm32: add joystick support on stm32mp157c-ev1
> > 
> >   Documentation/devicetree/bindings/mfd/stmfx.txt    |  28 +
> >   .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 116 +++
> >   arch/arm/boot/dts/stm32746g-eval.dts               |  66 ++
> >   arch/arm/boot/dts/stm32mp157c-ev1.dts              |  60 ++
> >   drivers/mfd/Kconfig                                |  13 +
> >   drivers/mfd/Makefile                               |   2 +-
> >   drivers/mfd/stmfx.c                                | 568 ++++++++++++++
> >   drivers/pinctrl/Kconfig                            |  12 +
> >   drivers/pinctrl/Makefile                           |   1 +
> >   drivers/pinctrl/pinctrl-stmfx.c                    | 820 +++++++++++++++++++++
> >   include/linux/mfd/stmfx.h                          | 123 ++++
> >   11 files changed, 1808 insertions(+), 1 deletion(-)
> >   create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt
> >   create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
> >   create mode 100644 drivers/mfd/stmfx.c
> >   create mode 100644 drivers/pinctrl/pinctrl-stmfx.c
> >   create mode 100644 include/linux/mfd/stmfx.h
> > 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
