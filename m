Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80641C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EC4206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tfSz93eG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfEFNA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 09:00:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49285 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfEFNA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:00:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190506130053euoutp01e8ed9b968e78be2de6a5fb358ea574bb~cGYpqJLtZ1351013510euoutp018;
        Mon,  6 May 2019 13:00:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190506130053euoutp01e8ed9b968e78be2de6a5fb358ea574bb~cGYpqJLtZ1351013510euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557147653;
        bh=Q6MAYfpfyHu8aSZ3bUWW5jR63Rk5nop3PVjLGiZRUjw=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=tfSz93eGaCltC1t36KDopuaXIpUVAhXzIXFgaOuewyYMxCVu009Pvhw5XZEsvdmXv
         RwYi82g1uRDVOfijLT3LCGRYpjbhF6ACUrLKHBDzneSgnEtyGbv7BPzxZ2NjXzBCZ2
         8aI8Sha0wQgmvx1NfrktjQNnN7jgsvRTV9/FJ8Nw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190506130053eucas1p1eb3544a522d9225357c5d719ce96cdba~cGYpRpE8o2766527665eucas1p1c;
        Mon,  6 May 2019 13:00:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B7.D2.04377.40030DC5; Mon,  6
        May 2019 14:00:52 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190506130052eucas1p25afd4e15648e9efc6fd011e46081fbea~cGYopf_4e2185021850eucas1p2F;
        Mon,  6 May 2019 13:00:52 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-96-5cd030041958
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6F.7B.04140.40030DC5; Mon,  6
        May 2019 14:00:52 +0100 (BST)
Received: from AMDC2765.DIGITAL.local ([106.120.51.73]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PR300JEW2TC4H40@eusync4.samsung.com>;
        Mon, 06 May 2019 14:00:52 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] usb: dwc2: Force 8bit UTMI width for Samsung Exynos SoCs
Date:   Mon, 06 May 2019 15:00:46 +0200
Message-id: <20190506130046.20898-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190503204958.GA12532@kozik-lap>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7djP87osBhdiDNoP61lsnLGe1WL+zSSL
        xl972S1mzTjNanH+/AZ2i8u75rBZzDi/j8li0bJWZou1R+6yO3B6nF5/k9Fj06pONo95JwM9
        +rasYvTYsv8zo8fnTXIBbFFcNimpOZllqUX6dglcGfs3TWUv2MZW8WLRSaYGxq2sXYycHBIC
        JhIT5/5m72Lk4hASWMEo0dX9nBnC+cwo8eTQTCaYqhMHDjBCJJYxSqzueA9V9Z9R4tSDl8wg
        VWwChhJdb7vYQGwRgQSJI5vfg8WZBfqYJO63a4LYwgKeEmvXfQGrYRFQlZh2+jbYHbwCthLn
        Jy1hgdgmL7F6wwGwXk4BfYldCyaygSyTEJjDJnHr3Cx2iCIXiWev70I1yEhcntzNAlHUzCjx
        8Nxadginh1HictMMRogqa4nDxy+yQpzEJzFp23SgFRxAcV6JjjYhiBIPiWdH+lkgXmtilOht
        WsE6gVFiASPDKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMA4PP3v+JcdjLv+JB1iFOBg
        VOLhXaByPkaINbGsuDL3EKMEB7OSCG/is3MxQrwpiZVVqUX58UWlOanFhxilOViUxHmrGR5E
        CwmkJ5akZqemFqQWwWSZODilGhjV6iqfbvr5faKvrVONe81qS1E9LjYO36Yz3z+pnjgruf+1
        wISpx7L6bG46fVwfOcHSPFb7jd4tgzKz0O9d7/eX3v6XcfL1//hNUzkfHjF9evpkUcq1VUd3
        WR/co3j+mCn/ZOuMU+/CVk9uL05Rrf3RoXS/6dpuqcUK2RnXtwXF7eO6kunUW39TiaU4I9FQ
        i7moOBEA3NNlX78CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKLMWRmVeSWpSXmKPExsVy+t/xa7osBhdiDHbdYLXYOGM9q8X8m0kW
        jb/2slvMmnGa1eL8+Q3sFpd3zWGzmHF+H5PFomWtzBZrj9xld+D0OL3+JqPHplWdbB7zTgZ6
        9G1ZxeixZf9nRo/Pm+QC2KK4bFJSczLLUov07RK4MvZvmspesI2t4sWik0wNjFtZuxg5OSQE
        TCROHDjA2MXIxSEksIRRYvnkFawQTiOTxMMjjxlBqtgEDCW63naxgdgiAgkSS95uZgcpYhaY
        wCSx58xjsISwgKfE2nVfwGwWAVWJaadvg63gFbCVOD9pCQvEOnmJ1RsOMIPYnAL6ErsWTASr
        FxLQk9h7qYllAiPPAkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGBte3Yzy07GLveBR9i
        FOBgVOLh9VA6HyPEmlhWXJl7iFGCg1lJhDfx2bkYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwd
        AgdjhATSE0tSs1NTC1KLYLJMHJxSDYxaPqsrWh5MvPHds3s774XLejmTzqq22287WlsUZns3
        dsXtfeksXOG7Z22b7nCuSKvt2q0Jly5e8T4z2X5SUXzwu/Xrl3323S3NKS45c+/v1c1ivy+Y
        8EZOaMqIUkkLLXzDzPhGue/oHH5pEXMRKc7gNdNbN59476ISr3dVJ0/zcEiqg65r0WElluKM
        REMt5qLiRABxH+vCKAIAAA==
X-CMS-MailID: 20190506130052eucas1p25afd4e15648e9efc6fd011e46081fbea
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506130052eucas1p25afd4e15648e9efc6fd011e46081fbea
References: <20190503204958.GA12532@kozik-lap>
        <CGME20190506130052eucas1p25afd4e15648e9efc6fd011e46081fbea@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samsung Exynos SoCs require to force UTMI width to 8bit, otherwise the
host side of the shared USB2 PHY doesn't work.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: 707d80f0a3c5 ("usb: dwc2: gadget: Replace phyif with phy_utmi_width")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/usb/dwc2/params.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 6900eea57526..9ece4affb9d4 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -76,6 +76,7 @@ static void dwc2_set_s3c6400_params(struct dwc2_hsotg *hsotg)
 	struct dwc2_core_params *p = &hsotg->params;
 
 	p->power_down = 0;
+	p->phy_utmi_width = 8;
 }
 
 static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
-- 
2.17.1

