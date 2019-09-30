Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C75CC35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51E921920
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tIxdis1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfI3NDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:03:00 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:40689 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730830AbfI3NC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:02:59 -0400
Received: by mail-wm1-f48.google.com with SMTP id b24so12625524wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vNX+Pqr7l6mVyA3yK7rKaQ3s0VflVZgQrJhL3g7/Ip4=;
        b=tIxdis1cAH+RvP4PA/a2sKVUiFk+Cb8ktSu0Khl9Hhsng9haOllbEdr+iuZx3lPSYU
         sDOw0/LmRP8ATtF8hVEim3PnfPDf7quuj2Rn4LNrfdNjQ/WNeOIEa1ZLSpdi01EojiUu
         v2U2CqItDoxwn99A0kVco8fUslg9NmMhNjof/Zm9Hj/7fzahvz+7MW24L6ymTx9cntQ4
         iG8x57C+wJnP1ViTabcJxmaDc9fur1vkKOQ2wJ/uwMiVtM4pZ7eeBQB7jQVZvcfHgs5b
         0igr1XNlgRQ6W1pmNpMM5C3eRZKZW6j9mpzEV/oMcDWMbEP8KJsJw5uVhQ2QYXy4w2Ft
         g9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vNX+Pqr7l6mVyA3yK7rKaQ3s0VflVZgQrJhL3g7/Ip4=;
        b=NqD8ylCrx8st9R2m3ucpe7ValskUyzn2g9Eob/RD1kB/LwCInenhjDIBxg2qe0og+O
         a21hTw/4sCWXq1PCwuay0Z4weNWkCEQ423igvGcj0WdJFJiZIoKc6bOPca07730Jkk67
         0PtaDGG03rlc/s7ZzPPdlqjV6FvrMZJ+OFkS4pTdGWtu7HIjqcZL5wmAKviBI/tB1mKm
         +V00KLXNgXXBrFQhIA3mtnf8TLiPJ8PoTs6rMNDy6TGNkiuOCsadSSDKGeuxpheuImK9
         Q9I42w9RXvort5EG1rMJgbNL8lnckjWjC1EwZFxuWg2V6lTt4SemWk9GFSgEbGrxhrm3
         2x8A==
X-Gm-Message-State: APjAAAUOaNM4OSSyiawqO1ldHjBvAg+bAn20Qo2Hajho+n5atGoRgZAo
        xuIejEbgmHFtquGK0QfeILqzvw==
X-Google-Smtp-Source: APXvYqxK7o4G9mpvoB48Pb3o2/pQXGinDSvX0SV4RdXXaPNltTKFMwrC3kfNsl75Q4BTOzphLXez4w==
X-Received: by 2002:a1c:3182:: with SMTP id x124mr18351314wmx.168.1569848577745;
        Mon, 30 Sep 2019 06:02:57 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id e6sm10654756wrp.91.2019.09.30.06.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 06:02:57 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/6] dt-bindings: max77650: convert the device-tree bindings to yaml
Date:   Mon, 30 Sep 2019 15:02:40 +0200
Message-Id: <20190930130246.4860-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series converts all DT binding documents for max77650 PMIC to yaml.

Bartosz Golaszewski (6):
  dt-bindings: mfd: max77650: convert the binding document to yaml
  dt-bindings: input: max77650: convert the binding document to yaml
  dt-bindings: regulator: max77650: convert the binding document to yaml
  dt-bindings: power: max77650: convert the binding document to yaml
  dt-bindings: leds: max77650: convert the binding document to yaml
  MAINTAINERS: update the list of maintained files for max77650

 .../bindings/input/max77650-onkey.txt         | 27 +-----
 .../bindings/input/max77650-onkey.yaml        | 43 ++++++++++
 .../bindings/leds/leds-max77650.txt           | 58 +------------
 .../bindings/leds/leds-max77650.yaml          | 82 ++++++++++++++++++
 .../devicetree/bindings/mfd/max77650.txt      | 47 +----------
 .../devicetree/bindings/mfd/max77650.yaml     | 83 +++++++++++++++++++
 .../power/supply/max77650-charger.txt         | 29 +------
 .../power/supply/max77650-charger.yaml        | 42 ++++++++++
 .../bindings/regulator/max77650-regulator.txt | 42 +---------
 .../regulator/max77650-regulator.yaml         | 51 ++++++++++++
 MAINTAINERS                                   |  4 +-
 11 files changed, 308 insertions(+), 200 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.yaml

-- 
2.23.0

