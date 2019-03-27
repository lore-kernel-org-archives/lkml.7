Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9ED22075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulaK2kPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387699AbfC0Gl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:41:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42367 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfC0Gl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:41:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id cv12so2861564plb.9;
        Tue, 26 Mar 2019 23:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xu/t2AQHDvTZzVCd+Vt9EzeubkFkOp8aXB7xYOtkOR8=;
        b=ulaK2kPShWcojgV2+qDpz8urKcb9D2Khj+3kRbcTenker2NMNFUlqLGQcKudnnDA33
         Yq7v8MgCnx+rhfzXvF05d5PztMAYXuLPaUxV7t/gkC8HpLnuoCAI/iKPWCRktChLX3XC
         DXtSJgQVIZFXFKeN9+f7gNGxt8QC7uVchddh4CSD5xeddoYMyFR6bDBcaNh0gflEkTK/
         Csv1GZCmPjROQegLrEueZR84tUG7NgkgOwsMNBUROUFBgposRaMB6IXQ5DBav+k7980P
         no5UYSGGmHd3j1wKdzCKtkwQxpdjDBtFh0kYUGJ8iZshc8PBgufqtJNbUWhXzSQSv2aL
         9TfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xu/t2AQHDvTZzVCd+Vt9EzeubkFkOp8aXB7xYOtkOR8=;
        b=dLfCswsAtq+TqVvhewr61Yt1Lf+mXX5f7i1trlIOa33yvzZwcGq3GMIyk2bGPS0CWc
         XehB680EPwfX1EktRJGJB/6Cge0qkbD3LLuX1FqKQwq6mFOLvwgpS3k+h54UEuWeSCtd
         /DFL1azU/uQcThokPGgwf8X+FFGBvMOQVOShx0bICFHTA4i5ckGrURuncTl+1iyanlrU
         pgCulc9hFi64e2cu5QKDBYERdMpqi7b7N9g7ixlfFkY/4FJIcD6xWPDs50oPX0UqYJ97
         hDopL0P8rXf2ORL158cc2aARn8Zm3mUF6rCRHiDsy9lBnxd1nKLY8vNgUymrhSho9JFk
         JtfA==
X-Gm-Message-State: APjAAAW3hMFzHAmKYhiIMXZMVcLp3EQo7XoHb0eZHExN3sv2GwGVJ6m3
        rGlr7qH+wl+SN8wKso7osNs=
X-Google-Smtp-Source: APXvYqyHS/WK6S0CSta42GglpsS9Yg0hmL740Zn0xm9fOFJXDVH3Efep1KC5QCbQt6RVprQMHrYLhg==
X-Received: by 2002:a17:902:bccc:: with SMTP id o12mr33872828pls.70.1553668915980;
        Tue, 26 Mar 2019 23:41:55 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id q87sm2487054pfa.133.2019.03.26.23.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 23:41:55 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: fsl: Add support for ZII i.MX7 RPU2 board
Date:   Tue, 26 Mar 2019 23:41:49 -0700
Message-Id: <20190327064150.31549-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ZII i.MX7 RPU2 board.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index fb0a37bf16b8..18ffe3bfecf7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -141,6 +141,7 @@ properties:
         items:
           - enum:
               - fsl,imx7d-sdb             # i.MX7 SabreSD Board
+              - zii,imx7d-rpu2            # ZII RPU2 Board
           - const: fsl,imx7d
 
       - description:
-- 
2.20.1

