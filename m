Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8663C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9059A21D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vV+vsVcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfIZLCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 07:02:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35856 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfIZLC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:02:29 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190926110227euoutp01e5528ddabd8ba5ebcc36b2fb0c8b31cc~H_BEE8W1E0923409234euoutp01x
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 11:02:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190926110227euoutp01e5528ddabd8ba5ebcc36b2fb0c8b31cc~H_BEE8W1E0923409234euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569495747;
        bh=T1vG9yJ0SrvHDQJfyMirTT552HaxAD38CrVYzRGiMrA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=vV+vsVcpVWomhaEqJilNT2Zsq8sW11jXNZViSCGly36ahapYZoqN+3/yVt0ZrSj3r
         hUK8FJ/KY/amTMFidA1ZdLksfG/I74zS80TZMoJlZCNjNGhzS6UqZtMGTrvVsG7/v9
         e4wN0UE8Q4yvOM8H7HGt/MV7Yr4zOLKBrSrt7i0o=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190926110226eucas1p2a5a0fb04e6ecd1ce99ed81599a1e85d4~H_BDry20e0586305863eucas1p20;
        Thu, 26 Sep 2019 11:02:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 45.D8.04374.2CA9C8D5; Thu, 26
        Sep 2019 12:02:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190926110226eucas1p24dbb1b39ffa3f607aa28c0c4d9ff6aba~H_BDSjD0z0586305863eucas1p2z;
        Thu, 26 Sep 2019 11:02:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190926110226eusmtrp25ba1e9e4c5004f2f562a43e1a591292b~H_BDK4MpT2039620396eusmtrp2B;
        Thu, 26 Sep 2019 11:02:26 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-5b-5d8c9ac2c1e3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 51.E9.04166.2CA9C8D5; Thu, 26
        Sep 2019 12:02:26 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190926110225eusmtip162bc8419c3a731febe25b42acf6782c0~H_BCiMLpZ2692226922eusmtip1R;
        Thu, 26 Sep 2019 11:02:25 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] ASoC: samsung: i2s: Document clocks macros
Date:   Thu, 26 Sep 2019 13:02:19 +0200
Message-Id: <20190926110219.6144-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOd1Ds3piDdrea1pcuXiIyWLqwyds
        FvOPnGO1OH9+A7vFtysdTBaXd81hs5hxfh+TxYPmdWwWa4/cZbdYev0ik0Xr3iPsFofftLM6
        8Hhs+NzE5rFm3hpGj52z7rJ7bFrVyebRt2UVo8fnTXIBbFFcNimpOZllqUX6dglcGT+X32Ev
        2MhVsan3PHsD4yWOLkYODgkBE4k9nxm7GLk4hARWMEqce32MBcL5wihxeN0S9i5GTiDnM6PE
        ztmiMA2zp0LVLGeUmHviByNcw53mGWANbAKGEl1vu9hAbBGBOomzZ46AFTELHGGSaL7/mwkk
        ISxgJ3F8bQ8LiM0ioCrx8vQSsAZeARuJKRtugNVICMhLrN5wgBmkWUKgmV3i39mTzBAJF4mv
        /3oYIWxhiVfHt7BD2DIS/3fOZ4JqYJR4eG4tO4TTwyhxuWkGVIe1xOHjF1lBHmIW0JRYv0sf
        IuwoceXNVhaIP/kkbrwVBAkzA5mTtk1nhgjzSnS0CUFUq0nMOr4Obu3BC5egTvOQ+LP6Hisk
        5GIlDvYuYZnAKDcLYdcCRsZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgWnk9L/jX3cw
        7vuTdIhRgINRiYf3QFh3rBBrYllxZe4hRgkOZiURXt/Inlgh3pTEyqrUovz4otKc1OJDjNIc
        LErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjLFybCdDTugHlQkdv5Yd0flwwp+Mn+EmoVEC
        D3hehYlcDtVP3vft3voDh8qeqR7ZdqdZWOi8ZQBzjK8b555DB6fEJwYcPNOdse66yJ9122p1
        50juMHh2iCMq/8C1UtVVtq9i/nf2d3iyWNQVps3KksvfF3Qx7x+L1wcN380z3jhVRxX1Tirv
        VWIpzkg01GIuKk4EAFo3rPUfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsVy+t/xu7qHZvXEGnTOZLW4cvEQk8XUh0/Y
        LOYfOcdqcf78BnaLb1c6mCwu75rDZjHj/D4miwfN69gs1h65y26x9PpFJovWvUfYLQ6/aWd1
        4PHY8LmJzWPNvDWMHjtn3WX32LSqk82jb8sqRo/Pm+QC2KL0bIryS0tSFTLyi0tslaINLYz0
        DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mn4uv8NesJGrYlPvefYGxkscXYwcHBIC
        JhKzp7J0MXJxCAksZZTo6G4FcjiB4jISJ6c1sELYwhJ/rnWxQRR9YpT4+2whE0iCTcBQoust
        REJEoIlR4tjmmWCjmAVOMUncuDqFEaRKWMBO4vjaHrCxLAKqEi9PL2EDsXkFbCSmbLjBBLFC
        XmL1hgPMExh5FjAyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAgM4W3Hfm7ewXhpY/AhRgEO
        RiUe3gNh3bFCrIllxZW5hxglOJiVRHh9I3tihXhTEiurUovy44tKc1KLDzGaAi2fyCwlmpwP
        jK+8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2ManbsrZOVu5bp
        8lzX+s25PsXg2fQrJyb/apkSyOkqOSnjOsfKvY89WFSeajr3vK7af3FToU6p0M7uWIfzlez8
        G2TvumeyPT+8pE8qWu4h47WVCltaw2q59220EGY5m+Xy+8M00z0u96coifP8Upj7fGXUIfVk
        JfUtxsdv/JvzWDt59coHSZxblViKMxINtZiLihMBXlom33cCAAA=
X-CMS-MailID: 20190926110226eucas1p24dbb1b39ffa3f607aa28c0c4d9ff6aba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190926110226eucas1p24dbb1b39ffa3f607aa28c0c4d9ff6aba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190926110226eucas1p24dbb1b39ffa3f607aa28c0c4d9ff6aba
References: <CGME20190926110226eucas1p24dbb1b39ffa3f607aa28c0c4d9ff6aba@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Falkowski <m.falkowski@samsung.com>

Document clocks macros with their description
from 'Documentation/devicetree/bindings/sound/samsung-i2s.txt'

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- Added proper commit message and description
- Moved comments to the right side

Best regards,
Maciej Falkowski
---
 include/dt-bindings/sound/samsung-i2s.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/sound/samsung-i2s.h b/include/dt-bindings/sound/samsung-i2s.h
index 77545f14c379..250de0d6c734 100644
--- a/include/dt-bindings/sound/samsung-i2s.h
+++ b/include/dt-bindings/sound/samsung-i2s.h
@@ -2,8 +2,14 @@
 #ifndef _DT_BINDINGS_SAMSUNG_I2S_H
 #define _DT_BINDINGS_SAMSUNG_I2S_H
 
-#define CLK_I2S_CDCLK		0
-#define CLK_I2S_RCLK_SRC	1
-#define CLK_I2S_RCLK_PSR	2
+#define CLK_I2S_CDCLK		0 /* the CDCLK (CODECLKO) gate clock */
+
+#define CLK_I2S_RCLK_SRC	1 /* the RCLKSRC mux clock (corresponding to
+				   * RCLKSRC bit in IISMOD register)
+				   */
+
+#define CLK_I2S_RCLK_PSR	2 /* the RCLK prescaler divider clock
+				   * (corresponding to the IISPSR register)
+				   */
 
 #endif /* _DT_BINDINGS_SAMSUNG_I2S_H */
-- 
2.17.1



