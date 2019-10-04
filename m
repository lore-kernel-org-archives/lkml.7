Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939BCC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF3321D71
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Uuvu/VJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbfJDJBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:01:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41642 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388128AbfJDJB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:01:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id q9so6124315wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 02:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HzQhDkqVyohi8147rI3+BgZwRO47r6m1rOvI8gEcCVQ=;
        b=Uuvu/VJSglYBjP4TqRtcqrbm88Z5R11mtl+miilq6RbbTApcuegQZtgcVbF3Z2l4xF
         fYOcVF57nVCXu11oNaPCMWpEB1Rzmx1qNlpeiMvvJ7Cm6fPMQ7qMKOwTbMF4qovVwWd+
         ZKdUW6DTje6WFZcUrBHlgODVyo/NIbyeABF/9oi8kzzB1DKbbNqbtzus/zj+6dZU2GAi
         5F/A6OQ15K8yih3MHAAFv2Pynsq3zqIk1KH4njoip/9rP5By7m7OUNjWXKMAtggu78Gi
         88rtqaVawgFfgePpOrUFfIM7psIQDOzBoVKfFg1nx93JDAEPRFboi+8lYlUDbZO/b0at
         NfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HzQhDkqVyohi8147rI3+BgZwRO47r6m1rOvI8gEcCVQ=;
        b=BemerPXodYJfrVRhl66ThTZFFTXOtXhWLpIjSUVA/viuzOuZh7XrzAbObwGOXqRQpk
         hsQJKnEypRzimbJW+deP1WVhwst6tWJN3fSqr9+pPOTvrzY5JIXrR7L6g/BIFbRVYR0P
         8pavIvhAlEnV2zpWl8eAnrFhUr0mI2gngJOEjNT5EAnLsVUdItQzX23d2P68KNX0BWNB
         +ptDNcPKdAGOlUHyQVIt/QIY3N2ygy0DmwZHwG40E6KFMMEo3XjC6K2bjN/7IqmBCopz
         xb2bayZ583iYutU4/mKEMy6Sr020w7jsx+Vptesp+RKpqIAyX5Pp+BBP/Nh4VtRI1ijP
         /y0g==
X-Gm-Message-State: APjAAAVdd6E2/0PMViDvQ6rqBHsliHXhIfVBMYe+ErHRJnECuv5KcF45
        9CF/pzPP39lKdnn1/W4scV+/nA==
X-Google-Smtp-Source: APXvYqzeMc3UmkSHx6AOi3+gnVZS5BJKpJ4oVQO5L4qeV7tfoJzaVdQ0uB2B6KtLlKTAR1/xlZ4wKA==
X-Received: by 2002:a5d:4f8a:: with SMTP id d10mr11319014wru.276.1570179685339;
        Fri, 04 Oct 2019 02:01:25 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v8sm7765170wra.79.2019.10.04.02.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 02:01:24 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v7 7/7] MAINTAINERS: add entry for Amlogic Thermal driver
Date:   Fri,  4 Oct 2019 11:01:14 +0200
Message-Id: <20191004090114.30694-8-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004090114.30694-1-glaroque@baylibre.com>
References: <20191004090114.30694-1-glaroque@baylibre.com>
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

