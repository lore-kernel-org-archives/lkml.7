Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A48C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F4B21927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RRpsPIui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388145AbfISF26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 01:28:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43189 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388120AbfISF24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 01:28:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so1040612pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 22:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HFlAwaqhm8dlhIw/iDdHiwYstLYBPJtkXdnpZsgY5Eo=;
        b=RRpsPIuiBJnuKBdUY6V0x4+hBkYZMrgBDYGWMfKllUbD982ZH9yAwmJU5e8dPh+Uo3
         po9p2/lHZvJZjkCmrAoFuvCK/1Z8l6yT4w1I5aU55mAdNZEmZ0SFxubbu6dx/X/R23Kq
         WROHdjAFrQuwa3ZShhcbJUburskKc0V/JS6q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HFlAwaqhm8dlhIw/iDdHiwYstLYBPJtkXdnpZsgY5Eo=;
        b=YGvpJFJTbDmttFmUm5g7RZ4iLVK9GV2kDrysakzdNvmxAouBqT9kvQGcv6NLvRiHD3
         OJ0BOmhk9IO9Fz75CMdyhlsWMVtV4Wwnze1E82Bcn55UjmiGDrZ8SfAj7tCnnz+67PmU
         l7/lqqNeDBwix6l0kcAFyj4OqBuoMbnui9N223RTclFQmJ8IH0PUyxJS77e/m/f6HN5O
         YF4ziL7fTbgqAxxM3xnTYgcpO/hcXuMPG45rLPYtgPhJqPVSqvzfKrPERqMvDYPQYseA
         HTfow+Jx9T2EuuVnHkpWNKjeA0rW4OTNEJCQmhLo8+r5OmvcqmcaDMX8O1eX6NjkrTDA
         ITzA==
X-Gm-Message-State: APjAAAUWoWkg6xqGP9S7jan1sPjX/9S3R9PttzF5cWa4ktfPtSSMGPC8
        c24D+dSxxK0hhzrPI5ckHJGgoQ==
X-Google-Smtp-Source: APXvYqxbOgq1HDVr1LGevm/V0Fyf1WFz9mP7w7bIeVUZhpKQfytlplyhSQTNZCS1BhH/JexW+9Zemw==
X-Received: by 2002:a17:902:9896:: with SMTP id s22mr7836198plp.207.1568870935949;
        Wed, 18 Sep 2019 22:28:55 -0700 (PDT)
Received: from localhost.localdomain ([49.206.200.127])
        by smtp.gmail.com with ESMTPSA id z20sm5051930pjn.12.2019.09.18.22.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 22:28:55 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>, Levin Du <djw@t-chip.com.cn>,
        Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Da Xue <da@lessconfused.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 3/6] arm64: dts: rockchip: Use libretech model, compatible for ROC-PC
Date:   Thu, 19 Sep 2019 10:58:19 +0530
Message-Id: <20190919052822.10403-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190919052822.10403-1-jagan@amarulasolutions.com>
References: <20190919052822.10403-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though the ROC-PC is manufactured by firefly, it is co-designed
by libretch like other Libretech computer boards from allwinner,
amlogic does.

So, it is always meaningful to keep maintain those vendors who
are part of design participation so-that the linux mainline
code will expose outside world who are the makers of such
hardware prototypes.

So,
- append the compatible to "libretech,roc-rk3399-pc" and
- update the model to "Libre Computer Board ROC-RK3399-PC"
  like other libretech computer boards does.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
index c53f3d571620..e09bcbdd92f5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
@@ -9,8 +9,8 @@
 #include "rk3399-opp.dtsi"
 
 / {
-	model = "Firefly ROC-RK3399-PC Board";
-	compatible = "firefly,roc-rk3399-pc", "rockchip,rk3399";
+	model = "Libre Computer Board ROC-RK3399-PC";
+	compatible = "libretech,roc-rk3399-pc", "firefly,roc-rk3399-pc", "rockchip,rk3399";
 
 	chosen {
 		stdout-path = "serial2:1500000n8";
-- 
2.18.0.321.gffc6fa0e3

