Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84490C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4198A20644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dWruacQ8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XkBKGI+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfHPLtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 07:49:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14907 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfHPLtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 07:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565956184; x=1597492184;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=peVBt3PK93AJklAeCImltElpFoIpg80hEv4pIiy0qq0=;
  b=dWruacQ8MaMDm0fUSMaGfLZb/0/zC5BtG4qDc6dwY17rg2eKE+mEdRgI
   zeBfChI0mC0hcNHvipyx8OeC05UYxAs/MNjwxYABu3vftO+UYBHBIp3pm
   gus8YjZnZKq7rls/FOzgH9Nzn7K0lTYMdhw71ToLRU4S08QbOhY/9fqrA
   qFMijJ+iNDKEbRBRJyE1/l1Vpxuk7WXi7WmRS7vB4kdANYbGjPRfN6Ik0
   1SLt0AkhFU1W/8kDuVG4ErJ2k1qCSlQwDx2T3TmvDXncvxugqSibUNND7
   OGW12H5HEXcRcfx8eHOChaKk4YsFNbPlV7rnPMHSt3D16zPdxnFoxNwiy
   Q==;
IronPort-SDR: Ksbh/r+izx9+37SDi+HMBOy6k0NKGzplRegrQV9Uls7n3BkERedMelUM25DhD/yc1rQbZFehG8
 X/jDop/aAiJGWViWEgXyKEBqiQ15XS0Xv8UJa7ZrdiJUZSaHV+OUx4CP37OZepvU4jQGELRF9N
 qWZLmRenehRNabwY9NlaCwWar88dNIxPh0bchMd5jp+0xUePD/7q2mqpxRct3kqv/wGRDwRR7b
 Har091RD4skCYVsyIRn+fQvTEyz3ZHBOQrevcBY13cVK5ZdxbY3Z3fi7xjoTnBJz1AUr24FT8p
 ecc=
X-IronPort-AV: E=Sophos;i="5.64,393,1559491200"; 
   d="scan'208";a="117587710"
Received: from mail-bn3nam04lp2052.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.52])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2019 19:49:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMjmaCfjLeWGZHw9eORst69XWtdEEs5rxBypSaRQdj/xA9c1ZPx0AzBaf4Xk+7tgLUKgarqyckd802e5IpP9e3QDJiaynYjcSdPUV580ss6o5d8G9USA2ZrPa6pUcOHJUa3VOmOu5FNWoWfl9AmdEFjQJpM7gT437MR4Vqtig8N2Ul28XwQnSK5zbHH/VLi1L3BDAWVbfUByXJJfGIiKPyPiwq3JZNFQtjxOtgFvkk3DdbqaByVxfotx5hJ7sePQqh1ebAcj6k+1tG6eHkbgdUHeJQNyKm8KjsI7N2e6og66Ri/7V+qXA7XruMans02dMShvPzThuFeI3pHsgnjPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krwJykziMpM9hcIUU9Cj+t9tfj3PElI0xza1sQcjMS0=;
 b=IrmYG0K4YrZzL1xRK+ycfLoYM1YQW2RZtgsE8Ne2iJS6aRMUptBkSVl8/X0Z/ptZMNGNEGjx67rKtJ4bB8pqVwCrBxS9m0djeB8uUKz9ENH3P7BFaHmCRl8eGMjfVG8ojIt0o0xafthK4hbdVV33UyNjVUkAF2ngMod230sAJwNxGd4yaYRDIwhzXQpBBqMR3P5t/lwUEm9JuGmRKUIwyyUhbTRvgnom2WhVQoJRYKpAWafZ13LEQJ4s2pJCoYN1GC8EJ6XMwvUm11ouz7xG8hbRfX5ZWL79N0hx6rrVNleSdHOwCySfH9eFdyWjI/7Z+gfD1EzShV0q+1f0UxmfAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krwJykziMpM9hcIUU9Cj+t9tfj3PElI0xza1sQcjMS0=;
 b=XkBKGI+EGncTTC3d2neGZRbD5qAKwQmnydrtx/wIzD3cuP6v7Q8eUcPaNLYcxG/gkKBK8Do3gt+5uLy29gCJ6gr2sw9BpsuAOJUO/1EDuuKNw788/1jSS2QLm3WJ5Ql++panl8+kpP4zCvXsPAPP3QyEJvfjRugK5uDRw/Cui/M=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6237.namprd04.prod.outlook.com (20.178.245.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Fri, 16 Aug 2019 11:49:41 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a815:e61a:b4aa:60c8]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a815:e61a:b4aa:60c8%7]) with mapi id 15.20.2178.016; Fri, 16 Aug 2019
 11:49:41 +0000
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
Subject: [PATCH] RISC-V: Fix FIXMAP area corruption on RV32 systems
Thread-Topic: [PATCH] RISC-V: Fix FIXMAP area corruption on RV32 systems
Thread-Index: AQHVVCiwkrMhoC888UyZ9cBEv4GnHA==
Date:   Fri, 16 Aug 2019 11:49:40 +0000
Message-ID: <20190816114915.4648-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::30) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.207.53.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de585ded-84a1-4794-2f26-08d7223fd2a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB6237;
x-ms-traffictypediagnostic: MN2PR04MB6237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6237BFECECD9813854E2D84F8DAF0@MN2PR04MB6237.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(189003)(199004)(4326008)(478600001)(86362001)(71190400001)(6512007)(71200400001)(66946007)(8936002)(3846002)(1076003)(316002)(50226002)(36756003)(44832011)(5660300002)(99286004)(476003)(2616005)(54906003)(110136005)(486006)(66066001)(25786009)(2906002)(52116002)(102836004)(6116002)(186003)(66556008)(6436002)(6506007)(55236004)(386003)(14454004)(7736002)(256004)(53936002)(305945005)(14444005)(8676002)(66476007)(6486002)(66446008)(26005)(81166006)(81156014)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6237;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P7Ktxgh2vIInarPYLbK2vRPxdoWYwNOXy4Crpl5MNk+t3/CUm9vwcqAW4LUnnN9qeFSkxPNufbBPifjTYIPmfU+iHi+GZIyKX7Z66Ehj9X73RkCXmPDboACuTYLxKBnlltHHxirMftbz9v2gBrJz/N2mM+64TFrob5XE8Ko6JvjPHr5uj16JJUAtiEWuYjq7S6uQ7bvCFWGkRbZDR2mVesl8BlYzRDlIzCEHsKYeHueBKpzNUmB0RU0X8+p+cOalPRC/nPH3ZZVavZQU1faEinn7t/FM5/DfNtXxHNm744XKQFU5ZCd7wviC/w436MZcpMZQQ9l8nKpmEHmleHW9c154dYT5lNZ9/HwXIshDRMOzR5n1xMVdxn3VcWmT42RXeVEE7DgfGXDFe1YBDPeG/CnhjcH57nD2r89fG6D+u4I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de585ded-84a1-4794-2f26-08d7223fd2a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 11:49:41.1097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XisOAn2WLe35yA79Heeks9H6uHH2nlVfxCS3QcgtXMw4cdmv2uXhsOIFCpkVDFcue+1HVUs4+4ZgPfbc7ieRug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the order of various virtual memory areas in increasing
order of virtual addresses is as follows:
1. User space area
2. FIXMAP area
3. VMALLOC area
4. Kernel area

The user space area starts at 0x0 and it's maximum size is represented
by TASK_SIZE.

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
=20
-#define FIXADDR_SIZE		(__end_of_fixed_addresses * PAGE_SIZE)
-#define FIXADDR_TOP		(VMALLOC_START)
-#define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
-
 #define FIXMAP_PAGE_IO		PAGE_KERNEL
=20
 #define __early_set_fixmap	__set_fixmap
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgta=
ble.h
index a364aba23d55..9dd08a006a28 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -420,14 +420,22 @@ static inline void pgtable_cache_init(void)
 #define VMALLOC_END      (PAGE_OFFSET - 1)
 #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
=20
+#define FIXADDR_TOP      (VMALLOC_START)
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
=20
 #include <asm-generic/pgtable.h>
--=20
2.17.1

