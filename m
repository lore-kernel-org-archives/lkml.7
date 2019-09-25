Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83663C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413572054F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nx0VENwm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xWgYeRSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411624AbfIYE3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 00:29:54 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8923 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390426AbfIYE3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 00:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569385794; x=1600921794;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=sy7bw9A1dgchQPEOcdrZCFPR7e0jhnirUwAj72H/WcM=;
  b=Nx0VENwmPWxK/nGjNQvFPiR/MJhjUs4dVtjlLlQHCKWWCmChiwLvlthA
   bdl41ToNSH5IyWgo2mBjRKaDyr6NIeE8K72SLaAQIcCHWAbxonPCChU72
   C7jdMu3wTh68Fu3K4j2aCRyw5INuDBkGJnj/AnkGIMg6TfOP5re7aGs8s
   HDwGwSRs70XWiV6yeK7BR0J3VXOvVm6uTOq9oaJOl40M8uQCzQZXxC/H8
   odHXBLBWOFBfb2TZzlUbb+0h9X/7V8VgyIrkkdQIYLNtFKdHLLzTryZ4x
   cYtRmFhybwIu5xaeIiDbuiszz87IsBvo5tjnhoSNql8B2IA/l66fgYPgG
   g==;
IronPort-SDR: x7N0zbq1iNOPQMHE4iFWsNxHEh6pH10N0hOeAzcyxe9oKd1aOMqoH3cNkrTheuGNc+yoOYUGU2
 xdfLO7ojpUdGLhEzky8xCQ5DYoLV7tWUBe+b6bWHnHsoZbg/kWH+Nxf8ADhUXDzqLZtsUBeCM/
 rmdvLFUTyQHwSYSbUwJtxXpbrIfYBx5yyCjyoyQMXNpsh+3jyN2deWcRQkwaE8gL+wj+9/qOK/
 1RkRJVYw1Pj6UCnn7u2d4cl818RqMjOnLZH9ekrx3T+4PjB7U8b4VhlfLP0Oep0bA8eIGbpuoj
 c9A=
X-IronPort-AV: E=Sophos;i="5.64,546,1559491200"; 
   d="scan'208";a="119815051"
Received: from mail-cys01nam02lp2058.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.58])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2019 12:29:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vrk3moAglHaPfAV/Gg0ZBYdLGtxPtDzJjZLFaZfdMkg7we3SCd9MVfoPCrP5SfHexdCnT6ayMqcNY9keqif/GhOTtzpnHurtBYgKV3RF3BKH1gcQvUfN+/KoO+pecu7rWJiDGv6HBm9FPSwrO7G3dHThA4N1jUaZWIrpaOfXDvRKfAjwczoVoMBbslPymI4U9VTglIKblB2aEpmEsHnBYcHucFf5fxY/rgKtRV4Cphyz8MVl8Vyau7xCDG9PpaXdDkhG4e9E+JseuVgsMVjBxGO/CRuJBiY0xWT2KenGBGZZQ9RUSj1AwD3hwDEYrQFaw55DfWGyQoOTxUNppbyDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubKR6GBpv5yoFzYa2DiT46DRMrTZfYw1L6gA3ER9cuo=;
 b=OtS4H3XCMUK3ipibH+F2q8huzqg6UFxRKH/7eNYCY4jD2wpWKnjSpln0s9GBzMm6DymVuHM93iYufZBCfC7PPlodhg4TrYGBkYGH9BtHpF5YUgCpi/zsoDu8j9bG2mKGBg9X67OtLATyJ5M9X2EOXfkqlnq7lqkor9Va6y1AILCnLPYFN1672aj2r1woNcP1b9dg60Kf4j9RcuK/+uldOnaNyPzDY1vA0UXMvif0y9QEk4sZdrHx2a9gp2Ca9UP5Pl67rRM9bihh2/2C4MsBYpDi+dsJWvHReotaACfUFhzj3GTRiM2jshhssFIA5oDMmWyp+ozy6T9pWoH3AHOsKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubKR6GBpv5yoFzYa2DiT46DRMrTZfYw1L6gA3ER9cuo=;
 b=xWgYeRSqJFSgLn8gr1cAqBdUdJqZUWJFuipxbC1itm2hdLHQLQyNdrLQ0ZrNHOKYrK4WI+1qIY8QtsJbS3Hx/Ejz4jYDBWhcgxO7usGXGFzzAvd5XFi6KDQ7kSuMHnY4s7jXWXYPDtcB84lOOMKw5ylJx9kVdFxOR9Oe/+GJXH8=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5805.namprd04.prod.outlook.com (20.179.20.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Wed, 25 Sep 2019 04:29:50 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 04:29:50 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roman Kiryanov <rkir@google.com>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH 0/2] Enable Goldfish RTC for RISC-V
Thread-Topic: [PATCH 0/2] Enable Goldfish RTC for RISC-V
Thread-Index: AQHVc1nepxqfGWFS50OoivEjdAa3tA==
Date:   Wed, 25 Sep 2019 04:29:50 +0000
Message-ID: <20190925042912.119553-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::15) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc54e0aa-ea00-4846-4b85-08d7417100e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5805;
x-ms-traffictypediagnostic: MN2PR04MB5805:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5805E495440354B1FEE4EDF08D870@MN2PR04MB5805.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(189003)(25786009)(6506007)(316002)(186003)(256004)(4326008)(5660300002)(50226002)(8936002)(476003)(4744005)(26005)(14444005)(2616005)(2906002)(486006)(44832011)(99286004)(81156014)(81166006)(6116002)(3846002)(2171002)(36756003)(102836004)(6436002)(52116002)(6306002)(14454004)(6486002)(66556008)(71200400001)(8676002)(71190400001)(66446008)(66476007)(66946007)(64756008)(305945005)(110136005)(7736002)(478600001)(54906003)(6512007)(1076003)(86362001)(386003)(966005)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5805;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: igm0aYLscvYME82zsMqfGG6kPM1izxXKZqII7TORDIzR92jihR5vmDik2QxVgfcGi4Uf/GVHorm6nQfXhIaBnNFTrD85o2ZaCIKVCa1aar2HDMOLHgbxABxgN0/KMvhl7fH5qPEIKM2l0iqXjZ26fayDDxSjTCYdRbmw/AcxF1saG/Eo+VMHvsA4yMIBEH3Nuhe74qWm5Z9q/zNj5UwZYM7+ggDnNJKwa+fMB/7N+FRIQ42EwK7NUQNwzRvs64AIW9JNAxd9jHnNGqYPLtLRGBTwnXIihlf2edHbRskrnsOsTz0Unwdr3VdFrJBbmox28x1bgiKRPXeT7u021b/XIug6ZkB3I1QJyq26+TwABC0EbwgSDqJOVt1FHJytwJYRqDEvDH2wzhoYCLrgtWkHgQBU8rKvHJJy85e4hz0zsK3USRx/37Xr0uATIJ0DdIIXcF+welu5dv5y8GznUQj+Lg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc54e0aa-ea00-4846-4b85-08d7417100e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 04:29:50.6498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1R3b8T53+5aDA7c/lgluP/dfKsit4Xi77QAQN9PWhImEB8Il3NLGGpyHnh/hKDOU0dDlXsE5pguK6llGa49FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will be using Goldfish RTC device real date-time on QEMU RISC-V virt
machine so this series:
1. Allows GOLDFISH kconfig option to be enabled for RISC-V
2. Enables GOLDFISH RTC driver in RISC-V defconfigs

This series can be found in goldfish_rtc_v1 branch at:
https//github.com/avpatel/linux.git

For the QEMU patches adding Goldfish RTC to virt machine refer:
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg05465.html

Anup Patel (2):
  platform: goldfish: Allow goldfish virtual platform drivers for RISCV
  RISC-V: defconfig: Enable Goldfish RTC driver

 arch/riscv/configs/defconfig      | 3 +++
 arch/riscv/configs/rv32_defconfig | 3 +++
 drivers/platform/goldfish/Kconfig | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

--
2.17.1
