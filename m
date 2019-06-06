Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7D5C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855C62070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="VAV1B5Ok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfFFMPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:15:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:30654 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726522AbfFFMPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:15:19 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56C7Efh017662;
        Thu, 6 Jun 2019 14:14:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=2ao/1Ko28jWmrR5KQ2lgMosqcwhFq37QstmQ1+57bmQ=;
 b=VAV1B5Ok6Fy7pGBgTGRVh59NUpaOP8Ypt7x+6i5fW58wXFKyH9oPqDvXyc7sXBwAJp6j
 IuPsKQscjFzxfrcUAJpxWvJH/csMGT4t9BzeQpcnUcEzU6NmVXUBPSyZQxZqYWR9SjoE
 I9BsWX0nIgt+j2UsuubA/8Yu4h3fK5EdgKwqwrHmDeqvggGGxEm0ZCVIEmmUrU9gO5d6
 1kz4okJfV4oqkBzD3+fKECiO7YqeotXFyhaEPWF+149BErfswcsQsoy9sNlhDVqVzJx3
 gP02dhwaMWcvNI+3C0UaCGcMJtqf9XEhUWRVYMvfwHhsiGQnvpvSES88gmdNYFDhLwj7 3A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2sxqyab5qv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 06 Jun 2019 14:14:47 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3E45331;
        Thu,  6 Jun 2019 12:14:45 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0980E2718;
        Thu,  6 Jun 2019 12:14:45 +0000 (GMT)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 6 Jun
 2019 14:14:44 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1347.000; Thu, 6 Jun 2019 14:14:44 +0200
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v2 0/5] stm32-ddr-pmu driver creation
Thread-Topic: [PATCH v2 0/5] stm32-ddr-pmu driver creation
Thread-Index: AQHVDyCA+bIWujGZrUGYoRHYm+G4SqaOo0BA
Date:   Thu, 6 Jun 2019 12:14:44 +0000
Message-ID: <f886ca5ef786493a8a5c7859465d6822@SFHDAG5NODE1.st.com>
References: <1558366019-24214-1-git-send-email-gerald.baeza@st.com>
In-Reply-To: <1558366019-24214-1-git-send-email-gerald.baeza@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

A gentle reminder to get your feedbacks on the series below.

Best regards

G=E9rald



> -----Original Message-----
> From: Gerald BAEZA <gerald.baeza@st.com>
> Sent: lundi 20 mai 2019 17:27
> To: will.deacon@arm.com; mark.rutland@arm.com; robh+dt@kernel.org;
> mcoquelin.stm32@gmail.com; Alexandre TORGUE
> <alexandre.torgue@st.com>; corbet@lwn.net; linux@armlinux.org.uk;
> olof@lixom.net; horms+renesas@verge.net.au; arnd@arndb.de
> Cc: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; lin=
ux-
> stm32@st-md-mailman.stormreply.com; linux-kernel@vger.kernel.org;
> linux-doc@vger.kernel.org; Gerald BAEZA <gerald.baeza@st.com>
> Subject: [PATCH v2 0/5] stm32-ddr-pmu driver creation
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
> Gerald Baeza (5):
>   Documentation: perf: stm32: ddrperfm support
>   dt-bindings: perf: stm32: ddrperfm support
>   perf: stm32: ddrperfm driver creation
>   ARM: configs: enable STM32_DDR_PMU
>   ARM: dts: stm32: add ddrperfm on stm32mp157c
>=20
>  .../devicetree/bindings/perf/stm32-ddr-pmu.txt     |  20 +
>  Documentation/perf/stm32-ddr-pmu.txt               |  41 ++
>  arch/arm/boot/dts/stm32mp157c.dtsi                 |   9 +
>  arch/arm/configs/multi_v7_defconfig                |   1 +
>  drivers/perf/Kconfig                               |   6 +
>  drivers/perf/Makefile                              |   1 +
>  drivers/perf/stm32_ddr_pmu.c                       | 512 +++++++++++++++=
++++++
>  7 files changed, 590 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/stm32-ddr-
> pmu.txt
>  create mode 100644 Documentation/perf/stm32-ddr-pmu.txt
>  create mode 100644 drivers/perf/stm32_ddr_pmu.c
>=20
> --
> 2.7.4
