Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C6EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FB72084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TYWmbyIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbfDAIUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:20:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36211 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731774AbfDAIUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:20:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so10233241wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 01:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rEg3FUE78pv51fRzdo9AOI1NgLqP/dc+g1COkhcT4wU=;
        b=TYWmbyIZi+MZUrihq9REeBWs3zAwmeZkWmcF95pUtVGlJvVYMrM30ptbFUy7Lbf2Yn
         GiFTO0SwZpPAS7mxwl6rptKVTrTPr68fj1JFyIH2r/6MziRwObhIrhvlTm2uQeZuBvO6
         EA5eS4oeQwKOYI5z0TYO2ebCbzkB1NP9VnVuS/uipYq6LUNQz/AXM8vy6EzF7Mw666JK
         to/Hp8aefDnTJ/rkh8tOZLiZjvaHBV/MJWpEJ0GOjZe+A/zmzKtszn671dih+OUm9XTb
         uS1znov/jtg+NMubMC0vjNUs9iDdKRv7xvMPWD3EpYlghck8V2f/8cjdc2Z7xhg8syug
         7IqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rEg3FUE78pv51fRzdo9AOI1NgLqP/dc+g1COkhcT4wU=;
        b=F/luZ3HqJkn4iPJQJVsz212wyaz9r+xTmUWBbQawjO51+r6D1N6HGfwlj8O/ro4K4a
         hpGgw2lESA9Cp8usjOb0HQnpI3aJ9wQXMVxVCtw85qtkhymoUd9rAiI5YJ10UMv6m3B4
         lphng8zneGh/b5+lzV+IraQ+7/d4xhTRhUD7VjCXxGb9VmV3073yn3WReqPvZL5KdBY7
         UaUkMwgupR7PBt+BAhlC2Oic7++Qm+HTVuJ3TfW8tral+n/mV/N2eDkxVN+lzGDsFdHS
         JvycPeSqRSci2qUg8/VNJpYaa7lLjHDGvCafcOcWMqG80eXUrSNGPvYrHrNvl4HiCLsc
         pGrQ==
X-Gm-Message-State: APjAAAXUISseOEgD7VTswQLiiTwecFGQbZmDOPyOJM/0YnteTfC7h8H1
        ahzXxVL/ARvYzQkl1+4DiCKa/A==
X-Google-Smtp-Source: APXvYqxkLbBHJz4aZZ0hB9WF1VFFL4/zSQWx3FvY8SipCuhxVAGxXg6xedviDZAljU4qfFU2GHVv2g==
X-Received: by 2002:a1c:f618:: with SMTP id w24mr11630071wmc.3.1554106801798;
        Mon, 01 Apr 2019 01:20:01 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id r196sm10053534wmf.22.2019.04.01.01.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Apr 2019 01:20:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] media: platform: Add support for the Amlogic Meson G12A AO CEC Controller
Date:   Mon,  1 Apr 2019 10:19:56 +0200
Message-Id: <20190401081959.16474-1-narmstrong@baylibre.com>
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

