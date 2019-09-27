Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316BFC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3019217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yCIRZafe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfI0SoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:44:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50703 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfI0SoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:44:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id 5so7061124wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HzQhDkqVyohi8147rI3+BgZwRO47r6m1rOvI8gEcCVQ=;
        b=yCIRZafej34veAsB/dI9AI4AW98eG0+WviNpnhZzTwYErlctHeC4PdUDkvkDbOpjcS
         WY0FhlZfG0FijsdvbAFU7ML9GXDyMOYkrXSt4GBu2IO3bIwCw3V4ZXnZLYoJHFWlTtzY
         Xk5dQrZm+LA4pKZr+XNyfimVY9IVlbAEOw+T+oa8XwEBtFuvBKUvB6cjOEpQ7v57l8Kn
         lQjKqeuWo4sfcLlN824NR249X2A+YmcYnfKRXEjMIz4x/5SP11aCddGd9LKB0axSwqiJ
         oaTAGJ0MUxuIyfBrELTkVTQtMys/AZYWzlrh5jhamcx7k1y0Ujq3PMboLb2ZIOdPZZEm
         RrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HzQhDkqVyohi8147rI3+BgZwRO47r6m1rOvI8gEcCVQ=;
        b=sWnkEl+S+qN/+CifdNpH79xNivLhKFy5U5hMDndlO3ld3kPHKM14oXITJEzCnxBOXA
         Oeg1BoBlMJDu45xWIZQotYrMHHCtJxd4uMwMlOaPnClAUaHGD0dGVnoldQ5DHGet0hO8
         BIAZEpQLDpWSDu93433aunSJZYBrYLYp9uBCmKAEqBrFPDBnr3q2SglDOCXOMAz3/S+Q
         SQf33FXI97iSJ7sPbVf2K4wyWkAGxkNwtSRVX+sUd8VL1qhyIE1c4fLXMQK+CQE5xxS0
         w7V0GOA9DRTF6iG5LgfEwcmz2X/q88hlwDOYICpZe1oaD/5xbhhyA6Mj+N/YbNcB82+/
         RXWw==
X-Gm-Message-State: APjAAAVeHXje/F7J4zYMHv7TJFKT3e9cSlV/qB9ygcygcfSV4kg/wcXy
        kMpm5qEW0K2viRlu0nY89UZNdw==
X-Google-Smtp-Source: APXvYqxSi62wIlpGsvXmkF2vMjWdJJWKf6euaYF+PUGFCzIsIJHaJ4eRMDJRAoy+1xk8Rbwsy3vwnQ==
X-Received: by 2002:a1c:d183:: with SMTP id i125mr8708860wmg.1.1569609843906;
        Fri, 27 Sep 2019 11:44:03 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.home ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id r13sm6246272wrn.0.2019.09.27.11.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 11:44:03 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v6 7/7] MAINTAINERS: add entry for Amlogic Thermal driver
Date:   Fri, 27 Sep 2019 20:43:52 +0200
Message-Id: <20190927184352.28759-8-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927184352.28759-1-glaroque@baylibre.com>
References: <20190927184352.28759-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for Amlogic Thermal driver.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 390c3194ee93..bdc30d740342 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15932,6 +15932,15 @@ F:	Documentation/driver-api/thermal/cpu-cooling-api.rst
 F:	drivers/thermal/cpu_cooling.c
 F:	include/linux/cpu_cooling.h
 
+THERMAL DRIVER FOR AMLOGIC SOCS
+M:	Guillaume La Roque <glaroque@baylibre.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-amlogic@lists.infradead.org
+W:	http://linux-meson.com/
+S:	Supported
+F:	drivers/thermal/amlogic_thermal.c
+F:	Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+
 THINKPAD ACPI EXTRAS DRIVER
 M:	Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
 L:	ibm-acpi-devel@lists.sourceforge.net
-- 
2.17.1

