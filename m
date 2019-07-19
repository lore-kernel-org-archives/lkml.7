Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200F5C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8E42084D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fC9BomUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfGSJ1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 05:27:47 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60222 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfGSJ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:27:47 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190719092745euoutp01d8bd3316b2f0f60cb131419a51bccfb0~yxNscCkjq0044900449euoutp01B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:27:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190719092745euoutp01d8bd3316b2f0f60cb131419a51bccfb0~yxNscCkjq0044900449euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563528466;
        bh=Spljwi04NPz7tPwQDU3ylhpMAcBmPOyA+LcLqOe48yU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fC9BomUpsql2COyJ6gc4WDI6fHvJC+/hdyejnXPtXym/Mf8NBhFzk95rsRaQRuSdc
         KWcWgDc/xOQnP4nkP1j5stZ8RYhe8oHkP8LQNIKM2s8Rx84qNcBpV9GA3fkf/EQJTr
         EOMjJ2L131jySWjtf0lxGx8bKyFDI3ZqYYTGaaL4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190719092745eucas1p2d63ead0ad0ba74f60f0fefac910e87ea~yxNsEYFit0571605716eucas1p2M;
        Fri, 19 Jul 2019 09:27:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7D.1D.04325.11D813D5; Fri, 19
        Jul 2019 10:27:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190719092744eucas1p24f1b497e46cf66ac3ae8c717b626a5d4~yxNrQ3dVU0485504855eucas1p2a;
        Fri, 19 Jul 2019 09:27:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190719092744eusmtrp1d31cf3cd69253e47b48dfc82134eb1af~yxNrC0zDS1975419754eusmtrp1S;
        Fri, 19 Jul 2019 09:27:44 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-9f-5d318d1196c9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6C.01.04140.01D813D5; Fri, 19
        Jul 2019 10:27:44 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190719092744eusmtip243b0f5902555ec37e058b710f169bcc7~yxNqp7hk01330413304eusmtip2b;
        Fri, 19 Jul 2019 09:27:44 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] phy: exynos5-usbdrd: Calibrating makes sense only for
 USB2.0 PHY
Date:   Fri, 19 Jul 2019 11:27:34 +0200
Message-Id: <20190719092734.12501-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7djP87qCvYaxBlP+ilhsnLGe1eLC0x42
        i/PnN7BbXN41h81ixvl9TBaLlrUyW6w9cpfdgd1j06pONo++LasYPY7f2M7k8XmTXABLFJdN
        SmpOZllqkb5dAlfGpfO/GQt2clQ8u/mdrYFxBXsXIyeHhICJxOJdPaxdjFwcQgIrGCXmfjnN
        COF8YZToW30fyvnMKPF+52W4lrXdm9kgEssZJW6unMsM1/Jm6gZGkCo2AUOJrrddbCC2iICD
        xJKld8A6mAWuMUo8b3zFBJIQFgiWuP/zJFgRi4CqRFPvL6AVHBy8ArYSW7r8IbbJS6zecABs
        gYTAGTaJ3r+noc5wkbh2cBcbhC0s8er4Fqi4jMTpyT0sEA3NjBIPz61lh3B6GCUuN81ghKiy
        ljh8/CIryDZmAU2J9bv0IcKOEq1tN8HCEgJ8EjfeCoKEmYHMSdumM0OEeSU62oQgqtUkZh1f
        B7f24IVLzBC2h8SPlmlgLwoJxEoc3b6KfQKj3CyEXQsYGVcxiqeWFuempxYb56WW6xUn5haX
        5qXrJefnbmIEJoHT/45/3cG470/SIUYBDkYlHt6AXINYIdbEsuLK3EOMEhzMSiK8t1/qxwrx
        piRWVqUW5ccXleakFh9ilOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpgvCOuuavS+tLj
        NP/mSK2Ti474X3d8rfjo0udMkYe9U2oZWMw1vwmsW/FD4W9j21YZN5Yb9x+0lqYUn/nFfOTF
        AcXK+duqxOMlD1yz5rj4qnv9hq6ZK0U4Vr7QmH7mc+/ztsr2K1YHrl16ZpAtrbH7n5Xp6Y12
        kfwqU290eYSbBy+7ec9278q4ZiWW4oxEQy3mouJEAKPKhdj+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsVy+t/xe7oCvYaxBk9/yFhsnLGe1eLC0x42
        i/PnN7BbXN41h81ixvl9TBaLlrUyW6w9cpfdgd1j06pONo++LasYPY7f2M7k8XmTXABLlJ5N
        UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GpfO/GQt2
        clQ8u/mdrYFxBXsXIyeHhICJxNruzWxdjFwcQgJLGSW27D3FCJGQkTg5rYEVwhaW+HOtC6ro
        E6PE9hXfwRJsAoYSXW9BEpwcIgJOEp1rT4MVMQvcYpT4PP8cM0hCWCBQ4uqXuywgNouAqkRT
        7y+g1RwcvAK2Elu6/CEWyEus3nCAeQIjzwJGhlWMIqmlxbnpucVGesWJucWleel6yfm5mxiB
        obft2M8tOxi73gUfYhTgYFTi4Q3INYgVYk0sK67MPcQowcGsJMJ7+6V+rBBvSmJlVWpRfnxR
        aU5q8SFGU6DdE5mlRJPzgXGRVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQim
        j4mDU6qBcVakvUfebN0Dckcdl77b9/qk4xLLKLH79kmpXMaVGm7x3RV3dhbnpXV9OG2j/Cfc
        Ittge0hs0ByRTwv8PFhL/XVWPTSfFXSTS/+5+yq1lBdF99VsmH6kXXQJvH/tw/z/LUbhR//4
        TdP+K1nfG9OVeP1faVXnq0XzJgnyb93ie1HJrcVQzTNXiaU4I9FQi7moOBEAdHBeY1MCAAA=
X-CMS-MailID: 20190719092744eucas1p24f1b497e46cf66ac3ae8c717b626a5d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190719092744eucas1p24f1b497e46cf66ac3ae8c717b626a5d4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190719092744eucas1p24f1b497e46cf66ac3ae8c717b626a5d4
References: <CGME20190719092744eucas1p24f1b497e46cf66ac3ae8c717b626a5d4@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHY calibration is needed only for USB2.0 (UTMI) PHY, so skip calling
calibration code when phy_calibrate() is called for USB3.0 (PIPE3) PHY.

Fixes: d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 646259bee909..f07edd80d2f3 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -714,7 +714,9 @@ static int exynos5_usbdrd_phy_calibrate(struct phy *phy)
 	struct phy_usb_instance *inst = phy_get_drvdata(phy);
 	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
 
-	return exynos5420_usbdrd_phy_calibrate(phy_drd);
+	if (inst->phy_cfg->id == EXYNOS5_DRDPHY_UTMI)
+		return exynos5420_usbdrd_phy_calibrate(phy_drd);
+	return 0;
 }
 
 static const struct phy_ops exynos5_usbdrd_phy_ops = {
-- 
2.17.1

