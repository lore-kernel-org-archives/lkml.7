Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3008C48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AB6206A3
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROJDc2rq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfGGNXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 09:23:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51417 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfGGNXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 09:23:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so13248330wma.1;
        Sun, 07 Jul 2019 06:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=K0RTcoO3eeXEQ/VOA/kvp7SGagErS4KYjRrruQqiKoQ=;
        b=ROJDc2rqI7UvbNRweUh+r2bBgqFCTo9JCUFGVnleU7Q1mCJU0J7+3xseQrxNmt45Yg
         WjvdlCjNcunxGMwkI6msx/DlOmxFwzji4KijNRNXrTfGc5Qr6UlDXHhRaGnXNsmwtJjl
         YNV4aPs1x31SxEsH8TDFzRCRVJUgeMi1o2DXjFi4113Ie3IPoHIHWNNjH2vyKRj1wApi
         M8YTEd4svLWP53fLso5DcNLh0sgvcqCBRlVfEMo/y9NcXuFoUxFjkGHoalrTYn+Ktxge
         tqDgCaXiI7zjprSCLBxBE6VyR5oPFGW6pvD5PQ6/pOQoJHW+rPCQ0KzMzURjYbCSqf33
         8SJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=K0RTcoO3eeXEQ/VOA/kvp7SGagErS4KYjRrruQqiKoQ=;
        b=lxXryhKnXn4ARol8cfFI87wJWgr70WESoYTA7uXDOUCVif7bQS/VdYsHUbyI15rHv0
         saPVLLbdGkuoH5Vwyj/zRHLeJ7fN1USFUpJqXG4hta7wNxZv3DZaZA3LoghPGHOXTsok
         oDjiLE8v3IBCfEwUP7s98k39qqgXL3EzaIRb/BLkY5jIrX8FQ1sT1ASMxO1M0d07Wb4R
         BhsneA0nd4s+h/51DXCYiQ4L/2gRWl+MMlraLli9Mz6hEHYKewXAujg8IPLJYxH0EDsY
         pq1o6DYS2O7fV+Z2uXUR6RvCcUB28qT2qbwFDdImdELdmFNbRWK3BOzNg9X+MjWSonYE
         t0FQ==
X-Gm-Message-State: APjAAAWtxAXs+3T0NtnIP8hx8QZV5mGqb3444zEFgko4/WOEvWTgLKow
        A5bXfS3I57FpqRbex1N367ZB6fV+nyo=
X-Google-Smtp-Source: APXvYqx2x2SBLnwpDYcIhsQfbAcvKWlOd53k5NUzpD1x6Bg50bDEMiHB/Fi49gUVjnnroUk3BQURNg==
X-Received: by 2002:a7b:c4c1:: with SMTP id g1mr12835947wmk.14.1562505822861;
        Sun, 07 Jul 2019 06:23:42 -0700 (PDT)
Received: from arks.localdomain (179.red-83-58-138.dynamicip.rima-tde.net. [83.58.138.179])
        by smtp.gmail.com with ESMTPSA id h8sm13515959wmf.12.2019.07.07.06.23.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 06:23:42 -0700 (PDT)
Date:   Sun, 7 Jul 2019 15:23:39 +0200
From:   Aleix Roca Nonell <kernelrocks@gmail.com>
To:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] dt-bindings: arm: Document RTD1296
Message-ID: <20190707132339.GF13340@arks.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Relatek RTD1296 SoC. And the Bannana Pi BPI-W2 board.

Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
---
 Documentation/devicetree/bindings/arm/realtek.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/realtek.txt b/Documentation/devicetree/bindings/arm/realtek.txt
index 95839e19ae92..78da1004d38c 100644
--- a/Documentation/devicetree/bindings/arm/realtek.txt
+++ b/Documentation/devicetree/bindings/arm/realtek.txt
@@ -20,3 +20,16 @@ Root node property compatible must contain, depending on board:
 Example:
 
     compatible = "zidoo,x9s", "realtek,rtd1295";
+
+
+RTD1296 SoC
+===========
+
+Required root node properties:
+
+ - compatible :  must contain "realtek,rtd1296"
+
+
+Root node property compatible must contain, depending on board:
+
+ - Bannana Pi BPI-W2: "bananapi,bpi-w2"
-- 
2.21.0

