Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89665C282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601C02075B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/F6K1R/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfDNSeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:34:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32817 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfDNSeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:34:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so7469918plo.0;
        Sun, 14 Apr 2019 11:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/EbcEuSb4+GVtPwZ6CTWAqigRhpwJKmXogMtZe4IOA=;
        b=U/F6K1R/pqtAj9Cqj5fXu1eOK8v6fb6e6KQtLl+FbLBioG4yXQP58U1nYgUeBUPm3z
         6T96lDHwCWd9ovlbiLDZdZjm8kTk3khr1kR4dNj6X9M06NLI2LSTL2yG2M+hJla87kyS
         hcI4pmphFMJqs6krvL1UFsWbh4NniDdugbQHrYewaLqoAHxkfA5/6xOO4IeJMoP9qfhs
         2zy7MTZTAiKBdDGv4FwlcvpK6hvLLAK/WJS7NSnHiMScDYW5eItSBV+QCFQK4Ubc18TM
         akyKTtUcpphCcgWm32wSLWUisBFhztqDLQsf4mAnEl7EfGMylx+j1y9ZfAHtkxqoHEw/
         49IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/EbcEuSb4+GVtPwZ6CTWAqigRhpwJKmXogMtZe4IOA=;
        b=lS7cHbHaQogTwk1HDzPkai9AEligGKfOfRzdlV4AUWxga38KrrMhlF6WLCtkpn0R7U
         JT6WU6S2NFmaBjq2hj8yDu1xTx2NYBo8KCpnW6S7RI3mmWqYWqqnDQ14IwOwZJTFwSb0
         W8Wfpkugi3skjl8hylTnv8aTBDqOKUCzrf9ykg2B9K/8lppNef8A0speYG3ZrolZ0D4c
         EBixV3X6bfTQHPXuzEROwjmYZyB0Vr+8b9rok/v01wsmpD2gTQq9yjt+oAV9wBNyRVv0
         qHEZ7sOicJb1fSP21+0IA6ImZKEDR+gq2UfclkZxdwkDD+Jb9Uajb7yCCQjt8UrQuC9f
         Pzdg==
X-Gm-Message-State: APjAAAVEi78fAdFIJdEeAVs+sb2/phcSNEd+zvFFeXIyHmlF/s8lwLsw
        89+gAklbOga7mM8Pz0NP87w=
X-Google-Smtp-Source: APXvYqwFRybK1VpQQv9L/xhyqnTNXb8cNZ4XoDPLgwFacidh3VUUzCWX7CAJwU3YL+rg0TjubCrggA==
X-Received: by 2002:a17:902:8a4:: with SMTP id 33mr71538785pll.7.1555266857197;
        Sun, 14 Apr 2019 11:34:17 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id 10sm70159439pft.100.2019.04.14.11.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 11:34:16 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 3/4] dt-bindings: arm: fsl: Add support for ZII i.MX7 RPU2 board
Date:   Sun, 14 Apr 2019 11:34:02 -0700
Message-Id: <20190414183403.21538-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190414183403.21538-1-andrew.smirnov@gmail.com>
References: <20190414183403.21538-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ZII i.MX7 RPU2 board.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

