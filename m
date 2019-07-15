Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C02BC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE492081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rsCMcmjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfGOMqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:46:45 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49766 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbfGOMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:45:00 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190715124458euoutp02d0852073bc153a7d433f9cf7cee8f15d~xlUvmWWdu0726607266euoutp02M
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:44:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190715124458euoutp02d0852073bc153a7d433f9cf7cee8f15d~xlUvmWWdu0726607266euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563194698;
        bh=oqtiqLW1OpVVmIG8M/apCby8iZ166UIVroisx7myTFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rsCMcmjTPXBqAathsD+jibOhjCPBJwT5YYsr/qXt0Bjevbo+7MQF2SE+cZP/+n5Kh
         D7O86K/pPkAqWgUyM+BBUkQXWEtg0kApQD3wg55B+UfP56CVLqNy9Zeau4o6asEIw9
         9P5pAuTzt7NXpGtuJZtYaa9rL2vYZm+VGDYW2SZE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190715124457eucas1p235fc48f3616a3b58afe7b68823d86f69~xlUusmWDk2241922419eucas1p2x;
        Mon, 15 Jul 2019 12:44:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9E.B0.04325.9457C2D5; Mon, 15
        Jul 2019 13:44:57 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190715124457eucas1p1b3033c2505581b350191eed7ba47bb40~xlUt4QqHG0572305723eucas1p1D;
        Mon, 15 Jul 2019 12:44:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190715124456eusmtrp14a8de5bf681a901a86c0201c8a957ab8~xlUtqNJ0x0488104881eusmtrp1f;
        Mon, 15 Jul 2019 12:44:56 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-e9-5d2c7549572d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 30.17.04140.8457C2D5; Mon, 15
        Jul 2019 13:44:56 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190715124455eusmtip2d458de21c2bf8a29d2db3d431264ff31~xlUs2cXHQ1115311153eusmtip2c;
        Mon, 15 Jul 2019 12:44:55 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, a.hajda@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v1 28/50] ARM: dts: exynos: change OPPs for g2d and g2d_acp
 buses in Exynos5420
Date:   Mon, 15 Jul 2019 14:43:55 +0200
Message-Id: <20190715124417.4787-29-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715124417.4787-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djPc7qepTqxBjNOqlrcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KC6blNSczLLUIn27BK6Ms1tqC85yV9w8zt7AeIqji5GTQ0LA
        ROLogo2MXYxcHEICKxglHv/dA+V8YZR40bqNGcL5zChxYPt5ZpiWB3PvQCWWM0qsnNjGBNdy
        6fAn1i5GDg42AT2JHasKQRpEBJYwShz5mQRSwyxwk0liz5OdrCAJYYFEiRsH94DZLAKqEnPX
        t7KB2LwC9hJvz+9lg9gmL7F6wwGwzZxA8Z/TLrCBDJIQuMQusXf5XEaQZRICLhIn1jlB1AtL
        vDq+hR3ClpE4PbmHBcIulmjoXcgIYddIPO6fC1VjLXH4+EWwm5kFNCXW79KHCDtKPLu5iwli
        Op/EjbeCIGFmIHPStunMEGFeiY42IYhqDYktPReYIGwxieVrpkEN95C4dnMxGyR0JgHDcMkW
        tgmM8rMQli1gZFzFKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmKRO/zv+dQfjvj9JhxgF
        OBiVeHgdUrRjhVgTy4orcw8xSnAwK4nw2n4FCvGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQ
        LSSQnliSmp2aWpBaBJNl4uCUamAs2nbkQsHTLXqzVR6VXHsxt+Fdicjq6t13rnoU8bEZJu2o
        fC69UK5u7Y4Z8VHmS5vWP2XQi0somvJijyFPyHux4PsKUYdXBi27+c3n/NtGH4P6RwoSTSFz
        nbvb7/89t3SLa97ZDp5OppeP1PZ0TFwnajJjZqL3750Fpbe3/aoPf3hv68qrUZfeKLEUZyQa
        ajEXFScCAP1avbxOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xe7oepTqxBtNn6VjcWneO1WLjjPWs
        Fte/PGe1mH8EyO1//JrZ4vz5DewWZ5vesFvcapCx2PT4GqvFx557rBaXd81hs5hxfh+Txdoj
        d9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWB2GPNfPWMHq8v9HK7rFpVSebx+Yl
        9R4H3+1h8ujbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2Ms1tqC85yV9w8zt7AeIqji5GTQ0LAROLB3DvMILaQwFJGiTV/hCHi
        YhKT9m1nh7CFJf5c62LrYuQCqvnEKNE38xJrFyMHB5uAnsSOVYUgNSICKxglJp/wBqlhFnjN
        JHHk6DtWkISwQLzEhktnmUBsFgFVibnrW9lAbF4Be4m35/eyQSyQl1i94QDYEZxA8Z/TLrBB
        HGQnsfjoT6YJjHwLGBlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbNtmM/t+xg7HoXfIhR
        gINRiYfXIUU7Vog1say4MvcQowQHs5IIr+1XoBBvSmJlVWpRfnxRaU5q8SFGU6CjJjJLiSbn
        AyM6ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDI+e9Y97dWUcj
        TirEt4Xt+/LuB0PG5byjL45vq9HbnzcjpuXHtcm+IrPzzV9vuLp099IErgxHgVWf2zoVT6/I
        uXztrlHa9N3vTr1dsvmm+CXPMpfsLgN2dZ2GCT0rIjn+iT12CHfefIO38lrhtLfVK+53Ost9
        K3tmu+z7HSZru70Mk3x3v1nUl6TEUpyRaKjFXFScCAAkk+y8sAIAAA==
X-CMS-MailID: 20190715124457eucas1p1b3033c2505581b350191eed7ba47bb40
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190715124457eucas1p1b3033c2505581b350191eed7ba47bb40
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190715124457eucas1p1b3033c2505581b350191eed7ba47bb40
References: <20190715124417.4787-1-l.luba@partner.samsung.com>
        <CGME20190715124457eucas1p1b3033c2505581b350191eed7ba47bb40@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the frequencies in OPPs to values which are possible to set using
a divider and parent clock rate. Keep the OPP number in the table equal
or less to the number in bus_wcore (any higher OPPs would not be set).

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index a355c76af5a5..3a128cd717e2 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1216,7 +1216,7 @@
 			compatible = "operating-points-v2";
 
 			opp00 {
-				opp-hz = /bits/ 64 <84000000>;
+				opp-hz = /bits/ 64 <110000000>;
 			};
 			opp01 {
 				opp-hz = /bits/ 64 <167000000>;
@@ -1225,9 +1225,6 @@
 				opp-hz = /bits/ 64 <222000000>;
 			};
 			opp03 {
-				opp-hz = /bits/ 64 <300000000>;
-			};
-			opp04 {
 				opp-hz = /bits/ 64 <333000000>;
 			};
 		};
@@ -1236,16 +1233,16 @@
 			compatible = "operating-points-v2";
 
 			opp00 {
-				opp-hz = /bits/ 64 <67000000>;
+				opp-hz = /bits/ 64 <100000000>;
 			};
 			opp01 {
-				opp-hz = /bits/ 64 <133000000>;
+				opp-hz = /bits/ 64 <150000000>;
 			};
 			opp02 {
-				opp-hz = /bits/ 64 <178000000>;
+				opp-hz = /bits/ 64 <200000000>;
 			};
 			opp03 {
-				opp-hz = /bits/ 64 <267000000>;
+				opp-hz = /bits/ 64 <300000000>;
 			};
 		};
 
-- 
2.17.1

