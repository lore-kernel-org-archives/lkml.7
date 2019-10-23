Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3EECA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D223520650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p3MKCf8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404644AbfJWLGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:06:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43002 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390486AbfJWLGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:06:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id c16so6181681plz.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 04:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qPpOdZIAHDcQDrpBHTEE+DHd+oPdwYCkPle0TB+oIr0=;
        b=p3MKCf8wTny1eS9+WPg6KOdbGDAsoT4+mmQ/bB4oIdKy1EGN/uexUzv2N6TBs8n0EY
         m7hssrUIb+/WSqvEqhdbUhZeUJUlI8wmbxI1D4tYuGKWlavl2peaFC1guqcEhtvTFZOE
         ccBz0AU/19tolt7kAyLX5NTSYSzXqMKzQZg7id7A1B3YVpS8wqZglTvTfMvHs7zBkVl3
         5OyjG5TJIC33F5tRek+T9wO8yS/zOWHMCz1mBHnlfcrYMg7l0fJWQ6Ds8smtZyrS1RW5
         U9Nw9FxVBivygrSN2t2x8CMo1pFKPpxLXZiXO1y3mib6P3EBO1/76FfNkkpwya/yyH5t
         UCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qPpOdZIAHDcQDrpBHTEE+DHd+oPdwYCkPle0TB+oIr0=;
        b=nMjnyIOXLoVOqZhV5XrMqqOlwub9V9PAASg0Ct/ZQFXpDABIhTuik/fakoHBR+Z0NE
         hzcudfWamslPycPBtLaoLuFeHU/2vfXd2YvWOk5u2luWkSApPAn0r7OQyDqzcCMH+PVW
         RV7LSV9BBqQdClhqkEfQEWtiljh+Q5inJPAipvBNbN4XRY9Ea+5BQtltdIKEFluS2kN2
         /egniRnTB5WdbZAbQq4UXRP9PB1QpUJCwhe+XvXSm96qVNAMHOKQ/8QX+nTJ6rtsx/0h
         s/iDy6hVOCaxZINzTw7ASUE4Fc9phfsVr5pagZJewSw44VI3CReMh5U74CWmMi/kr/SQ
         DltA==
X-Gm-Message-State: APjAAAUysMVWbbZrfPMHCR3ei8F0E2QG3NiKNebfFvsOjokzjwZoWn0Z
        idPmu6MaLrl8NIy8NpuiaxF7Jw==
X-Google-Smtp-Source: APXvYqwfrOgnuHFr7yKLUeel5YnP71QVIOnjIksynYQ+9B7+FuzJo2MjfhTvfAHVg7D8MpdMVYNLXw==
X-Received: by 2002:a17:902:6ac8:: with SMTP id i8mr8498933plt.164.1571828773442;
        Wed, 23 Oct 2019 04:06:13 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y138sm23388684pfb.174.2019.10.23.04.06.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 04:06:12 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     arnd@arndb.de
Cc:     olof@lixom.net, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, orsonzhai@gmail.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update the Spreadtrum SoC maintainer
Date:   Wed, 23 Oct 2019 19:05:27 +0800
Message-Id: <2e3d8287d05ce2d642c0445fbef6f1960124c557.1571828539.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change my email address, and add more Spreadtrum PMIC drivers
to maintain.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 MAINTAINERS |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55199ef..7e6fdcf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2327,10 +2327,19 @@ F:	drivers/edac/altera_edac.
 
 ARM/SPREADTRUM SoC SUPPORT
 M:	Orson Zhai <orsonzhai@gmail.com>
-M:	Baolin Wang <baolin.wang@linaro.org>
+M:	Baolin Wang <baolin.wang7@gmail.com>
 M:	Chunyan Zhang <zhang.lyra@gmail.com>
 S:	Maintained
 F:	arch/arm64/boot/dts/sprd
+F:	drivers/power/reset/sc27xx-poweroff.c
+F:	drivers/leds/leds-sc27xx-bltc.c
+F:	drivers/input/misc/sc27xx-vibra.c
+F:	drivers/power/supply/sc27xx_fuel_gauge.c
+F:	drivers/power/supply/sc2731_charger.c
+F:	drivers/rtc/rtc-sc27xx.c
+F:	drivers/regulator/sc2731-regulator.c
+F:	drivers/nvmem/sc27xx-efuse.c
+F:	drivers/iio/adc/sc27xx_adc.c
 N:	sprd
 
 ARM/STI ARCHITECTURE
-- 
1.7.9.5

