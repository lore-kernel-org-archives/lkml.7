Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6B5C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129962184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWec3DHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfHZUp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:45:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43010 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731684AbfHZUpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:45:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id y8so16573637wrn.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iM5BJyr4mn2hoXsP74QtrPoZacw8VcD7wJN6v4Wcvr4=;
        b=rWec3DHjN+OMnET4cKmo5FTJ6PFPh0M+ViJ5jsHArDp2zJwNheWC7MfsSfeZTTYG1O
         5SW1JyjSC9PBd9qZWv6F8J886PzxO+t2xf9zRMNLybWHuAqu7SMm25HWvPVxbaCfuN7j
         mhlWUrDtsqDVWoBx734i8qMKJdwQqSUMIwhlpuL5QKbLTnbQsB2iPESMmcgumx0Zwp5c
         B0/osc7Lr80E3LBy8Ku57OQ3pvp3ZDrXGfTcUxG7H4lCfBFYN9HpArY0uO9rFV0jT7tc
         uhrPKQ6BjAV1OnlYzfoGAGNbGjpaKtMcdL0xRac+Ik8b8MiX9cZAi0arykL6wgFEWNi7
         JIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iM5BJyr4mn2hoXsP74QtrPoZacw8VcD7wJN6v4Wcvr4=;
        b=TOCf98jnlNYZq2qnCOgTp0/zAMU/sAKI8wK36sL2euXmgpcSBsLw5rXawgenabhqAv
         zcNyKw+XVCsxXH8t/OMnZHScT8ebrn84mort7rh68LWjcDEfpnIvIobYKF/gjEL1sHXy
         z4OuqvV8GEYdTg87ckkyp1Y/hDZ+ozJ0yy5GV+Q1dHRVAdCS+HCcuh1fzO/Lnvvx84ul
         s1lV/XZvmnoEfOFWI1YDZAOF5LMSZLYxoGvzDOlAhWxK6E0xV34anZsLzNuDqPwXLKJH
         v7mruyDiyLkR8Q5Ptnxs+EIDoLmievsDIdY3Q5In922BLAMHtAc7oYJ6Q+gJ4Hmg0YcP
         bvcA==
X-Gm-Message-State: APjAAAX0bliLXt9BIuKE/Djwj6PpsaWAK6c2g0SbkEcM6BsWDWp1k15A
        9HGhqNPePXntlz0RXDhXGk/Kog==
X-Google-Smtp-Source: APXvYqzqpAyh6/5oZsDxwFDgw82glVJZuhRDdnSFLkFXhoRGNRE+RlWF3V1e0nGQQwigwBilGha1Fw==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr25391450wrm.295.1566852320844;
        Mon, 26 Aug 2019 13:45:20 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:45:19 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Magnus Damm <damm+renesas@opensource.se>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 18/20] dt-bindings: timer: renesas, cmt: Update R-Car Gen3 CMT1 usage
Date:   Mon, 26 Aug 2019 22:44:05 +0200
Message-Id: <20190826204407.17759-18-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

The R-Car Gen3 SoCs so far come with a total for 4 on-chip CMT devices:
 - CMT0
 - CMT1
 - CMT2
 - CMT3

CMT0 includes two rather basic 32-bit timer channels. The rest of the on-chip
CMT devices support 48-bit counters and have 8 channels each.

Based on the data sheet information "CMT2/3 are exactly same as CMT1"
it seems that CMT2 and CMT3 now use the CMT1 compat string in the DTSI.

Clarify this in the DT binding documentation by describing R-Car Gen3 and
RZ/G2 CMT1 as "48-bit CMT devices".

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/timer/renesas,cmt.txt | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index c7fdcb02e083..a444cfc5852a 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -28,9 +28,9 @@ Required Properties:
     - "renesas,r8a77470-cmt0" for the 32-bit CMT0 device included in r8a77470.
     - "renesas,r8a77470-cmt1" for the 48-bit CMT1 device included in r8a77470.
     - "renesas,r8a774a1-cmt0" for the 32-bit CMT0 device included in r8a774a1.
-    - "renesas,r8a774a1-cmt1" for the 48-bit CMT1 device included in r8a774a1.
+    - "renesas,r8a774a1-cmt1" for the 48-bit CMT devices included in r8a774a1.
     - "renesas,r8a774c0-cmt0" for the 32-bit CMT0 device included in r8a774c0.
-    - "renesas,r8a774c0-cmt1" for the 48-bit CMT1 device included in r8a774c0.
+    - "renesas,r8a774c0-cmt1" for the 48-bit CMT devices included in r8a774c0.
     - "renesas,r8a7790-cmt0" for the 32-bit CMT0 device included in r8a7790.
     - "renesas,r8a7790-cmt1" for the 48-bit CMT1 device included in r8a7790.
     - "renesas,r8a7791-cmt0" for the 32-bit CMT0 device included in r8a7791.
@@ -42,19 +42,19 @@ Required Properties:
     - "renesas,r8a7794-cmt0" for the 32-bit CMT0 device included in r8a7794.
     - "renesas,r8a7794-cmt1" for the 48-bit CMT1 device included in r8a7794.
     - "renesas,r8a7795-cmt0" for the 32-bit CMT0 device included in r8a7795.
-    - "renesas,r8a7795-cmt1" for the 48-bit CMT1 device included in r8a7795.
+    - "renesas,r8a7795-cmt1" for the 48-bit CMT devices included in r8a7795.
     - "renesas,r8a7796-cmt0" for the 32-bit CMT0 device included in r8a7796.
-    - "renesas,r8a7796-cmt1" for the 48-bit CMT1 device included in r8a7796.
+    - "renesas,r8a7796-cmt1" for the 48-bit CMT devices included in r8a7796.
     - "renesas,r8a77965-cmt0" for the 32-bit CMT0 device included in r8a77965.
-    - "renesas,r8a77965-cmt1" for the 48-bit CMT1 device included in r8a77965.
+    - "renesas,r8a77965-cmt1" for the 48-bit CMT devices included in r8a77965.
     - "renesas,r8a77970-cmt0" for the 32-bit CMT0 device included in r8a77970.
-    - "renesas,r8a77970-cmt1" for the 48-bit CMT1 device included in r8a77970.
+    - "renesas,r8a77970-cmt1" for the 48-bit CMT devices included in r8a77970.
     - "renesas,r8a77980-cmt0" for the 32-bit CMT0 device included in r8a77980.
-    - "renesas,r8a77980-cmt1" for the 48-bit CMT1 device included in r8a77980.
+    - "renesas,r8a77980-cmt1" for the 48-bit CMT devices included in r8a77980.
     - "renesas,r8a77990-cmt0" for the 32-bit CMT0 device included in r8a77990.
-    - "renesas,r8a77990-cmt1" for the 48-bit CMT1 device included in r8a77990.
+    - "renesas,r8a77990-cmt1" for the 48-bit CMT devices included in r8a77990.
     - "renesas,r8a77995-cmt0" for the 32-bit CMT0 device included in r8a77995.
-    - "renesas,r8a77995-cmt1" for the 48-bit CMT1 device included in r8a77995.
+    - "renesas,r8a77995-cmt1" for the 48-bit CMT devices included in r8a77995.
     - "renesas,sh73a0-cmt0" for the 32-bit CMT0 device included in sh73a0.
     - "renesas,sh73a0-cmt1" for the 48-bit CMT1 device included in sh73a0.
     - "renesas,sh73a0-cmt2" for the 32-bit CMT2 device included in sh73a0.
@@ -69,7 +69,7 @@ Required Properties:
 		listed above.
     - "renesas,rcar-gen3-cmt0" for 32-bit CMT0 devices included in R-Car Gen3
 		and RZ/G2.
-    - "renesas,rcar-gen3-cmt1" for 48-bit CMT1 devices included in R-Car Gen3
+    - "renesas,rcar-gen3-cmt1" for 48-bit CMT devices included in R-Car Gen3
 		and RZ/G2.
 		These are fallbacks for R-Car Gen3 and RZ/G2 entries listed
 		above.
-- 
2.17.1

