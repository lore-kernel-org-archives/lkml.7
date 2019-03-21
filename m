Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0987EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B85320850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g2ArM0Va";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fHYtGTV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfCUJrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:47:40 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33266 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfCUJrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553161660; x=1584697660;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=3NR3JdXMObXsOMllAUE01pI69BnRgki4wsNx0ew1O28=;
  b=g2ArM0Va7HB+Hek8pqUsYYMR4KU2t6dZoqIIDuPp+bbpcja64g2GovnA
   m3b3V7D3MR5szid5hKvJ66wsnVRx3bhbtQtWvP1Ks3dNajE3WVlg0c7ND
   g54vbeDnGkCwobPU3PV8jOLG5yjnbGra5wOK+UpCVY6cajv6uRrGgt4CP
   syMx5gKR23Nk0JZvHdn/gjGT9X4qvETPrtT1Ow4PAa72/5CbWqAN3Oh1h
   OH+9uz/CA11dOd59INj/+NozYii7aLHTTZEsw+6OppOk4OL9/bFAERkeB
   ET4MDk0RKWQpWM2NYTWap9o9kMqGkIwbazBRpWPTMAF2MMRDPyYEGNWf+
   g==;
X-IronPort-AV: E=Sophos;i="5.60,252,1549900800"; 
   d="scan'208";a="105647542"
Received: from mail-by2nam05lp2051.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.51])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2019 17:47:39 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eP0HVLjKZpEPTh+nA82nOUcetLgT7SGQkcnciC/jCcM=;
 b=fHYtGTV1Q1GKdImUxRSaGDcsPbZXYcowsDobuyFCVO+iIpNoPzI89EnmrFUotUyBYCSG7oeYV48Z9vYVJP7qGvTMVV96Wyz3WGY/Kx+TGdOwvC9hfnMLyiBlx0nLXjHg5aAqrPtug3Ktwy4l1bsgoX0tXzVlCQSs1Rcf+KI6rbg=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5757.namprd04.prod.outlook.com (20.179.21.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 21 Mar 2019 09:47:36 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819%4]) with mapi id 15.20.1730.013; Thu, 21 Mar 2019
 09:47:36 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2 0/5] Boot RISC-V kernel from any 4KB aligned address
Thread-Topic: [PATCH v2 0/5] Boot RISC-V kernel from any 4KB aligned address
Thread-Index: AQHU38sdwDGIWUY7eUuUlcce4MfVqQ==
Date:   Thu, 21 Mar 2019 09:47:36 +0000
Message-ID: <20190321094710.16552-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR0101CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::23) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.18.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5ba726e-f766-4584-de1d-08d6ade23f86
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB5757;
x-ms-traffictypediagnostic: MN2PR04MB5757:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB5757BEE1170D9FC37C7DDE8B8D420@MN2PR04MB5757.namprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(54906003)(1076003)(68736007)(110136005)(316002)(6436002)(81166006)(2906002)(78486014)(8936002)(5660300002)(25786009)(50226002)(6486002)(52116002)(102836004)(6506007)(36756003)(386003)(26005)(9456002)(186003)(97736004)(99286004)(476003)(486006)(2616005)(44832011)(81156014)(105586002)(14454004)(4326008)(72206003)(106356001)(256004)(86362001)(55236004)(6512007)(71190400001)(7736002)(71200400001)(66066001)(3846002)(478600001)(305945005)(6116002)(53936002)(2171002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5757;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wBgsYAFQ75kzIHyXZGAJ77CniMyZP/yOG31QWscClRt2T++H4PQdVLu5GGxrSU6HetMUrI3x20CZ/wxurVLobWZU84ZDvGLsMPjvaEhbBEsA3trh+Fr6JfYXRZFV8u/8ySWHhkfbyaUnstiBlHwUGR36SOHSJVtpc+ttoJNL/oQ+gF+Ce6RdbmYfQdaBzt3vPUuxBkUyRE/Z6HshaD1WVQuxraHLg5tYC48TAHh8rekaIlar7O0k8LM186F0mUpOKfGGrdy9NRWwAZWftAVd/2b96LlwUVp4jX482eikfhqr2fA3LOngAvvP/VdhPnpp+VGmCN1CRt1SNtBnhdVNR0YewyH1fyMRHeAJ/l88YcYhQii8CZzRqhLwBQF6JL2SahKy3rhzQooAp7QYodvdMJ1KVEPFNvWnWi0h2iPzt1A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ba726e-f766-4584-de1d-08d6ade23f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 09:47:36.2683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset primarily extends initial page table setup using fixmap
to boot Linux RISC-V kernel (64bit and 32bit) from any 4KB aligned address.

We also add 32bit defconfig to allow people to try 32bit Linux RISC-V
kernel as well.

The patchset is based on Linux-5.1-rc1 and tested on SiFive Unleashed
board and QEMU virt machine.

It can also be found in riscv_setup_vm_v2 branch of
https//github.com/avpatel/linux.git

Changes since v1:
- Add kconfig option BOOT_PAGE_ALIGNED to enable 4KB aligned booting
- Improved initial page table setup code to select best/biggest
  possible mapping size based on load address alignment
- Added PATCH4 to remove redundant trampoline page table
- Added PATCH5 to fix memory reservation in setup_bootmem()

Anup Patel (5):
  RISC-V: Add separate defconfig for 32bit systems
  RISC-V: Make setup_vm() independent of GCC code model
  RISC-V: Allow booting kernel from any 4KB aligned address
  RISC-V: Remove redundant trampoline page table
  RISC-V: Fix memory reservation in setup_bootmem()

 arch/riscv/Kconfig                  |  11 +
 arch/riscv/configs/rv32_defconfig   |  84 ++++++
 arch/riscv/include/asm/fixmap.h     |   5 +
 arch/riscv/include/asm/pgtable-64.h |   5 +
 arch/riscv/include/asm/pgtable.h    |   6 +-
 arch/riscv/kernel/head.S            |  15 +-
 arch/riscv/kernel/setup.c           |   4 +-
 arch/riscv/mm/init.c                | 391 +++++++++++++++++++++++-----
 8 files changed, 450 insertions(+), 71 deletions(-)
 create mode 100644 arch/riscv/configs/rv32_defconfig

--=20
2.17.1

