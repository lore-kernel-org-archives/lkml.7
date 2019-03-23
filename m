Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B85C10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5CA21874
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TNE9CAyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfCWVTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:19:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37804 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfCWVQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:16:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so5317006wmf.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8CBudz3H1DPyVigof7bklSKtdnOHBWQH7PJ01poP6l0=;
        b=TNE9CAyjTjiHx0MHysvJWZWRVZMPKr81uUgdNOnOHO1vtvyvAOtFRkEc33mXYFGWpq
         KPtZQjsAsElUlTIlTMjO/ac5hWvAYBrNFSMe0/W/cm7jDr37JIWumnoaemwlMBULZ0eO
         I6P8wzt5ckHfxepytcoou9dli/PRLRQtXXgu8e8ZZQ/iDOEpVCHDCmULdCkbet0iMMdE
         wip0CTJSU9I/wHolawI2BjFbXxdvGkigllmYVrto9vrDdPj8D0uFhOEIw8I1lBV7iN0V
         Yfrq42XJemE6bZ5YtRuMP4qgfA1P3CW7rLQb9qHgA8m9g9lYcGLsn/Ps33g6oaDqlOaj
         NvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8CBudz3H1DPyVigof7bklSKtdnOHBWQH7PJ01poP6l0=;
        b=JMyA4vvyV8nV6FUp1JM6gdYKGLZy3lZnn5nACQlcjU6wZtofjojoG29DFXbszcSTrJ
         V7a5Rtf3wP0Pdz21CXhhg4uKBwOZoi2w3ZMchOAb8JS27OreHNP9rWHP6NjUcRvleIeu
         LYGqkHKca/17MUXykCCa3EURPT2l7n0nxocOAVaK48YMWaKdwhDrKtxCuUQJOG6WnOcP
         AUNkaHEDSLtBz5kYpDrmDVIV3rl/C+WrrbQFFp1cdaA8zGdW8OKQViiYUnN3wS9AZMjy
         FHM8RIxIgzGSFQG80ZXyRkwAB3yoLPdRPeKx1MuaewCe+tJ4pXotkW82E6VDr6a7XTbk
         CQ0g==
X-Gm-Message-State: APjAAAURwpDAKXmkys9Ky4nczCQy02s1k3HzyIaANy6uTFfMKIGRPoYj
        BtjI9DfIbb+MoJqLT0Z3KsLpMQ==
X-Google-Smtp-Source: APXvYqwQXLwZ/5GxBRuCftwQ3CxEztQ7XbdRahDZrZGRiUm2F0EnfNVyGbVskGvwQYjP5CKNYN5pmg==
X-Received: by 2002:a1c:6309:: with SMTP id x9mr932061wmb.101.1553375803647;
        Sat, 23 Mar 2019 14:16:43 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:16:42 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 03/24] dt-bindings: pwrap: mediatek: add pwrap support for MT8516
Date:   Sat, 23 Mar 2019 22:15:51 +0100
Message-Id: <20190323211612.860-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of pwrap for MT8516 SoCs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
index 5a2ef1726e2a..7a32404c6114 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
@@ -25,6 +25,7 @@ Required properties in pwrap device node.
 	"mediatek,mt8135-pwrap" for MT8135 SoCs
 	"mediatek,mt8173-pwrap" for MT8173 SoCs
 	"mediatek,mt8183-pwrap" for MT8183 SoCs
+	"mediatek,mt8516-pwrap" for MT8516 SoCs
 - interrupts: IRQ for pwrap in SOC
 - reg-names: Must include the following entries:
   "pwrap": Main registers base
-- 
2.20.1

