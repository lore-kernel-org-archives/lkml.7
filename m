Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3825FC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CF720850
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hrgSnmEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfEJIYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 04:24:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46109 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfEJIX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 04:23:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so6038336wrr.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 01:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Wj+JuMQUbdyPmxQe7yGb3on4JCnRF2E0EfoUvV/8+mo=;
        b=hrgSnmEZP5o845QntWaqkMqOVqNtfRnJYedwIUiR8aPv3ToBQClvXus+4pijKIphJ+
         mju28gpMrnOTM9z7MYRAGPici4FVfNz+TShfe8r6CyXky1Ih8JmxTScix+E04B3sRfgF
         L3sOCzpOZYj3Hj6jMrWSqj2mYH1+2j8ov41RmXVBFaIT8wzFffPWwZwgOV7i4PKIOUAu
         sx1JH1zTJ0iq1IMsKAEDgdLfFPFQMcxKwPiS0HPEdq5cSPMfiNDzbDWf/j4mdhHdvlbe
         q/XV9JO1MbM5xRpaD1ZZqFZLCvUFqFfZg1q7sGkEv9avADAEmB0W3DQP4LoUQDeN/ea/
         0Xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wj+JuMQUbdyPmxQe7yGb3on4JCnRF2E0EfoUvV/8+mo=;
        b=c281GHPja4uvlUnQRqXQK5RhuxZHMN6XPMGs/7uGXcCGscAg1ghQUsBz87jP93T6u8
         stsj99Ck6c2z9jmVqBAy0MGqlfB5ZmXQlXPSqzQW+3ZUsLYLhtGrjBsHCWqMy3rbrlkG
         LlPkEAp/O4WE+qq21PJ/5huoVKQwWm2keLPv+79GvUJ0ip7lMvW8rlziL/5C1KheSinp
         ANQyX9PxSbJFmHffjsdH+wKbkIG7jdBhlHyzeRHojgqrm47faEZRd1aYbQtUwxjrQWhX
         R095yiCwJLTXxXCmJBpxX316CJ6YQ5CKePWZT/SSPlep2dm5lrjBwcWRV52RS/MtB5Gl
         GAtA==
X-Gm-Message-State: APjAAAVsK0CH4BpNt3m0XH8hKmmucERV4iRMgR+gJviDqXBSMpvK/1Pa
        NNFO20OCqzQxENdtZBntu3uoRg==
X-Google-Smtp-Source: APXvYqwecEWs+XfLMKppQZEk1BrPP3H3rvwtOqtfnWYTx6JqWQTAaqAiGxF1JGoGfM272vY60No63w==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr6684597wrw.105.1557476606633;
        Fri, 10 May 2019 01:23:26 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z4sm3790285wmk.5.2019.05.10.01.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 01:23:25 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, khilman@baylibre.com
Cc:     jbrunet@baylibre.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] Add drive-strength in Meson pinctrl driver
Date:   Fri, 10 May 2019 10:23:18 +0200
Message-Id: <20190510082324.21181-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patchset is to add drive-strength support in meson pinconf
driver. This is a new feature that was added on the g12a. It is critical for us
to support this since many functions are failing with default pad drive-strength.

The value achievable by the SoC are 0.5mA, 2.5mA, 3mA and 4mA and the DT property
'drive-strength' is expressed in mA.
So this patch add another generic property "drive-strength-microamp". The change to do so
would be minimal and could be benefit to other platforms later on.

Cheers
Guillaume

Changes since v4:
- fix dt-binding documentation
- rename drive-strength-uA to drive-strength-microamp in coverletter

Changes since v3:
- remove dev_err in meson_get_drive_strength
- cleanup code

Changes since v2:
- rename driver-strength-uA property to drive-strength-microamp
- rework patch series for better understanding
- rework set_bias function

Changes since v1:
- fix missing break
- implement new pinctrl generic property "drive-strength-uA"

[1] https://lkml.kernel.org/r/20190314163725.7918-1-jbrunet@baylibre.com

Guillaume La Roque (6):
  dt-bindings: pinctrl: add a 'drive-strength-microamp' property
  pinctrl: generic: add new 'drive-strength-microamp' property support
  dt-bindings: pinctrl: meson: Add drive-strength-microamp property
  pinctrl: meson: Rework enable/disable bias part
  pinctrl: meson: add support of drive-strength-microamp
  pinctrl: meson: g12a: add DS bank value

 .../bindings/pinctrl/meson,pinctrl.txt        |   4 +
 .../bindings/pinctrl/pinctrl-bindings.txt     |   3 +
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    |  36 ++--
 drivers/pinctrl/meson/pinctrl-meson.c         | 180 ++++++++++++++----
 drivers/pinctrl/meson/pinctrl-meson.h         |  18 +-
 drivers/pinctrl/pinconf-generic.c             |   2 +
 include/linux/pinctrl/pinconf-generic.h       |   3 +
 7 files changed, 193 insertions(+), 53 deletions(-)

-- 
2.17.1

