Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1F0C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB875218B8
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q+g/GyIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfGVRck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:32:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59751 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfGVRck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:32:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190722173237euoutp0199dddaa5a060b119797553e01d57ecbb~zyw5PB6CM2844428444euoutp01O
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 17:32:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190722173237euoutp0199dddaa5a060b119797553e01d57ecbb~zyw5PB6CM2844428444euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563816757;
        bh=85hIYZIUSz2sajlTBWW2bBjChuGeN2EeF//kqgRb2D0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=q+g/GyIiCSk+dVn1nzJwAjrNZSpMtXOg1/tllmmhS+Sl5i/AI++KYFiXiYyibiv53
         luWvZA4BcDUY9WYWRQNXBTHEtk4I7BgIuv8ZYVZ3DOItfhounaTih+HQ7jhVHCpsQH
         htkEQ5CuzsBAJXSbtre8VCiCrk+9cKxD3SZkFt0M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190722173237eucas1p16e96da4835c4f0ac84c47c31cefda747~zyw4Z8IC11305913059eucas1p1v;
        Mon, 22 Jul 2019 17:32:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C8.DC.04298.433F53D5; Mon, 22
        Jul 2019 18:32:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190722173236eucas1p171299dfaa34f3124622df488bfe57a89~zyw3m9yeP0714007140eucas1p1l;
        Mon, 22 Jul 2019 17:32:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190722173235eusmtrp1a484cb96a4f7d585c54b0134f26c21d9~zyw3Y7q9v0411704117eusmtrp1g;
        Mon, 22 Jul 2019 17:32:35 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-73-5d35f334eb5c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 54.47.04146.333F53D5; Mon, 22
        Jul 2019 18:32:35 +0100 (BST)
Received: from AMDC2765.DIGITAL.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190722173235eusmtip1e2c9e2516c30587a1479aaf27bb423bc~zyw3DIbIi0484004840eusmtip15;
        Mon, 22 Jul 2019 17:32:35 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] phy: core: document phy_calibrate()
Date:   Mon, 22 Jul 2019 19:32:23 +0200
Message-Id: <20190722173223.19518-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsWy7djPc7omn01jDQ4tNbDYOGM9q8WFpz1s
        Fpd3zWGzmHF+H5PFomWtzBZrj9xld2Dz6NuyitHj+I3tTB6fN8kFMEdx2aSk5mSWpRbp2yVw
        ZUy7OYelYBNnxZy7s1gbGG+xdzFyckgImEhM3nmRtYuRi0NIYAWjxK65z1kgnC+MEp8X3oPK
        fGaUWPhxGStMy/nOzUwQieWMEhMbTyO0bNiwlwmkik3AUKLrbRcbiC0i4CCxZOkdNpAiZoH1
        jBIrF38H2y4sYC4x4e9RMJtFQFWi988LRhCbV8BWYuW7WUwQ6+QlVm84wAzSLCGwh03i28of
        UHe4SExo+gVVJCzx6vgWqJdkJE5P7mGBaGhmlHh4bi07hNPDKHG5aQYjRJW1xOHjII9zAN2k
        KbF+lz5E2FFiTdt+dpCwhACfxI23giBhZiBz0rbpzBBhXomONiGIajWJWcfXwa09eOESVImH
        RPNcdZCwkECsRM+T5ywTGOVmIaxawMi4ilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzDi
        T/87/mkH49dLSYcYBTgYlXh4N+wxjRViTSwrrsw9xCjBwawkwptnABTiTUmsrEotyo8vKs1J
        LT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXAmNtpXhiw2+D63eMyIXE5zhFOpYx/
        Q5UUxW2i3N9GdbPPcPoWvu/r7gQ1o0tnH88/VfDX5vhGPgV11W9P8316WPwlmy+dkp8uH29w
        OyN9daS5pAz/qbhprz0FpzwNrv8c/OaLQKFfM0PaIXmjhRLnrpff90ncdksvj3lRiopol+Xs
        a0Elc/SVWIozEg21mIuKEwEGbCqh9AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsVy+t/xu7rGn01jDXY/NLfYOGM9q8WFpz1s
        Fpd3zWGzmHF+H5PFomWtzBZrj9xld2Dz6NuyitHj+I3tTB6fN8kFMEfp2RTll5akKmTkF5fY
        KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZUy7OYelYBNnxZy7s1gbGG+x
        dzFyckgImEic79zM1MXIxSEksJRRYvKZs2wQCRmJk9MaWCFsYYk/17rYIIo+MUrM3/YOLMEm
        YCjR9bYLrEFEwEmic+1psCJmgY2MEk93XmUESQgLmEtM+HsUbB2LgKpE758XYHFeAVuJle9m
        MUFskJdYveEA8wRGngWMDKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECA23bsZ+bdzBe2hh8
        iFGAg1GJh3fDHtNYIdbEsuLK3EOMEhzMSiK8eQZAId6UxMqq1KL8+KLSnNTiQ4ymQMsnMkuJ
        JucDoyCvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAMj08RpOdnM
        ht8Vs7mXrcucurDo/P0cbiFzr6kMs94stvv22k3t3KJdR+bum3HlbM6cvKJ1QcY8P840f4rI
        X1t06p707F1SjqfrZZWVH71LfpqxNyPQsmzOEWcbWZNvsam9yrqvq1b3L9vY5BaRLiQ8bS67
        8pQV/e8+Rr7Z8zb4MYOdgm2PvMIlJZbijERDLeai4kQA5ftaukoCAAA=
X-CMS-MailID: 20190722173236eucas1p171299dfaa34f3124622df488bfe57a89
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722173236eucas1p171299dfaa34f3124622df488bfe57a89
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722173236eucas1p171299dfaa34f3124622df488bfe57a89
References: <CGME20190722173236eucas1p171299dfaa34f3124622df488bfe57a89@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 36914111e682 ("drivers: phy: add calibrate method") added support
for generic phy_calibrate() method, but it didn't explain in detail when
such method is supposed to be called. Add some more documentation directly
to the phy.h to make it clean that it is intended to be called after every
host controller reset.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/phy/phy-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index e3880c4a15f2..b04f4fe85ac2 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -394,6 +394,16 @@ int phy_reset(struct phy *phy)
 }
 EXPORT_SYMBOL_GPL(phy_reset);
 
+/**
+ * phy_calibrate() - Tunes the phy hw parameters for current configuration
+ * @phy: the phy returned by phy_get()
+ *
+ * Used to calibrate phy hardware, typically by adjusting some parameters in
+ * runtime, which are otherwise lost after host controller reset and cannot
+ * be applied in phy_init() or phy_power_on().
+ *
+ * Returns: 0 if successful, an negative error code otherwise
+ */
 int phy_calibrate(struct phy *phy)
 {
 	int ret;
-- 
2.17.1

