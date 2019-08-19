Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC5BC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A192070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bdfnN9Nm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="h5cphBbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfHSFO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:14:26 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:17919 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSFOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566191665; x=1597727665;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=o4V4kyIo4eGlMNs7vsAk+abMWhxg+6JqeMxmCU5u5HI=;
  b=bdfnN9NmxhWvxAjfa/0U409ITCSwaGF6TiwHZtKvN9dqRkT0g4Bes1Mq
   W7n2NPU8+ZIBKXFNmRXxzdcdwutuX5dTh7D1t4prkR8Vh9d4VX9vCbejC
   BzgUCfTeYpsabnSHGS30mruxkpkeElloWeh+8XdnN0MndQ0Yc40BWxAyS
   3StdkWxkOWRWCjhB8tE1f/NRVCsjcYdR0Y8EIw+Wlz80tto3Rggba9/aB
   vw6vEj8ikI/siBuejmJUmdv/fhhi0I/+zmo/0nDEf6hXigvmouLgoXRr9
   aUmIqc1I1u1lJVw8ADyzLclL4R4t1rDJ+jkE949o/wmOQXEh3N0lPF4Rf
   g==;
IronPort-SDR: e/klVoC11xuUfRWxO66G4TTRrsU5GuuJ3coco424b4+GIOpdzfdNR5gVyoUMRGEspfxFsavGcr
 UeKWWr94zjTIx/+cgVIzm/muTQcKjbbiu4ocb/4RQzGvNCE2/d5m40Wpyi/pir8gP0+410Nx99
 qYj0+P2+fGBAg042n5vVegLzmDy9lPLyDyjvZXv6VoOp1CQPODXaiWYXh7hKGqDbxZBV9eMpGh
 7MuDPTMudGjxAHdAKX4WQOdbioMjT+Jnr0csj7JFqw7xvbMvuUvP/TDohB0a0j5g9AHYJBLT56
 oDs=
X-IronPort-AV: E=Sophos;i="5.64,403,1559491200"; 
   d="scan'208";a="222668664"
Received: from mail-by2nam01lp2056.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.56])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2019 13:14:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hay7CeqtADNGj1+sWI6hZMSR0O6afTguff+r3NromzzlPwIaxIeD/hV5PGArSR+GeQX+zQejDlYTGPyxC5A+3mBj7per2d2QsBKz6STouoW+CaC1myA++1T6mm9JX1z3K6bqak/yrCbX8F5p5nWD1gJ7pcFeqW5w+jQ0yXb7XYLQXaTjDNA5ldFyZWQ1DHjyNP1V79eizVHrkC3t250QxC/2MfOSmxYbdJcBZMUocPBWtDhB97VBGi2/ivgVQ9crwLhwa8glkI1LxhOwj1SQdjZKJMuRPHxxNL91Xytq6T3tm8VZD2qqpmj+o81n9/rGEvPJmrvVlyZXMf3wwV3Bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58XXYhjX6yB0zaExq34oM1RTtcxgWzfAh7mrGop0Cdo=;
 b=EfZSQa77u56agQlySKGXyDjfEQAGx1CskqD1eubdDCOLSbcioXeONH+XEmQTPRi354LEB2n8HbJxrQJTFl+cY8MV37+rBduAo8w8kDUAVPQtbpoqmiOc7BxUj8KQ1U/GSioN598OvGd+hDNoIrFt+fM0Z+3jXQ8qoClTX6uhNc/lIqD90A/eJi4X88+IBBxLBxjNe5sal+h1HhlJyY7Gs475+R5URzD7TCjMtBagFpxrudRprMbMmNUTadsNhzvvp4KSXElCKM87y+rS6EVY/q731fdktfyFYEZpsnc350e53DR2ndS7xiJH4iiizWkzG7rNtkJqKeGdp5ZMjiIVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58XXYhjX6yB0zaExq34oM1RTtcxgWzfAh7mrGop0Cdo=;
 b=h5cphBbVekFh+S2rCwBhzrIg7bcKkNb11dyz6QVcomgAp27eDFv5BT+J5ez+asBYGjzSDodRQBlOckK74suraQMyOlxmA8zjcz7Y3ajLJ0QdYZvn12I+zmXtO1IQzyREPg/su1F/EVXAp/DrNkDGkbXzpe7g9RcI2BEf2hcC8dI=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5632.namprd04.prod.outlook.com (20.179.20.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 05:14:23 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a815:e61a:b4aa:60c8]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a815:e61a:b4aa:60c8%7]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 05:14:23 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v2] RISC-V: Fix FIXMAP area corruption on RV32 systems
Thread-Topic: [PATCH v2] RISC-V: Fix FIXMAP area corruption on RV32 systems
Thread-Index: AQHVVkz2mzRBOANcr0Cpw6hsdQg8zw==
Date:   Mon, 19 Aug 2019 05:14:23 +0000
Message-ID: <20190819051345.81097-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0076.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::16)
 To MN2PR04MB6061.namprd04.prod.outlook.com (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d90ba53f-40e2-4f35-6a86-08d7246418aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR04MB5632;
x-ms-traffictypediagnostic: MN2PR04MB5632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB56325E264A0E4B34D054DEE08DA80@MN2PR04MB5632.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(189003)(66946007)(66476007)(66446008)(64756008)(66556008)(476003)(6512007)(99286004)(71190400001)(71200400001)(305945005)(44832011)(4326008)(6486002)(7736002)(52116002)(6436002)(50226002)(8936002)(8676002)(81166006)(1076003)(2906002)(14444005)(25786009)(81156014)(256004)(5660300002)(53936002)(54906003)(110136005)(2616005)(316002)(26005)(486006)(102836004)(66066001)(478600001)(386003)(6506007)(186003)(86362001)(6116002)(36756003)(14454004)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5632;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vw77a4cXZVAhoZJC0JqXot6l1ZkIYW+9o3qXCUH1pA0xg8Ow8r1j2XwPLvGJCN6wau0gHrnWRond39RDi4XTVPfUn358XUVzvB/6S9bxOm1EctjXMUULUFlRC/gDSBRwSm7STy/5+Jt2o94rQUPjvTgFTI1J0r2ikwsT0IJ49n5TtKU78ShzdKzLreZsKahXJ2VvpT7TjwDtX+EmJLAgRE5yUUTa/RGl9zVVpShfEYifh0O3HKBwK3ic9kWhFEKajW9IVgsYzXfEPbNCu8O4M50rxJU+zuKxDQ+UKGBYd/QHhWbVmI2jZiPHp+PgLGL5MfTBgOD3n4Fy0koPBSc630u/qUYVgAEmJwMuwtuub2nXsayUM+0rwBFnXrf9tXUnH4IkWcGmK8E42e1E7zsOgRkcWUVI0dXb+//YI85aX6k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90ba53f-40e2-4f35-6a86-08d7246418aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 05:14:23.2031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +bMhb4GRBZk8/+W3dbM+62xjxvaZ4cq0yh2lsOoJ2zydZDJR5MfdrXCsGgwRifZ2GRNKHXeSQwd9jzzjwiCHMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, various virtual memory areas of Linux RISC-V are organized
in increasing order of their virtual addresses is as follows:
1. User space area (This is lowest area and starts at 0x0)
2. FIXMAP area
3. VMALLOC area
4. Kernel area (This is highest area and starts at PAGE_OFFSET)

The maximum size of user space aread is represented by TASK_SIZE.

On RV32 systems, TASK_SIZE is defined as VMALLOC_START which causes the
user space area to overlap the FIXMAP area. This allows user space apps
to potentially corrupt the FIXMAP area and kernel OF APIs will crash
whenever they access corrupted FDT in the FIXMAP area.

On RV64 systems, TASK_SIZE is set to fixed 256GB and no other areas
happen to overlap so we don't see any FIXMAP area corruptions.

This patch fixes FIXMAP area corruption on RV32 systems by setting
TASK_SIZE to FIXADDR_START. We also move FIXADDR_TOP, FIXADDR_SIZE,
and FIXADDR_START defines to asm/pgtable.h so that we can avoid cyclic
header includes.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Tested-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
Changes since v1:
- Drop braces from "#define FIXADDR_TOP"
---
 arch/riscv/include/asm/fixmap.h  |  4 ----
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixma=
p.h
index 9c66033c3a54..161f28d04a07 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -30,10 +30,6 @@ enum fixed_addresses {
 	__end_of_fixed_addresses
 };

-#define FIXADDR_SIZE		(__end_of_fixed_addresses * PAGE_SIZE)
-#define FIXADDR_TOP		(VMALLOC_START)
-#define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
-
 #define FIXMAP_PAGE_IO		PAGE_KERNEL

 #define __early_set_fixmap	__set_fixmap
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgta=
ble.h
index a364aba23d55..c24a083b3e12 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -420,14 +420,22 @@ static inline void pgtable_cache_init(void)
 #define VMALLOC_END      (PAGE_OFFSET - 1)
 #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)

+#define FIXADDR_TOP      VMALLOC_START
+#ifdef CONFIG_64BIT
+#define FIXADDR_SIZE     PMD_SIZE
+#else
+#define FIXADDR_SIZE     PGDIR_SIZE
+#endif
+#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
+
 /*
- * Task size is 0x4000000000 for RV64 or 0xb800000 for RV32.
+ * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
  */
 #ifdef CONFIG_64BIT
 #define TASK_SIZE (PGDIR_SIZE * PTRS_PER_PGD / 2)
 #else
-#define TASK_SIZE VMALLOC_START
+#define TASK_SIZE FIXADDR_START
 #endif

 #include <asm-generic/pgtable.h>
--
2.17.1
