Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3006C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8909720684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SIfYRBgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfCEKTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:19:49 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54951 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbfCEKTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:19:31 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190305101929euoutp01979136688fd46fb251a585160aee2333~JCMCejbns0639506395euoutp01B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2019 10:19:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190305101929euoutp01979136688fd46fb251a585160aee2333~JCMCejbns0639506395euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551781170;
        bh=xc/7rUEXW34l1G+b9ZoYdMgZh6gwNaSaXuTTk1vzFfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SIfYRBgGgnXs9o+dkkCm99YfjvAXVJR8QUwkbJmJ+iajCAmJBGeTZlOwPB87o7H3w
         UVcVN3h+GNuMwJwgYlv2ECSHZAWMU8uBRe/ZCWJAPxxF+dGG+7LOJh6hIauG51ZjIa
         uAkpAfp6RusBtsw5DLPvZl6LjFdnIJfU3Y//pxTw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190305101929eucas1p2da611df642b0d9f28b73e8440499af95~JCMCCEcBu3166131661eucas1p2N;
        Tue,  5 Mar 2019 10:19:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 47.4F.04441.13D4E7C5; Tue,  5
        Mar 2019 10:19:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190305101928eucas1p2032dea7512be3d57618842d65e67bc8f~JCMBVzE-A2248922489eucas1p28;
        Tue,  5 Mar 2019 10:19:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190305101928eusmtrp2ab5170725a23b2c09f001812da6076af~JCMBByv5U2083020830eusmtrp2E;
        Tue,  5 Mar 2019 10:19:28 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-0f-5c7e4d319d47
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0D.1F.04128.03D4E7C5; Tue,  5
        Mar 2019 10:19:28 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190305101927eusmtip14947d7927686c75876d5777e4f0804ef~JCMAbjwcq3045130451eusmtip1m;
        Tue,  5 Mar 2019 10:19:27 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v5 7/8] drivers: devfreq: events: add Exynos PPMU new events
Date:   Tue,  5 Mar 2019 11:19:10 +0100
Message-Id: <1551781151-5562-8-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djPc7qGvnUxBot7BSw2zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdouzTW/YLW41yFhc3jWHzeJz7xFGixnn9zFZrD1yl93iduMKNovD
        b9pZHXg9Nq3qZPM4+G4Pk0ffllWMHp83yQWwRHHZpKTmZJalFunbJXBl3Fo0hb3gHVvF2uNr
        GBsY37N2MXJySAiYSKzcfpKli5GLQ0hgBaNE05dOVgjnC6PE164FjBDOZ0aJaw2T2GBaTt2Y
        CVW1nFHiX9tVFriWc1OfAzkcHGwCehI7VhWCNIgIVEvcub6fGaSGWeAto8TMm19YQBLCAj4S
        5w82gtksAqoSfYs/gG3gFfCU6Lx7gRFim5zEzXOdzCA2p4CXxP6F68EGSQhMZpf4uBYiISHg
        IvH1x3UWCFtY4tXxLewQtozE/53zmSDsYomzHaugXqiRaD+5A6rGWuLw8YusIEczC2hKrN+l
        DxF2lGh8e5gNJCwhwCdx460gSJgZyJy0bTozRJhXoqNNCKJaQ2JLzwWoRWISy9dMY4co8ZC4
        Oj0CEjpzGSW67/xjnsAoPwth1wJGxlWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBKeX0
        v+OfdjB+vZR0iFGAg1GJhzfDrDZGiDWxrLgy9xCjBAezkgjvH/G6GCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK81QwPooUE0hNLUrNTUwtSi2CyTBycUg2MXBYuv0umFda3yrF2n75udpyp3PXW
        41lu259U+yW/EO01ZfdZdf9O+GVWUc5FMdU/HLpT7nmu37xpTV7aLBMHv8b7Z9QlrwmpPFb9
        VcFcoHPMVmXer8BNdr3rHvOUepwOMGV0WrDgYLrcshfcJ2Sy7x6fc7v0yDTBIKXGAnX3dLFF
        8a9dq4uVWIozEg21mIuKEwGoP3rUJQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsVy+t/xu7oGvnUxBpPmSVhsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgidKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx
        1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuLVoCnvBO7aKtcfXMDYwvmftYuTkkBAwkTh1YyaQ
        zcUhJLCUUWL+nGtQCTGJSfu2s0PYwhJ/rnWxQRR9YpTY9Oc9SxcjBwebgJ7EjlWFIDUiAvUS
        /W8ugdUwC3xnlDj0ZAIjSEJYwEfi/MFGFhCbRUBVom/xBzYQm1fAU6Lz7gVGiAVyEjfPdTKD
        2JwCXhL7F64Hs4WAaqZ+XcgygZFvASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMAg33bs
        55YdjF3vgg8xCnAwKvHwZpjVxgixJpYVV+YeYpTgYFYS4f0jXhcjxJuSWFmVWpQfX1Sak1p8
        iNEU6KiJzFKiyfnACMwriTc0NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2aWpBaBNPHxMEp
        1cAou8Ojwb2jSCLv8tRn1neMww49ief3Yf6Q6hUdLSd3dv0cN6bomg4NvieL5C8mrSximB0u
        sZ7hZWSgs9V6hu0r1kZbNRScfFq7X2Ri1BHJ+eVpDAHqDs37521nC1CO3rHvj8O8/dynWDfd
        c50eesXq6rHoT8q1xx4c/MQxwShgi03G090b++8rsRRnJBpqMRcVJwIAymK8+YgCAAA=
X-CMS-MailID: 20190305101928eucas1p2032dea7512be3d57618842d65e67bc8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190305101928eucas1p2032dea7512be3d57618842d65e67bc8f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190305101928eucas1p2032dea7512be3d57618842d65e67bc8f
References: <1551781151-5562-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190305101928eucas1p2032dea7512be3d57618842d65e67bc8f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new performance events supported by Exynos5422 SoC counters.
The counters are built-in in Dynamic Memory Controller and provide
information regarding memory utilization.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index c61de0b..67d6674 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -89,6 +89,12 @@ static struct __exynos_ppmu_events {
 	PPMU_EVENT(d1-cpu),
 	PPMU_EVENT(d1-general),
 	PPMU_EVENT(d1-rt),
+
+	/* For Exynos5422 SoC */
+	PPMU_EVENT(dmc0_0),
+	PPMU_EVENT(dmc0_1),
+	PPMU_EVENT(dmc1_0),
+	PPMU_EVENT(dmc1_1),
 };
 
 static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
-- 
2.7.4

