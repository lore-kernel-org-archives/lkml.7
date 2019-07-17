Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13495C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2F920818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZzYceC2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfGQGLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:11:09 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:40540 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfGQGLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:11:09 -0400
Received: by mail-pf1-f169.google.com with SMTP id p184so10284127pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 23:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rxjGrJMP1hpxMB6zVTeQy9AZszZ72B624ErR+RAbbCM=;
        b=ZzYceC2OChsPGS2vpmrexEdklm5EoB5tf1aBMFg6jA2ot+XYQR7urjAGkuAjghzku4
         65l51zAlox2SI6SdyenABJDJC8LgCqAUD49JhfC7t7bH9/fKLZIKabhoq9fUct10LV9O
         97AibNE35b4hi9WjZPrDjXnqlYDf67IJPaKvF+L8L8oryM81dk12ebnqyZXJ4FaQs2pj
         SqVIjwlXHiljM9WLoPAApn09WwzojHRNWlGmc36mo9gLQ8wooCOUy1kRBa+00iVDYqpC
         vvbKTPaa0/WVu+Lcl3owMVpKHxUInduj7w6jbB5B9YY0M9CJpcRpLkY883dFgb+cHgSy
         2q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rxjGrJMP1hpxMB6zVTeQy9AZszZ72B624ErR+RAbbCM=;
        b=fsSK4lrR9TNHzVqPp0JSkvJXmg2YpI2rqZQYB3rvWkYq11VhgIpqdiDShF35W/30Gm
         RAtau4RZmdnZyGgYcmY72QZt69Wo2zuFN19NEz9zzz0/u9OgSbHfvpGwiHbVnwr0ns0q
         b+2blaCVihlt2tcBQRcgxO7Ydf8LfPPyOYys4fye7YVQvx3CpuWMNQiE8FnAsJJuMjvp
         8aWJEpQZJmkiLQAdXLqWbrSZTwnSrKVedyAHNioyWQx10KoQF25iLHlvbKMuDZgAobFI
         x6HQzOCdNS+0is8Ofv9X6Wp3pSZ2wfVZ9xCBrPcNAKcIZoShKAiPMXVwrpBgLxP0hblN
         BXkQ==
X-Gm-Message-State: APjAAAUtJzs7yvggi7qqNrvbc9XOYf2aVDSeYa0prvP2veJ+rleZ7ACl
        o8LMgbJaiORDSY70nFOe2w+XPFvjZQ==
X-Google-Smtp-Source: APXvYqzXP8tcS4UU5zL6p3U9o3cY9LFJ9E45fr8SnzhLehnihIs217ic/N+BCZP+YeattNw8ToK/Yw==
X-Received: by 2002:a63:4185:: with SMTP id o127mr1301569pga.82.1563343868160;
        Tue, 16 Jul 2019 23:11:08 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7301:59e6:f493:40df:9c8a:5041])
        by smtp.gmail.com with ESMTPSA id r27sm25993313pgn.25.2019.07.16.23.11.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 23:11:07 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Darshak.Patel@einfochips.com,
        kinjan.patel@einfochips.com, prajose.john@einfochips.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] dt-bindings: arm: Document i.MX8QXP AI_ML board binding
Date:   Wed, 17 Jul 2019 11:40:38 +0530
Message-Id: <20190717061039.9271-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717061039.9271-1-manivannan.sadhasivam@linaro.org>
References: <20190717061039.9271-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree binding of i.MX8QXP AI_ML board from Einfochips.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 407138ebc0d0..8e9209a75478 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -180,6 +180,7 @@ properties:
       - description: i.MX8QXP based Boards
         items:
           - enum:
+              - einfochips,imx8qxp-ai_ml  # i.MX8QXP AI_ML Board
               - fsl,imx8qxp-mek           # i.MX8QXP MEK Board
           - const: fsl,imx8qxp
 
-- 
2.17.1

