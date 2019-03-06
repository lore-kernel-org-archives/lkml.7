Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8BB20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XqAAR3DC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfCFKlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:41:18 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:55705 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbfCFKlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:41:17 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190306104114epoutp047a75371fa0ad745f0c80603f2f2b921c~JWITQJfMG2868328683epoutp04M;
        Wed,  6 Mar 2019 10:41:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190306104114epoutp047a75371fa0ad745f0c80603f2f2b921c~JWITQJfMG2868328683epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551868874;
        bh=fGvMUsNK8LiwXPW8H+Twl8qTGZcvmUYDlaTdFX6L1h0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=XqAAR3DCHEtHCPJJf6BnOjsVpyryJFbo6EEewHN6pu/uDIqsgTQJanJxtcUiuo/G8
         S6tsXMnn7LRKp1+vgqV6KR0Y7V7w/kD3+fZ8WoYEnwg8YO2OtnctgEdTBraA1QNTWl
         J9zhvPYqyKxZon2CDqEH3p/WmI6RJnt4YJ6lb5YY=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190306104113epcas1p210aaee15c5b35cf3d02904cd6746a3ac~JWIS5mKKF2750727507epcas1p20;
        Wed,  6 Mar 2019 10:41:13 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.68.04173.9C3AF7C5; Wed,  6 Mar 2019 19:41:13 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190306104113epcas1p4a12ebf1aac63883cbd80b2750be76d06~JWISkS1qs1698416984epcas1p4e;
        Wed,  6 Mar 2019 10:41:13 +0000 (GMT)
X-AuditID: b6c32a36-5d9ff7000000104d-af-5c7fa3c97498
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.94.04015.9C3AF7C5; Wed,  6 Mar 2019 19:41:13 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PNX00MLMXOABX10@mmp1.samsung.com>; Wed, 06 Mar 2019
        19:41:13 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ARM: dts: exynos: Fix audio routing on exynos5422-odroidxu3
Date:   Wed, 06 Mar 2019 11:40:56 +0100
Message-id: <20190306104056.7603-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCmnu7JxfUxBltaNSw2zljPajH/yDlW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWcw4v4/JYu2Ru+wWrXuPsFscftPO6sDlsWlVJ5vH5iX1
        Hn1bVjF6fN4kF8ASxWWTkpqTWZZapG+XwJXxZU4/S8FZ9orJk2axNTCuY+ti5OSQEDCRePfq
        BWMXIxeHkMAORokv+y+zQzjfGSWOzf3KAlN1q/ECM0RiN6PExq4HUFW/GCU6fy0Hq2ITMJTo
        PdrHCGKLCAhL3Fu6HKyIWWASk8SXzvNMXYwcHMICPhKfTqSB1LAIqErcmDsZrJdXwEqib9pT
        Roht8hKrNxwA2yYh0Mgm8fjdLahjXSS6G1uYQeZICEhLXDpqCxGulti1vRuqvoNRouXCdmaI
        hLXE4eMXWUFsZgE+iXdfe1ghenklOtqEIEo8JJrfPAO7QUggVmLB8ddsExjFFzAyrGIUSy0o
        zk1PLTYsMNIrTswtLs1L10vOz93ECI4vLbMdjIvO+RxiFOBgVOLhndBaFyPEmlhWXJl7iFGC
        g1lJhLdpbn2MEG9KYmVValF+fFFpTmrxIUZpDhYlcd71Ds4xQgLpiSWp2ampBalFMFkmDk6p
        BsZwr4RVy/bUvtB9tun1hxZb2SfOx3NKuiam9l46dGppL3/mrfLCjxmLXCcLRxXM+bzjjmb2
        PhOeztVhR9/bxG+7kj8nrNuVbda5My983uWvTDpzSGCW+D2hdT9Y1ucVJc2T2feO6SfPp1Zf
        FhXPhS0PGmZV3djo+v/ewnsLnbh+RXJd54rmWHFAiaU4I9FQi7moOBEAbTFIX6sCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDJMWRmVeSWpSXmKPExsVy+t9jAd2Ti+tjDHat5bHYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZjHj/D4mi7VH7rJbtO49wm5x+E07qwOXx6ZVnWwem5fU
        e/RtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfGlzn9LAVn2SsmT5rF1sC4jq2LkZNDQsBE4lbj
        BeYuRi4OIYGdjBIH/x9hh3B+MUpc3nmEBaSKTcBQovdoHyOILSIgLHFv6XJ2EJtZYBKTxO5X
        ll2MHBzCAj4Sn06kgYRZBFQlbsydDNbKK2Al0TftKSPEMnmJ1RsOME9g5FrAyLCKUTK1oDg3
        PbfYqMAwL7Vcrzgxt7g0L10vOT93EyMwTLYd1urbwXh/SfwhRgEORiUe3gmtdTFCrIllxZW5
        hxglOJiVRHib5tbHCPGmJFZWpRblxxeV5qQWH2KU5mBREue9nXcsUkggPbEkNTs1tSC1CCbL
        xMEp1cC4we6R+edbf7oKK5uXntzjFrdxxwGz70zektfr/1l1NV1fXCp7et/7q51i97vjm2Xm
        zuk6dDCLzerY7ysJK1YesFT5IuCheORdLv8TQXef6yu9jsYq8y/MvqxmyH54z5Zn29Iq+jxC
        mp6fCMr7w5FmNnHhydyT+43Xf/TfcNt3auaBWzkBaVtdlViKMxINtZiLihMBJmwIAw8CAAA=
X-CMS-MailID: 20190306104113epcas1p4a12ebf1aac63883cbd80b2750be76d06
CMS-TYPE: 101P
X-CMS-RootMailID: 20190306104113epcas1p4a12ebf1aac63883cbd80b2750be76d06
References: <CGME20190306104113epcas1p4a12ebf1aac63883cbd80b2750be76d06@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing audio routing entry for the capture stream, this change
is required to fix audio recording on Odroid XU3.

Fixes: 885b005d232c ("ARM: dts: exynos: Add support for secondary DAI to Odroid XU3")
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
index 51a843bd65ed..3a37267e6134 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
@@ -26,7 +26,8 @@
 			"Speakers", "SPKL",
 			"Speakers", "SPKR",
 			"I2S Playback", "Mixer DAI TX",
-			"HiFi Playback", "Mixer DAI TX";
+			"HiFi Playback", "Mixer DAI TX",
+			"Mixer DAI RX", "HiFi Capture";
 
 		assigned-clocks = <&clock CLK_MOUT_EPLL>,
 				<&clock CLK_MOUT_MAU_EPLL>,
-- 
2.17.1

