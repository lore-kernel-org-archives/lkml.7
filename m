Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CC9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C190D20643
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="p8vWYBuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKUQMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:12:23 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27342 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbfKUQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:12:23 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALFq6jY032620;
        Thu, 21 Nov 2019 17:11:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=t+47w3ZxOzPvOfnpHUIZTNysGQGkRlS9if3BoXHEp/c=;
 b=p8vWYBuX6eITDAoXWYZA61KOdd4iq4NhRXTUYCVWt8N/AkTLVq2MPadHjY//4W2KPkvg
 X8Ujq4pLwkmnAvLUBF72d1DdE3rtw5cBZRko6ozJsdgDlJZ59qA5xul+X9FRCegno9ys
 D7csLi4X5StafcofndVVieUXGMLXtxYD81kBkH03ZMMMMG/QBe9OkgD0KCVqMTpphCFU
 Uzu09qezYWTeLM0lDTr4YnPqm1oxwul6shBVKztUAswwEln2HHDJ9B3Tu+NiJd1LH4i5
 Rj+6xtnZdfJTjnKSBcYm9EfJ8UOrCimrjbMEeQDEjARCdyDBI3rOn0Oz0OctGFNUtvIP MQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wa9ujc9ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 17:11:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4C80910002A;
        Thu, 21 Nov 2019 17:11:53 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 152102C084E;
        Thu, 21 Nov 2019 17:11:53 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 21 Nov 2019 17:11:52
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/5] USB support on stm32mp157 boards
Date:   Thu, 21 Nov 2019 17:11:52 +0100
Message-ID: <20191121161152.25541-1-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_03:2019-11-21,2019-11-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for USB (Host and OTG) on stm32mp157a-dk1.
USB OTG HS is forced in Peripheral mode.
This patchset also fixes USB on stm32mp157c-ev1: USB PHYS supplies were missing
(CONFIG_REGULATOR_STM32_PWR) and usbotg_hs node requires phy-names property to
get the phy.

Amelie Delaunay (5):
  ARM: multi_v7_defconfig: enable STM32 PWR regulator
  ARM: dts: stm32: enable USBPHYC on stm32mp157a-dk1
  ARM: dts: stm32: enable USB Host (USBH) EHCI controller on
    stm32mp157a-dk1
  ARM: dts: stm32: enable USB OTG HS on stm32mp157a-dk1
  ARM: dts: stm32: add phy-names to usbotg_hs on stm32mp157c-ev1

 arch/arm/boot/dts/stm32mp157a-dk1.dts | 28 +++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts |  1 +
 arch/arm/configs/multi_v7_defconfig   |  1 +
 3 files changed, 30 insertions(+)

-- 
2.17.1

