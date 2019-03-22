Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67ABC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC6F218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HpL9MugE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GOpZVbBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfCVKEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:04:49 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45076 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfCVKEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553249088; x=1584785088;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=xAWqDzrPg60ipQL1AzyJnu1A6THaoEMzRXtDDlCuPXA=;
  b=HpL9MugEfvW1qNicm+oGSqHSCUTJASM++3lWUuiu3Vnk0lDKOMO8fhSl
   tCFjGlYfeFPgvSwA/SVwq2fVZbsG3rdmD/F3Hgw6ljLKGQ5lVUz0tcaJb
   4VvoRR9mi1EhuwbZYbFzh5+csu54VUYzV6UnhgU5yuz3EYwW7z0gsJmfC
   SS/IOSqh7jk8IXG2lXgi51Vu//IMiefCrefLyTGfx5PZk6HNh9BjMrHbv
   5RMyhPDzZgms64I7+AUs36kdVeGitNRcPPmPm/DTjcBTa733Sp/yr1mnb
   F0LJSpIYDsyOSfdpucBSOpxbKbYcL5DMvedVqUAXiJ6vITENSEsLKGgHe
   A==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="109044933"
Received: from mail-sn1nam01lp2059.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.59])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2019 18:04:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khEH0LUe1Xd/u0Bcxva+aGiEgtbirzxLDpW+bfnG9qQ=;
 b=GOpZVbBkfgGimkMeAraMbO7herpX62YXBuC6qQxdByQNSm+vZE0uubr6t/PM8nDRm3qEh8Gn/m/nUoLkr8OPoJ8+Wat/mM3fnpksFQf1JyubmZS35ttJLzdb2wRUn3xcqGC9tW11l52VQBEJKUc5aLp5HYjD2gCH2TqoqCNCxII=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6014.namprd04.prod.outlook.com (20.178.249.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 10:04:45 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819%4]) with mapi id 15.20.1730.013; Fri, 22 Mar 2019
 10:04:45 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH] RISC-V: Fix FIXMAP_TOP to avoid overlap with VMALLOC area
Thread-Topic: [PATCH] RISC-V: Fix FIXMAP_TOP to avoid overlap with VMALLOC
 area
Thread-Index: AQHU4JasomKgXLWLxUO3YcHzM5EpmQ==
Date:   Fri, 22 Mar 2019 10:04:44 +0000
Message-ID: <20190322100414.32221-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::34) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c85f473-1173-44ae-fea5-08d6aeadced9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB6014;
x-ms-traffictypediagnostic: MN2PR04MB6014:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB6014FF58F459749459BF2A058D430@MN2PR04MB6014.namprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(376002)(366004)(39860400002)(51234002)(199004)(189003)(25786009)(97736004)(45080400002)(72206003)(110136005)(86362001)(99286004)(316002)(186003)(44832011)(4326008)(476003)(2616005)(3846002)(486006)(71200400001)(71190400001)(6116002)(106356001)(105586002)(2906002)(8676002)(81156014)(478600001)(81166006)(1076003)(14454004)(53936002)(102836004)(2171002)(26005)(54906003)(66066001)(7736002)(256004)(305945005)(6506007)(52116002)(68736007)(14444005)(5660300002)(6486002)(6436002)(8936002)(386003)(50226002)(36756003)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6014;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MTTJgWDhj8n4yhjClEW84QNlKb5NiBAl5rnEz444M9wdKCe6A9aIfYr8GT9eqcDEpHF1l1L40B6xt6HA+j/SBnt+S3xMS3aTewyqA1B0mk0R9X0d+U+Qnz9O2pjXEWL+A4jLzdzxyUyP0MCebhpyyzwVCHXf1Zn+3cYhfcmq86+6LCY0jJ+LTkRp+waAyBQEtl7VtqZazhhJy8g/oe6juPyJMZhTNmKIUShczoR678EfnGMC23LT4zidBGDqGhTjbTyh+x6kL7lFFoqDeMVzIJIxk20qp5ftUSO1ktEjErjDIEzESEdqVCsMdTCAnO3FH/rBCkYmIM6OxAjs0xhgU+O9/fIavFzXyTZ8v8BV8CQ98P8iTijx6Ilf1i1VLnHHuM6/mtBhcF7nL/3f0Of0F8pLVH4KXtVU6PA7CRMBdfA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c85f473-1173-44ae-fea5-08d6aeadced9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 10:04:44.8216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FIXMAP area overlaps with VMALLOC area in Linux-5.1-rc1 hence we get
below warning in Linux RISC-V 32bit kernel. This warning does not show-up
in Linux RISC-V 64bit kernel due to large VMALLOC area.

WARNING: CPU: 0 PID: 22 at mm/vmalloc.c:150 vmap_page_range_noflush+0x134/0=
x15c
Modules linked in:
CPU: 0 PID: 22 Comm: kworker/0:1 Not tainted 5.1.0-rc1-00005-gebc2f658040e =
#1
Workqueue: events pcpu_balance_workfn
Call Trace:
[<c002b950>] walk_stackframe+0x0/0xa0
[<c002baac>] show_stack+0x28/0x32
[<c0587354>] dump_stack+0x62/0x7e
[<c002fdee>] __warn+0x98/0xce
[<c002fe52>] warn_slowpath_null+0x2e/0x3c
[<c00e71ce>] vmap_page_range_noflush+0x134/0x15c
[<c00e7886>] map_kernel_range_noflush+0xc/0x14
[<c00d54b8>] pcpu_populate_chunk+0x19e/0x236
[<c00d610e>] pcpu_balance_workfn+0x448/0x464
[<c00408d6>] process_one_work+0x16c/0x2ea
[<c0040b46>] worker_thread+0xf2/0x3b2
[<c004519a>] kthread+0xce/0xdc
[<c002a974>] ret_from_exception+0x0/0xc

This patch fixes above warning by placing FIXMAP area below VMALLOC area.

Fixes: f2c17aabc917 ("RISC-V: Implement compile-time fixed mappings")
Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/fixmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixma=
p.h
index 5cf53dd882e5..9c66033c3a54 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -31,7 +31,7 @@ enum fixed_addresses {
 };
=20
 #define FIXADDR_SIZE		(__end_of_fixed_addresses * PAGE_SIZE)
-#define FIXADDR_TOP		(PAGE_OFFSET)
+#define FIXADDR_TOP		(VMALLOC_START)
 #define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
=20
 #define FIXMAP_PAGE_IO		PAGE_KERNEL
--=20
2.17.1

