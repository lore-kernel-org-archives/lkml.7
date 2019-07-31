Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BD1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD912089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZBhSKOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfGaI0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:26:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42630 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbfGaIZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:25:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so18732415wrr.9;
        Wed, 31 Jul 2019 01:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nie3vRCAA3P2WBFQINaLTshvz2jl1k5/q8MQmGfrr+k=;
        b=cZBhSKOvmACLS//fFwYciUrtPk5+8xzmapM5YG9MeLci6M/AbV5f5DPxmzorEqe8hO
         C0bdCTbU8UeQa/LipkiA/f5IXh9ij8yMsQ1G4y9qZAbfoebax0+PhkCBAaEIAqA1oO9X
         FKUJvBuK5bPkEzJy6t24Uw5DSnr2B3uMFMBkW3SilpuHkkaY8mNAWagnh3QsjqFuFLrT
         Ektr9a/2S6JiZ5sxDHjB081Z9otgQPb3t3GZuf3NXc/kvxHEn8a9JBdanuSxXw5Tx/Dz
         lHGBkxdDvY1p6cbiS9/2rs2JXwPgI4tuD9ikOR2/czZmd5IDe6egFW92/bofahc3TSfS
         O7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nie3vRCAA3P2WBFQINaLTshvz2jl1k5/q8MQmGfrr+k=;
        b=DcmndTg+1iPChF6Ycdi3WRGBKzHWuERzuCgLPm/7BNPWAgsThvNIZJCFqqZClIrcdU
         yfBk/ScrE8OqsNQ4mTu2O9LtETVES0Q5/SnTJgyKJHELMw3jYiBfg3WUa7X4iiyp1b7N
         3tuUzArVJbPQeRezHfSm8QOdmmJO5+iUoaiP7JE+Sm2eBQCjP0yrZ007IWm0pZe6z/cH
         SMBlX1Cw9y45gtZYLoaMF7fYn8Rmk04TgoAIJTi4mr1y2U/EUaB+ZXTDk5qxzyk9L0uU
         WfIuSaS2WkeiKK19wB+Rt5sQWeZBnketiPB+1wyccG+IoeplgpvkBGzYTbGvpSEpm5zt
         ZB5g==
X-Gm-Message-State: APjAAAW9vTDNgn2yZodNnj0XJKy59gWRjr5ZbHBsS/F9K6ttqmWS8RAO
        ZrK8Uo/a4K7oem3ZVt8QPmgpZFWO+48=
X-Google-Smtp-Source: APXvYqwV3U51huq3cZ+eVl5YsV2JSBa4m12WPYbJVaYkEDyRZp9cHR75ZSXonFtQZ9v2I9po/BkoZA==
X-Received: by 2002:a5d:5647:: with SMTP id j7mr56381028wrw.191.1564561545735;
        Wed, 31 Jul 2019 01:25:45 -0700 (PDT)
Received: from vd-lxpc-hfe.ad.vahle.at ([80.110.31.209])
        by smtp.gmail.com with ESMTPSA id c78sm93223959wmd.16.2019.07.31.01.25.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 01:25:45 -0700 (PDT)
From:   Hubert Feurstein <h.feurstein@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hubert Feurstein <h.feurstein@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH net-next v2 2/6] dt-bindings: net: dsa: marvell: add 6220 model to the 6250 family
Date:   Wed, 31 Jul 2019 10:23:47 +0200
Message-Id: <20190731082351.3157-3-h.feurstein@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731082351.3157-1-h.feurstein@gmail.com>
References: <20190731082351.3157-1-h.feurstein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MV88E6220 is part of the MV88E6250 family.

Signed-off-by: Hubert Feurstein <h.feurstein@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/net/dsa/marvell.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell.txt b/Documentation/devicetree/bindings/net/dsa/marvell.txt
index 6f9538974bb9..30c11fea491b 100644
--- a/Documentation/devicetree/bindings/net/dsa/marvell.txt
+++ b/Documentation/devicetree/bindings/net/dsa/marvell.txt
@@ -22,7 +22,7 @@ which is at a different MDIO base address in different switch families.
 - "marvell,mv88e6190"	: Switch has base address 0x00. Use with models:
 			  6190, 6190X, 6191, 6290, 6390, 6390X
 - "marvell,mv88e6250"	: Switch has base address 0x08 or 0x18. Use with model:
-			  6250
+			  6220, 6250
 
 Required properties:
 - compatible		: Should be one of "marvell,mv88e6085",
-- 
2.22.0

