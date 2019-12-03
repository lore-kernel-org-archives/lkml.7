Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AE5C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A010F206E1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rFg8xO07";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SPpfwuCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLCDtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:49:35 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65119 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfLCDta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575344969; x=1606880969;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=G0KUVm2FQzknDf4W8VHl6rHywV0n7uw1wTnadtoxEk0=;
  b=rFg8xO07fPDJWVWKHr1rZPXPlVQxn5yoDNJdutP3e9UQwJoXH1bFIStR
   7KllDVavhltxh833VoRzk0dE916rjik40tSb29mJpZewautZSQk3hxwUP
   dUFFmkU/tSP/FwLmtUIWMsfAkqXEr8ClZyhFtMyW9ZqUnilRN5w1WEIgP
   wvwvKMJ6FUH4hHyOEZMaKBVu10W1czWsjF+guYhlPvjUcUfkkk4DrH8zA
   lpOHY8Olv4Sd6c517vLpoMoVvX12KSAt15Ypxlg26B51x9Ud3HNFwuwtz
   BOGjaAQhnnAV9XGEf+2FrYmafdi25vmeQwm71522Dn0ZjXdFIrBTrMBXf
   g==;
IronPort-SDR: aEDeN4J7lxJ4dbFQzqDLnwjugW6VaSZFALpuTZR9/VB1WUFVNu0tlIeVzCodI6SOSutRauk+VA
 k0Mf/b41VRLCQNzGIUUe0lx3it+2QmbpzCDi4s1vQJE3czlXC2gslUtWC9xpZosK5ixVvuKi8w
 io/3sE5FEhk/a7IZIoJzV4UV/xekdsoRMQMKoW0K8umGfmYjJrDxySwOi3/kxo/ZUIqMxYaj7D
 cYba7XgZD86cPI7KsLgzR+UsVKCwF0rztQ+wUs0KbvNXFY8Ebtmc+hoWHUIFDTKaX7cqxhUaXC
 +XQ=
X-IronPort-AV: E=Sophos;i="5.69,271,1571673600"; 
   d="scan'208";a="231947957"
Received: from mail-sn1nam01lp2053.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.53])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2019 11:49:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLN6ipWazo9D7oI/nLbCKJJ7iKaC+avfECLQo0i7jQ2QnROoTsAOkDCsRcS1HxLsRusbHLadxA+PG5G4Dzu4rfqhhUZh/NmIff4rAkkJ2M+N3TjXKdrSghNJxvFHSMB8yzKkoBB6b2ozJLCz/SK1Kqix9Fg/i8yEmSwWhbZlxEaBVOGkADMj1KYmMUfwUslPwP3Ts8Iiz3nB9JiPTKvwWLb5R8WTG1joYsapsGSws2a/uvwSV/k9tFu58Fb5Ny8yGI2lkuqZVgcEDtXh7J8vmUBIr2P9sxVog+/WflbI13OaIR8wVZO9Sr3hQ46S8R0P7DhH4aybY/n2q2uwPlOQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt+0R8J6QUOgksrjfWkj4r6f4wHsinWtPE6KFGtfKHI=;
 b=AhQBSmxua6pF7Xemy1pLmsREKid3IVPmQkZHLrKfw6hnGK/nCy6E7bt8Rxd1wfmq9G4zTld165fUOejhbOzEQDdStRwrf+5brG4VqZlgaDPCLVueIKGD06F3YN6QXImXhNZT7dTjYDfqO/2gCzSpIJ3QWXyfW3jr5AAJeqA+V416tgdfRZpZX78B/oo/0c/5UZ8AHOlZv4uB/bsfRdxDU74Ot7rxoG8ogirEXHesKiFePCCRifJg7GniTNblBSP9BSdJPkRFuSkDMoU+DbIz234ApJ3eaabvVu+FDiUinc+ow9ArQmPsjYC5fXmBafJSy6RYAryB2vxE+TUTvdMNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt+0R8J6QUOgksrjfWkj4r6f4wHsinWtPE6KFGtfKHI=;
 b=SPpfwuCgdUzSclDC6lwYWOAH4vfd4yt83UC/Jbbq5BXLrSAvB8ucWPNG89ORmMg+Wl1zPw2rfZi02/qIiWVlONnp7hu2bPffHvR3yIxhhoOpGWSNJHa7dlJKGuoN1hO0nNw9ZfpvaI2hjlzudGbDitmY0PpqYB0yQSk4HCS2ZsY=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5807.namprd04.prod.outlook.com (20.179.22.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Tue, 3 Dec 2019 03:49:28 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::7949:d205:5ad1:1d30]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::7949:d205:5ad1:1d30%7]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 03:49:27 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2 0/4] QEMU Virt Machine Kconfig option
Thread-Topic: [PATCH v2 0/4] QEMU Virt Machine Kconfig option
Thread-Index: AQHVqYypfP5NcMqDjEOlOAueLUJ8PQ==
Date:   Tue, 3 Dec 2019 03:49:27 +0000
Message-ID: <20191203034909.37385-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::40) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [12.169.102.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f38179f-40ad-414c-6f52-08d777a3cb8c
x-ms-traffictypediagnostic: MN2PR04MB5807:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB58075A60402F1D0E198A36F08D420@MN2PR04MB5807.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(66556008)(6116002)(3846002)(66446008)(66476007)(64756008)(66946007)(25786009)(52116002)(6506007)(386003)(186003)(305945005)(7736002)(26005)(102836004)(478600001)(316002)(71190400001)(71200400001)(14454004)(44832011)(256004)(2616005)(2906002)(66066001)(81166006)(8676002)(50226002)(81156014)(8936002)(110136005)(54906003)(4744005)(4326008)(5660300002)(99286004)(2171002)(6436002)(36756003)(6486002)(6512007)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5807;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oejHjTDKEPX0xVKkfhRkCrXNb0qxZWiuhCXLYLUvxlQSNXBCwtDOMzWe/WTALFokABtbA+FQ4CMdpBjpXgvVrCLI392DZiFpNu5XSt/h+YMWBW5kz+0Y2RT37uQx7EbpuOgnxREf2X4LItZUukkGXUwrVkOIsm1SeUMEtryzU+QLZuoTFpk0759+xUsP0Iv6sW1iJ0ojUv6TCAJcV7xEDpxXVkAEhw5W50aDnrz6U+PS+0S0gf2uQZCTeNOLqf16/csae7LQkq16lWV7TWRuMmo9gNKfcpDZSNx4GKTUqx1TervKnfKkA8VccmXzkfLmNSkAkVhwc4x3OFx9ss3jwo6NrVClCEVEd2syP6rOdoGGXKG8eBw8L/xbdpASL3TNYtpIUf7bY2bLfocIRaWDn3De5tshIeema/xv2CLo30Q7OtJZinBnW1D+MtTKibQp
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f38179f-40ad-414c-6f52-08d777a3cb8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 03:49:27.7705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7c+sevKMD00l7GzboaqmUk/bNR0hJe5/NXbGyqzefyZEtvFPjqEXz3AXLpftZncZ9cRj3yyGBBuHVxJcIOHv3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5807
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series primarily adds QEMU Virt machine kconfig opiton and
does related RV32/RV64 defconfig updates.

This series can be found in riscv_soc_virt_v2 branch at:
https//github.com/avpatel/linux.git

Changes since v1:
 - Fixed commit description in PATCH2
 - Rebased series on latest Linus's master branch at
   commit 76bb8b05960c3d1668e6bee7624ed886cbd135ba

Anup Patel (4):
  RISC-V: Add kconfig option for QEMU virt machine
  RISC-V: Enable QEMU virt machine support in defconfigs
  RISC-V: Select SYSCON Reboot and Poweroff for QEMU virt machine
  RISC-V: Select Goldfish RTC driver for QEMU virt machine

 arch/riscv/Kconfig.socs           | 24 ++++++++++++++++++++++++
 arch/riscv/configs/defconfig      | 17 +++--------------
 arch/riscv/configs/rv32_defconfig | 18 +++---------------
 3 files changed, 30 insertions(+), 29 deletions(-)

--=20
2.17.1

