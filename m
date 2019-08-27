Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CFAC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19257214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="K3vuiPZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfH0PJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:09:10 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58816 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730276AbfH0PJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:09:03 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RF2Bim026535;
        Tue, 27 Aug 2019 17:08:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=STMicroelectronics;
 bh=gUrvHgWah4ogK3e4d0X42dS33drOe0YLe+g4hljra6o=;
 b=K3vuiPZdjQRwuogyBGGmCVwVhUnIoztJkMiE1atuBbpcgX/pyRAoXcs5vvR7NKZV8d9I
 dhCVBrBKLVTOrgfA+uYNNn3fAOTl2mwmCqRbyUfeX56+2dELOgN2slqYDBmv5erAtZQG
 PSggwkbHt1sLpmJbAQQFaBFNnBkLNCqItHazJrQ/W+bEJRMMAugfn+aFT/UmBhjrNZfY
 SQHsqpnZ5GBliovconIptSZzgg+pvSIErx31m6qhleoTPQDxUwH5bP6NvD8egP9m0Kr9
 fR7CwnctL7LSMsDyG1TtlhWJlNXoRIYxB7KnkAZF6yyVIR+87QjN2jFUgdPVWspNbUFX KQ== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ujv4kt4a8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 27 Aug 2019 17:08:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C14A222;
        Tue, 27 Aug 2019 15:08:13 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D24672AFE03;
        Tue, 27 Aug 2019 17:08:12 +0200 (CEST)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Aug
 2019 17:08:12 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1473.003; Tue, 27 Aug 2019 17:08:12 +0200
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
Subject: [PATCH v3 0/5] stm32-ddr-pmu driver creation
Thread-Topic: [PATCH v3 0/5] stm32-ddr-pmu driver creation
Thread-Index: AQHVXOk+As8mb1s6+UKuO5XjiYJqiQ==
Date:   Tue, 27 Aug 2019 15:08:12 +0000
Message-ID: <1566918464-23927-1-git-send-email-gerald.baeza@st.com>
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

The DDRPERFM is the DDR Performance Monitor embedded in STM32MP1 SOC.

This series adds support for the DDRPERFM via a new stm32-ddr-pmu driver,
registered into the perf framework.

This driver is inspired from arch/arm/mm/cache-l2x0-pmu.c

---
Changes from v1:
- add 'resets' description (bindings) and using (driver). Thanks Rob.
- rebase on 5.2-rc1 (that includes the ddrperfm clock control patch).

Changes from v2:
- rebase on 5.3-rc6 that has to be completed with
  'perf tools: fix alignment trap in perf stat': mandatory.
  'Documentation: add link to stm32mp157 docs': referenced from this series=
.
- take into account all remarks from Mark Rutland: thanks for your time!
  https://lkml.org/lkml/2019/6/26/388
- fix for event type filtering in stm32_ddr_pmu_event_init()

Gerald Baeza (5):
  Documentation: perf: stm32: ddrperfm support
  dt-bindings: perf: stm32: ddrperfm support
  perf: stm32: ddrperfm driver creation
  ARM: configs: enable STM32_DDR_PMU
  ARM: dts: stm32: add ddrperfm on stm32mp157c

 .../devicetree/bindings/perf/stm32-ddr-pmu.txt     |  16 +
 Documentation/perf/stm32-ddr-pmu.txt               |  37 ++
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   8 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/perf/Kconfig                               |   6 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/stm32_ddr_pmu.c                       | 426 +++++++++++++++++=
++++
 7 files changed, 495 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/stm32-ddr-pmu.tx=
t
 create mode 100644 Documentation/perf/stm32-ddr-pmu.txt
 create mode 100644 drivers/perf/stm32_ddr_pmu.c

--=20
2.7.4
