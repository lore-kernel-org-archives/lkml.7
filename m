Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40917C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0544D222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j9Jrh7pU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbfJDNjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:39:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36172 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388289AbfJDNjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:39:07 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191004133906euoutp02ce49dfd7045765b2704fd645e183bb1e~KdUH5_HDC1004810048euoutp020
        for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2019 13:39:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191004133906euoutp02ce49dfd7045765b2704fd645e183bb1e~KdUH5_HDC1004810048euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570196346;
        bh=DlYC6mhsX8aRrg3teYoSKtGXKEdU9NyepCecbB1Z7iE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9Jrh7pUx6DeIUXH+58nErvuL3XZl7xlXEZyVEwxH6Pm7I6D/LCfXthlApknIQmSf
         FcyvAPXftpchoR1wMgxHVA6hoaJRHV/JTG4y9wMDIvWPYmERsYifYpUJLhB1EN4t7d
         50mslbEVR1BNdfH5abrv6eu86MhXgjYXwBYd3CxY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191004133906eucas1p154efa848d5c0ba608321665c4fb241ac~KdUHtWDYE2704927049eucas1p1U;
        Fri,  4 Oct 2019 13:39:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 21.BE.04309.A7B479D5; Fri,  4
        Oct 2019 14:39:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191004133905eucas1p18363c8c5f98cc5e7dfaa046d405808cf~KdUHebLV60860708607eucas1p1m;
        Fri,  4 Oct 2019 13:39:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191004133905eusmtrp1c86a987209db7284f21e007c4503229f~KdUHd1OTn2251922519eusmtrp1A;
        Fri,  4 Oct 2019 13:39:05 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-26-5d974b7a7743
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 72.83.04166.97B479D5; Fri,  4
        Oct 2019 14:39:05 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191004133905eusmtip297518b647c1f1547d45779c8dafa8bde~KdUHD69DP2649426494eusmtip2A;
        Fri,  4 Oct 2019 13:39:05 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, lukasz.luba@polnum.com
Cc:     b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [RFC 1/2] DT: ARM: exynos: change SRAM device node
Date:   Fri,  4 Oct 2019 15:38:54 +0200
Message-Id: <20191004133855.17474-2-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004133855.17474-1-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsWy7djP87pV3tNjDZZMYLXYOGM9q8WtBhmL
        y7vmsFlMeveIyWLtkbvsFofftLM6sHkcfLeHyeNH50FGj74tqxg9Pm+SC2CJ4rJJSc3JLEst
        0rdL4MrY++YnW8EvtopV/9cxNzDuYe1i5OSQEDCRaN6wnb2LkYtDSGAFo8SfpguMEM4XRokN
        y98yQTifGSUmXWxjgmlZ8egvVNVyRonVN4+xw7U0/3rI3MXIwcEmoCexY1UhiCkiYCHxpL8c
        pJdZoEri4I2fjCC2sIC1xM0f25lBbBYBVYk1L3+AncQrYC/ReGkBC8QueYnVGw6A1XAKOEhs
        WXYC7CAJgcdsEtdWnmeGKHKRODrlDFSDsMSr41vYIWwZidOTe6DixRINvQsZIewaicf9c6Fq
        rCUOH7/ICnIns4CmxPpd+hBhR4kneyaAhSUE+CRuvBWEOJ9PYtK26cwQYV6JjjYhiGoNiS09
        F6ChIyaxfM00qOEeEgcXzWGBBM5kRonvU9+zT2CUn4WwbAEj4ypG8dTS4tz01GKjvNRyveLE
        3OLSvHS95PzcTYzAVHD63/EvOxh3/Uk6xCjAwajEw/vBYnqsEGtiWXFl7iFGCQ5mJRHeS+un
        xArxpiRWVqUW5ccXleakFh9ilOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpgXLzN1ZHj
        gOumL2Wla/98ibv72dH40auONwrTRNQWu38SZtVw3KPpt22Vwg61R+rX9nwTcHU5dpBxQ/3n
        6yylvTcqHm+R2aF1J/qSWoeKQ+elHUd9uOZWzpwjrLor5J520fl4CaOvXy6kXXt0a+kWQYfc
        gpRQzQ0+djob6hhDtx39Z/crpHvRXiWW4oxEQy3mouJEADlfaqsBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsVy+t/xe7qV3tNjDVZt17fYOGM9q8WtBhmL
        y7vmsFlMeveIyWLtkbvsFofftLM6sHkcfLeHyeNH50FGj74tqxg9Pm+SC2CJ0rMpyi8tSVXI
        yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvY++YnW8EvtopV/9cx
        NzDuYe1i5OSQEDCRWPHoL2MXIxeHkMBSRoldTxqgEmISk/ZtZ4ewhSX+XOtiA7GFBD4xSjzu
        4Oti5OBgE9CT2LGqECQsImAlMW/9L7ASZoE6iYYDM8FahQWsJW7+2M4MYrMIqEqsefkDbDyv
        gL1E46UFLBDj5SVWbzgAVsMp4CCxZdkJJpDxQkA1l3/pTGDkW8DIsIpRJLW0ODc9t9hQrzgx
        t7g0L10vOT93EyMwMLcd+7l5B+OljcGHGAU4GJV4eD9YTI8VYk0sK67MPcQowcGsJMJ7af2U
        WCHelMTKqtSi/Pii0pzU4kOMpkA3TWSWEk3OB0ZNXkm8oamhuYWlobmxubGZhZI4b4fAwRgh
        gfTEktTs1NSC1CKYPiYOTqkGxrCPpdW9e67vXLNplmHApZSKmRvL3687dHim09JVtpo81Uf4
        T5eteBaz8ti5iYw9F3zkG45v1Ge0077KxlH1e0FQ3u/L/O41rEKLzEy3s92Mkljd9fXd7AN8
        ik5nHq6ZecCvLUn6zbf6iZv+fLpUdleMkXNK5QvDWyvZX9R0OapXPeSafC5I5pQSS3FGoqEW
        c1FxIgBcOykEYgIAAA==
X-CMS-MailID: 20191004133905eucas1p18363c8c5f98cc5e7dfaa046d405808cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191004133905eucas1p18363c8c5f98cc5e7dfaa046d405808cf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191004133905eucas1p18363c8c5f98cc5e7dfaa046d405808cf
References: <20191004133855.17474-1-l.luba@partner.samsung.com>
        <CGME20191004133905eucas1p18363c8c5f98cc5e7dfaa046d405808cf@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos54xx.dtsi | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index 0b27bebf9528..1e43ad9f2d89 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -47,21 +47,11 @@
 
 	soc: soc {
 		sysram@2020000 {
-			compatible = "mmio-sram";
+			compatible = "direct-sram";
 			reg = <0x02020000 0x54000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x02020000 0x54000>;
-
-			smp-sysram@0 {
-				compatible = "samsung,exynos4210-sysram";
-				reg = <0x0 0x1000>;
-			};
-
-			smp-sysram@53000 {
-				compatible = "samsung,exynos4210-sysram-ns";
-				reg = <0x53000 0x1000>;
-			};
 		};
 
 		mct: mct@101c0000 {
-- 
2.17.1

