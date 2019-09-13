Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56402C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F232084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFCxCyjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404298AbfIMXWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 19:22:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45360 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404277AbfIMXWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 19:22:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id x3so13881012plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 16:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z1Pess6DXDrIJ6QuvI+LdyiByRaqVj94CLs3+lzmJ5o=;
        b=TFCxCyjouz2ihZhBiLFll1twWmE7Hr8+hOqgMO0pfxkO2WSbDS8tFGjkzE1V2QZEZP
         9ociCuHLAZ+sdirE601FSRAf/i+kUZNoANIBf4vNhmFSSaHlsiim1WY0/WGuwHD/Au+C
         UXeyyF7TWownmPc3ZUlR6mDiGXEd7BeXu0hoZ0jnhz/ekzo9uMs5v/AeWu1Lfba+rz7w
         PdBDi19C+lRHrOYQSkpeaL7iEHFvvsApGudESAAdZGPqVe39dH4Z/tUh8vUtuNDLnQmC
         wHo+KqBUY/3CRDy8ZiPYtN5GL4N6vpTcFMGAD8dJLbKWcyA71rD7s1cBeyEJcl6SmJVY
         iQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z1Pess6DXDrIJ6QuvI+LdyiByRaqVj94CLs3+lzmJ5o=;
        b=eSG7kRg/bjb50DapjIAGevS7mbpmIgh3Fy0Aw6FQY8QOo8x8UH2bIZ3V6uOYa+NTla
         U5Jw8roUN/7axvaNxvbbNcgp3mi/TJ4Ej84pkkZrDf0kkLwd7Uel31L5B48XmDQsCpnx
         mq7MBkojG+W1aDQfKJhUCBo+9GlIjWG0WFuqNjWWKPFYIqwgdIqvRl1jrmeixDbH5aex
         q2DpOeluIoQ5fElamaNP1vD9MFs9Cv2FYw5JQHO2PiFiR2MznMm72TbXuvdYklD1Sg/e
         oiwDY0/pawuohuChZ7z52l3c150xAvxeo/DPZdSeosQxs9wRIL9gCcSsRy5W4Ki0o8+S
         dogA==
X-Gm-Message-State: APjAAAVc4sQRVv1cIb6TtaZQ6KF4dyA6MWM4Fp527ZP70cPUVHXfbtJS
        nq+XivVrF0I4GmF720zSL3TFmV1ZYdg=
X-Google-Smtp-Source: APXvYqzzG+NxPezvh/Wi9z4P3y4if99zz+hHKlk7wX2DP1anzRTJgeDF7qX/Gzg0qrP3uzGt1umAEw==
X-Received: by 2002:a17:902:7685:: with SMTP id m5mr52342845pll.218.1568416968796;
        Fri, 13 Sep 2019 16:22:48 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 196sm38397564pfz.99.2019.09.13.16.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 16:22:48 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 4/7] dt-bindings: interrupt-controller: Add brcm,bcm7211-l1-intc binding
Date:   Fri, 13 Sep 2019 16:22:33 -0700
Message-Id: <20190913232236.10200-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190913232236.10200-1-f.fainelli@gmail.com>
References: <20190913232236.10200-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM7211 uses a very similar root interrupt controller than what exists on
BCM2836, define a specific compatible string to key off specific
behavior.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt
index 8ced1696c325..13bef028d6ad 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt
@@ -7,7 +7,9 @@ controller.
 
 Required properties:
 
-- compatible:	 	Should be "brcm,bcm2836-l1-intc"
+- compatible:	 	Should be one of
+			"brcm,bcm2836-l1-intc"
+			"brcm,bcm7211-l1-intc"
 - reg:			Specifies base physical address and size of the
 			  registers
 - interrupt-controller:	Identifies the node as an interrupt controller
-- 
2.17.1

