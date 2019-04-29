Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C7CC004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856BB2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="URwv2Gxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfD2JzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 05:55:01 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53786 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727624AbfD2JzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 05:55:00 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3T9kxuR031685;
        Mon, 29 Apr 2019 11:54:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=STMicroelectronics;
 bh=NpKHSHilJ8VtsKy2Eh73u7f/s16+/jfGkYS573A6cho=;
 b=URwv2GxebEgOjfAMFTa3Ak+GpQVsVLlauhQc8u9c9crOUnXwEZdquDHQZCqdgi0Fq21g
 JuLUOKDh6yr4vOBZEChwo+VxCcrJAS6zg5ioRLZOHBiwm/Ya8AncCG+daoGZXE3gnBE4
 vR+3S7vKPACustyWcxoEaIhBU1HczcXvlllGv8mU5fcaPHseINPyNPDYHrfyGL/plqsw
 /RzY/hZwgqmErWxYLzeCwDK4ZBA76U+M4yGgQdt3lXK6+rWVHEYkgij3tuv/ne43W9A7
 PsnfsPjOqa3VF/ylyhU8yMxKP+hlrJKEKTm2u2Bo3UaonDSE7p1Wi+Q3HOwGh19ORzbC Rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2s4cj0be9r-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 29 Apr 2019 11:54:45 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0FD7C34;
        Mon, 29 Apr 2019 09:54:45 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag4node3.st.com [10.75.127.12])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D7D7E14F5;
        Mon, 29 Apr 2019 09:54:44 +0000 (GMT)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG4NODE3.st.com
 (10.75.127.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 29 Apr
 2019 11:54:44 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1347.000; Mon, 29 Apr 2019 11:54:44 +0200
From:   Gerald BAEZA <gerald.baeza@st.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        Gerald BAEZA <gerald.baeza@st.com>
Subject: [PATCH 1/1] clk: stm32mp1: Add ddrperfm clock
Thread-Topic: [PATCH 1/1] clk: stm32mp1: Add ddrperfm clock
Thread-Index: AQHU/nGSI1KYPhvKvEC7x41++h176w==
Date:   Mon, 29 Apr 2019 09:54:44 +0000
Message-ID: <1556531652-27740-1-git-send-email-gerald.baeza@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-29_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Add ddrperfm clock for DDR Performance Monitor driver

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 drivers/clk/clk-stm32mp1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index a0ae8dc..a875649 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1402,6 +1402,7 @@ enum {
 	G_CRYP1,
 	G_HASH1,
 	G_BKPSRAM,
+	G_DDRPERFM,
=20
 	G_LAST
 };
@@ -1488,6 +1489,7 @@ static struct stm32_gate_cfg per_gate_cfg[G_LAST] =3D=
 {
 	K_GATE(G_STGENRO,	RCC_APB4ENSETR, 20, 0),
 	K_MGATE(G_USBPHY,	RCC_APB4ENSETR, 16, 0),
 	K_GATE(G_IWDG2,		RCC_APB4ENSETR, 15, 0),
+	K_GATE(G_DDRPERFM,	RCC_APB4ENSETR, 8, 0),
 	K_MGATE(G_DSI,		RCC_APB4ENSETR, 4, 0),
 	K_MGATE(G_LTDC,		RCC_APB4ENSETR, 0, 0),
=20
@@ -1899,6 +1901,7 @@ static const struct clock_config stm32mp1_clock_cfg[]=
 =3D {
 	PCLK(CRC1, "crc1", "ck_axi", 0, G_CRC1),
 	PCLK(USBH, "usbh", "ck_axi", 0, G_USBH),
 	PCLK(ETHSTP, "ethstp", "ck_axi", 0, G_ETHSTP),
+	PCLK(DDRPERFM, "ddrperfm", "pclk4", 0, G_DDRPERFM),
=20
 	/* Kernel clocks */
 	KCLK(SDMMC1_K, "sdmmc1_k", sdmmc12_src, 0, G_SDMMC1, M_SDMMC12),
--=20
2.7.4
