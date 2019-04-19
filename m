Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C888C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A5520645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WLbnphCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfDSTJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:09:25 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54680 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbfDSTHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:07:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190419141952euoutp02fce2867a2c3e9427a05805d1e8d77256~W5fwjzBoW2305123051euoutp02Q
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:19:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190419141952euoutp02fce2867a2c3e9427a05805d1e8d77256~W5fwjzBoW2305123051euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555683592;
        bh=8KYk6Wu+VGNS7Bd7ddkeqgSBm1dne421Ukn42iWD658=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WLbnphCbLiCVYnyce1U6dc8UKMPjVRqL6elAPYZyN6yRPCtLemYR6RR0vvmKYHwC6
         ErDr5Vo7Ep75RyOddS6bU42iphlKOLiAcjtTRdXAhQmypcjtdfYWTygh2ugL+JXJHy
         WOw4X1EsY7jAnjfMddmapTdg9sZEbmQFI/dQyhQw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190419141951eucas1p28b8df2ee819b1342ab760adab7646ebf~W5fv4YelW2300423004eucas1p2s;
        Fri, 19 Apr 2019 14:19:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6B.72.04298.709D9BC5; Fri, 19
        Apr 2019 15:19:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190419141950eucas1p2e810215d1ceaf75fc9e807bbaa78e003~W5fvMYqjt2099920999eucas1p27;
        Fri, 19 Apr 2019 14:19:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190419141950eusmtrp1c09ee400302e83a3a4a1f42076deaed5~W5fu_UazO1759317593eusmtrp1h;
        Fri, 19 Apr 2019 14:19:50 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-2d-5cb9d907d17d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DF.02.04146.609D9BC5; Fri, 19
        Apr 2019 15:19:50 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190419141949eusmtip2aed1e8d2298b4e5f78ccba4496794f84~W5ft_p8qf2872728727eusmtip2U;
        Fri, 19 Apr 2019 14:19:49 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v6 08/10] drivers: devfreq: events: add Exynos PPMU new
 events
Date:   Fri, 19 Apr 2019 16:19:26 +0200
Message-Id: <1555683568-20882-9-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTURSGvZ3pzLSxZCxGbhDR1GhcIkvCw3UJkcSHSX3xwQejJFhhAmhb
        oQMq4kMRXBAqShNBRRDrggVBoGmg0VpLYw20ZRNZq0aUGmQJVAhoMFKm6tt///Od85+cXAqT
        OoThVLo6i9WoFUoZIcbNbxY9u8jB1sQYW3UYaixvEKL+Hz4hqnJ4hKh2ZhQgffs9AXIVqVDJ
        6HcMdXY+J5H74gSJhrQRqNdSQSC/zgFQeadVgJ45vCQazqshUNvEFSF69U6Ohn+FoPm3n8H+
        UGZ+rhRn7mq7cab1jpdkmoyFBKPLnyKY11MvBMx1kxEwzR25jL8p8pDoqHhfCqtMP8NqouOP
        i9OsPXlExhRxzmA3EVowLbwGRBSk46Cr2QWuATElpWsArMjvwfnHDwBnLJVYgJLSfgAnC7C/
        HZ5LL4Q89ATAK4992L+Oae3X5QpFEXQUbDFmBhrW0rlwpP/VCoPREwLo/rmABwqh9CHof/Ac
        D/A4vQVa6zYHbAkth+O6WQEfFgkHPYUrwSL6ILQ8NRGBOZD+QMKBh06Shw5AY21DUIfCcacp
        qCNgh74Y5zUHtbpqwOsLcLTkXpDZC9uc3Ss7Y/R22GCJ5u0EaC4qEwRsSIfAgck1ARtblqXm
        Moy3JfDqZSlPb4Om4q7gxuvgk7pbweEMnGx3k/x1KgF8POQmb4CNd/6H3QfACMLYbE6VynKx
        avZsFKdQcdnq1Kjk06omsPy3On47Z1vAXM8JO6ApIFstsZW2JkqFijNcjsoOIIXJ1koSUkyJ
        UkmKIuc8qzmdpMlWspwdrKdwWZgkd9WnY1I6VZHFnmLZDFbztyqgROFaoEdd6xa2RhY0biL3
        fNz31R51t8U21nZk9vjNNNugr09V71lTZnBl7K+PK2qsuf6oPXNJ/rQ8Iu6Wz1uFVcsOvO+b
        9p5Mvn3ZOqL3jhmSwhdiMd0ICHnZa0rYXvjWkeekNsybdxt2fov3xXwBi4YZbClrTut1yCsO
        U2yF0vVJhnNpitgdmIZT/AEBClIKVwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7psN3fGGEw4L2WxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7jVIGNxedccNovPvUcYLWac
        38dksfbIXXaL240r2CwOv2lntdh/xcvi9m8+i28nHjE6CHt8+zqJxWN2w0UWj52z7rJ7bFrV
        yebR2/yOzePguz1MHn1bVjF6bD5d7fF5k1wAZ5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexr5LjWwF79gqFh/awtbA+J61i5GTQ0LAROJc6x4g
        m4tDSGApo8SUFcuZIBJiEpP2bWeHsIUl/lzrYoMo+sQoMeH/UpYuRg4ONgE9iR2rCkFqRATq
        JfrfXAKrYRZoYJZYs/0q2AZhAT+JJWfusYHUswioSuxbowwS5hXwknjV+wlql5zEzXOdzCA2
        p4C3xK6VW9hAbCGgmg3X9jJNYORbwMiwilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzCSth37
        uXkH46WNwYcYBTgYlXh4D0zaGSPEmlhWXJl7iFGCg1lJhNcxZUuMEG9KYmVValF+fFFpTmrx
        IUZToJsmMkuJJucDozyvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwen
        VAMji+G+qeu/TLovXRiwetl3ptmdrMaFf5ne9no7q9/ca/0gRDjvTnH1jvPF+8wtQpys+DY/
        Tgp1kMlfZ5fwsXviol9P2fyXWJ/kyk/Q5umeEVHTxiItMi/s2Jy38m3li3ISrfnmB7DtNS7m
        KGg49bw6J+i7aWHov9T/z9V9dvudXlZ29/Vlth9KLMUZiYZazEXFiQBlbPxFugIAAA==
X-CMS-MailID: 20190419141950eucas1p2e810215d1ceaf75fc9e807bbaa78e003
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141950eucas1p2e810215d1ceaf75fc9e807bbaa78e003
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141950eucas1p2e810215d1ceaf75fc9e807bbaa78e003
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419141950eucas1p2e810215d1ceaf75fc9e807bbaa78e003@eucas1p2.samsung.com>
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
index 073bf2c..dca97ca 100644
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

