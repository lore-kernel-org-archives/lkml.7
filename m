Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA6C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A50E20863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EwmQPOlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfCCUG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:06:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43050 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfCCUGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:06:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so1406404pfh.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 12:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KSB3JHeBa6n+vw3GYJmSsvLwY8LGEiqlJWQgPjkufFE=;
        b=EwmQPOlPXEqa7vhBX6AocGEi40e1KoIAwEMxkE+MgNr8LwC6YL8GhZPlmYlD+m3BIp
         qL9xXTsY06EmTEBDCKwtl4OCu5OVPaJb9npvDt6rxEjQAeSXZvaT4HZNX1Gp6EB/x6Dx
         br5b3d3ld2GTH3bwxWuV8ZlSBWnLbJ9jHJwQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KSB3JHeBa6n+vw3GYJmSsvLwY8LGEiqlJWQgPjkufFE=;
        b=H1XnFyw28A0JzU00yCdvgt5bhFhYrnUGckeOS/ZrgbCygCq86+/30LRRUTnSxKoH7L
         u2Jvg9NUuYljo/YhWO27UEs4QKeIBSs9tGqiQi9JCji7h4kQUUpFf+SKt8ngNZa2zLQk
         kur3GKEaVcPNhHaxW/N7ntUcR4L8tgN9K5u1aLMDbVbv/Fdv404/E1LZSTlBkekJOSiF
         ziFi8/T01u2nCWK8Sitel+MKVb8D4BzNO2LzR9ASq97LExNuvVeXa9POEiQASfW6hIf+
         z8+XhD5wtbtrdfkenCQ38qoX99tXIFToYJElCOYce/t6CMjtiqYmLPnedTX7IOqDdzUe
         CjhA==
X-Gm-Message-State: APjAAAUSMO85i00Rxo8tIXGLXfUQ694UBVUQ4YQSsHBSO7X+zmRvr3RN
        mLQsGfBa2mDbJADuTxvcadT3Lg==
X-Google-Smtp-Source: APXvYqy1WcLiZbZFKmB8Ccf0KIpTX6YT81PTaSKsnH1Jh+/WvO2CxZUZvf7bIn+F3BJmCdMYja54/A==
X-Received: by 2002:a17:902:7798:: with SMTP id o24mr16760416pll.212.1551643614409;
        Sun, 03 Mar 2019 12:06:54 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id j14sm5654021pfn.77.2019.03.03.12.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 12:06:52 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com, devicetree@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/4] dt-bindings: Add vendor prefix for microtech
Date:   Mon,  4 Mar 2019 01:36:16 +0530
Message-Id: <20190303200618.17581-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190303200618.17581-1-jagan@amarulasolutions.com>
References: <20190303200618.17581-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for microtech, known as
Microtech Technology Company Limited. a known producer for
Liquid Crytal Display modules and Touch Panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 87d556472729..b84f27f077be 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -242,6 +242,7 @@ micrel	Micrel Inc.
 microchip	Microchip Technology Inc.
 microcrystal	Micro Crystal AG
 micron	Micron Technology Inc.
+microtech	Microtech Technology Company Limited
 mikroe		MikroElektronika d.o.o.
 minix	MINIX Technology Ltd.
 miramems	MiraMEMS Sensing Technology Co., Ltd.
-- 
2.18.0.321.gffc6fa0e3

