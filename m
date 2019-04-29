Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7392EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EED520644
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="rN/NQmxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfD2KEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:04:05 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7902 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727817AbfD2KED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:04:03 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3TA37W2029049;
        Mon, 29 Apr 2019 12:03:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=n2u4++2HSfET332tMSV3lV3tD9SsVHg37tndqAOXNsU=;
 b=rN/NQmxoXNbvzde+GhX0trZQo+p5rJrmjppITX01WoHmt/r29utiq4/Geib8QbSILOmz
 1u4DTvXhqKBKxpp+D9Y9kdMpY7AHp7DRtiUH5EyLBhr2VGhwmX0VmbZ1+dmHWpvWV5KX
 kLAoIGuLiU0OmHic2rfNjw9bwA+PDKHIxZEODcQYKWUPDiSLxOZKH5gsw+v5ocETuBGK
 cSXFgRwBJiEyXWieNZLhGN1GaR3yHvrm9SAvXWD+S92ENW9Pv2zKer4q5i+NJVmGsynE
 xHLOZiRLMiije//OpC0QW9veZYPQin/5O0hGJsYDPoclxVtQG/k7veLzgy4H2aH0rlDH 8g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2s4c7448a0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 29 Apr 2019 12:03:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 41E9834;
        Mon, 29 Apr 2019 10:03:39 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 203441517;
        Mon, 29 Apr 2019 10:03:39 +0000 (GMT)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 29 Apr
 2019 12:03:38 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1347.000; Mon, 29 Apr 2019 12:03:38 +0200
From:   Gerald BAEZA <gerald.baeza@st.com>
To:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Gerald BAEZA <gerald.baeza@st.com>
Subject: [PATCH 4/5] ARM: configs: enable STM32_DDR_PMU
Thread-Topic: [PATCH 4/5] ARM: configs: enable STM32_DDR_PMU
Thread-Index: AQHU/nLQ6c8DagHePECKTlRzQJvc3A==
Date:   Mon, 29 Apr 2019 10:03:38 +0000
Message-ID: <1556532194-27904-5-git-send-email-gerald.baeza@st.com>
References: <1556532194-27904-1-git-send-email-gerald.baeza@st.com>
In-Reply-To: <1556532194-27904-1-git-send-email-gerald.baeza@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-29_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32_DDR_PMU enables the perf driver that
controls the DDR Performance Monitor (DDRPERFM)

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v=
7_defconfig
index c75051b..6bc6ffd 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -979,6 +979,7 @@ CONFIG_PHY_UNIPHIER_USB2=3Dy
 CONFIG_OMAP_USB2=3Dy
 CONFIG_TI_PIPE3=3Dy
 CONFIG_TWL4030_USB=3Dm
+CONFIG_STM32_DDR_PMU=3Dm
 CONFIG_NVMEM_IMX_OCOTP=3Dy
 CONFIG_NVMEM_SUNXI_SID=3Dy
 CONFIG_NVMEM_VF610_OCOTP=3Dy
--=20
2.7.4
