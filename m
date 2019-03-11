Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A77AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C5F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pb4ws1/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfCKPu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:50:27 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:39362 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbfCKPu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:50:26 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190311155024epoutp03cf6a6576f4b780eea4a7ab502597fb57~K8kqtpXU52089620896epoutp03y;
        Mon, 11 Mar 2019 15:50:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190311155024epoutp03cf6a6576f4b780eea4a7ab502597fb57~K8kqtpXU52089620896epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552319424;
        bh=PWweXdHeQM230BkQfb3/K3K5eqh6ahnLgxB7l3qawts=;
        h=From:To:Cc:Subject:Date:References:From;
        b=pb4ws1/hpdyarrRKizbrBUwlxr90iFyzYoykTQe3ihFXZALnl9PqS1v0FXNBzqOf+
         BqZ3xprrU7ahdtm30bKPGYnKJorRYCD4ZWHdC4oSkQ4z2HpLHbY8R4MvdRGhYp313m
         m3Y/yn04tZVanrnOWCy1tuTM3PavAAjjlmq23g8U=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190311155023epcas2p182d0fd723d59d80adeb7cabc3f7f56e1~K8kqggj0Z0843208432epcas2p1X;
        Mon, 11 Mar 2019 15:50:23 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.A6.04206.FB3868C5; Tue, 12 Mar 2019 00:50:23 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190311155023epcas2p428a025925f6442554b50e14e328a6d04~K8kqOgVyL2161821618epcas2p4O;
        Mon, 11 Mar 2019 15:50:23 +0000 (GMT)
X-AuditID: b6c32a47-133ff7000000106e-f6-5c8683bf8f3a
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.4A.03620.FB3868C5; Tue, 12 Mar 2019 00:50:23 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PO700GYHLBQEV60@mmp1.samsung.com>; Tue, 12 Mar 2019
        00:50:23 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        stable@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: Fix audio (microphone) routing on Odroid
 XU3
Date:   Mon, 11 Mar 2019 16:50:12 +0100
Message-id: <20190311155012.15797-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCmqe7+5rYYg73HTC02zljPajH/yDlW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWcw4v4/JYu2Ru+wWrXuPsFscftPOarFg4yNGB26PTas6
        2Tw2L6n36NuyitHj8ya5AJYoLpuU1JzMstQifbsEroyn+zayFvxiq+j5PY+9gfENaxcjJ4eE
        gInEgffnGUFsIYEdjBI7r6V3MXIB2d8ZJTo7vrDAFHV+uswGkdjNKLG8sZcRwvnFKLH2+3qw
        KjYBQ4neo31go0QEhCXuLV3ODlLELLCGSWLe2bdgCWGBQImXu74zgdgsAqoSf2Y0gTXzClhL
        /DpwHmqdvMTqDQeYQZolBBrZJPY9vgA0iQPIcZF415cIUSMt8WzVRkaImmZGiR3Pr7FDOBMY
        JSbMmcwGUWUtcfj4RbBPmQX4JDoO/4UaxCvR0SYEUeIhMWlvOyskAGIlft68wTqBUXwBI8Mq
        RrHUguLc9NRiowJjveLE3OLSvHS95PzcTYzgWNNy38G47ZzPIUYBDkYlHl6H4rYYIdbEsuLK
        3EOMEhzMSiK8eVVAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwPpedGCwmkJ5akZqemFqQWwWSZ
        ODilGhh3X8vfp8x2xHO92CenBJMfJ3YFuFe3PXPgbk346yEs5tdQ5s7ymKnqgEso95KazfnR
        huET+y9M7Dec8GCx22ttxsdaaTl27zi1JhR5tN0p3DurtEVO15Tt0swFOzdYdRrP9Njd3/v4
        tgzLzqNHpstK7DTYkD57wja5x3pvl3baWs2adOZ8ipASS3FGoqEWc1FxIgBZ7/bdsQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpiluLIzCtJLcpLzFFi42I5/e+xgO7+5rYYg7tPFCw2zljPajH/yDlW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWcw4v4/JYu2Ru+wWrXuPsFscftPOarFg4yNGB26PTas6
        2Tw2L6n36NuyitHj8ya5AJYoLpuU1JzMstQifbsEroyn+zayFvxiq+j5PY+9gfENaxcjJ4eE
        gIlE56fLbF2MXBxCAjsZJY50vGSHcH4xSiyddZgdpIpNwFCi92gfI4gtIiAscW/pcrA4s8Aa
        JolvTZIgtrCAv8Sex1fB4iwCqhJ/ZjSxgNi8AtYSvw6cZ4HYJi+xesMB5gmMXAsYGVYxSqYW
        FOem5xYbFRjlpZbrFSfmFpfmpesl5+duYgSGzLbDWv07GB8viT/EKMDBqMTD+6KgLUaINbGs
        uDL3EKMEB7OSCG9eFVCINyWxsiq1KD++qDQntfgQozQHi5I4L3/+sUghgfTEktTs1NSC1CKY
        LBMHp1QD4+FwPSev9ZtPvzrZfkcxvfqaN3NpusGhjWd+nvshGnvq3zJzZt+HmdOT+A90Xd17
        4GlxZ/ukr9FnXP4FxyVeypDXF5xx8ZTen2WiVtJ3F3E21oheYr8j9Vnqb0aoXHFe0cto1+n3
        GRiDE88Y+76axGjxdPelu68E76+KWcybt9QrmUk87oHObSWW4oxEQy3mouJEAMkOQtcVAgAA
X-CMS-MailID: 20190311155023epcas2p428a025925f6442554b50e14e328a6d04
CMS-TYPE: 102P
X-CMS-RootMailID: 20190311155023epcas2p428a025925f6442554b50e14e328a6d04
References: <CGME20190311155023epcas2p428a025925f6442554b50e14e328a6d04@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of CODEC input widget to which microphone is connected through
the "Headphone" jack is "IN12" not "IN1". This fixes microphone support
on Odroid XU3.

Cc: <stable@vger.kernel.org> # v4.14+
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
index e84544b220b9..b90cea8b7368 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
@@ -22,7 +22,7 @@
 			"Headphone Jack", "HPL",
 			"Headphone Jack", "HPR",
 			"Headphone Jack", "MICBIAS",
-			"IN1", "Headphone Jack",
+			"IN12", "Headphone Jack",
 			"Speakers", "SPKL",
 			"Speakers", "SPKR";
 
-- 
2.17.1

