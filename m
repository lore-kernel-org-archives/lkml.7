Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60859C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2244B207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hdpc19K0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VsqfUi+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfKYNW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:22:26 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4276 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYNWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574688146; x=1606224146;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=evCkJbpp2d6kDzaEJY/xVtdr+/sHbZXz6c1/WWq2YBM=;
  b=hdpc19K0QDHpyYODvgs9JLZ7q/eeUwfRWMbhj37CE0EFNl79qOFC5r+J
   E9S8XJ1p+/Gr7rOGtvk3JIWV4eD5Pij4GTMawOJm8GmeLk787Pm0HVCPi
   2HfByVQBRj5JENO1xeWB4rUpA3GKUtLEk2+cNRCgntdck7k9PgCJQaZQj
   JtV2rq2E/0Lr+iXb6KqTO3Xz0pgnh3iF7LGKMjg29MYC+AA/PMEPUH43o
   hKbYq3PSTTWhLxE6nNACkZqUPx03KqEOYA0HZQNyZ1G7EZkWNh0oKE5RO
   aOK5HFNiHUAp+KknJb1osq65yKYOeM+OAfqZcGPPTCuBChVn75aavwkYn
   g==;
IronPort-SDR: 8Zn/j/YVVEaaVPpOiSkJGv6e8y8rV0lax1lgld+suhicplX0tNRM9frK43Z1ZVFhv5Y59jPsvi
 uXObooMnDbjuBgb2dfCWett4ohL3NGNYk7ihn++x1ZgtsUr8OGqP11qsnvGk1OQUEIXTqTWgrN
 IAmRHOqdf6lcKt5TFUMul5dOmt/0QN0lqHwKWWldxhjKY5ybc93RmmP7BpIZPpGZstFEJclHgo
 E2ZN3ca8nWNoS6RHMI7LVHsFRE1BLQBLmPs1q+yZK317LR5Y3cYoBL9ImextCSIOsFCkw25VcF
 M4k=
X-IronPort-AV: E=Sophos;i="5.69,241,1571673600"; 
   d="scan'208";a="125552352"
Received: from mail-co1nam03lp2059.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.59])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2019 21:22:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcZizsvtxfCMhHFFAC6dHiXEtdp4mrSVu9WbKJ06u1iWD6KlD7FgFQB2EeMr+bF6owBD0wtsBtERjhvyRToZsoC3bFV8Lr5b79hD78Kd2vPet6zGLCKYqYrJlDjmIWc1XWOpSrb9wcIgBXKwhoOe2sG5bcjU2UbMMHqtdPYds7BxpfWwAYwTZ/D/P1gjcD8QqkBKgkwpdUI9uJyIxGKgd7xVK8znCoql7gR8RDcj00UakvlnGmx7HxlqZ9Z7XlvgPI4HdxIBSNtdu2lWc8hIN3cijhebcLDmuNif5Cv4mEWoa+AFHLzANy+JIQ0UzM/hTQIrTJVlauvz88OEZ8wfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0aJwRYzyZ3/itQRkXNvUQhdjpGbb+Qm6goquC6DHqo=;
 b=Ln7Qnfh+F4qR853kub0HkiTzUqUbC86F33hH9iifA7B3MB+wk1fjuNz5NZOwQKQZUm9CR2qzJiMS03YYSoZCRBKnqWVpPEeiAgylsW/1juiF/vh+YzPvNAhB5iMlWQuCDfKYyXoarSzLNDpTcSJu+ca9j4bK1Z5Jrd3vmFVHPI7HRqxZ6zHFeVmyH1SCX4aRSq8WTmjYbz03VBriqPqGK7od5EqjNSm90baVK6z7pdchZmaDF0lc8pYrGKoYnu2EThxcw0sZts/kErwdEQ9Vejf4xuRvbkcqWvdRwikz7+/TvfRa+hu4kqK6pOJKOsKuRH7fFhr3/WAwDWDxyIWLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0aJwRYzyZ3/itQRkXNvUQhdjpGbb+Qm6goquC6DHqo=;
 b=VsqfUi+kuDtnCoqvZqYGLFJYawhomo5ShgoqZe2ekDZKu12HWUW6qA4PpaqUJHfDDBdBSYiW7xwqQlE3maTszZTkdMC8nLR7yQVe0zDuHU8mxe8fXEt+tmIRoQoXzEubzqySHwTSB3suT11y/4410wFf2UuGxaLsXDE8bD+ycLI=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5981.namprd04.prod.outlook.com (20.178.246.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Mon, 25 Nov 2019 13:22:14 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::7949:d205:5ad1:1d30]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::7949:d205:5ad1:1d30%7]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 13:22:13 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH 0/4] QEMU Virt Machine Kconfig option
Thread-Topic: [PATCH 0/4] QEMU Virt Machine Kconfig option
Thread-Index: AQHVo5NZE5Jo2xnU1keuEYpYfC9DRw==
Date:   Mon, 25 Nov 2019 13:22:13 +0000
Message-ID: <20191125132147.97111-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::15) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.21.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f351a5d-d865-493e-a415-08d771aa7bb4
x-ms-traffictypediagnostic: MN2PR04MB5981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5981029E9DC7CCB1E4A976488D4A0@MN2PR04MB5981.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(14454004)(50226002)(66946007)(8936002)(2906002)(81166006)(81156014)(6506007)(66476007)(6486002)(305945005)(25786009)(256004)(9456002)(54906003)(316002)(8676002)(4744005)(6436002)(66446008)(386003)(66556008)(64756008)(110136005)(99286004)(52116002)(186003)(26005)(5660300002)(102836004)(1076003)(44832011)(55236004)(478600001)(66066001)(2616005)(71190400001)(71200400001)(6116002)(3846002)(86362001)(6512007)(36756003)(4326008)(7736002)(2171002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5981;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yyj6j2+bqN3u33/hotz8YnmdxWtFmZwlQLVzgX5WxMiVsReq3x3Wrv6gTrb6+4UCukxbGe5EzGSdB/hisYwsHs7fsO7rYIaMDeZSl3mwZypGlacAlwdCAP6vwJmR149xAvE8XhRM145UAz2Ake4T0rWI6JgpSzqpAGGPiTVh7YQC7Ld4quZeuZtjuns1E4XGizMAmTuvbi46LouoRnYmu+dyTK+qWilhBFogRszVMwYPkVT44GHrAXBpFfiD3nGOGUd00pIySdGqiURuRo1T0KYWcB0bApXSjG02yW01URX7BYdGUd8MsMnZk7AYQDHgFKdNCuXedK3nf/aI02IjpsnB41JDrCrIo7BHof41CVXxd8lcIh52QOKoHJPRa+9KejAs8VwblZbTpA/3kGeXO1CCOZMSB6xbZ638/Vb2dvQK/8tznQ74sMTbiy6jv4cu
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f351a5d-d865-493e-a415-08d771aa7bb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 13:22:13.6945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LafyBGIZrPkLDDAvc6VYoK3Kd1qwQdFvqsqLi4LLkMkovyoOhrGZ4EYPbEj6Urk+fsUna/qA1hbcH7GGmC+94g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5981
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series primarily adds QEMU Virt machine kconfig opiton and
does related RV32/RV64 defconfig updates.

This series can be found in riscv_soc_virt_v1 branch at:
https//github.com/avpatel/linux.git

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

