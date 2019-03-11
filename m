Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8308BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46857206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNR1p1b4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfCKG2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:28:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41995 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfCKG2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:28:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id n74so2966371pfi.9;
        Sun, 10 Mar 2019 23:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxNpXdY5s/j8SDDG+kt/vul7CmvFZi2pFDli+Pvm+HM=;
        b=WNR1p1b4jGS080GvFHdh4fmPYg0fODU/fds3CesUcFvyJXitjfIdQxdZbMmc8Dt9QV
         KvfhS/qHHSijioP5EMkwgxE4d+jF6YrO6jW/rwh9zVmzllJ++m+gANKrnQl76OmiR3WI
         B4KM0Bqh+ArVaX06o+sJRGPrN0SnJi7dXhvwlh0nTIY/7fYQp6zhvzgweL+ubMhmmYTR
         njq0RQ7mszZJcqplVapuPlBfviY21pK66Ags1+wzhbiO3e6pwl/jiJkVN1AIwXWraA3s
         PZkI9P+ch0+oAZM6BTKDCbwxEqboQ7B0VHenEgcU4QCNNJ8oVWCYC1OxeBstW4S8X8RX
         JqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxNpXdY5s/j8SDDG+kt/vul7CmvFZi2pFDli+Pvm+HM=;
        b=ek1wNmXleA0q8LERfevcg2lwBifJ3mUwE0CwC2KkPbG5J7zn9zRFji5Aniyp0eSQvZ
         I0/1UqF/w0AYae6xVvMBJX9rJdVSYARgdSCir905rFPAg1X1mM3byY5p3KmprfTokR4O
         4pKJ/4ylDR4bbZFM5IlBznTCjBe1WNsA919ZoF6n3103nCBVsjWLTq7YwzheGc48vJdw
         JPP4r+oj5sTcCtGLw99XyOEjVexagMDuH6vZq2KXGthNvMz70dZNcDr+ChYrtTgObIqC
         Co1YtPkpq3Cg6Sw0PUvGqVHg9LJ7vZLYK7kXzx1XS7LdSFxwLSPnEwVC0uqMVQ3J6Qll
         ZQGg==
X-Gm-Message-State: APjAAAXyFKM2rjj38avX7r253RRAS1ZBqI7NR3U9wq7z2ddKJABEEizM
        QAAJcjX7YHfNLjfg+rSH6X8N4ZscLrs=
X-Google-Smtp-Source: APXvYqxcr3m+JE42J5ZMw7QeCBAjcoacp0rtt/7stL/LYidztYfI1JFBBuqOh+Rf9pZDlWThGKN70g==
X-Received: by 2002:a62:4793:: with SMTP id p19mr32294567pfi.76.1552285685171;
        Sun, 10 Mar 2019 23:28:05 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id f192sm10241679pfc.180.2019.03.10.23.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 23:28:04 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-gpio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 0/7] VF610 GPIO fixes/improvments
Date:   Sun, 10 Mar 2019 23:27:30 -0700
Message-Id: <20190311062737.6652-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series contains a number of fixes/improvements I came up with
while working VF610 GPIO code. Hopefully each commit is
self-explanatory.

Feedback is welcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (7):
  gpio: vf610: Do not share irq_chip
  gpio: vf610: Simplify vf610_gpio_set()
  gpio: vf610: Simplify vf610_gpio_get()
  gpio: vf610: Use devres to disable clk_port
  gpio: vf610: Use devres to disable clk_gpio
  gpio: vf610: Use devres to remove gpiochip
  gpio: vf610: Don't use explicit &pdev->dev in vf610_gpio_probe()

 drivers/gpio/gpio-vf610.c | 85 +++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 49 deletions(-)

-- 
2.20.1

