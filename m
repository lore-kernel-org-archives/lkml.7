Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D55FC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EDC2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rVLr9BKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfGRGWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:22:14 -0400
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:5091
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbfGRGWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:22:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDqBmyKM3Q8CXu55Dwz2YlEE8qeo6jd+BVIHN7U68Tv5xcb4LC1bxZcPAnm/hNj7eXTYuysVHGoQbIQqYSt75ea23Jbs3odRDs3TdmJXkno/z+8aLLsJNxPL8nnmOrSkNpaD5EQQdfG6Zzu9GeQQVcF90yiIYQm0G+0ZfYU/0LBPz7sVNtB46kJsHfzJy7enV16AUyrnNvnOASlEvd7Ho+dChG8O1nmiR1RXP2O0rIzk6UjgXSC7zs+4jchXS4yfTU73YrSmWOJwzEColdgAotb1eNit5NMWH0fNi+39WxtVU9Vzu3EAEr5+0rbbRG46tM2w2miJjxm09J7OoZqK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1rQa6Kw6gnPlBda24LamQfltnhGf0HOlXr1aR2ExQ0=;
 b=f3DpAthj/L93bhV69pzsy4wRopaE122k/KLkgW16O5H3M63tboSKK/BGsqV4jd2CxW3zgQg6l4r65zRme7dNbGAOuQsWQBgYP7MH9ZHiuCUKCk4NXQakRIgP5hT+8ornhtWYub+d9A8NZFSplK0AKd3vEgqGqrSbmEI3vATeJVB2Wi8BEXxdTx290/13J3870gVaLyWBRemobLrJ8W+yQrLvF7qNYDrLzMg5mIDw4VHj8RyTim2SAdzrTK7dlrL/GO++gMZ+GV0iDRr93f2wqRK/W7GylmN+05ynsQdRljf3z+6nhXV/3piU8wITXtVu9nUcwPr5fgyER76rW9nKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1rQa6Kw6gnPlBda24LamQfltnhGf0HOlXr1aR2ExQ0=;
 b=rVLr9BKwUDKQ3rBL5n2wUcKd5n9+d0Dg9x4UGvzN6FGZ9At+5eyyFbErlX89btbdvdhgdg3QeD5WAkTKxf9GhSKiarqNS9iAxAu/31NUq+DAmeyoauCAwIJvi1s3ssHdPkoLnSKCBFWSm2u2tDLiAil+4/sePvyBKznjUfyoe6I=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB4315.eurprd04.prod.outlook.com (52.134.110.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Thu, 18 Jul 2019 06:21:30 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::6553:8d04:295c:774b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::6553:8d04:295c:774b%5]) with mapi id 15.20.2094.011; Thu, 18 Jul 2019
 06:21:30 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
CC:     Frank Li <frank.li@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH] perf tool: arch: arm64: change the way for get_cpuid_str()
 function
Thread-Topic: [PATCH] perf tool: arch: arm64: change the way for
 get_cpuid_str() function
Thread-Index: AQHVPTEJbljaEfwA1kmeHm0+nYaIVA==
Date:   Thu, 18 Jul 2019 06:21:30 +0000
Message-ID: <20190718061853.10403-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR06CA0187.apcprd06.prod.outlook.com (2603:1096:4:1::19)
 To DB7PR04MB4618.eurprd04.prod.outlook.com (2603:10a6:5:38::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1b343ad-abfe-42a3-c295-08d70b482c14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4315;
x-ms-traffictypediagnostic: DB7PR04MB4315:
x-microsoft-antispam-prvs: <DB7PR04MB4315E1E1F1F215B8B22C7CAEE6C80@DB7PR04MB4315.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(6116002)(6512007)(53936002)(6436002)(6486002)(256004)(66066001)(7736002)(305945005)(3846002)(478600001)(68736007)(8676002)(2201001)(36756003)(81166006)(8936002)(316002)(2906002)(6506007)(386003)(71190400001)(2501003)(86362001)(50226002)(66946007)(1076003)(476003)(66446008)(64756008)(486006)(66556008)(2616005)(102836004)(71200400001)(26005)(66476007)(81156014)(110136005)(99286004)(14454004)(4326008)(25786009)(186003)(5660300002)(52116002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4315;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EqFdtW5mj45E9ojBSFhYqKK6+uRpK8Sgck/f4/PGOLGwXGQU68ESob4S9mRKk6VwQ6Lt1is9HhJo10odAJ4F9SlUxDhYe0gV/ICI1daaD2wSU/AVPnmrwWJE44tne1Rhw1qYu5dvcv0t7GNLPYyfJnuC0pG/p4evXtGfWMue3pw+TUxfCimNdbYjUw7UB8A9zVpwMuVin/mHdu2D2Jw2aZiiGjuyON945Co2Qgnd0PKLpT1uxY3MurmvpvGhOH/i+6P0l+p+/GAv9U9ZEjcZiNMYaIRx4VBwmvQn6Sm6584CsC/ErwK4TDE2fwXNv3oQLu0gPPKmGD6xcSbHuk5/HNUAfhR182CnLwrYK6DhPQxmYJmf43qyXG+A0BMa2yL3c0xyofOAeNidbTweN/f3E3NXUHu76/eIfzJdqAtWmz0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b343ad-abfe-42a3-c295-08d70b482c14
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 06:21:30.4711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qiangqing.zhang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the get_cpuid__str function returns the MIDR string of the first
online cpu from the range of cpus asscociated with the PMU CORE device.

It can work when pass a perf_pmu entity to get_cpuid_str. However, it
will pass NULL via perf_pmu__find_map from metricgroup.c if we want to add
metric group for arm64. When pass NULL to get_cpuid_str, it can't return
the MIDR string.

There are three methods from userspace getting MIDR string for arm64:
1. parse sysfs(/sys/devices/system/cpu/cpu?/regs/identification/midr_el1)
2. parse procfs(/proc/cpuinfo)
3. read the hwcaps(MIDR register) with getauxval(AT_HWCAP)

Perfer to select #3 as it is more simple and direct.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 tools/perf/arch/arm64/util/header.c | 68 +++++++++++------------------
 1 file changed, 25 insertions(+), 43 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/ut=
il/header.c
index 534cd2507d83..f58f08af0be8 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -2,64 +2,46 @@
 #include <stdlib.h>
 #include <api/fs/fs.h>
 #include "header.h"
+#include <asm/hwcap.h>
+#include <sys/auxv.h>
=20
-#define MIDR "/regs/identification/midr_el1"
 #define MIDR_SIZE 19
 #define MIDR_REVISION_MASK      0xf
 #define MIDR_VARIANT_SHIFT      20
 #define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
=20
-char *get_cpuid_str(struct perf_pmu *pmu)
+#define get_cpuid(id) ({					\
+		unsigned long __val;				\
+		asm("mrs %0, "#id : "=3Dr" (__val));		\
+		__val;						\
+	})
+
+char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 {
 	char *buf =3D NULL;
-	char path[PATH_MAX];
-	const char *sysfs =3D sysfs__mountpoint();
-	int cpu;
-	u64 midr =3D 0;
-	struct cpu_map *cpus;
-	FILE *file;
+	unsigned long midr =3D 0;
=20
-	if (!sysfs || !pmu || !pmu->cpus)
+	if (!(getauxval(AT_HWCAP) & HWCAP_CPUID)) {
+		fputs("CPUID registers unavailable\n", stderr);
 		return NULL;
+	}
=20
-	buf =3D malloc(MIDR_SIZE);
-	if (!buf)
+	midr =3D get_cpuid(MIDR_EL1);
+	if (!midr) {
+		fputs("Failed to get cpuid string\n", stderr);
 		return NULL;
+	}
=20
-	/* read midr from list of cpus mapped to this pmu */
-	cpus =3D cpu_map__get(pmu->cpus);
-	for (cpu =3D 0; cpu < cpus->nr; cpu++) {
-		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
-				sysfs, cpus->map[cpu]);
-
-		file =3D fopen(path, "r");
-		if (!file) {
-			pr_debug("fopen failed for file %s\n", path);
-			continue;
-		}
-
-		if (!fgets(buf, MIDR_SIZE, file)) {
-			fclose(file);
-			continue;
-		}
-		fclose(file);
+	/* Ignore/clear Variant[23:20] and
+	 * Revision[3:0] of MIDR
+	 */
+	midr &=3D (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
=20
-		/* Ignore/clear Variant[23:20] and
-		 * Revision[3:0] of MIDR
-		 */
-		midr =3D strtoul(buf, NULL, 16);
-		midr &=3D (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
-		scnprintf(buf, MIDR_SIZE, "0x%016lx", midr);
-		/* got midr break loop */
-		break;
-	}
+	buf =3D malloc(MIDR_SIZE);
+	if (!buf)
+		return NULL;
=20
-	if (!midr) {
-		pr_err("failed to get cpuid string for PMU %s\n", pmu->name);
-		free(buf);
-		buf =3D NULL;
-	}
+	scnprintf(buf, MIDR_SIZE, "0x%016lx", midr);
=20
-	cpu_map__put(cpus);
 	return buf;
 }
--=20
2.17.1

