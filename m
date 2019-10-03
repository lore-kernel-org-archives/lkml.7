Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777E3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0D621A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="tWLZ2rCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfJCKIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:08:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46642 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727410AbfJCKIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:08:34 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x93A2vsa020834;
        Thu, 3 Oct 2019 12:08:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=aOluPCF6ESczZ7lBj75ysirYywqU6TpjFJ3pKXx14HA=;
 b=tWLZ2rCpdbtQMBUgXGvr/BC7PDLIdTDZcXKZvrsSlLQ+QdRLZewXN7uj6MTgO+2VeCeh
 GX4lh9VcZmScLP2p2lmbpdVH4Gxtb1yWC5IVj/0JYA0BgcKqXxnL9PRXoYHf2E3rUqzX
 /6Le48HXrwFWbeOIsMy8NUU+TCLl/Zl8CBLtK1iQ+UoU+Fi+QjPp1cvYAe4I5UP1xzLj
 39bQW4u6cYieeCSTSDvHk0T7Hklv2O5jROxhLy+QZZowsAzf1zJ07Gp0BqkW6EmDUBW9
 gs3nQ9Dfat/5SFN3quriPKhjEZHsmLL8JKmV+UAqbeVJINAh/9dn6s2GYPmJNdIl39EQ lA== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2v9xdh3kq6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 03 Oct 2019 12:08:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 27E3822;
        Thu,  3 Oct 2019 10:08:07 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CC98B2B00F7;
        Thu,  3 Oct 2019 12:08:06 +0200 (CEST)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Oct
 2019 12:08:06 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1473.003; Thu, 3 Oct 2019 12:08:06 +0200
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
Subject: RE: [PATCH v3 0/5] stm32-ddr-pmu driver creation
Thread-Topic: [PATCH v3 0/5] stm32-ddr-pmu driver creation
Thread-Index: AQHVXOk+As8mb1s6+UKuO5XjiYJqiadI6qNQ
Date:   Thu, 3 Oct 2019 10:08:06 +0000
Message-ID: <013321ff60ae44da892d806fbd3024d4@SFHDAG5NODE1.st.com>
References: <1566918464-23927-1-git-send-email-gerald.baeza@st.com>
In-Reply-To: <1566918464-23927-1-git-send-email-gerald.baeza@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-03_04:2019-10-01,2019-10-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

Gentle reminder for this review.

Thanks in advance !

G=E9rald

> From: Gerald BAEZA <gerald.baeza@st.com>
>=20
> The DDRPERFM is the DDR Performance Monitor embedded in STM32MP1
> SOC.
>=20
> This series adds support for the DDRPERFM via a new stm32-ddr-pmu driver,
> registered into the perf framework.
>=20
> This driver is inspired from arch/arm/mm/cache-l2x0-pmu.c
>=20
> ---
> Changes from v1:
> - add 'resets' description (bindings) and using (driver). Thanks Rob.
> - rebase on 5.2-rc1 (that includes the ddrperfm clock control patch).
>=20
> Changes from v2:
> - rebase on 5.3-rc6 that has to be completed with
>   'perf tools: fix alignment trap in perf stat': mandatory.
>   'Documentation: add link to stm32mp157 docs': referenced from this seri=
es.
> - take into account all remarks from Mark Rutland: thanks for your time!
>   https://lkml.org/lkml/2019/6/26/388
> - fix for event type filtering in stm32_ddr_pmu_event_init()
>=20
> Gerald Baeza (5):
>   Documentation: perf: stm32: ddrperfm support
>   dt-bindings: perf: stm32: ddrperfm support
>   perf: stm32: ddrperfm driver creation
>   ARM: configs: enable STM32_DDR_PMU
>   ARM: dts: stm32: add ddrperfm on stm32mp157c
>=20
>  .../devicetree/bindings/perf/stm32-ddr-pmu.txt     |  16 +
>  Documentation/perf/stm32-ddr-pmu.txt               |  37 ++
>  arch/arm/boot/dts/stm32mp157c.dtsi                 |   8 +
>  arch/arm/configs/multi_v7_defconfig                |   1 +
>  drivers/perf/Kconfig                               |   6 +
>  drivers/perf/Makefile                              |   1 +
>  drivers/perf/stm32_ddr_pmu.c                       | 426 +++++++++++++++=
++++++
>  7 files changed, 495 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/stm32-ddr-
> pmu.txt
>  create mode 100644 Documentation/perf/stm32-ddr-pmu.txt
>  create mode 100644 drivers/perf/stm32_ddr_pmu.c
>=20
> --
> 2.7.4
