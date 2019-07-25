Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C7EC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19ADD2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l3CmL7z5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388376AbfGYOnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:43:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50416 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387518AbfGYOna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:43:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190725144329euoutp01a9cb3761a881c6e209bca1450755c764~0rZEHqR_52885228852euoutp01F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 14:43:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190725144329euoutp01a9cb3761a881c6e209bca1450755c764~0rZEHqR_52885228852euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564065809;
        bh=uK2H2CY5YVkbPXh3EKmhTQmAPpi5mTFt1H3u7NFbf9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3CmL7z5bfrmJYcEou3jU5iLykE3lf99gkqAe+zrhRbXmuVgqy9DVVhJYWp6K0kSZ
         xOooHnS/10uAaNbvqCE8vhYUh1NU0KLc5ph1u4A7dPn5B412w6So2OjI9SgrqAWV0r
         CUGHIzGC1xKBfFjW8/Kt5HhfM2MeTDSvDr8Rw1Lc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190725144328eucas1p1a52860f55a3f5f69ef6fb86d25e20561~0rZDZoq2F0145701457eucas1p1I;
        Thu, 25 Jul 2019 14:43:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8E.CA.04377.F00C93D5; Thu, 25
        Jul 2019 15:43:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190725144327eucas1p1c799f61c7ff5c926002c4da846c048a6~0rZCqt6pJ2619726197eucas1p1f;
        Thu, 25 Jul 2019 14:43:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190725144327eusmtrp11adc7a58e2e33ee9de97d84a1c7527cd~0rZCcnnlg0724307243eusmtrp1F;
        Thu, 25 Jul 2019 14:43:27 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-98-5d39c00f84a9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B0.3E.04146.F00C93D5; Thu, 25
        Jul 2019 15:43:27 +0100 (BST)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190725144326eusmtip1e790de2bfdd22725206e38e615e047fd~0rZBqWG_I0248702487eusmtip1F;
        Thu, 25 Jul 2019 14:43:26 +0000 (GMT)
From:   k.konieczny@partner.samsung.com
To:     k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v4 4/5] dt-bindings: devfreq: exynos-bus: remove unused
 property
Date:   Thu, 25 Jul 2019 16:42:59 +0200
Message-Id: <20190725144300.25014-5-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190725144300.25014-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHd3bv3b1Kq7tpeNCynBQmmSVBZyTRky5RYEH/FKErbypuU3db
        ZgX56Klp9nROUwstW1PnfGSmZms4a+l8kBk+EMokUyGUKClt27XHf5/z/X1/Tw6FSQcJXypO
        fYLVqBVKmcgTr2/74QhZ0io/sv7BWzmq1lUR6N3MGIGKrZ0EymmZB+jahy8YcjhMJOpInyCR
        +UMfgXobC0VoOtsKkM7RIkQV1iESlb3rFqKBtHIRmvjeIUQXmq0kmuurxlHNSJtoq5QxFhkB
        YzZcETE1peeYF1NNQian1gAYW/8TITNt9o8gD3mGR7PKuJOsJnRLlGds5dO9iUPUqTvNxUQq
        eElmAg8K0hth5+ViPBN4UlK6HMD+yTuAf8wAmGsaJVwuKT0N4Pin438yunofi3jTQwCzqr4J
        /2Y8mnrtriuiV8Fa3Wc3e9OB8OZwHuYyYfQPHJp6q90BL/oAdNzvAC7GnQlmY6uzLEWJ6Z3w
        fc1SvtsKeKXhGe5iD3oX/JVW4baLaQl8lf/RrWNOT0ZdAcb7J0nYXC7heSdML7WLePaC47ba
        hZ2XQfvNqzjPyXD0Xg7pmg3S5wEcufR1IbAZvrR1E655MHoNrGoM5eVtsG+sHnPJkF7sPJeE
        H2ExvFGftyCL4eWLUt4dAovm3xA8+8HM+coFZmDGt24yFwTo/1tG/98y+n99SwBmAD6sllPF
        sFyYmk1exylUnFYds+5YgsoMnH/OPmebaQCNP49aAE0B2SJxkEF+REooTnIpKguAFCbzFtc1
        OCVxtCLlNKtJiNRolSxnAX4ULvMRnxGMHJbSMYoTbDzLJrKaP1Eh5eGbCkr3mbZ7CJRl6aA9
        zEf7PGrPWW2Kf2RW6+xK2x5xe0lTX1KP9m1X/RP5jvztganLjXfTi28LtNlZ3G6NbBBvH066
        FSSYd3w5qPfTlxvkq4f29+wYXt6gCY4P0EWuvW7Mb2IMlnDjcJhdWhh4Sl1QJ4zoHxiUpFG5
        q6NnYYh9kwznYhUbgjENp/gN6P5AZ28DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xu7r8ByxjDe6+5LDYOGM9q8X1L89Z
        LeYfOcdq0bfvP6NF/+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3
        WHr9IpPF7cYVbBZvfpxlsmjde4Td4t+1jSwWmx8cY3MQ8lgzbw2jx6ZVnWwem5fUexx8t4fJ
        o2/LKkaP4ze2M3l83iQXwB6lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRv
        Z5OSmpNZllqkb5egl7Fup0/BXY6KaXvnszYwHmbvYuTkkBAwkbhweTVbFyMXh5DAUkaJ+Vv2
        MkEkpCUaT6+GsoUl/lzrgir6xCgxd8sFNpAEm4CqxJYZL8EmiQgoS0y+N50ZpIhZoJNVYsWT
        I0BFHBzCAgESd04UgdSwANVvWnMALMwr4CJxc7MoxHx5ic4du1lAbE4BV4m/jWsZQWwhoJLG
        /mNgNq+AoMTJmU/AapiB6pu3zmaewCgwC0lqFpLUAkamVYwiqaXFuem5xYZ6xYm5xaV56XrJ
        +bmbGIERue3Yz807GC9tDD7EKMDBqMTDe2G5ZawQa2JZcWXuIUYJDmYlEd6tO4BCvCmJlVWp
        RfnxRaU5qcWHGE2BfpjILCWanA9MFnkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NT
        C1KLYPqYODilGhgntx/pFYt/tCqhcZ37tjan2T+F+Z8LzI8O2Pfi9pmYTRXBMQnBngn7nP9G
        tvJzaPW+5LVNWbhP9f/fedsYHbgMLy/QeHWfJTzkHGfzCbumVYs+ymzWc11/tc9jlu2yn08C
        RTfUbjVlFLgyoWnP7ktPPp5q+qV3cWX9O/4pl1Yopn86bLtDeNN+JZbijERDLeai4kQAZmtr
        vt4CAAA=
X-CMS-MailID: 20190725144327eucas1p1c799f61c7ff5c926002c4da846c048a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190725144327eucas1p1c799f61c7ff5c926002c4da846c048a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190725144327eucas1p1c799f61c7ff5c926002c4da846c048a6
References: <20190725144300.25014-1-k.konieczny@partner.samsung.com>
        <CGME20190725144327eucas1p1c799f61c7ff5c926002c4da846c048a6@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused DT property "exynos,voltage-tolerance".

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 Documentation/devicetree/bindings/devfreq/exynos-bus.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index f8e946471a58..e71f752cc18f 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -50,8 +50,6 @@ Required properties only for passive bus device:
 Optional properties only for parent bus device:
 - exynos,saturation-ratio: the percentage value which is used to calibrate
 			the performance count against total cycle count.
-- exynos,voltage-tolerance: the percentage value for bus voltage tolerance
-			which is used to calculate the max voltage.
 
 Detailed correlation between sub-blocks and power line according to Exynos SoC:
 - In case of Exynos3250, there are two power line as following:
-- 
2.22.0

