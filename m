Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3D2C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4EC22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HWmyO/ZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfHUClQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:41:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33429 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfHUClP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:41:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so431301pgn.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 19:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZOe0QY1KzUF5P+bCoUM0BJ5F01MAdy4sijBj6AsQWEY=;
        b=HWmyO/ZOIBs+A7zmQrIMqVgyxPQ2jB0Ddy0+rEqooIS+YxUle0+bJYmfSvbdeKYUX2
         0EmoZ95HMKoXzihfE59cWYZwRpKM9O3xOMZfsCGegfiFytsqkv6Xc5JccykPm9L3PRrk
         Up8koMo3E6TXR/qynopS8F42HgAN/sDyd2zFCFyoZVGuzp1O9a26qm6MlXTXfsiE7QAy
         hq1I8SJNFGSQes+82DZeGKlJHrnp0OS41f/RCV9JHQomXmBFHLimNj1BNCq0gLiaNgCw
         Xb4mIjU/7I8lyINue6igBtz/3bWVguWnPYITjEV2KwbOQ6Zn61NLBpnXGt8RiZmShFeX
         +fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZOe0QY1KzUF5P+bCoUM0BJ5F01MAdy4sijBj6AsQWEY=;
        b=VVEwtvSkTZCOMzzleXhMpKBkqA6jb7kyaioYPK0bawmJcl1Q+eHam/7YOIj0Wp49te
         LgsaXdYyBjV9qk/WTcgV16lXNrqfwx04xEy78/3a3z3Uz+n34chT2Vm6Av35yEU1DMC4
         cA+1f2cE0MaRyxE9ZPq3G9D5Y5Ctz+cQJI/n70vuqTD+V3FBhFbGOLDYhQsfEMz2y2dK
         MByop5XGLoFUcZ8nK8DqCJYli/gyBf9eUOHaG6e7ASwBiP8Bhwvl6qbzlpYvYidpbxPK
         QfSa+VJhsjf20nMOzAUNI01OikXNnFtwk2tnizcwGhQgsuQ24CwjUwwxXSbSMKKn5JGp
         lrEw==
X-Gm-Message-State: APjAAAXklB6jgrp9bkoFEF+L+4SaLk6URR5GIls5e90Ngr4OrabSGsOT
        uSDOJIwJ/NP2rpZuck7yAaaS
X-Google-Smtp-Source: APXvYqx8as53UWMctePrdUCwm/ptziUdDjmDttJKVhO0LjcJc5tCGhcTtg3y6wHbQE7foFo3/P5+Gg==
X-Received: by 2002:a63:4e05:: with SMTP id c5mr26433918pgb.82.1566355274706;
        Tue, 20 Aug 2019 19:41:14 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id b126sm26091608pfa.177.2019.08.20.19.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:41:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 6/7] MAINTAINERS: Add entry for Actions Semi SD/MMC driver and binding
Date:   Wed, 21 Aug 2019 08:10:13 +0530
Message-Id: <20190821024014.14070-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
References: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Actions Semi SD/MMC driver with its binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c31e6492b601..247d5332f7b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1375,6 +1375,7 @@ F:	drivers/clk/actions/
 F:	drivers/clocksource/timer-owl*
 F:	drivers/dma/owl-dma.c
 F:	drivers/i2c/busses/i2c-owl.c
+F:	drivers/mmc/host/owl-mmc.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
@@ -1383,6 +1384,7 @@ F:	Documentation/devicetree/bindings/arm/actions.yaml
 F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
 F:	Documentation/devicetree/bindings/dma/owl-dma.txt
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
+F:	Documentation/devicetree/bindings/mmc/owl-mmc.txt
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
-- 
2.17.1

