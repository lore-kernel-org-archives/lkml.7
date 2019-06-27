Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3C5C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3C52083B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjwcbA9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfF0Nae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:30:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54681 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfF0Nac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:30:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id g135so5741414wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xbq4KdqxHucz+vpFUkxO4MJyaiD5Od/cLcCD3lID9E4=;
        b=mjwcbA9iklldSmepid2v8Chbd3qYrKNJjxW/rysKzF2eNQzTZRNoDbYGiOL/IfD82N
         6gW7Qz76lf72OpVkr3jA4yWGkm9ThBjr/2Zpzl3DAzw8ODl+jFCDeaXMvHNcE4N/oZJU
         RKKMBMNHJyu+2raEIPRtXKIlq+ZTdD2zqPy6cgwgxd1gPXDIFC18gKH2kIhsLa1tAQaU
         sYzv/QIymUiCNQd2TJO7f9Ubb9eVMfCeLMyKbdD9mbZJAa2JuUFThhzJKuxTAH22kcnJ
         b3hOZoLePhBrkm5moeRivcOzrs2VEwcVOVtKUoiqCkESy6tY37RP0kqFakRFDS3LCzBv
         i6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xbq4KdqxHucz+vpFUkxO4MJyaiD5Od/cLcCD3lID9E4=;
        b=QoV5psojqCmw6YeMYYV3+zjUVt69iIlz4F1KJSXqu3O4uewfmEadp9Xvyq4GRVdAU6
         L5pH9qj4HEGlg9IOV+VeSwhCVNhqMMkcgKpi+dyUx16DqvayznImqoZTdeFbqAfdQ1Fj
         D6E+LQLFKvTRGfBXBljGkovckgV3eV7nQGpe6CtVoiI/L6sFh6WyXTf9DNIk2p/h2rqL
         TQzEMu/7OuDOw9O6naNTwtxZ4G4K8LzZ1J0JVgwDkD0BB7CfEpU439ENT9P6Tcy7e9Di
         Kp/rHacZkPywuU6+KZje8oEQplR4l7Ug46hhpK5UJmp1uAAbrWxY80w/XcULJu7jms4h
         574w==
X-Gm-Message-State: APjAAAWANiuuaNnjc5uuYWO7kbMl2Vhq6pUayhxHFGBpLbJAX2feWZdL
        H3T8HlVYwSA4jDmRv4F4OG/0GQ==
X-Google-Smtp-Source: APXvYqwnCtGtIHU6oxnjOXis56rx3dsxnAGKNuysbzf/1YRh5Mc7ST2Z50KP/cLbucVnbJzfyj8BNA==
X-Received: by 2002:a1c:d10c:: with SMTP id i12mr3277916wmg.152.1561642230011;
        Thu, 27 Jun 2019 06:30:30 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id c6sm7876851wma.25.2019.06.27.06.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 06:30:29 -0700 (PDT)
Date:   Thu, 27 Jun 2019 14:30:27 +0100
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, Clk, GPIO, Power, Regulator
 and RTC due for the v5.3 merge window
Message-ID: <20190627133027.GC2000@dell>
References: <cover.1559546139.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1559546139.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-clk-gpio-power-regulator-rtc-v5.3

for you to fetch changes up to f8c7f7ddd8ef0855d06cff5d1cc7713b556006a7:

  power: supply: Initial support for ROHM BD70528 PMIC charger block (2019-06-27 10:57:24 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Clk, GPIO, Power, Regulator and RTC due for the v5.3 merge window

----------------------------------------------------------------
Matti Vaittinen (7):
      mfd: regulator: clk: Split rohm-bd718x7.h
      mfd: bd70528: Support ROHM bd70528 PMIC core
      clk: bd718x7: Support ROHM BD70528 clk block
      dt-bindings: mfd: Document first ROHM BD70528 bindings
      gpio: Initial support for ROHM bd70528 GPIO block
      rtc: bd70528: Initial support for ROHM bd70528 RTC
      power: supply: Initial support for ROHM BD70528 PMIC charger block

 .../devicetree/bindings/mfd/rohm,bd70528-pmic.txt  | 102 +++
 drivers/clk/Kconfig                                |   6 +-
 drivers/clk/clk-bd718x7.c                          |  24 +-
 drivers/gpio/Kconfig                               |  11 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-bd70528.c                        | 232 +++++++
 drivers/mfd/Kconfig                                |  17 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/rohm-bd70528.c                         | 316 +++++++++
 drivers/mfd/rohm-bd718x7.c                         |  23 +-
 drivers/power/supply/Kconfig                       |   9 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/bd70528-charger.c             | 743 +++++++++++++++++++++
 drivers/regulator/bd718x7-regulator.c              |  25 +-
 drivers/rtc/Kconfig                                |   8 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-bd70528.c                          | 500 ++++++++++++++
 include/linux/mfd/rohm-bd70528.h                   | 408 +++++++++++
 include/linux/mfd/rohm-bd718x7.h                   |  22 +-
 include/linux/mfd/rohm-generic.h                   |  20 +
 20 files changed, 2425 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
 create mode 100644 drivers/gpio/gpio-bd70528.c
 create mode 100644 drivers/mfd/rohm-bd70528.c
 create mode 100644 drivers/power/supply/bd70528-charger.c
 create mode 100644 drivers/rtc/rtc-bd70528.c
 create mode 100644 include/linux/mfd/rohm-bd70528.h
 create mode 100644 include/linux/mfd/rohm-generic.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
