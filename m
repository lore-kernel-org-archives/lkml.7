Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36877C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBE921871
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ebizXI9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfCNQ0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:26:35 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7020 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfCNQ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:26:35 -0400
X-IronPort-AV: E=Sophos;i="5.58,478,1544511600"; 
   d="scan'208";a="28204132"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Mar 2019 09:26:34 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Mar 2019 09:26:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USsFL0/AHDAxshJuY+W4CJz6eHdZRtxYc4xJpUbQiKI=;
 b=ebizXI9eUT5tF+ZrnKutVIJZHedmsgczNv5Umc6ukTfZcSXIvOp51ADs1tHs98HRQQxzLkcTWsneQPMT0YQE1RnJYbLP6AVmHep5dwzqrA9r78vHw0H0Bmk1dgTsCWFdPmlbsPGl7Bnik7L4f0i4TX9BCFmRYdR89MHSqxqj5S0=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB0061.namprd11.prod.outlook.com (10.164.204.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 16:26:30 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%9]) with mapi id 15.20.1686.021; Thu, 14 Mar 2019
 16:26:30 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 0/2] add Microchip PIT64B timer
Thread-Topic: [PATCH 0/2] add Microchip PIT64B timer
Thread-Index: AQHU2oKuzP5So9KpPEq5C3g4nsIwMQ==
Date:   Thu, 14 Mar 2019 16:26:30 +0000
Message-ID: <1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0088.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::32) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [86.120.234.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3c9fbcb-0662-4ada-d895-08d6a899d04d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB0061;
x-ms-traffictypediagnostic: MWHPR11MB0061:
x-microsoft-antispam-prvs: <MWHPR11MB0061775C692552B0D71995EB874B0@MWHPR11MB0061.namprd11.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(366004)(396003)(189003)(199004)(107886003)(305945005)(106356001)(7736002)(316002)(478600001)(86362001)(2201001)(72206003)(256004)(25786009)(99286004)(53936002)(6512007)(4326008)(8676002)(105586002)(81156014)(81166006)(54906003)(110136005)(50226002)(14454004)(6116002)(3846002)(66066001)(8936002)(97736004)(5660300002)(68736007)(2501003)(102836004)(6436002)(2906002)(71190400001)(386003)(2616005)(6506007)(476003)(186003)(71200400001)(26005)(52116002)(36756003)(6486002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB0061;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3CwpMepr4X462O4hTRqPgj2SzCNtT6zft72LDmtvZBUsaAidbatQ1PJqWGx7G0QMMwt6zbd5ImUqLSxjT2CwVoBeGqmX/LEe8OAKAkM1ctiqOc01cxnKseUeNeJ/bJFQffrQeWwzXi0ovxqm7arpd2M2frHDig/uf+qnQv0J/irkcsaEYK4K4KeypxqagiZpB9E9yKZR+V1Hw4yqdoPccnnRf2zjXqNJVKhQWhO3wZ8LOz3HtcP/NmKPlPVa9v3WSojN6s5PKlUiQtg8Lbe7O2In0y0zvxpatUBoDzxBbMZtHd6oUVdzm2fNSxdumCAPlxPBIR4Ojo/2kIfv2Yt49iVI606RA6wU/ZAoKGWtVDoCNn7aAK9ePliXPE4A9OUTSeWOU95agYP8wloVxm78v9QZjOJclhdYMhrEbTUNA6o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c9fbcb-0662-4ada-d895-08d6a899d04d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 16:26:30.1142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0061
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Hi,

This series adds driver for Microchip PIT64B timer.
Timer could be used in continuous or oneshot mode. It has 2x32 bit register=
s
to emulate a 64 bit timer. The timer's period could be configured via LSB_P=
R
and MSB_PR registers. The current timer's value could be checked via TLSB a=
nd
TMSB registers. When (TMSB << 32) | TLSB value reach the (MSB_PR << 32) | L=
SB_PR
interrupt is raised. If in contiuous mode the TLSB and TMSB resets and rest=
art
counting.

This drivers uses PIT64B capabilities for clocksource and clockevent.
The first requested PIT64B timer is used for clockevent. The second one is =
used
for clocksource. Individual PIT64B hardware resources were used for clockso=
urce
and clockevent to be able to support high resolution timers with this PIT64=
B
implementation.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  dt-bindings: arm: atmel: add bindings for PIT64B
  clocksource/drivers/timer-microchip-pit64b: add Microchip PIT64B
    support

 .../devicetree/bindings/arm/atmel-sysregs.txt      |   7 +
 drivers/clocksource/Kconfig                        |   6 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-microchip-pit64b.c       | 469 +++++++++++++++++=
++++
 4 files changed, 483 insertions(+)
 create mode 100644 drivers/clocksource/timer-microchip-pit64b.c

--=20
2.7.4

