Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69CDC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872DC214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1XsB9wyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbfHFNFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:05:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37742 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfHFNFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:05:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so62762852wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=60yWYtJLk0Xp9SLelz+MaI60GmV6Utt18fBkUyG2qxM=;
        b=1XsB9wyPJKfVdt0XFULvvBF/+L4sPvBzqlPsQ3/7818JIn78HG6OJumFYaHF72EZiQ
         3r+tbI6kf2XmvaBnMq6a9/lZ/5papd0jJyFpoUtVL53nadn8VtpgPDafseSrDIuOt+UT
         /EOZC41Tt9sDGPOxzi32bafjR1WXbVk/3gWg/V9UJ5Fpw2N7m9BdV4BU7JOCUi66GVAM
         vOKee9IcLeW4v9gjgMpfseHvCaSfgaOf7oL/xhk/+EpuMxjYaBdClEpCYIIj567dUUTK
         4YsjCLeXbhoLlybPpGffo8skD2wRjyHpahZ2KL35fD/n7RtMFVdx4ePceqC4B4/n3Ofy
         U67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=60yWYtJLk0Xp9SLelz+MaI60GmV6Utt18fBkUyG2qxM=;
        b=LiY2m68e1RjVflaiEgTzkAM7OJIHtW3CbGyGih8xdf9kgMX8JIqVVKqyB2j7/00SSA
         toQ6wTVYqapLa2njvwU51YcbSkyUPttFAJ1N1jsdkcmGcqjSFmo11zBGgPPAPwGny3pJ
         O6UnKeS/Qo9mxVjb3N0nOA11Y6sVuY0AmvPxkjYjMm7AccUHXfkI8/uRe6kwgkUcQELK
         43uXlFKVbpEXoZvnm6bg5KCw//CKqw9ltfDAtLCcVD7dKZhkYKeiQiaT/vn32rdohPp4
         RBzQmFWHEjnTwBRKo/3bDAGqS46hQb+1c5Hab2tNU5AV/qPie7LbJhaQxPzSSU2Akzhs
         rxrQ==
X-Gm-Message-State: APjAAAXVf9c79y0NyROC6Ke2lzJj/KrI0vAjHDg2DCQindQIZ7G1MfaZ
        T0EC+ATbD2R0ZiBRHLi2t6lC7Q==
X-Google-Smtp-Source: APXvYqxe8+FVvkyz0LH3/p+5jXQjRtCu1JfWNK+8gB5Jwg7o9KmjpX18AjkaFMctc3YE7l8bagEx+Q==
X-Received: by 2002:adf:dcc6:: with SMTP id x6mr4927209wrm.322.1565096716745;
        Tue, 06 Aug 2019 06:05:16 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j33sm201888738wre.42.2019.08.06.06.05.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 06:05:16 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 6/6] MAINTAINERS: add entry for Amlogic Thermal driver
Date:   Tue,  6 Aug 2019 15:05:06 +0200
Message-Id: <20190806130506.8753-7-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806130506.8753-1-glaroque@baylibre.com>
References: <20190806130506.8753-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for Amlogic Thermal driver.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb2b12f75c37..299f27d11058 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15910,6 +15910,15 @@ F:	Documentation/driver-api/thermal/cpu-cooling-api.rst
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

