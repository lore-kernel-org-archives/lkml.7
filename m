Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27823C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FD421872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EgRKAfxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfDLIbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:31:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33744 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfDLIbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:31:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so10848721wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 01:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nD0E6tvz5YY5blNDuqlTgUoxXWGGIerDYPpbiC5BzT8=;
        b=EgRKAfxitsVdBGjPWdMUZjFwye2c9N00X5az65pVszj0chMAgMcaKkYIDmRR4hQWj9
         AH+SIz1zBUV5gS/CiBgY56vh6/7vJYNxKzXJu3LKQ3JMojEEt0Pf+BSuD17uJtBtc/BU
         id2+oDFixe7eCFxaWEXFFku5Ls5Jim6vU1X057P6AsVhC3AG33vruAdinCBSSJO9qwNe
         JVsyAX+s4YCpfRTpc5llav0yEMplLflJ97khEd8CoRrDS3p4Kp8Na9WKTiwiDLtFgalm
         WoLfkHZ0gVijqVwYb34w8hy0ZHlqn2D4GybOQCNicIvo9boh6FDi0j9peCdKLCp850Dl
         NQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nD0E6tvz5YY5blNDuqlTgUoxXWGGIerDYPpbiC5BzT8=;
        b=asBMjWbUzwcRlMJmLFNxlRC4zS6VkOp+Pb/2HdCMLUngtBW6EROPL7tofUhRnLZRUA
         Jm3Xv8LrpH1zI+tUOwBe7SimG6lH/fkIKht82R268yGnGtQFtglr3nu5TbM612X80dsX
         NtwGC7iRpkxKsFjjGznb6sMqgDxqM9FlbG5Sv7A5y+uF37VLNN0DJJtsvxfo93XeZ1Le
         kC3Fo4jwuKh22IDYK+RviXwGMQkaXkjgWHnLLuH7V0P54lJwdmhKF+Kve0cVgDucZWCl
         riiG5b3qphfU+EdFL7QbG3UwryPN5MqHqM4WXyPBtOSDkh82+A/OCKS954Ec95zq2zeN
         ty2Q==
X-Gm-Message-State: APjAAAXdKUra5lPCQJLVdFYiSslgN5OAOQ7uOaqiIf5zTErAmSymCELO
        pPaOdd1imO2lVoOQZJ5AsMlP6Q==
X-Google-Smtp-Source: APXvYqyj9qhtklu5zlotJHBRMnpz1f4ODSoQ6hdMNzhFrM7HYZ3UpvCzBSC8eFhwzrEng6nmndsCpQ==
X-Received: by 2002:adf:ee07:: with SMTP id y7mr32473119wrn.219.1555057870812;
        Fri, 12 Apr 2019 01:31:10 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w11sm116054702wre.15.2019.04.12.01.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 01:31:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] media: platform: Add support for the Amlogic Meson G12A AO CEC Controller
Date:   Fri, 12 Apr 2019 10:30:57 +0200
Message-Id: <20190412083100.4070-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SoC embeds a second CEC controller with a totally
different design.

The two controller can work in the same time since the CEC line can
be set to two different pins on the two controllers.

This second CEC controller is documented as "AO-CEC-B", thus the
registers will be named "CECB_" to differentiate with the other
AO-CEC driver.

Unlike the other AO-CEC controller, this one takes the Oscillator
clock as input and embeds a dual-divider to provide a precise
32768Hz clock for communication. This is handled by registering
a clock in the driver.

Unlike the other AO-CEC controller, this controller supports setting
up to 15 logical addresses and supports the signal_free_time settings
in the transmit function.

Unfortunately, this controller does not support "monitor" mode.

This patchset :
- Update the bindings for this controller
- Add the controller driver
- Update the MAINTAINERS entry

Changes since v4:
- Rebased on top of [2] to use cec_notifier_parse_hdmi_phandle()
- Added Kconfig dependency on COMMON_CLK and OF, and selects REGMAP & REGMAP_MMIO

Changes since v3:
- Use the cec_notifier_find_hdmi_dev() introduced in [1]

Changes since v2:
- Really fixed compatible used in driver
- Collected bindings review tag

Changes since v1:
- Fixed typos in bindings
- Fixed compatible used in driver, using the bindings defined one
- Fix regmap return value handling
- Fix irq error handling
- Fixed wrong clk unprepare on oscin

[1] https://patchwork.linuxtv.org/patch/55513/
[2] https://patchwork.linuxtv.org/patch/55588/

Neil Armstrong (3):
  media: dt-bindings: media: meson-ao-cec: Add G12A AO-CEC-B Compatible
  media: platform: meson: Add Amlogic Meson G12A AO CEC Controller
    driver
  MAINTAINERS: Update AO CEC with ao-cec-g12a driver

 .../bindings/media/meson-ao-cec.txt           |  13 +-
 MAINTAINERS                                   |   1 +
 drivers/media/platform/Kconfig                |  16 +
 drivers/media/platform/meson/Makefile         |   1 +
 drivers/media/platform/meson/ao-cec-g12a.c    | 779 ++++++++++++++++++
 5 files changed, 807 insertions(+), 3 deletions(-)
 create mode 100644 drivers/media/platform/meson/ao-cec-g12a.c

-- 
2.21.0

