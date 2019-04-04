Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A2DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623F72082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n6uEq9Hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfDDRWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:22:53 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:20702 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729558AbfDDRWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:22:51 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190404172248epoutp02e1317ce7991584789b36fe0159b3ef10~SVUM3Yu521978019780epoutp02R;
        Thu,  4 Apr 2019 17:22:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190404172248epoutp02e1317ce7991584789b36fe0159b3ef10~SVUM3Yu521978019780epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554398568;
        bh=LsfL0Rn/AIXJ4Wot4MfRJXimLX/12DuBTziK/XGtHAI=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=n6uEq9Hf607UzyO1PXIgQf5k3KXbq50JzvRHC4p5m6HIuQNs9Nz4ck536+4untSOg
         F0YDcGrlWIQg/FUM234V6Frb5YZYR9ITI56zMFSmR2jD+/8EdWK5RsAihwqjgbcLOR
         nHU5DAzxfOMMzrmOICpTX2pOhZWxWEE7GYz30gNI=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190404172248epcas2p1d51ffcb04e599b082322baca3ebd17fa~SVUMl6lT_0629106291epcas2p1k;
        Thu,  4 Apr 2019 17:22:48 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.15.04195.86D36AC5; Fri,  5 Apr 2019 02:22:48 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190404172247epcas2p2d24f19f76db3cee177bd5b9df783eb3b~SVUMHXji91739317393epcas2p2t;
        Thu,  4 Apr 2019 17:22:47 +0000 (GMT)
X-AuditID: b6c32a45-d47ff70000001063-91-5ca63d680f11
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.68.03620.76D36AC5; Fri,  5 Apr 2019 02:22:47 +0900 (KST)
Received: from AMDC3061.DIGITAL.local ([106.120.51.75]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PPG00B165KSW780@mmp1.samsung.com>; Fri, 05 Apr 2019
        02:22:47 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        pankaj.dubey@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: [PATCH RFC 6/8] ARM64: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
Date:   Thu, 04 Apr 2019 19:17:33 +0200
Message-id: <20190404171735.12815-7-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190404171735.12815-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCmqW6G7bIYgxcNXBYbZ6xntbj+5Tmr
        xfwj51gt+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLtUfuslssvX6RyeJ24wo2i0Vbv7Bb
        tO49wu7A67Fm3hpGj02rOtk8Ni+p9+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6M7r4dbAUL
        2CqWzH/O0sC4irWLkZNDQsBE4uWud8xdjFwcQgI7GCX2z7jLDpIQEvjOKLHzvwNMUc/70ywQ
        RbsZJZYsmg/V8ZNRYn3bREaQKjYBQ4neo31gtoiAsMS9pcvZQYqYBU4wScw6dgxsn7CAj8T3
        UzdZQGwWAVWJjQu6gRo4OHgFrCV+/dWA2CYvsXrDAWYQm1PARuLxkjdsIHMkBHawSfxpWskE
        Ui8h4CLx/V49RL20xLNVGxkhapoZJXp232aHcCYwStw/voARospa4vDxi2BHMAvwSXQc/ssO
        MYhXoqNNCKLEQ2LexW5WiM/6GSV+3l3LDjRiASPDKkax1ILi3PTUYqMCQ73ixNzi0rx0veT8
        3E2M4AjVct3BOOOczyFGAQ5GJR7eBpZlMUKsiWXFlbmHGCU4mJVEeIO/L40R4k1JrKxKLcqP
        LyrNSS0+xCjNwaIkzvtIem60kEB6YklqdmpqQWoRTJaJg1OqgVEsN9e/Ryit+NXH14u49hbU
        bOttnPT18JfLaaWXvyQzLJz9lO3Cj00V27Z9WjGXk2Prc6/DfBq82UbZHrLPpqe+zvvz4KZo
        O+e/+7NXati9KPj9e14n6y631BXBColxq1VZj+2TFoktktRRN6/y6bpe6TxLcdeenx1xlfPU
        uyu6u+cIqraK71NiKc5INNRiLipOBAAvRuinzAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsVy+t9jAd1022UxBp+/qFtsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y26x9PpFJovbjSvYLBZt/cJu
        0br3CLsDr8eaeWsYPTat6mTz2Lyk3qNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyuvt2sBUs
        YKtYMv85SwPjKtYuRk4OCQETiZ73p1m6GLk4hAR2MkqcOXCbEcL5ySgxc/1ENpAqNgFDid6j
        fYwgtoiAsMS9pcvZQYqYBU4wSfxfuIYFJCEs4CPx/dRNMJtFQFVi44JuoAYODl4Ba4lffzUg
        tslLrN5wgBnE5hSwkXi85A0bSIkQUMn3LQkTGHkWMDKsYpRMLSjOTc8tNiowykst1ytOzC0u
        zUvXS87P3cQIDL9th7X6dzA+XhJ/iFGAg1GJh1eDaVmMEGtiWXFl7iFGCQ5mJRHe4O9LY4R4
        UxIrq1KL8uOLSnNSiw8xSnOwKInz8ucfixQSSE8sSc1OTS1ILYLJMnFwSjUwms0U/eg1a6fq
        pZrfgXWdC+wOZE2MmqenHPhozgaNqdonLG26DL3ziqcdrGNkaXHYFFzEwqXlnds4ef+WQsv6
        ulshc5VVJ9332FX5c+mfv1ELZiVd3tex70T/gRt7FXhuWZlOSE7pYjwseazYs1csbcLOPS9e
        eNv+8Mq+MPvYCvWtMo5ZLwNNlViKMxINtZiLihMBncr6+TsCAAA=
X-CMS-MailID: 20190404172247epcas2p2d24f19f76db3cee177bd5b9df783eb3b
CMS-TYPE: 102P
X-CMS-RootMailID: 20190404172247epcas2p2d24f19f76db3cee177bd5b9df783eb3b
References: <20190404171735.12815-1-s.nawrocki@samsung.com>
        <CGME20190404172247epcas2p2d24f19f76db3cee177bd5b9df783eb3b@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

This patch enables exynos_chipid driver for ARCH_EXYNOS
based SoC.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 70498a033cf5..794c65a4910a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -67,6 +67,7 @@ config ARCH_BRCMSTB
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
+	select EXYNOS_CHIPID
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select EXYNOS_PMU
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-- 
2.17.1

