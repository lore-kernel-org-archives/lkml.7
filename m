Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11847C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC642173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mXA3OKyJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dV+j3Y1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfCLWIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:08:12 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46960 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCLWIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1552428590; x=1583964590;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=MBZYZD4eSviWTKcV0TQz1/bJ8uzjPi2hCJhPFcjWdtI=;
  b=mXA3OKyJjECzjaosmOt/eAZyVemEZnkhvG1IbZnC/oReFpHYlFyzmPbi
   JjHQol2ccvgRERsEYAsfl32stIKN3+CrB8S/NuA5nI23DkVqxvMXPKbfX
   G/A7LobN5I7SDWqMlYyjgBwDmOm2Spo/jhNm6FAMvQsk/HrCuWltlgYmq
   FFCMW30QRcq4kVLKyAlVw4sIfTfozXyA/yQEo5+twqfckelO9tQs9kwm3
   n/Ow9VZ9ZfKQGGTTUAwEBI5M2BPEbljA7wtKMxbstgdtUWJVYGJ+WovaO
   +NMtzPt6pocxazIGuUvfDgnHccC39jPTA89kYuufu0GbTtLaExa3ja/1j
   g==;
X-IronPort-AV: E=Sophos;i="5.58,471,1544457600"; 
   d="scan'208";a="201863387"
Received: from mail-by2nam01lp2051.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.51])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2019 06:09:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8HFKkoIRvAyrM2FPAZlCvfO+U3ngTMt9osv6AUjgxw=;
 b=dV+j3Y1nwsXZHUB/roFywfk9B3mFPEiCbnQMnMbFjC5i76feUT5M2Go6tNoH1gepLLzuAQBUSgO8vTbzTH77GZA8jTwanxtfButSY0d1VQgABCqT3RBOzEQaaBLX+N1MDyM9Se/v4UeayJKa9OkVhOq8M7wj+8RKZXZbFWCQ1UQ=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB5643.namprd04.prod.outlook.com (20.179.48.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 12 Mar 2019 22:08:09 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::447:8360:6df9:c934]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::447:8360:6df9:c934%3]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 22:08:09 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH 0/3] Boot RISC-V kernel from any 4KB aligned address
Thread-Topic: [PATCH 0/3] Boot RISC-V kernel from any 4KB aligned address
Thread-Index: AQHU2SATag7fx1KS0Uu+vlG/L6sUIQ==
Date:   Tue, 12 Mar 2019 22:08:09 +0000
Message-ID: <20190312220752.128141-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:180::41) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da6b8697-652a-4582-c34a-08d6a73735cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5643;
x-ms-traffictypediagnostic: DM6PR04MB5643:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB5643AD011050CF7DECB378678D490@DM6PR04MB5643.namprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(102836004)(106356001)(386003)(6506007)(86362001)(66066001)(7736002)(97736004)(305945005)(81156014)(81166006)(105586002)(8676002)(52116002)(44832011)(2616005)(486006)(476003)(99286004)(68736007)(25786009)(6486002)(2171002)(71190400001)(8936002)(6512007)(36756003)(6436002)(4326008)(53936002)(50226002)(186003)(110136005)(478600001)(54906003)(256004)(316002)(14454004)(2906002)(72206003)(26005)(4744005)(3846002)(1076003)(6116002)(71200400001)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5643;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MgmM9x1MOR9pPzjmeEccwXvK48LRtqazqBOfhALPBxviefrqA05Wvp/tzFjWTpltP+6ftHCwsZMsh17XRm/a7av7j32U1CPH5DteJ2e4aSY/tSo+IMQqqZa82Oaiu/Zl1Q46lu600fa/t5cCGJ1fmSV2krP6pczmWQLGyz3Xa5RzJKWbKs56jpeY9u8H2jXp/cq9yeC1pbuy4hnURV7Rhd+jEKOPHBomHqNIpNGkwxqlmlWouw+0yN6t7B0nPh3MQeja7oJLm/o2DdaQ/8+7dcYFQEX1mnOI9aEqLIH3ERPrREDBDLbYset8aeOkG56SVy4s8u9UDBwMHH5Wp3JmjQtT8hhihhZEei5oM+tcSVrJbxR0ixNGq8br8fYEq2hTIvNfDhVgcGvm7u9sEHRPi356L/73c+hCwFAyneWh4B0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6b8697-652a-4582-c34a-08d6a73735cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 22:08:09.7949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5643
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup@brainfault.org>

This patchset primarily extends initial page table setup using fixmap
to boot Linux RISC-V kernel (64bit and 32bit) from any 4KB aligned address.
We also add 32bit defconfig to allow people to try 32bit Linux RISC-V
kernel as well.

The patchset is tested on SiFive Unleashed board and QEMU virt machine.

It can also be found in riscv_setup_vm_v1 branch of
https//github.com/avpatel/linux.git

Anup Patel (3):
  RISC-V: Add separate defconfig for 32bit systems
  RISC-V: Make setup_vm() independent of GCC code model
  RISC-V: Allow booting kernel from any 4KB aligned address

 arch/riscv/configs/rv32_defconfig   |  84 +++++++
 arch/riscv/include/asm/fixmap.h     |   5 +
 arch/riscv/include/asm/pgtable-64.h |   5 +
 arch/riscv/include/asm/pgtable.h    |   6 +-
 arch/riscv/kernel/head.S            |   2 +
 arch/riscv/kernel/setup.c           |   4 +-
 arch/riscv/mm/init.c                | 370 +++++++++++++++++++++++-----
 7 files changed, 419 insertions(+), 57 deletions(-)
 create mode 100644 arch/riscv/configs/rv32_defconfig

--=20
2.17.1

