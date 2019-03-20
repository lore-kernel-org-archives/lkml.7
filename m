Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D49C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAAA2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mQ6kri7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfCTKAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:00:07 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:41250 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfCTKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:00:07 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190320100003epoutp03d8abc180b33bf134e32de9e8b1072d39~NomWeGDXn2912029120epoutp03b;
        Wed, 20 Mar 2019 10:00:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190320100003epoutp03d8abc180b33bf134e32de9e8b1072d39~NomWeGDXn2912029120epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1553076003;
        bh=cgNzCydZsdjYKV2Hj4+0wnbQBP7npt6wfB6szDEcwbQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=mQ6kri7KyMqxkIBkU3hFSipxFnUQQ2rJ/jtMYyzBRx+wyKYgxLs5YvoX7+Dm7Zd56
         B8qeyefuxCsLPpdWUjq4wk79Jv1LXFUFcS5TjoU4J8zjBegpNgWBZ2s3uaJGWYZDdv
         iVC9IGrCCCR2v+8FaZ8iq+4NZLJnN43i5YOcPa6A=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190320100003epcas2p315b98bcdde146ff2ee6c37a3a7bff406~NomWNaAeH2635226352epcas2p3_;
        Wed, 20 Mar 2019 10:00:03 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.9C.04207.32F029C5; Wed, 20 Mar 2019 19:00:03 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190320100002epcas2p2c85f13b20896f837aa5a48643b917680~NomVqAe0m2116921169epcas2p2s;
        Wed, 20 Mar 2019 10:00:02 +0000 (GMT)
X-AuditID: b6c32a46-d4bff7000000106f-91-5c920f239636
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 63.16.03620.22F029C5; Wed, 20 Mar
        2019 19:00:02 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PON005YLT3TTP70@mmp2.samsung.com>; Wed, 20 Mar 2019
        19:00:02 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, kgene@kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        stable@vger.kernel.org
Subject: [PATCH RESEND] ARM: dts: exynos: Fix audio (microphone) routing on
 Odroid XU3
Date:   Wed, 20 Mar 2019 10:59:50 +0100
Message-id: <20190320095950.23566-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190319205522.GD16150@kozik-lap>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCmqa4y/6QYg09TZC2uXDzEZLFxxnpW
        i/lHzrFa9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWa4/cZbdo3XuE3eLwm3ZWiwUbHzE6
        8Hhs+NzE5rFpVSebx+Yl9R59W1YxenzeJBfAGsVlk5Kak1mWWqRvl8CVcffEEvaC2ewVfRv3
        sjUwtrN1MXJySAiYSFxtfc4EYgsJ7GCU6Pgg1cXIBWR/Z5Q4c7oTrmhabxMzRGIDo0Tryels
        EM4vRoljEz4yg1SxCRhK9B7tYwSxRQSEJe4tXc4OUsQscJJJonnWDHaQhLBAhMSb+4dYQWwW
        AVWJVTuvgDXzClhLPJ83hxlinbzE6g0HgGwODk4BfYn5dx1B5kgIbGGTaPn4mhWixkXi09pN
        UOdJSzxbtZERoqiZUaJn9212CGcCo8T94wsYIaqsJQ4fvwjWzSzAJ9Fx+C87yAYJAV6JjjYh
        iBIPidMtzVCvNTFKnP05mwVoxAJGhlWMYqkFxbnpqcVGBUZ6xYm5xaV56XrJ+bmbGMGRqeW2
        g3HJOZ9DjAIcjEo8vBVPJ8QIsSaWFVfmHmKU4GBWEuEtSpwYI8SbklhZlVqUH19UmpNafIhR
        moNFSZz3ofTcaCGB9MSS1OzU1ILUIpgsEwenVAPjsfbzsn57OMQ/zH5d1Sx3JoM7c59sEJ/p
        L+NrQaWLqzj+8m2SStLtY2IWu8eWXJD0ceuJX/XiZeob1jPozD5Xu0ROSXhVZi7fL5N0Gw6b
        L3r++TE1BpzG0Rfae7uYf03l5WAoUvthJLNGW7Jgf9QhxytJFYcStkx+xh2jU+x6y3aO06WW
        DiWW4oxEQy3mouJEAJackR7IAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsVy+t9jQV0l/kkxBiv+mFpcuXiIyWLjjPWs
        FvOPnGO16H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y27RuvcIu8XhN+2sFgs2PmJ0
        4PHY8LmJzWPTqk42j81L6j36tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoEr4+6JJewFs9kr+jbu
        ZWtgbGfrYuTkkBAwkZjW28TcxcjFISSwjlHi2dLJTBDOL0aJ20ueM4FUsQkYSvQe7WMEsUUE
        hCXuLV3ODmIzC5xkkpi4KADEFhaIkHhz/xAriM0ioCqxaucVZhCbV8Ba4vm8OcwQ2+QlVm84
        AGRzcHAK6EvMv+sIEhYS0JPYvLmBfQIjzwJGhlWMkqkFxbnpucVGBUZ5qeV6xYm5xaV56XrJ
        +bmbGIFBt+2wVv8OxsdL4g8xCnAwKvHwXng+IUaINbGsuDL3EKMEB7OSCG9R4sQYId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rz8+ccihQTSE0tSs1NTC1KLYLJMHJxSDYwb+v5z/Avb0ORfWBFx
        4tNDyUn88wqOPdlb8jPbr3xfqniTWdmjoiXr9Ou/NGlmJl/e3NzrlZe1b8IZ02fCi57r7OHj
        3LGrf+ut6VfSs5295qeZb87Wnrh2Y56YuOjNSw8+fqmyd1+TVefBs/ZfvEbWAofeV9l+i9Tc
        2Ay3W52U1T//yrOj7YYSS3FGoqEWc1FxIgBmCewONgIAAA==
X-CMS-MailID: 20190320100002epcas2p2c85f13b20896f837aa5a48643b917680
CMS-TYPE: 102P
X-CMS-RootMailID: 20190320100002epcas2p2c85f13b20896f837aa5a48643b917680
References: <20190319205522.GD16150@kozik-lap>
        <CGME20190320100002epcas2p2c85f13b20896f837aa5a48643b917680@epcas2p2.samsung.com>
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
index 3a37267e6134..c3c2d85267da 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
@@ -22,7 +22,7 @@
 			"Headphone Jack", "HPL",
 			"Headphone Jack", "HPR",
 			"Headphone Jack", "MICBIAS",
-			"IN1", "Headphone Jack",
+			"IN12", "Headphone Jack",
 			"Speakers", "SPKL",
 			"Speakers", "SPKR",
 			"I2S Playback", "Mixer DAI TX",
--
2.17.1

