Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFBEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355F12186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfCOMXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:23:16 -0400
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41]:65335 "EHLO
        mgwym02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfCOMXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:23:15 -0400
Received: from yt-mxq.gw.nic.fujitsu.com (unknown [192.168.229.66]) by mgwym02.jp.fujitsu.com with smtp
         id 28b5_d1c2_d8ae4ca9_faab_4e5d_8232_28a8d91cc97e;
        Fri, 15 Mar 2019 21:23:07 +0900
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
        by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 7D3FEAC00B7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 21:23:07 +0900 (JST)
Received: from G01JPEXCHKW15.g01.fujitsu.local (G01JPEXCHKW15.g01.fujitsu.local [10.0.194.54])
        by g01jpfmpwkw01.exch.g01.fujitsu.local (Postfix) with ESMTP id D55C9692597;
        Fri, 15 Mar 2019 21:22:37 +0900 (JST)
Received: from G01JPEXMBKW02.g01.fujitsu.local ([10.0.194.66]) by
 g01jpexchkw15 ([10.0.194.54]) with mapi id 14.03.0415.000; Fri, 15 Mar 2019
 21:22:36 +0900
From:   "Okamoto, Takayuki" <tokamoto@jp.fujitsu.com>
To:     'Will Deacon' <will.deacon@arm.com>,
        'Mark Rutland' <mark.rutland@arm.com>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'James Morse'" <james.morse@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Subject: [RESEND PATCH] Make Fujitsu Erratum 010001 patch can be applied on
 A64FX v1r0
Thread-Topic: [RESEND PATCH] Make Fujitsu Erratum 010001 patch can be
 applied on A64FX v1r0
Thread-Index: AdTbJFde57o7xnMQR9OpSdZTOYeW4w==
Date:   Fri, 15 Mar 2019 12:22:36 +0000
Message-ID: <5FA513F682BE7F4EAAB8EE035D5B08E44E9363CC@G01JPEXMBKW02>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.87.120.48]
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I resend the patch due to whitespace munging.

> -----Original Message-----
> From: James Morse <james.morse@arm.com>
> Sent: Wednesday, February 27, 2019 3:44 AM
> To: james.morse@arm.com; linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org; Catalin Marinas
> <catalin.marinas@arm.com>; Mark Rutland <mark.rutland@arm.com>; Will
> Deacon <will.deacon@arm.com>; Zhang, Lei <zhang.lei@jp.fujitsu.com>
> Subject: [PATCH v5] arm64: Add workaround for Fujitsu A64FX erratum
> 010001
> 
> +/* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
> +#define MIDR_FUJITSU_ERRATUM_010001
> 	MIDR_FUJITSU_A64FX
> +#define MIDR_FUJITSU_ERRATUM_010001_MASK
> 	(~MIDR_VARIANT(1))

This workaround for the erratum should be applied for both A64FX v1r0 and
v0r0, however, the patch v5 is only enabled on A64FX v0r0(MIDR.Variant == 0
&& MIDR.Revision == 0).
This issue is caused by the macro MIDR_FUJITSU_ERRATUM_010001_MASK.

I have tested on both A64FX v1r0 and v0r0. This new patch will effect
only for A64FX.

--
Changed to be applied for not only A64FX v0r0 but also v1r0.

Signed-off-by: Zhang Lei <zhang.lei@jp.fujitsu.com>
---
 arch/arm64/include/asm/cputype.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 2afb133..1fb47b5 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -129,7 +129,7 @@
 
 /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
 #define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
-#define MIDR_FUJITSU_ERRATUM_010001_MASK	(~MIDR_VARIANT(1))
+#define MIDR_FUJITSU_ERRATUM_010001_MASK	(~(0x1 << MIDR_VARIANT_SHIFT))
 #define TCR_CLEAR_FUJITSU_ERRATUM_010001	(TCR_NFD1 | TCR_NFD0)
 
 #ifndef __ASSEMBLY__
-- 
1.8.3.1

