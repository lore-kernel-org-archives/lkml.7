Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6CCC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737EC2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oi7neAwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfI0MsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:48:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39156 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbfI0MsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:48:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so6027034wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 05:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HzQhDkqVyohi8147rI3+BgZwRO47r6m1rOvI8gEcCVQ=;
        b=oi7neAwW2LPL3XABbjq079ydlG5AqDgyurTggZMicVjKIV5UMxxiyLM+baxNYU7LMn
         KX0awqzp3ut3v6fG74urUYMNC7Us0TNh9cFPafo8aX6keUN84SNN8/13CiS2mOaNYVXW
         51GjVuPtTereISnJig7mP/IpoNpIQPIiC9dIHozWqZj8wKaFul+FMr0+2WVtMfP9Pit0
         iwshl1qVi1DzPPokQOFhT608amsRwajCmDibnhxZ2uNGfJGVClCLRHl2oTzSMrGuU6BL
         VMNsZeZHCwXRvn8wMc3M95Xc8gy4zBAopdQdfa29TD3KYqD7aefu+UKji02tx/K8JHiL
         3p0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HzQhDkqVyohi8147rI3+BgZwRO47r6m1rOvI8gEcCVQ=;
        b=jbmUAWOaNwdWLiRSa/6w1JHrdf86DxPAhkPg62rvdfKiQ41opVAsiXaWnSsjrKqQn0
         7cByTzuPveoHEzcZda0vKr6q46+H1XFes3DmM4alXzWw2e8YAu5maTgEYNOGwjpT3nGS
         YmkS0xGGSsNn+zwLQ/u9l1hWm0o4CZwKk8klpHBK5HPX6qbLt2Lb/OIXojTbUOZAHcUx
         FD5VQf4xODjN2pxpXfCADYYSN0qttFC5SAQZcXZrTOVD22Xa2iEDl7NeURLlEeUz7JJP
         bmP/S3zjTfNL1q8r53rLszJMxx+CizWfNHjUMHNiL20VUZnboxkxUYQ3Io3j5iF1rmfC
         oJLw==
X-Gm-Message-State: APjAAAVhA64KsqiCSySMicEFOTuX9Lalr8Ik/ZNN88UXgEbVZJJq5/0q
        0PlUkeULX379ncbM3/reP+M2XA==
X-Google-Smtp-Source: APXvYqy/1/MJyl2yq0JNJ1lJAbS7sXpETew3r6arHgnR/Bo+YJC+IXAdeOl3m8wFVO8i1kW5vfviIg==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr7418209wmb.93.1569588481463;
        Fri, 27 Sep 2019 05:48:01 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h9sm2985564wrv.30.2019.09.27.05.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 05:48:00 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v5 7/7] MAINTAINERS: add entry for Amlogic Thermal driver
Date:   Fri, 27 Sep 2019 14:47:50 +0200
Message-Id: <20190927124750.12467-10-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927124750.12467-1-glaroque@baylibre.com>
References: <20190927124750.12467-1-glaroque@baylibre.com>
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

