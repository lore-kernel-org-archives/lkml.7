Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06491C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C4920873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GV9+iVN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfGSMZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:25:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58193 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbfGSMZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:25:44 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190719122543euoutp01466a14864d0adf394c0310ea54915294~yzpEVob1p3039630396euoutp01C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 12:25:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190719122543euoutp01466a14864d0adf394c0310ea54915294~yzpEVob1p3039630396euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563539143;
        bh=ZkJKWho2ClrEqfnUpDTH/xfBXBjcM+BhDvk5JIuR9Jc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=GV9+iVN/pilqUPir3EvADoEpImt88QXgGpf+c9DSpXIoicsISn8ys+FzM4E/fqwns
         XppsKBePc7I6b+4MBLR1i8Sh5i/PnijNZPaZhtkMnbgl8yiAVnf5p4H39XPgZYglEL
         pU0pk8rpzFKbuxgixDPWbEaVItA7pD2avjaT5FgE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190719122542eucas1p2fec19789ea42d61b6eb9df50fd0bdbb4~yzpD02QXr2925729257eucas1p2N;
        Fri, 19 Jul 2019 12:25:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 46.16.04298.6C6B13D5; Fri, 19
        Jul 2019 13:25:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190719122541eucas1p2448ec705f84347c0a79732883daeb2b4~yzpDGyAAe0324603246eucas1p2M;
        Fri, 19 Jul 2019 12:25:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190719122541eusmtrp2e746679023378e3301c751821a0905f3~yzpC4tkfV2814328143eusmtrp2g;
        Fri, 19 Jul 2019 12:25:41 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-b1-5d31b6c66fb7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 95.45.04140.5C6B13D5; Fri, 19
        Jul 2019 13:25:41 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190719122541eusmtip2a19a3ae7e05f05acf108082c2e80e1be~yzpCdNE8t2842128421eusmtip2B;
        Fri, 19 Jul 2019 12:25:41 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] phy: samsung: disable bind/unbind platform driver feature
Date:   Fri, 19 Jul 2019 14:25:32 +0200
Message-Id: <20190719122532.29591-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7djP87rHthnGGuw5JWqxccZ6VosLT3vY
        LM6f38BucXnXHDaLGef3MVksWtbKbLH2yF12B3aPTas62Tz6tqxi9Dh+YzuTx+dNcgEsUVw2
        Kak5mWWpRfp2CVwZzxezFmyVrTj+7Q1bA+MiyS5GTg4JAROJ5eemMHYxcnEICaxglJi24TYT
        SEJI4AujxMHWKAj7M6PEiT0cMA13d55hh4gvZ5S49pkXohmo/tyS+WDNbAKGEl1vu9hAbBEB
        B4klS++wgRQxC1xjlHje+AqsSFjAS+L5tOMsIDaLgKrEufPHWEFsXgFbifVzJrNCbJOXWL3h
        ADNIs4TAGTaJu/t/sUEkXCR+NL1mgrCFJV4d38IOYctI/N8JcgVIQzOjxMNza9khnB5GictN
        MxghqqwlDh+/CLSCA+gmTYn1u/Qhwo4Smx+fZgYJSwjwSdx4KwgSZgYyJ22bDhXmlehoE4Ko
        VpOYdXwd3NqDFy4xQ9geEifv7mKFhFCsxPmF09kmMMrNQti1gJFxFaN4amlxbnpqsWFearle
        cWJucWleul5yfu4mRmD8n/53/NMOxq+Xkg4xCnAwKvHwBuQaxAqxJpYVV+YeYpTgYFYS4b39
        Uj9WiDclsbIqtSg/vqg0J7X4EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dUA+NsH8c5
        X9ZW8BftkF/EdiPF6rydj9TbGx/iZGrEwn+Wd87wPXcx6LxKsfzjwnPfrM8Zz3FdtjBii1uK
        /7en/fHyzAtvbsm6V744rI3/Xv4y2Qluqd8ZrCWf3b78+tJOj59LsxJyi1qX3p+9/fT3OgP1
        2ozlpxbcmmOzvOgS17eNpxgMY+NPaz5SYinOSDTUYi4qTgQAsueR2vsCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsVy+t/xe7pHtxnGGnxfK2+xccZ6VosLT3vY
        LM6f38BucXnXHDaLGef3MVksWtbKbLH2yF12B3aPTas62Tz6tqxi9Dh+YzuTx+dNcgEsUXo2
        RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZzxezFmyV
        rTj+7Q1bA+MiyS5GTg4JAROJuzvPsIPYQgJLGSVa/7FBxGUkTk5rYIWwhSX+XOsCinMB1Xxi
        lJj6ZA4jSIJNwFCi620XWIOIgJNE59rTYEXMArcYJT7PP8cMkhAW8JJ4Pu04C4jNIqAqce78
        MbCpvAK2EuvnTIbaIC+xesMB5gmMPAsYGVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIEBt62
        Yz+37GDsehd8iFGAg1GJhzcg1yBWiDWxrLgy9xCjBAezkgjv7Zf6sUK8KYmVValF+fFFpTmp
        xYcYTYGWT2SWEk3OB0ZFXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYO
        TqkGRu/F6RzXb/z75LDy5Wq3Lncbhcoj/wO1L/9Zd//s/bzPrAePX2qtOpmr5X1sXmCDfUaw
        YPCM3OqVs69o5c5zvxwTyHA4cJVtqUmwnhSXbLzN7/D6izvLD7e+k/oULzYr5sjkeQdipXef
        lpFZZX9HK/TKt0ztGXxz9qbdDft4U7FYafpx0SVnZyuxFGckGmoxFxUnAgBAgHK4UgIAAA==
X-CMS-MailID: 20190719122541eucas1p2448ec705f84347c0a79732883daeb2b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190719122541eucas1p2448ec705f84347c0a79732883daeb2b4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190719122541eucas1p2448ec705f84347c0a79732883daeb2b4
References: <CGME20190719122541eucas1p2448ec705f84347c0a79732883daeb2b4@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung PHY drivers control the power to the SoC core components needed by
their client devices (USB HCDs, SATA, camera ISP bridge, DP encoder) to
properly operate. Disabling PHYs in runtime usually causes the client
device to crash with external abort exception or similar issue due to lack
of API to notify clients about PHY removal. This patch removes the
possiblity to unbind Samsung Exynos PHY drivers in runtime.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/phy/samsung/phy-exynos-dp-video.c   | 1 +
 drivers/phy/samsung/phy-exynos-mipi-video.c | 1 +
 drivers/phy/samsung/phy-exynos-pcie.c       | 1 +
 drivers/phy/samsung/phy-exynos5-usbdrd.c    | 1 +
 drivers/phy/samsung/phy-exynos5250-sata.c   | 1 +
 drivers/phy/samsung/phy-samsung-usb2.c      | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/phy/samsung/phy-exynos-dp-video.c b/drivers/phy/samsung/phy-exynos-dp-video.c
index aebd216dcf2f..6c607df1dc9a 100644
--- a/drivers/phy/samsung/phy-exynos-dp-video.c
+++ b/drivers/phy/samsung/phy-exynos-dp-video.c
@@ -109,6 +109,7 @@ static struct platform_driver exynos_dp_video_phy_driver = {
 	.driver = {
 		.name	= "exynos-dp-video-phy",
 		.of_match_table	= exynos_dp_video_phy_of_match,
+		.suppress_bind_attrs = true,
 	}
 };
 module_platform_driver(exynos_dp_video_phy_driver);
diff --git a/drivers/phy/samsung/phy-exynos-mipi-video.c b/drivers/phy/samsung/phy-exynos-mipi-video.c
index 3784bf100b95..bb51195f189f 100644
--- a/drivers/phy/samsung/phy-exynos-mipi-video.c
+++ b/drivers/phy/samsung/phy-exynos-mipi-video.c
@@ -359,6 +359,7 @@ static struct platform_driver exynos_mipi_video_phy_driver = {
 	.driver = {
 		.of_match_table	= exynos_mipi_video_phy_of_match,
 		.name  = "exynos-mipi-video-phy",
+		.suppress_bind_attrs = true,
 	}
 };
 module_platform_driver(exynos_mipi_video_phy_driver);
diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
index 1b4ba8bdb43c..659e7ae0a6cf 100644
--- a/drivers/phy/samsung/phy-exynos-pcie.c
+++ b/drivers/phy/samsung/phy-exynos-pcie.c
@@ -272,6 +272,7 @@ static struct platform_driver exynos_pcie_phy_driver = {
 	.driver = {
 		.of_match_table	= exynos_pcie_phy_match,
 		.name		= "exynos_pcie_phy",
+		.suppress_bind_attrs = true,
 	}
 };
 
diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index f07edd80d2f3..7f6279fb4f8f 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -955,6 +955,7 @@ static struct platform_driver exynos5_usb3drd_phy = {
 	.driver = {
 		.of_match_table	= exynos5_usbdrd_phy_of_match,
 		.name		= "exynos5_usb3drd_phy",
+		.suppress_bind_attrs = true,
 	}
 };
 
diff --git a/drivers/phy/samsung/phy-exynos5250-sata.c b/drivers/phy/samsung/phy-exynos5250-sata.c
index 9e5fc126032c..4dd7324d91b2 100644
--- a/drivers/phy/samsung/phy-exynos5250-sata.c
+++ b/drivers/phy/samsung/phy-exynos5250-sata.c
@@ -237,6 +237,7 @@ static struct platform_driver exynos_sata_phy_driver = {
 	.driver = {
 		.of_match_table	= exynos_sata_phy_of_match,
 		.name  = "samsung,sata-phy",
+		.suppress_bind_attrs = true,
 	}
 };
 module_platform_driver(exynos_sata_phy_driver);
diff --git a/drivers/phy/samsung/phy-samsung-usb2.c b/drivers/phy/samsung/phy-samsung-usb2.c
index 6c82f4fbe8a2..090aa02e02de 100644
--- a/drivers/phy/samsung/phy-samsung-usb2.c
+++ b/drivers/phy/samsung/phy-samsung-usb2.c
@@ -250,6 +250,7 @@ static struct platform_driver samsung_usb2_phy_driver = {
 	.driver = {
 		.of_match_table	= samsung_usb2_phy_of_match,
 		.name		= "samsung-usb2-phy",
+		.suppress_bind_attrs = true,
 	}
 };
 
-- 
2.17.1

