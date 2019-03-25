Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7D0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F38220700
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDdiZGuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfCYSXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:23:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42502 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbfCYSXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:23:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so6975658pgh.9;
        Mon, 25 Mar 2019 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sYs72nPCs92RUnYzANfhrY+VUiGAE+8bjNffkEQO8DY=;
        b=vDdiZGuIcOVpb3mgPBt5S0PUMgOg7UDGNfhSUPesGZ70fYTudbu8dCGbZdB8mm91Wz
         I6ipWNbLBz4SXK0FPSEpXmy1OS+7r2YoaFrZAiuYbbA/cS73+DjHBhMwZRrIDKyYlE3A
         sZ8jUBpYGyruIFZOvLuxfGSeVhj6V0FIa4tTEL0qW8dSqFjzwnhO7fT4JYHIUO3Klyts
         phW+qYhSy1zMqv4ZLVKVLtcztgCVRFFTIsP9eUii2ykXiRyAvI3VVVYdHAE4+XEUIZr6
         Ohq5LtMvgVDebmHTuwTdZfTFnDPb9e2c+fVQCSZ217a6hH+HHXxuhFnv06PBHEN9pxab
         3GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sYs72nPCs92RUnYzANfhrY+VUiGAE+8bjNffkEQO8DY=;
        b=eDheQR5wAdDevcRs8TlP6e6SL/0MoVeAAUCoX/DORmCmzZVk1bu3uQ0CVeZpZ2g8ZD
         HNDBA8zyaBueSCoUUe+xfzwfoJG9rf1ax3+LbPHzAAiysdP1WFQWmDZfBOhFsLLXtZTt
         0hNJOlmCPPU8ECBehtSsMoHkejrHGHOP4zlf06VcGCjMWQncR5vQD9tA3STFcdOTuie4
         Zgtiz0kNCx4rzwSo0bY3uLrsr7BDUeUThhUvSgPt3q7ZkH24AflwUTbwEcmWD6bcNn6i
         SSZNnuNia7P96a0ikQ9D1Mf3VZW8xR73V2tOBBv+ZmkSgq3G5X0384nP4KBVpq06DnLh
         4Wag==
X-Gm-Message-State: APjAAAWXnoU59f54TG/1Tu7gn7BQ6FEocONrm4muAq3e9UQPE3hC+dqu
        FA97K0U36r8lF/quNPhDAZg=
X-Google-Smtp-Source: APXvYqxdB0WqISOSawDW8BuEUBpjL5AXDITyZ1c5r+8XDOycdbcf+BI2VQYuD1abO1oFFf0RlGEVOQ==
X-Received: by 2002:a63:2b82:: with SMTP id r124mr24369314pgr.214.1553538182465;
        Mon, 25 Mar 2019 11:23:02 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h19sm23603315pfd.130.2019.03.25.11.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 11:23:01 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: arm: fsl: Add supported ZII VF610 boards to DT schema
Date:   Mon, 25 Mar 2019 11:22:41 -0700
Message-Id: <20190325182243.16788-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add already supported ZII VF610 boards to DT schema.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7e2cd6ad26bd..431ca87aa600 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -176,6 +176,18 @@ properties:
               - fsl,vf610
               - fsl,vf610m4
 
+      - description: ZII's VF610 based Boards
+        items:
+          - enum:
+              - zii,vf610cfu1      # ZII VF610 CFU1 Board
+              - zii,vf610dev-c     # ZII VF610 Development Board, Rev C
+              - zii,vf610dev-b     # ZII VF610 Development Board, Rev B
+              - zii,vf610scu4-aib  # ZII VF610 SCU4 AIB
+              - zii,vf610dtu       # ZII VF610 SSMB DTU Board
+              - zii,vf610spu3      # ZII VF610 SSMB SPU3 Board
+          - const: zii,vf610dev
+          - const: fsl,vf610
+
       - description: LS1012A based Boards
         items:
           - enum:
-- 
2.20.1

