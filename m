Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152DDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF498214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="QWOq4bQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbfH0PJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:09:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58782 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728506AbfH0PI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:08:57 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RF27Pu026516;
        Tue, 27 Aug 2019 17:08:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=MKlaahYh2GyrYNC5OSGbdIImAgdDz5WxBqftSeUPh6k=;
 b=QWOq4bQUMB5zBU1+CzaYPmnKeVEpx+m6YtBdbQ+JTjVJtfKZLxfXYcZWWIP61Egv4hny
 TQjT0+ak6jI32S4OD2hd9Fx21WbUZ5GJefv94gDkc9H56I2/u67lqOsaVzBEUakwCJ5V
 bx2mpGWek4rQUDqWotQ3lzuo8HK77C6gV4IdoAG6WJfXt2BEmrC66G2VWhGUuyd8i2aQ
 F2Lb3QodX3RpwOhBJBvAvq9DDUaKQ+nQuROR4RwVz0k2Wx5Ei8ZbEiXEgfZtBbmF9pq/
 6LHyUvVMyhQ6nNIsYGdgdABWjz06OLYUSbffJZLdCyfde85BicwlxQ3gA+5nAub496Py CA== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ujv4kt4ay-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 27 Aug 2019 17:08:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 20AD154;
        Tue, 27 Aug 2019 15:08:22 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CCE1B2B76DF;
        Tue, 27 Aug 2019 17:08:21 +0200 (CEST)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 17:08:21 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1473.003; Tue, 27 Aug 2019 17:08:21 +0200
From:   Gerald BAEZA <gerald.baeza@st.com>
To:     "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     Gerald BAEZA <gerald.baeza@st.com>
Subject: [PATCH v3 4/5] ARM: configs: enable STM32_DDR_PMU
Thread-Topic: [PATCH v3 4/5] ARM: configs: enable STM32_DDR_PMU
Thread-Index: AQHVXOlD6Kq1uoloYU2GrfhWvkfaXA==
Date:   Tue, 27 Aug 2019 15:08:21 +0000
Message-ID: <1566918464-23927-5-git-send-email-gerald.baeza@st.com>
References: <1566918464-23927-1-git-send-email-gerald.baeza@st.com>
In-Reply-To: <1566918464-23927-1-git-send-email-gerald.baeza@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-27_03:,,
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
index 6a40bc2..8fa4690 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1011,6 +1011,7 @@ CONFIG_PHY_DM816X_USB=3Dm
 CONFIG_OMAP_USB2=3Dy
 CONFIG_TI_PIPE3=3Dy
 CONFIG_TWL4030_USB=3Dm
+CONFIG_STM32_DDR_PMU=3Dm
 CONFIG_MESON_MX_EFUSE=3Dm
 CONFIG_ROCKCHIP_EFUSE=3Dm
 CONFIG_NVMEM_IMX_OCOTP=3Dy
--=20
2.7.4
