Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83347C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B56C20715
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcBBVHwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbfKTOoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:44:09 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39032 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731732AbfKTOoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:44:09 -0500
Received: by mail-qk1-f195.google.com with SMTP id o17so1418477qko.6;
        Wed, 20 Nov 2019 06:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iD5VdmpBbS5ofXM1bEbJ4CdwRf9cLtYwc6n6MEZikZ8=;
        b=fcBBVHwd8stIuuRz12zTYinYh9Ekei8cksJtUXbByJEMTwCjd6eRT/nRQBZIJKooyT
         jXiMqzBD4G6kHSuBgXth5rLIYb5TcaKYbOpsnbQWUPj6u6pOGsUNJPPXMhJzaDgKAOx2
         hbI7IQWFrYvBkbxg1IkKVYyWZSAcXKFJFITpMlAg27bf564HcJtH65tuZx3V9mbuipr/
         Ylt4/bganmEimAFR19T+oKWbSvD5Xliwqsbr1Fbq2uUeoAcGXuwQD1R1F2xF4++syD0J
         +nDJsA43jFffW2fGx6yJoPS1kDb4DrOy3RCAVIjoxpUcsyvI21U24KispoP0PShm2K3U
         AVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iD5VdmpBbS5ofXM1bEbJ4CdwRf9cLtYwc6n6MEZikZ8=;
        b=YylKUOvYVGDL+7OZS1dLn9ZBp4uh00YJhwJt9k+uHchVNRxi1HzaFY02CiVHauqTp5
         I//1NXJ5qRlLRKAVceg+0u02+GJtuv4RRDww79Wk9yVCThbZIL4hwhLug8I6tlvXoFxu
         2MyRlc8kxC8nJZAq6TmzIEo9L5S9qo7Z2L/I609HsJdFLh6XDBAGXAwFrFu0ekU7xuke
         M2p8cMONgTXl3wLuQEyMLRC5r1ILPgB3uKtJ5zn+RwI1pLfnjiVrREVvQm4TblMMGXeO
         SWVzDzYA+aeypjwmDnS1tSiMRzhZM6mL3iDbRQuZzK/XBy6aS+K0ffjaRkN+iJNxRipu
         em2Q==
X-Gm-Message-State: APjAAAUUUhZAvPCbSZ+CH8uf7e/0b9AVz2VuU8upu1JceQD/caJm9S0j
        kkGGWUna6Dp2KZGfi0Y6EDM=
X-Google-Smtp-Source: APXvYqwOmADMwxL92rcPRniRH1Cz/Y9781sRftexfktLdGllzm5r9/vJO6BjLckNrzfIxUjCXFOtFA==
X-Received: by 2002:a37:610f:: with SMTP id v15mr2566068qkb.98.1574261046446;
        Wed, 20 Nov 2019 06:44:06 -0800 (PST)
Received: from localhost.localdomain ([72.53.229.209])
        by smtp.gmail.com with ESMTPSA id 62sm953069qkk.102.2019.11.20.06.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 06:44:05 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Grigoryev Denis <grigoryev@fastwel.ru>,
        Axel Lin <axel.lin@ingics.com>, Dan Murphy <dmurphy@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH v3 0/3] tps6105x add devicetree and leds support
Date:   Wed, 20 Nov 2019 09:43:58 -0500
Message-Id: <20191120144401.30452-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3:
	Removed tps6105x regulator patch - it was accepted (Mark Brown).
	
	Removed devicetree/platdata bindings for tps6105x led naming.
	I can test only with a 4.19 vendor kernel, which does not have the
	latest led naming infrastructure (function/color). Drop devicetree/
	fwnode/pdata led naming in favour of hard-coding to "tps6105x::torch",
	so the patch can be tested by me, yet remains acceptable to upstream.

v1 -> v2:
	Select chip operational mode by looking at subnode name, _not_ its
	compatible property. Suggested by Mark Brown.

I needed led operation for this mfd chip, so I added a very simple
driver for this.

My platform (arm imx6q) is devicetree-based, so I added optional
devicetree support for this chip and its sub-drivers.

Sven Van Asbroeck (3):
  tps6105x: add optional devicetree support
  leds: tps6105x: add driver for mfd chip led mode
  dt-bindings: mfd: update TI tps6105x chip bindings

 .../devicetree/bindings/mfd/tps6105x.txt      | 39 ++++++++++-
 drivers/leds/Kconfig                          | 10 +++
 drivers/leds/Makefile                         |  1 +
 drivers/leds/leds-tps6105x.c                  | 67 +++++++++++++++++++
 drivers/mfd/tps6105x.c                        | 34 +++++++++-
 5 files changed, 147 insertions(+), 4 deletions(-)
 create mode 100644 drivers/leds/leds-tps6105x.c

-- 
2.17.1

