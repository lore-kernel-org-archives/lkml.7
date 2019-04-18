Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A21C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808BF2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Kwi7D6/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388405AbfDRMsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:48:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42135 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRMsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:48:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so2817734wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zCoFO+U6J6V4upBBcgRbShJ9mBRp671ZMCkEN4roMmc=;
        b=Kwi7D6/7UCuK21K17QZqCdwlWSBCXkwz6XCwmCXGiRakEUBWbpffLd5GIPa8TOTnZe
         HJPjRXeizM+cNiyc9YSx3MH5G+uDrNhLsl1yyn782+uLQuPBx9YDYXmpkqrxT0b5/H+A
         qOhI08DFFa9e0FKEyG4jcGCXR/QGfHbhzyiFUJmVB6slQFapECurO3ytG8xtP5Jrr1Gc
         awb672/ItMblTTvml5CpIIx/pzWbMv1gaaSHbku85/uHSC4etip6hPW55RfxgkDBxlZ7
         edvkyz5woRH5rm4ybvQz8SPGT0LNFwJZr+viCZQBe8RFeKIggWClUhzssEmwRpCzzDu9
         CgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zCoFO+U6J6V4upBBcgRbShJ9mBRp671ZMCkEN4roMmc=;
        b=SfPU0cju/O1ecCU0DSJ8S9xWSZVQAJ2mweKjQF5D+b0q67b8lcKcZNpTNbvBLGw7jk
         lEKPqiIdMVQMM9ha25VHAhJ/1leBFyY81eSbr/qmLiOnrHaDc4HOk1oCPSxb2fIf1dcZ
         7tGIk3UQ5mAWHX0wTH60+xiHXBhEJEo0YnRgXZBk/8rLBIWeegWIdZLH7ksneDhvVN0f
         wU0cUIT0Ti+UlMyDObxM87jF+8vWgiag80Ryk4y+CXSLnlqIUFTC9BOMzRnoc9OWwAfl
         jCpAK1prZG6GxzjethavTNmFB5QI/1pSpEb8erN2k8VjEm2eRfS2zpmXP2QgpW67DLJo
         H6hg==
X-Gm-Message-State: APjAAAU033PLoSARKLZ6zxxX5/jXQVh/jC+OEpArRgZEXETlvCDUShmJ
        aJnPxzHVnQcnSGgBDACjvteliQ==
X-Google-Smtp-Source: APXvYqyBP9KpAvFTbFL4x8mrUe5kZzQ7GbeQs9drJWsz2j2Ip14m6nem990Rc1mGTMLzIzntsc8QdQ==
X-Received: by 2002:adf:e703:: with SMTP id c3mr7659644wrm.98.1555591680673;
        Thu, 18 Apr 2019 05:48:00 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q17sm1256823wrw.70.2019.04.18.05.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 05:47:59 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4]  Add drive-strength in Meson pinctrl driver
Date:   Thu, 18 Apr 2019 14:47:54 +0200
Message-Id: <20190418124758.24022-1-glaroque@baylibre.com>
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
So this patch add another generic property "drive-strength-uA". The change to do so
would be minimal and could be benefit to other platforms later on.

Cheers
Guillaume

Changes since v1:
- fix missing break
- implement new pinctrl generic property "drive-strength-uA"

[1] https://lkml.kernel.org/r/20190314163725.7918-1-jbrunet@baylibre.com

Guillaume La Roque (4):
  dt-bindings: pinctrl: add a 'drive-strength-uA' property
  pinctrl: generic: add new 'drive-strength-uA' property support
  dt-bindings: pinctrl: meson: Add drive-strength-uA property
  pinctrl: meson: add support of drive-strength-uA

 .../bindings/pinctrl/meson,pinctrl.txt        |   3 +
 .../bindings/pinctrl/pinctrl-bindings.txt     |   3 +
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    |  36 ++--
 drivers/pinctrl/meson/pinctrl-meson.c         | 166 ++++++++++++++----
 drivers/pinctrl/meson/pinctrl-meson.h         |  20 ++-
 drivers/pinctrl/pinconf-generic.c             |   2 +
 include/linux/pinctrl/pinconf-generic.h       |   3 +
 7 files changed, 174 insertions(+), 59 deletions(-)

-- 
2.17.1

