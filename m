Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2FAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB4F20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jj+X5oRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbfDBPVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:21:18 -0400
Received: from mail-eopbgr810058.outbound.protection.outlook.com ([40.107.81.58]:30560
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727525AbfDBPVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0JyEq23OED+eujt1TVvLsNlM+jElleVZfaIgsOtT+o=;
 b=jj+X5oRCFD4vVYRenUfmxs54mILSW3r30idR8n6RBfq79Jqn3SZ18OrAKlhd0fTchD6fv1aqtgQJqyOE1kWTDg7j2sXs4ZVDUbDtxRDb0Q/baZXWyQUth7Uy+zNHBvrU+Z4lg0KybvCPaiYcFXU3ZQ8AIKtwddbBgb963I+h8fM=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3257.namprd12.prod.outlook.com (20.179.105.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Tue, 2 Apr 2019 15:21:15 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b%5]) with mapi id 15.20.1750.014; Tue, 2 Apr 2019
 15:21:15 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v4 1/3] x86/perf/amd: Resolve race condition when disabling
 PMC
Thread-Topic: [PATCH v4 1/3] x86/perf/amd: Resolve race condition when
 disabling PMC
Thread-Index: AQHU6We2qIH6bY8CxUm+/Qbhdc/BAQ==
Date:   Tue, 2 Apr 2019 15:21:14 +0000
Message-ID: <2ce40dfc228501c45bf0acf5230aa9d8ee5d1c42.1554218314.git.thomas.lendacky@amd.com>
References: <cover.1554218314.git.thomas.lendacky@amd.com>
In-Reply-To: <cover.1554218314.git.thomas.lendacky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SN4PR0401CA0035.namprd04.prod.outlook.com
 (2603:10b6:803:2a::21) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dbb56b5-a2da-4f19-bcab-08d6b77ed875
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3257;
x-ms-traffictypediagnostic: DM6PR12MB3257:
x-microsoft-antispam-prvs: <DM6PR12MB3257D92738306026AE3459CAEC560@DM6PR12MB3257.namprd12.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(366004)(396003)(189003)(199004)(106356001)(7416002)(110136005)(50226002)(66066001)(105586002)(102836004)(2906002)(476003)(2616005)(5660300002)(386003)(256004)(486006)(6506007)(99286004)(6436002)(36756003)(446003)(186003)(6486002)(118296001)(11346002)(14444005)(76176011)(97736004)(2501003)(81156014)(81166006)(8936002)(316002)(3846002)(72206003)(14454004)(4326008)(26005)(6512007)(68736007)(52116002)(8676002)(25786009)(54906003)(305945005)(7736002)(71200400001)(53936002)(86362001)(71190400001)(478600001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3257;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8CLLndb23odv2Kr8Stni4QSE0rbRFoBLfuyPSSCdlNvftgkNLb75xznJO4Q6mhEFlTFh4PTYyW8BN85R5VFSLBCCH84Jt10QBywt9pYHbvRyvSHoER1fMCSgM5sX0HaUuuczQz9q876kGqdLyLUTiXXpsVqPI8h00jdcNGkQ8pJ+BXfMJpQFq2tO0FS7OyKtiPgUDx3ZDH7/MpQfRRNbMWjbCJ8UUD5o7Igk/3BL4tLLtLNoknmzEZSGO5F+xQgCdopbGFI+Ufue+hNkkq+R4SxCV5Mh2zgrnTrXfRT52JZ9HZVkiZxmUDP++1esWORuH0K+0dkdssGDAu0a2f/w265MIbW2BYX5hRZfk39CoRUuxZHn6e+c5HBCZQs9Gof/6lgYYG0tmHKbQDszIz06TGpkCbuVUsJhrrxDKK5VbE8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbb56b5-a2da-4f19-bcab-08d6b77ed875
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 15:21:14.8813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD processors, the detection of an overflowed counter in the NMI
handler relies on the current value of the counter. So, for example, to
check for overflow on a 48 bit counter, bit 47 is checked to see if it
is 1 (not overflowed) or 0 (overflowed).

There is currently a race condition present when disabling and then
updating the PMC. Increased NMI latency in newer AMD processors makes this
race condition more pronounced. If the counter value has overflowed, it is
possible to update the PMC value before the NMI handler can run. The
updated PMC value is not an overflowed value, so when the perf NMI handler
does run, it will not find an overflowed counter. This may appear as an
unknown NMI resulting in either a panic or a series of messages, depending
on how the kernel is configured.

To eliminate this race condition, the PMC value must be checked after
disabling the counter. Add an AMD function, amd_pmu_disable_all(), that
will wait for the NMI handler to reset any active and overflowed counter
after calling x86_pmu_disable_all().

Cc: <stable@vger.kernel.org> # 4.14.x-
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/events/amd/core.c | 64 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 7d2d7c801dba..beb132593622 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -3,6 +3,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <asm/apicdef.h>
=20
 #include "../perf_event.h"
@@ -429,6 +430,63 @@ static void amd_pmu_cpu_dead(int cpu)
 	}
 }
=20
+/*
+ * When a PMC counter overflows, an NMI is used to process the event and
+ * reset the counter. NMI latency can result in the counter being updated
+ * before the NMI can run, which can result in what appear to be spurious
+ * NMIs. This function is intended to wait for the NMI to run and reset
+ * the counter to avoid possible unhandled NMI messages.
+ */
+#define OVERFLOW_WAIT_COUNT	50
+static void amd_pmu_wait_on_overflow(int idx)
+{
+	unsigned int i;
+	u64 counter;
+
+	/*
+	 * Wait for the counter to be reset if it has overflowed. This loop
+	 * should exit very, very quickly, but just in case, don't wait
+	 * forever...
+	 */
+	for (i =3D 0; i < OVERFLOW_WAIT_COUNT; i++) {
+		rdmsrl(x86_pmu_event_addr(idx), counter);
+		if (counter & (1ULL << (x86_pmu.cntval_bits - 1)))
+			break;
+
+		/* Might be in IRQ context, so can't sleep */
+		udelay(1);
+	}
+}
+
+static void amd_pmu_disable_all(void)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+	int idx;
+
+	x86_pmu_disable_all();
+
+	/*
+	 * This shouldn't be called from NMI context, but add a safeguard here
+	 * to return, since if we're in NMI context we can't wait for an NMI
+	 * to reset an overflowed counter value.
+	 */
+	if (in_nmi())
+		return;
+
+	/*
+	 * Check each counter for overflow and wait for it to be reset by the
+	 * NMI if it has overflowed. This relies on the fact that all active
+	 * counters are always enabled when this function is caled and
+	 * ARCH_PERFMON_EVENTSEL_INT is always set.
+	 */
+	for (idx =3D 0; idx < x86_pmu.num_counters; idx++) {
+		if (!test_bit(idx, cpuc->active_mask))
+			continue;
+
+		amd_pmu_wait_on_overflow(idx);
+	}
+}
+
 static struct event_constraint *
 amd_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
@@ -622,7 +680,7 @@ static ssize_t amd_event_sysfs_show(char *page, u64 con=
fig)
 static __initconst const struct x86_pmu amd_pmu =3D {
 	.name			=3D "AMD",
 	.handle_irq		=3D x86_pmu_handle_irq,
-	.disable_all		=3D x86_pmu_disable_all,
+	.disable_all		=3D amd_pmu_disable_all,
 	.enable_all		=3D x86_pmu_enable_all,
 	.enable			=3D x86_pmu_enable_event,
 	.disable		=3D x86_pmu_disable_event,
@@ -732,7 +790,7 @@ void amd_pmu_enable_virt(void)
 	cpuc->perf_ctr_virt_mask =3D 0;
=20
 	/* Reload all events */
-	x86_pmu_disable_all();
+	amd_pmu_disable_all();
 	x86_pmu_enable_all(0);
 }
 EXPORT_SYMBOL_GPL(amd_pmu_enable_virt);
@@ -750,7 +808,7 @@ void amd_pmu_disable_virt(void)
 	cpuc->perf_ctr_virt_mask =3D AMD64_EVENTSEL_HOSTONLY;
=20
 	/* Reload all events */
-	x86_pmu_disable_all();
+	amd_pmu_disable_all();
 	x86_pmu_enable_all(0);
 }
 EXPORT_SYMBOL_GPL(amd_pmu_disable_virt);
--=20
2.17.1

