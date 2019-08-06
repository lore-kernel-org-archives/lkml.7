Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C339EC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9282C2147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JrZ6jaH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbfHFMoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:44:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34280 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbfHFMoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:44:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so87803792wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KO3I9isK829bDAzoIYhMJ5BHP8qWfbUOhOqwyY1Ue8Q=;
        b=JrZ6jaH1U8FIHz6Bc8fph0FiiWO6K+omU5EUJU4jjF30+ys1KQU3SZdTkQa3jdLrn0
         E7L1bTIc93b/aDcBr4funyN2HbaOOQUAE267YVC5GaaLCnjz+RM+FVzJYaATJfGImyc4
         r6Z/odJIDA5rFceLBE0XAZqZejXuLitKd5blVAf8H3urYm7jwPHgHTODfcZ95TA+PDaC
         cMRx3zSX1Q9811UjLuu4eddHynsPD0T53VLfp1zJFwHCtjukZZVpw8UERDQBYTmkMekx
         iEKyihqFLrtNAD0AeVEQsc4DtgbJxve5flvT1gYQRYBfikrDEVDcFYH4/Ghsmm6sJuJc
         OtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KO3I9isK829bDAzoIYhMJ5BHP8qWfbUOhOqwyY1Ue8Q=;
        b=WRKrEbDz0aeD9W+tBz474leMvyvUNqrqdwGIux2EXilorENxaDAjgvhlVpdqHFwSCD
         Qtg4D2hAHsmefgzy/PITrp95BGpCz8X7191skELowr1rSSrCVa5wqGYTbfrGGrRaOViN
         zEFN3kwl9FG3tucSO3TCTg5SHPE9rFv15lNCSl9/wrf65csoFaTnyJvxLDd+12dfZK8g
         jsBO+vQfFOKmPJoBh1EvXcA2fiuVndcmohvaNEszC3VOK98BmeEVYENk9P2RT4HVXwo3
         UnE9Hpg61np+kZMlDclSAppCcvBT6eQdE/ecJvbFcWr5xs8O0hw8goai+veMvTWatJ3J
         rOFQ==
X-Gm-Message-State: APjAAAVX2/aF9sKjntHH3BjntkL2eGBgSO7BGMWydkS1cSVcb5LRfjwH
        U9OmV8tir5AT/sgzXzZz9cKgGQ==
X-Google-Smtp-Source: APXvYqxzWD1+g+8j3XMze7/L/Id/Sa6g7GtYPAKutoXeGaVKKMV2UxVERxWGXrSeGKhdH+ieqhGhpQ==
X-Received: by 2002:a5d:56cb:: with SMTP id m11mr4724737wrw.255.1565095458656;
        Tue, 06 Aug 2019 05:44:18 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q20sm3842135wrc.79.2019.08.06.05.44.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 05:44:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] drm/meson: convert bindings to YAML schemas
Date:   Tue,  6 Aug 2019 14:44:13 +0200
Message-Id: <20190806124416.15561-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset converts the existing text bindings to YAML schemas.

Those bindings have a lot of texts, thus is interesting to convert.

All have been tested using :
$ make ARCH=arm64 dtbs_check

Issues with the amlogic arm64 DTs has already been identified thanks
to the validation scripts. The DT fixes will be pushed once these yaml
bindings are acked.

Neil Armstrong (3):
  dt-bindings: display: amlogic,meson-dw-hdmi: convert to yaml
  dt-bindings: display: amlogic,meson-vpu: convert to yaml
  MAINTAINERS: Update with Amlogic DRM bindings converted as YAML

 .../display/amlogic,meson-dw-hdmi.txt         | 119 --------------
 .../display/amlogic,meson-dw-hdmi.yaml        | 150 ++++++++++++++++++
 .../bindings/display/amlogic,meson-vpu.txt    | 121 --------------
 .../bindings/display/amlogic,meson-vpu.yaml   | 138 ++++++++++++++++
 MAINTAINERS                                   |   4 +-
 5 files changed, 290 insertions(+), 242 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml

-- 
2.22.0

