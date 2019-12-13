Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5F5C3498A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B91C24754
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fAowkLwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfLMNaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:30:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37365 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfLMNaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:30:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so6677610wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 05:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RihAxbyPf1sWOBRmJF5IKCF0zpUINaJgm3m7kfkEZZY=;
        b=fAowkLwbvcaMDwhICxvEuVnjEW+/HgTUaD7s4A/Xn36fZT0rVKZ4y7m1k0IE2WY4yG
         HpLmm5baYQ5QfDQDu1l10QecPEfxHOTfdJPIpLnZ51SFJQ4h0v/1XCERjTz+Lewf5W0S
         RoqxDd5K94lovPJJYQIzqqsWkO4Qd8QDymklzOooZuJrb9LpQFXyXk5+KLfphgJeKNY/
         rmGC7TI6Wv2mdHg7NC3Q0x6uxP4dOZEwaNz7COjP6srZrTQrT36UqZt2d1GSZdsWDte9
         eJDuz/WkglAvJY9CbMC40XjUUkcqgFwuOeInr59Xp2kvFvbrbOsB5eGqYlqUMV+MDr2Z
         HD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RihAxbyPf1sWOBRmJF5IKCF0zpUINaJgm3m7kfkEZZY=;
        b=b29Mil1fcXZ+k3pzC4YfeOXwSCOaJX7iCqhfX/PqqWbMIHsnS2d0GPMgse+sguHddG
         BKBTKSu0yLBCFocLVow95RO2G9nwtAqTfvI2U+ntIbT8OWvdrJPnZlZVcZ+ZxzUooCPo
         MKoSorKy1xQ3Lbtisst2TPiEjpawsLjGxhSVF9wU3/pzH5EG3dMxnxA9XUV8GhTwsr2h
         bKPVQE6Pa+NUJ2/D7dGWXxsFT/jUdRFtmsg8qQ7S9dXLT5IgTNO9Ptksho4ifKnKO9+y
         K65FIB2XqNGdnl+E6AO9WWkhZi5V8iNnVSxGMy1D3ZDM25+yk+AYGKbdHnBxpIvVcgSp
         LxIA==
X-Gm-Message-State: APjAAAXKHGhfsMEFLcVBhNDfkmVC2Q/PINaS4Nzm+1Maty+sHH/012q3
        zIBjDPeQLRYAx53WRhxRPv2vzA==
X-Google-Smtp-Source: APXvYqwNnx7cmRRsx41+o7uRC5/UJmd0OtDKCdpnC8FmFH+IVjL9ZtYfSJJwPHF91ntNAr9l0PWr/w==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr12978031wrm.284.1576243800998;
        Fri, 13 Dec 2019 05:30:00 -0800 (PST)
Received: from localhost.localdomain ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id n3sm10540543wmc.27.2019.12.13.05.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 05:30:00 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     narmstrong@baylibre.com, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, khilman@baylibre.com,
        devicetree@vger.kernel.org
Cc:     linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: meson-g12g12: add syscon phandle in cec node
Date:   Fri, 13 Dec 2019 14:29:55 +0100
Message-Id: <20191213132956.11074-3-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213132956.11074-1-glaroque@baylibre.com>
References: <20191213132956.11074-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add syscon phandle in cec node to activate wakeup support

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 7fabc8d9654a..98c6a1d1d035 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -1899,6 +1899,7 @@
 				interrupts = <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&clkc_AO CLKID_AO_CTS_OSCIN>;
 				clock-names = "oscin";
+				amlogic,ao-sysctrl = <&rti>;
 				status = "disabled";
 			};
 
-- 
2.17.1

