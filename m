Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D27C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9116C21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0btmJF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfDCHhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:37:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44929 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbfDCHhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:37:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id g12so7594194pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tTDqQ5Y5rmXUAYVS3wCM9s5HAV2vqc3Sb8tg6vODReA=;
        b=Q0btmJF2NaHkinKav01H6lIFNNF9E1YZ2b+1ZZf4T9BJSWb+nK/BxrzeL6eFPa4l4u
         feGr/g8MKoVJ2mDhfXsSQxYYAzfD4/Fes20c9tfJQiVL1dsH2QdSnTXsW8VZ1FcyCbpL
         I3XKzqRwtJtjf/xp3GRF18E2unUoztucL0CgLaxwVUkOvdvxl+tEHcYR8MI7NGIRyFXH
         HioNi3AORzzldkN8MHK/cozpqvt8FihDwegdARfR6x18ga1oVD0Z3VjJcKKiJIYpQ/Kn
         EWRR26r4zRtbZ1+3uqF3/pdhWy96F5pm/ysQ6Ti/E7rQW3RvkKYW33eNevv6dROKii8Z
         2QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tTDqQ5Y5rmXUAYVS3wCM9s5HAV2vqc3Sb8tg6vODReA=;
        b=b9cFdJ0nm4S/8h3cozoLI4e5uSKq8CqTw/7xIhb8BgHecfdIe1wXwvrpr81i+KG7Qa
         ssoVBeZgU3efPyPM1dwcPUla0k0rGYyJl0OktGMGwB7Xb48PPhRpeEy2CCIXk7+HZdwV
         x14ZICX5EBISAZgzf3JO3nZlEktz75Iob+AUT3h11AMUogHiohJBYC/pAwePFnLtOgef
         WaJw2iqBSHrwQnTm485tYvCiF1L+Fg1lzNaEoV5lvsWGqUW7zNbTEcS7yu5+t+kNTDeO
         3jHFldGbypy1cH6d6WGgo4fHmU4YRbY9ncHoGS+Bgz486A8V0KDBVug1s//+Rs5wbLwp
         /GLA==
X-Gm-Message-State: APjAAAXGiMrE6Au75kxRj/2OvNpjClRoc1i83KY5SyUut1m8mjWLZ3n6
        W5++PGGrWPSG2CVigWtGziJ/iQ==
X-Google-Smtp-Source: APXvYqwkdrbsBO1ZanQIGeR69xJZVQf09rEUd/FxbxU6alHWDkYqNikk0kZVmrz0PjgkJclUZZkvqQ==
X-Received: by 2002:a17:902:1123:: with SMTP id d32mr11706541pla.16.1554277039176;
        Wed, 03 Apr 2019 00:37:19 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id w3sm36826427pfn.179.2019.04.03.00.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:37:18 -0700 (PDT)
Date:   Wed, 3 Apr 2019 08:37:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v7 00/11] mfd: add support for max77650 PMIC
Message-ID: <20190403073710.GA11301@dell>
References: <20190326173208.30614-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190326173208.30614-1-brgl@bgdev.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series adds support for max77650 ultra low-power PMIC. It provides
> the core mfd driver and a set of five sub-drivers for the regulator,
> power supply, gpio, leds and input subsystems.
> 
> Patches 1-4 add the DT binding documents. Patch 5 documents mfd_add_devices().
> Patches 6-10 add all drivers. Last patch adds a MAINTAINERS entry for this
> device.

My review carries forward to this version.

Please apply Acks, make changes and resubmit.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
