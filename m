Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6653BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9BA20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FaQFMj/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfDHJYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:24:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38532 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfDHJYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:24:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so15470840wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5Uny1FpPc/winyYxn8pHKsj17b/jtLMie4lrrPoSm4=;
        b=FaQFMj/oNV6wcMNBV8gzYSbmSIDfc7ZSOVPJlRQMQUDnm1UpZjA+VbtD1nqlfzKDrV
         Q/3fh92G3raq+ISSPEXWzqwrwLAcfHpQmbb10hOK7NORa6tbUloJrRqzrHL60FQu8Ent
         7c1nAPUP5GBmflS6AMbi+tpCLH7QcVSilReOS8A8aNw6SzNccjEUoXfgdjqHQVScnkV3
         agIx1P5K2GU+OAo9hvqMPJ8764kRKOJhKJXfZKg+eHoSvPJ2Pr4nJfc/ZmbXgAQGWj9T
         +U518baxQz6oKUijkR21cSrYbVweRifzvc2P3opQUpUcQqQiD1jz+4AmlEaGx4/L0cT+
         pTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5Uny1FpPc/winyYxn8pHKsj17b/jtLMie4lrrPoSm4=;
        b=SQjzZWU9AtRFm3bjIS0JBzS35sbTlEXoC9GBRduuQ74Xx1QxQGqEpIFpnlv4Fm3aDj
         ejV1hS1mTwfHNavk0CIrWlLeIdqeDsSta3Rk22vkBwaEqM01jG5AcG0/ME0UHhka2N13
         qq/pqIJJ/eVOqio/L+9bfRWV1uDUk7euT+kDQ73VCvXs/FSPpZ1Qyn2DRqyqkK1BcnyQ
         VgnNATRPsY6i2uLfE/BuRyQP1kpRNQT3xy2LuGCalv1rG2jEiv8E/hjGpt3Bp4G1pfRW
         lNxq+jQFZPYyVC02Z+ItUB0Ea0F2vvgGdqYB9d/jfGmViqNdVAwi6DhHPI0OdznjmYrb
         CB5g==
X-Gm-Message-State: APjAAAXPsnXfgC7GdwRPWG0UjrKA6LbaiWsbxkKmsXkR0XH2GFDrBePl
        dnULvmNO89HfVV14i1tC9fttbg==
X-Google-Smtp-Source: APXvYqyvxOgBmrGCs9EGNc2CTiXm97QS5dwHHBvroH9tiDHtGi1VGk2O7U79DZdP28qc3B14j1LeUw==
X-Received: by 2002:adf:fecb:: with SMTP id q11mr772730wrs.252.1554715443187;
        Mon, 08 Apr 2019 02:24:03 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j3sm70528221wre.51.2019.04.08.02.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 02:24:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] media: platform: Add support for the Amlogic Meson G12A AO CEC Controller
Date:   Mon,  8 Apr 2019 11:23:55 +0200
Message-Id: <20190408092358.25894-1-narmstrong@baylibre.com>
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

Changes since v2:
- Really fixed compatible used in driver
- Collected bindings review tag

Changes since v1:
- Fixed typos in bindings
- Fixed compatible used in driver, using the bindings defined one
- Fix regmap return value handling
- Fix irq error handling
- Fixed wrong clk unprepare on oscin

Neil Armstrong (3):
  media: dt-bindings: media: meson-ao-cec: Add G12A AO-CEC-B Compatible
  media: platform: meson: Add Amlogic Meson G12A AO CEC Controller
    driver
  MAINTAINERS: Update AO CEC with ao-cec-g12a driver

 .../bindings/media/meson-ao-cec.txt           |  13 +-
 MAINTAINERS                                   |   1 +
 drivers/media/platform/Kconfig                |  13 +
 drivers/media/platform/meson/Makefile         |   1 +
 drivers/media/platform/meson/ao-cec-g12a.c    | 788 ++++++++++++++++++
 5 files changed, 813 insertions(+), 3 deletions(-)
 create mode 100644 drivers/media/platform/meson/ao-cec-g12a.c

-- 
2.21.0

