Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34704C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D941820856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LNVSuaWm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TBH0Jeb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbfCZID4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:03:56 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52530 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCZIDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553587435; x=1585123435;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=jkBun+SuQGpVrUgSqKWQWjLo3hrMTWGi5vsJsLR9BkE=;
  b=LNVSuaWmMmKucWmx713Huc3/jgdUwUYxdw6dUMCoOY1sQAC3kQeKB7g5
   RGen3fX0orvxTzol+Iu+7TINWs6dSYdl3PuKYnrcDNRVB7toX+RDZnmcE
   7r/8aYAc2AIZ0OC9Z0j0wA99ArOTRvMUuZDP3AZeKfDLK7bevB6e78HZD
   m4hOy/eGgkyOXAcv4zkQpfg7Qr1qzGFZBuc1CjX2QbrVoNq7lwyK1gSPw
   Zf3we65gETx5KG15iuWB3uy41U5v1AQCDdv+P+fR7PQjR/GadFSycyJAD
   Xus0iXIssZ0WEWW2pMqTNvuTQipc6wdDnCDWEtPC+KqShy1V9wHc0GXW9
   A==;
X-IronPort-AV: E=Sophos;i="5.60,271,1549900800"; 
   d="scan'208";a="104225910"
Received: from mail-co1nam03lp2050.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.50])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2019 16:03:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fB5NlOzQ9elZTHoxkarx92fjj+ifVJEQURJdv9bDArA=;
 b=TBH0Jeb5K5GjGeNMMXZVuZh2FvQnedfs5NaCWge+C1crDi+gYfMxE4FLO4JaKOo4AC7OifpRQS0WIqHJbDh+CYoBQrnZuU/jTexizXlpvg6FAm310EPV9qaGnx2ETcQ7nBYBxgo6fMWNSHjMkR0knvCvrHVqoe5e+atSc5wds5A=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6079.namprd04.prod.outlook.com (20.178.247.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.19; Tue, 26 Mar 2019 08:03:47 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::d197:7b59:7e0d:e819%4]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 08:03:47 +0000
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
Subject: [PATCH v4] RISC-V: Always compile mm/init.c with cmodel=medany and
 notrace
Thread-Topic: [PATCH v4] RISC-V: Always compile mm/init.c with cmodel=medany
 and notrace
Thread-Index: AQHU46pwuhL5pEHWUU6bL2a0SXAGKQ==
Date:   Tue, 26 Mar 2019 08:03:47 +0000
Message-ID: <20190326080315.9086-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14fc6cc7-edaf-40e9-a533-08d6b1c192d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB6079;
x-ms-traffictypediagnostic: MN2PR04MB6079:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB6079D4C9FBDD819B387DCE6E8D5F0@MN2PR04MB6079.namprd04.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(136003)(396003)(376002)(189003)(199004)(81156014)(4326008)(26005)(68736007)(105586002)(106356001)(186003)(2171002)(6506007)(386003)(2906002)(102836004)(478600001)(3846002)(256004)(8676002)(6512007)(44832011)(8936002)(81166006)(14444005)(86362001)(50226002)(6116002)(72206003)(53936002)(52116002)(71200400001)(1076003)(6436002)(36756003)(14454004)(71190400001)(5660300002)(110136005)(7736002)(97736004)(6486002)(2616005)(54906003)(99286004)(305945005)(316002)(25786009)(66066001)(476003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6079;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R+/Hm/jtXSgolUtq36eZ8wLqPlcWGwHPwl6QoGy+ckkn1Z2AxM0GJ9GYYVYnlDsIAMATijbMFmWtY2K2owRBXkiOXftUKksZ1m6mBYQ5gNZiXhnhMizErTUzrFIBqQCgCDkrQvv/pY/YJm78ni2/unbNykw4cjt2muUQy1weEoWtodCktQ/+/aENOUmIM5IOi7n4e56e0dNk5AwpPJPYVvcs5CjbXzJQJ8LpIX2NC0Vk79Pq4AFA9tCogjpifHuY8YRg2/cp8Ko8B0JM2ARAO9YKegVi+TFg++afh0zHLRH++0u9Ku3gY4H4ve+ZtmJIL3dDOCEJaPhnwdNqY942ONIkuKJsqC1YzvPZ3pid+A4m43wjXkOPb6fxU+GoEag54FzOlTPPNt54DzGsQjcC9yeQZlI2oLgZkvOHgVxKaC8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fc6cc7-edaf-40e9-a533-08d6b1c192d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 08:03:47.2329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux RISC-V 32bit kernel is broken after we moved setup_vm() from
kernel/setup.c to mm/init.c because Linux RISC-V 32bit kernel by default
uses cmodel=3Dmedlow which results in a non-position-independent setup_vm()=
.

This patch fixes Linux RISC-V 32bit kernel booting by:
1. Forcing cmodel=3Dmedany for mm/init.c
2. Moving remaing MM-related stuff va_pa_offset, pfn_base and
   empty_zero_page from kernel/setup.c to mm/init.c

Further, the setup_vm() cannot handle GCC instrumentation for FTRACE so
we disable it for mm/init.c by not using "-pg" compiler flag.

Fixes: 6f1e9e946f0b ("RISC-V: Move setup_vm() to mm/init.c")
Suggested-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v4: Use "#error" for setup_vm() compiled without cmodel=3Dmedany
v3: Don't use CFLAG "-pg" for mm/init.o
v2: Removed CFLAGS_setup.o from kernel/Makefile and replaced SoBs
---
 arch/riscv/kernel/Makefile |  3 ---
 arch/riscv/kernel/setup.c  |  8 --------
 arch/riscv/mm/Makefile     |  6 ++++++
 arch/riscv/mm/init.c       | 28 ++++++++++++++++++++++++++++
 4 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f13f7f276639..598568168d35 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -4,7 +4,6 @@

 ifdef CONFIG_FTRACE
 CFLAGS_REMOVE_ftrace.o =3D -pg
-CFLAGS_REMOVE_setup.o =3D -pg
 endif

 extra-y +=3D head.o
@@ -29,8 +28,6 @@ obj-y	+=3D vdso.o
 obj-y	+=3D cacheinfo.o
 obj-y	+=3D vdso/

-CFLAGS_setup.o :=3D -mcmodel=3Dmedany
-
 obj-$(CONFIG_FPU)		+=3D fpu.o
 obj-$(CONFIG_SMP)		+=3D smpboot.o
 obj-$(CONFIG_SMP)		+=3D smp.o
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index ecb654f6a79e..540a331d1376 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -48,14 +48,6 @@ struct screen_info screen_info =3D {
 };
 #endif

-unsigned long va_pa_offset;
-EXPORT_SYMBOL(va_pa_offset);
-unsigned long pfn_base;
-EXPORT_SYMBOL(pfn_base);
-
-unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_al=
igned_bss;
-EXPORT_SYMBOL(empty_zero_page);
-
 /* The lucky hart to first increment this variable will boot the other cor=
es */
 atomic_t hart_lottery;
 unsigned long boot_cpu_hartid;
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index eb22ab49b3e0..b68aac701803 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -1,3 +1,9 @@
+
+CFLAGS_init.o :=3D -mcmodel=3Dmedany
+ifdef CONFIG_FTRACE
+CFLAGS_REMOVE_init.o =3D -pg
+endif
+
 obj-y +=3D init.o
 obj-y +=3D fault.o
 obj-y +=3D extable.o
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b379a75ac6a6..5fd8c922e1c2 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -25,6 +25,10 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>

+unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
+							__page_aligned_bss;
+EXPORT_SYMBOL(empty_zero_page);
+
 static void __init zone_sizes_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES] =3D { 0, };
@@ -143,6 +147,11 @@ void __init setup_bootmem(void)
 	}
 }

+unsigned long va_pa_offset;
+EXPORT_SYMBOL(va_pa_offset);
+unsigned long pfn_base;
+EXPORT_SYMBOL(pfn_base);
+
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);

@@ -172,6 +181,25 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_=
t phys, pgprot_t prot)
 	}
 }

+/*
+ * setup_vm() is called from head.S with MMU-off.
+ *
+ * Following requirements should be honoured for setup_vm() to work
+ * correctly:
+ * 1) It should use PC-relative addressing for accessing kernel symbols.
+ *    To achieve this we always use GCC cmodel=3Dmedany.
+ * 2) The compiler instrumentation for FTRACE will not work for setup_vm()
+ *    so disable compiler instrumentation when FTRACE is enabled.
+ *
+ * Currently, the above requirements are honoured by using custom CFLAGS
+ * for init.o in mm/Makefile.
+ */
+
+#ifndef __riscv_cmodel_medany
+#error "setup_vm() is called from head.S before relocate so it should "
+	"not use absolute addressing."
+#endif
+
 asmlinkage void __init setup_vm(void)
 {
 	extern char _start;
--
2.17.1
