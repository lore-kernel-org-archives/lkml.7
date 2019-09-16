Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F464C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74832216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rdaXra6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbfIPKHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:07:20 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48334 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfIPKHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:07:20 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190916100718euoutp02087950083e8bd30bc6d501d15609d972~E40D_xGdx1472814728euoutp02N
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 10:07:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190916100718euoutp02087950083e8bd30bc6d501d15609d972~E40D_xGdx1472814728euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568628438;
        bh=tWj4RUrOhaavVZuv7OnDGI7YHLbzaWDaiJuf+U3+hFU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rdaXra6W53Y+P/m78uMOAzWslkP9F3Um4EvrCeAN+Kw2f8I82qaV/2qle3dxJSKeG
         Mv4kztu9UWwzk2HsNKX9ho1ZF6JFClHsd7UZzhyKEubQ3zGFCY8yY+Y98FoeC/ADit
         dk+H0DR3rHZUI0xmWXVTpyqYz013K/X7gmKflDC0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190916100717eucas1p2c677cffd1c1f89848e65550dabaf4a64~E40DI8IC02253722537eucas1p2a;
        Mon, 16 Sep 2019 10:07:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 25.DD.04374.5DE5F7D5; Mon, 16
        Sep 2019 11:07:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190916100716eucas1p213ef29ba8bd288dfc6b5f05138c9a558~E40CaP6VJ0349503495eucas1p2g;
        Mon, 16 Sep 2019 10:07:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190916100716eusmtrp236bea705cf67ba6e18bae7f688df1482~E40CL3N6F2883028830eusmtrp2w;
        Mon, 16 Sep 2019 10:07:16 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-b8-5d7f5ed5d4a1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2B.48.04117.4DE5F7D5; Mon, 16
        Sep 2019 11:07:16 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190916100715eusmtip2a1e525657e3f2d56e0836ed68728d299~E40BWQt_p3192531925eusmtip2Y;
        Mon, 16 Sep 2019 10:07:15 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 0/3] Exynos5 DMC minor fixes
Date:   Mon, 16 Sep 2019 12:07:01 +0200
Message-Id: <20190916100704.26692-1-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djP87pX4+pjDQ5dFrXYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUeB9/tYfLo
        27KK0ePzJrkA9igum5TUnMyy1CJ9uwSujBVrO9gKnrBVHG7rZW5gPMHaxcjJISFgIvHiZCd7
        FyMXh5DACkaJB4vfQTlfGCUefrrODOF8ZpT4/f0JI0zL1fYjTBCJ5YwSE191M8O1LJ40FaiK
        g4NNQE9ix6pCkAYRgcWMEt8OR4HYzALbmCR6v8qA2MIC+hLfX/1jBrFZBFQlDh2ZzgRi8wrY
        S8w9+44JYpm8xOoNB8DmSwhsYpdYte8aK8h8CQEXiZXTAiFqhCVeHd/CDmHLSPzfOR+qt1ii
        oXch1NE1Eo/750LVWEscPn4RbAyzgKbE+l36EGFHiT0Xn0FN55O48VYQ4mI+iUnbpjNDhHkl
        OtqEIKo1JLb0XIBaJCaxfM00qOEeEl9bp4E9JSQQK7F9wlzWCYxysxB2LWBkXMUonlpanJue
        Wmycl1quV5yYW1yal66XnJ+7iRGYek7/O/51B+O+P0mHGAU4GJV4eBta62KFWBPLiitzDzFK
        cDArifCGd1THCvGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2aWpBaBJNl4uCU
        amB0qEvpXM/A0X7NNH9Vk9aX2JAarZ1zMpyvmUnc3mS1IOGa//vjR8t51H5UyF5XtGFfY1V5
        qM8hKSr4kbmB/JrMfOWUorCkr1vPslz/7inmrtH0fd3jl+uUTQMZ/Q/mVB5se/j826TK2TtO
        dPYWPTJY0ibkU/g/cPLtO/nrd115qNPxj/O8/CYlluKMREMt5qLiRACoa3hEOQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e/4Pd0rcfWxBt3/5Sw2zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdouzTW/YLW41yFhsenyN1eLyrjlsFp97jzBazDi/j8li7ZG77BZL
        r19ksrjduILNonXvEXaLw2/aWS2+nXjE6CDosWbeGkaPnbPusntsWtXJ5rF5Sb3HwXd7mDz6
        tqxi9Pi8SS6APUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7Ms
        tUjfLkEvY8XaDraCJ2wVh9t6mRsYT7B2MXJySAiYSFxtP8LUxcjFISSwlFFiztzd7BAJMYlJ
        +7ZD2cISf651sUEUfWKUePp6J3MXIwcHm4CexI5VhSBxEYHljBLHVr1lBnGYBY4wSfTvmge2
        QlhAX+L7q3/MIDaLgKrEoSPTmUBsXgF7ibln3zFBbJCXWL3hAPMERp4FjAyrGEVSS4tz03OL
        jfSKE3OLS/PS9ZLzczcxAkN/27GfW3Ywdr0LPsQowMGoxMPb0FoXK8SaWFZcmXuIUYKDWUmE
        N7yjOlaINyWxsiq1KD++qDQntfgQoynQ8onMUqLJ+cC4zCuJNzQ1NLewNDQ3Njc2s1AS5+0Q
        OBgjJJCeWJKanZpakFoE08fEwSnVwCjV0jtr6sepK6N2FL9XfVd5LXYJ542D/x4oNZ/U/Frd
        qLmy6UiXpX/kB8mv510mnGn8sW3ejSRN6Vt7qibFeSzimV/c+q0+zlO77FfpxpnWmmHxIsEb
        VmmsfmmZzHvipuTs/ds/Jmf5C97L/x8atDi5qPCAa343386LrG+3T3n/+1e4W0Hp6UYlluKM
        REMt5qLiRAB7/63ZkwIAAA==
X-CMS-MailID: 20190916100716eucas1p213ef29ba8bd288dfc6b5f05138c9a558
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190916100716eucas1p213ef29ba8bd288dfc6b5f05138c9a558
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190916100716eucas1p213ef29ba8bd288dfc6b5f05138c9a558
References: <CGME20190916100716eucas1p213ef29ba8bd288dfc6b5f05138c9a558@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a follow up patch set for the Exynos5 Dynamic Memory Controller
driver v13 [1]. The patches are based on Krzysztof's 'for-next' branch [2].
There are a few minor fixes captured during static analysis and a new
binding for 'samsung,K3QF2F20DB' LPDDR3 memory.

Regards,
Lukasz Luba

[1] https://lkml.org/lkml/2019/8/21/283
[2] https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/log/?h=for-next

Lukasz Luba (3):
  memory: Exynos5422: minor fixes in DMC
  ARM: dts: exynos: fix too long line in memory device
  dt-bindings: ddr: Add bindings for Samsung LPDDR3 memories

 Documentation/devicetree/bindings/ddr/lpddr3.txt | 9 ++++++---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi    | 3 ++-
 drivers/memory/samsung/exynos5422-dmc.c          | 4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.17.1

