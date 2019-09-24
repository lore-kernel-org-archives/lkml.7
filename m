Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA450C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B289B21655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nOucOyfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395260AbfIXLsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:48:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48797 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395140AbfIXLsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:48:46 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190924114844euoutp02f22873129e305bc66177bc833eff31ed~HXW6GfQSh2534725347euoutp02f
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 11:48:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190924114844euoutp02f22873129e305bc66177bc833eff31ed~HXW6GfQSh2534725347euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569325724;
        bh=o/dbitjcpBjt6m19CxhZ8Q367YRKSVkRcHnq7IXVvU4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=nOucOyfouulZ0tfuXj9aH+KKEPZlfNZPsBYXHHVxuufkYfL42RTJnj1ZIbmZ+ChRx
         H7cCWRkKUL38ZxnrRx4ND3IwAMIVDjhPCu9ZIEIswWkaVQbO5k1myTiXKtiIn8354m
         nVWAXS4Oqf6Z8Dd96aH6xLdkV6VfsZlmFBKtL7BU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190924114843eucas1p20daf5d370dff434ea035b690ed891f6e~HXW5pZfEY1024310243eucas1p26;
        Tue, 24 Sep 2019 11:48:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5F.AD.04309.B920A8D5; Tue, 24
        Sep 2019 12:48:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190924114843eucas1p2ea9c36289d3912e022ad7c9070fc00ee~HXW5NuUUI1223012230eucas1p2x;
        Tue, 24 Sep 2019 11:48:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190924114843eusmtrp15164d2b96002f72cd9d5aab9736ccf26~HXW5MoZpe0400704007eusmtrp1R;
        Tue, 24 Sep 2019 11:48:43 +0000 (GMT)
X-AuditID: cbfec7f4-ae1ff700000010d5-43-5d8a029b8b06
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BE.E7.04117.B920A8D5; Tue, 24
        Sep 2019 12:48:43 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190924114842eusmtip204d537e43021b3373ad860bcc0f02458~HXW4pCOxk2063020630eusmtip2s;
        Tue, 24 Sep 2019 11:48:42 +0000 (GMT)
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
Subject: [PATCH] ASoC: samsung: i2s: Add clocks' macros descriptions
Date:   Tue, 24 Sep 2019 13:48:38 +0200
Message-Id: <20190924114838.25482-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOd3ZTF2xBgu3mllcuXiIyWLqwyds
        FvOPnGO1OH9+A7vFtysdTBaXd81hs5hxfh+TxYPmdWwWa4/cZbdYev0ik0Xr3iPsFofftLM6
        8Hhs+NzE5rFm3hpGj52z7rJ7bFrVyebRt2UVo8fnTXIBbFFcNimpOZllqUX6dglcGR8vT2Ms
        eMxR0TJ/F2sD4372LkZODgkBE4nvG48zdTFycQgJrGCUuP5lEhtIQkjgC6PE1l+1EPZnRonW
        o3IwDROXfWOGaFjOKLHx/nwmuIbtF5JAbDYBQ4mut11gg0QE6iTOnjnCCNLALHCESaL5/m+w
        BmEBF4m7R6cxg9gsAqoSe7dcALN5BWwlZu3sZYTYJi+xesMBsG0SAs3sEpfn3meGSLhIrJnb
        wAZhC0u8Or4F6h8ZidOTe1igGhglHp5byw7h9DBKXG6aATXWWuLw8YusXYwcQDdpSqzfpQ8R
        dpRY9fAeG0hYQoBP4sZbQZAwM5A5adt0Zogwr0RHmxBEtZrErOPr4NYevHAJ6jQPia1fvrFC
        AiVW4vT9RSwTGOVmIexawMi4ilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzCNnP53/MsO
        xl1/kg4xCnAwKvHwSmzriBViTSwrrsw9xCjBwawkwrtJqy1WiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dUA2Ot54RDi7ZtcTkp9Lh819I3Ps9c1G9XKodX
        /ZO+7Re36VRhmeevM5PjWPO0WJeXvRQ13SO8/7vzn/b6kAPKae7ihZcl54Sbu558OumztGbb
        CwmJWz4W9RbiTNv/eYeGLfwS9PfMs+YvRo+yNvD/ffJ75z3mO9uvlrmm5Qi7blLdt1wu1nLa
        ciUlluKMREMt5qLiRACQXCofHwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t/xe7qzmbpiDZr6pC2uXDzEZDH14RM2
        i/lHzrFanD+/gd3i25UOJovLu+awWcw4v4/J4kHzOjaLtUfuslssvX6RyaJ17xF2i8Nv2lkd
        eDw2fG5i81gzbw2jx85Zd9k9Nq3qZPPo27KK0ePzJrkAtig9m6L80pJUhYz84hJbpWhDCyM9
        Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jI+XpzEWPOaoaJm/i7WBcT97FyMnh4SA
        icTEZd+Yuxi5OIQEljJKvHk4gRkiISNxcloDK4QtLPHnWhcbRNEnRonJPxrZQBJsAoYSXW8h
        EiICTYwSxzbPZAFxmAVOMUncuDqFEaRKWMBF4u7RaWBjWQRUJfZuuQBm8wrYSsza2csIsUJe
        YvWGA8wTGHkWMDKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECAzibcd+btnB2PUu+BCjAAej
        Eg+vxLaOWCHWxLLiytxDjBIczEoivJu02mKFeFMSK6tSi/Lji0pzUosPMZoCLZ/ILCWanA+M
        sLySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYw80vdrK9elbQ5e
        uW3RyZLCPM+Lqtrytn0BC18yyK6/zdmp+SX+duoj7yyzG9fTM5rLC29vuKXy1fIq24UMp/Uz
        Zyyb8+ygT3LnhieRr6d9Pq607/kThcI5zovNWjxmndl7pV+ekcviz4k55zfOO/Hk9oz7Ys79
        evzJkYVlYVPUJonKXri2ef8SJZbijERDLeai4kQAOpKoyngCAAA=
X-CMS-MailID: 20190924114843eucas1p2ea9c36289d3912e022ad7c9070fc00ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190924114843eucas1p2ea9c36289d3912e022ad7c9070fc00ee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190924114843eucas1p2ea9c36289d3912e022ad7c9070fc00ee
References: <CGME20190924114843eucas1p2ea9c36289d3912e022ad7c9070fc00ee@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Falkowski <m.falkowski@samsung.com>

To increase macro readability added descriptions
to clocks macros.

Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/dt-bindings/sound/samsung-i2s.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/sound/samsung-i2s.h b/include/dt-bindings/sound/samsung-i2s.h
index 77545f14c379..fd752475c762 100644
--- a/include/dt-bindings/sound/samsung-i2s.h
+++ b/include/dt-bindings/sound/samsung-i2s.h
@@ -2,8 +2,13 @@
 #ifndef _DT_BINDINGS_SAMSUNG_I2S_H
 #define _DT_BINDINGS_SAMSUNG_I2S_H
 
-#define CLK_I2S_CDCLK		0
-#define CLK_I2S_RCLK_SRC	1
-#define CLK_I2S_RCLK_PSR	2
+/* the CDCLK (CODECLKO) gate clock */
+#define CLK_I2S_CDCLK 0
+
+/* the RCLKSRC mux clock (corresponding to RCLKSRC bit in IISMOD register) */
+#define CLK_I2S_RCLK_SRC 1
+
+/* the RCLK prescaler divider clock (corresponding to the IISPSR register) */
+#define CLK_I2S_RCLK_PSR 2
 
 #endif /* _DT_BINDINGS_SAMSUNG_I2S_H */
-- 
2.17.1



