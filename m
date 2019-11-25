Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62704C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3382053B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bqPrtHOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKYMzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:55:35 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57075 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfKYMze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:55:34 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191125125532euoutp0289ce3bfd4f35a727edb22924cfe78aec~aaQ7oX-yZ2673726737euoutp02G
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 12:55:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191125125532euoutp0289ce3bfd4f35a727edb22924cfe78aec~aaQ7oX-yZ2673726737euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574686532;
        bh=ftxI01Ir5QOSE0yFjamiErgIm7/ovyX5nxQuBtdP5cw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=bqPrtHOaE/x/sBIo4oZKGXi5cOfhIdIW0bG6sKni9YURMK1cCeA+RDBzKqa2yTcMq
         0pMaiO06UujJ7qStnCBt5Q4qTl4NffTZ2hlWrOkshOnwGNCWA0vwF/52wBuprJOeIH
         OMt/S9uv/Ehd6PMS1ISA0G7qEoW5W0zCIjPArJ1E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191125125532eucas1p2f1d0e2fbcbda0dcebcf4dd700a914a1b~aaQ7SXxYZ1938019380eucas1p2C;
        Mon, 25 Nov 2019 12:55:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E3.06.60679.44FCBDD5; Mon, 25
        Nov 2019 12:55:32 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191125125531eucas1p17f4044301903eeafe56865ed63738798~aaQ664Zur0061800618eucas1p12;
        Mon, 25 Nov 2019 12:55:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191125125531eusmtrp2e21a5caa7be2f67b6efbfb5c0525e28c~aaQ66POov0412704127eusmtrp2P;
        Mon, 25 Nov 2019 12:55:31 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-95-5ddbcf443d57
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8C.58.07950.34FCBDD5; Mon, 25
        Nov 2019 12:55:31 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191125125531eusmtip270dda46411723c7d5e2ea5cf79c1dc55~aaQ6WUQVQ0169101691eusmtip2K;
        Mon, 25 Nov 2019 12:55:31 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kusanagi Kouichi <slash@ac.auone-net.jp>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] arm: exynos_config: Restore debugfs support
Date:   Mon, 25 Nov 2019 13:55:15 +0100
Message-Id: <20191125125515.30795-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsWy7djPc7ou52/HGjxpYrHYOGM9q8X58xvY
        LS7vmsNmMeP8PiaLtUfuslvs63jAZPH81VlmB3aPFYv2snu07LvF7rFpVSebR9+WVYwenzfJ
        BbBGcdmkpOZklqUW6dslcGV0bWxjLHjIVrF02V/mBsZXrF2MnBwSAiYSTxavY+ti5OIQEljB
        KLHlRB8LhPOFUeL69ZlQzmdGiYuflrPAtNw53wOVWM4o0dPxgx0kAday4m08iM0mYCjR9baL
        DcQWEXCWaJjayATSwCzwiFHiz87rQA4Hh7CAjcTOZXYgNSwCqhJfuxrYQcK8ArYS3e1pELvk
        JVZvOMAM0iohcJtN4uu3l8wQCReJ3xfPskHYwhKvjm9hh7BlJP7vnM8E0dDMKPHw3Fp2CKeH
        UeJy0wxGiCpricPHL7KCbGMW0JRYv0sfIuwocexiE1hYQoBP4sZbQZAwM5A5adt0Zogwr0RH
        mxBEtZrErOPr4NYevHAJ6jQPiZYrJ1ggQRIr8aZrHfMERrlZCLsWMDKuYhRPLS3OTU8tNspL
        LdcrTswtLs1L10vOz93ECEwFp/8d/7KDcdefpEOMAhyMSjy8P87ejhViTSwrrsw9xCjBwawk
        wut29kasEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLpiSWp2ampBalFMFkmDk6pBkbD
        R3kvFbm40xXMns5QPPYgXerb84eP4i8UcXi/qDe2c//70JrhRUG1T3fzJJH2jNrw3edmFT9b
        581ufUFk24c3Gbv5l0y79mRPV1WfluWB0yUTzm5J+GIfwPZ+BpfVh34rq/R/rj9KCg/sr+ud
        1dY3v0zuY4dQ4UzFZ1kiFY/Ld6x1/GbOr6fEUpyRaKjFXFScCAAoxsDQAQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsVy+t/xe7rO52/HGrzr1bTYOGM9q8X58xvY
        LS7vmsNmMeP8PiaLtUfuslvs63jAZPH81VlmB3aPFYv2snu07LvF7rFpVSebR9+WVYwenzfJ
        BbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GV0
        bWxjLHjIVrF02V/mBsZXrF2MnBwSAiYSd873sHQxcnEICSxllPjX1c8OkZCRODmtAapIWOLP
        tS42iKJPjBJLXv5iBEmwCRhKdL0FSXByiAi4Shxa0csMUsQs8IRR4tS680BFHBzCAjYSO5fZ
        gdSwCKhKfO1qYAcJ8wrYSnS3p0HMl5dYveEA8wRGngWMDKsYRVJLi3PTc4uN9IoTc4tL89L1
        kvNzNzECQ3DbsZ9bdjB2vQs+xCjAwajEw/vj7O1YIdbEsuLK3EOMEhzMSiK8bmdvxArxpiRW
        VqUW5ccXleakFh9iNAXaPZFZSjQ5HxgfeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1Kz
        U1MLUotg+pg4OKUaGAPvCu0SOMqsPWVhU/q7sgtnpN9vtP6YcW1h1sIpDpk3fqw7ddLJR+y3
        rrDKScHg/mshXLeNXpTOCOlJ/Tt16sGECcVh36wMfp+Y53ajV3KHgabSNL9fwuZZqWciny48
        8miBpmXBP9l9T1mS3Wtkbz/i/hCte/G4fOz/MvZP7OaHnTl7l5y/pqLEUpyRaKjFXFScCABF
        PV2nVwIAAA==
X-CMS-MailID: 20191125125531eucas1p17f4044301903eeafe56865ed63738798
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191125125531eucas1p17f4044301903eeafe56865ed63738798
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191125125531eucas1p17f4044301903eeafe56865ed63738798
References: <CGME20191125125531eucas1p17f4044301903eeafe56865ed63738798@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0e4a459f56c3 ("tracing: Remove unnecessary DEBUG_FS dependency")
removed the dependency between DEBUG_FS and TRACING, so DEBUG_FS is no
longer enabled in default builds. Enable it again manually, as it provides
a lots of useful data for automated testing tools.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index e7e4bb5ad8d5..fde84f123fbb 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -350,6 +350,7 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 # CONFIG_DETECT_HUNG_TASK is not set
-- 
2.17.1

