Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BD7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63352133F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bbntovQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfCWVSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:18:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34510 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfCWVRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:17:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id o10so6721269wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wAGL8iGF3lMEmJ2uQantEnutEW+aOmbcQ6qmxTQcrtw=;
        b=bbntovQeLy+/qDuCYHnwKgjOwh57yDmKAoiUEGvZcoGUYug5LiOeCuoPx3Li9oZPa0
         loVxl3YC3CkOwO4YCWQuVLY0EQqjcx9XY3EZgtlcG2QRAGjtBRbdTW6r7EJKEJQpz767
         kJbB1GLxOQOrncOJNVBrmx7rQ20rntAC15NvVmFfjkJFput3J3qmjaen82tO734hg4Ie
         dYMdtaCOmkxUSw8V6WxPdqcj5e+G2CsQdQHNjqh9dY31XXT+D8ZjL/AKA6k/m5dNd5Hj
         uGfueM5e9ZinlKdBFvszHh8QtZIOOuiJ6TPBMvRpsNOGDtv59ZcFGOFHRDM6WalzGZA8
         iluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wAGL8iGF3lMEmJ2uQantEnutEW+aOmbcQ6qmxTQcrtw=;
        b=Qnv0vxCIoo6PsO8P0gsn7Kap4sbZnAvwblr0NLn8DRuvf120HX7UpgOoQFlUO7wCut
         44LiWDwOedK4fjVKBMBHFYLwzh+xcnX8FiHkcgzQSYk/DmtIj70+nvS0OhajMGIDnrN6
         7eRhUB6k5i79SsA5Vhk6sHKcPCd7tdwV4P/3Tu9S7uus43XtZi7xSF457m7tPpNlYCeu
         IW3zNYK24tUZff/Q6gLJPORMsH3UQsE6DlIVW/i0NRLgxYLtYPY5xVs4MKXvuJVgM6ra
         TaUaBqd10QeWX/+kDN2eL5dJaaooznWj1mo57qLI6WJ5p4X4bPkiv4dfwYujyYSFnBM/
         50hQ==
X-Gm-Message-State: APjAAAUNjrkTofujsRA+NSFgOn8D6V502h/0A2jcBpI9NSwvSmAls+64
        2rPXTeqKmtK4craqwx/AT9ViSg==
X-Google-Smtp-Source: APXvYqxMjTwXTMEFAp0Gzr3VorLKhzi3VUS3a1rCVhPbaueDCBLLUJz1Wqjy2n04R/toNi2OiWEpPg==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr848377wmc.107.1553375832356;
        Sat, 23 Mar 2019 14:17:12 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:17:11 -0700 (PDT)
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
Subject: [PATCH 13/24] dt-bindings: mediatek: apmixedsys: add support for MT8516
Date:   Sat, 23 Mar 2019 22:16:01 +0100
Message-Id: <20190323211612.860-14-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of apmixedsys for MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../bindings/arm/mediatek/mediatek,apmixedsys.txt      |  1 +
 include/dt-bindings/clock/mt8516-clk.h                 | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
index de4075413d91..c33d83f066c9 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -14,6 +14,7 @@ Required Properties:
 	- "mediatek,mt7629-apmixedsys"
 	- "mediatek,mt8135-apmixedsys"
 	- "mediatek,mt8173-apmixedsys"
+	- "mediatek,mt8516-apmixedsys"
 - #clock-cells: Must be 1
 
 The apmixedsys controller uses the common clk binding from
diff --git a/include/dt-bindings/clock/mt8516-clk.h b/include/dt-bindings/clock/mt8516-clk.h
index 956ee2c0748e..9cfca53cd78d 100644
--- a/include/dt-bindings/clock/mt8516-clk.h
+++ b/include/dt-bindings/clock/mt8516-clk.h
@@ -8,6 +8,16 @@
 #ifndef _DT_BINDINGS_CLK_MT8516_H
 #define _DT_BINDINGS_CLK_MT8516_H
 
+/* APMIXEDSYS */
+
+#define CLK_APMIXED_ARMPLL		0
+#define CLK_APMIXED_MAINPLL		1
+#define CLK_APMIXED_UNIVPLL		2
+#define CLK_APMIXED_MMPLL		3
+#define CLK_APMIXED_APLL1		4
+#define CLK_APMIXED_APLL2		5
+#define CLK_APMIXED_NR_CLK		6
+
 /* INFRACFG */
 
 #define CLK_IFR_MUX1_SEL		0
-- 
2.20.1

