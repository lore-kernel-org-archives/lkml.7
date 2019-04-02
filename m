Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5653BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE5420830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XX0exfil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbfDBPVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:21:22 -0400
Received: from mail-eopbgr810055.outbound.protection.outlook.com ([40.107.81.55]:58187
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731386AbfDBPVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCeuUYy65GFSjO6p53HQdhcj2MvO1K6WwUsAQLkOxkI=;
 b=XX0exfilwTmuVpMASzkaBd1CWsOpwZ99t6DjLXH7RYvaAvNwRacArDAZJwHyd7SyFF1L0jUULoruhW8f2eWdOabY8npQX6Nm5MKMqsAzjX2OuY43HbOesYl5g9PdHotBnySRfqA+3ZM4V3CXXam5g4fcohAZpzGw355rNe/LCQU=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3257.namprd12.prod.outlook.com (20.179.105.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Tue, 2 Apr 2019 15:21:17 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b%5]) with mapi id 15.20.1750.014; Tue, 2 Apr 2019
 15:21:16 +0000
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
Subject: [PATCH v4 2/3] x86/perf/amd: Resolve NMI latency issues for active
 PMCs
Thread-Topic: [PATCH v4 2/3] x86/perf/amd: Resolve NMI latency issues for
 active PMCs
Thread-Index: AQHU6We3GCgpzqJns0SOblHx8pDxSw==
Date:   Tue, 2 Apr 2019 15:21:16 +0000
Message-ID: <86189495b177259b925f48e79d892a3ef4653fa6.1554218314.git.thomas.lendacky@amd.com>
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
x-ms-office365-filtering-correlation-id: 12d0c341-25a0-494d-c213-08d6b77ed9a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3257;
x-ms-traffictypediagnostic: DM6PR12MB3257:
x-microsoft-antispam-prvs: <DM6PR12MB32578788C1419C6FA2BEDB46EC560@DM6PR12MB3257.namprd12.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(366004)(396003)(189003)(199004)(106356001)(7416002)(110136005)(50226002)(66066001)(105586002)(102836004)(2906002)(476003)(2616005)(5660300002)(386003)(256004)(486006)(6506007)(99286004)(6436002)(36756003)(446003)(186003)(6486002)(118296001)(11346002)(14444005)(76176011)(97736004)(2501003)(81156014)(81166006)(8936002)(316002)(3846002)(72206003)(14454004)(4326008)(26005)(6512007)(68736007)(52116002)(8676002)(25786009)(54906003)(305945005)(7736002)(71200400001)(53936002)(86362001)(71190400001)(478600001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3257;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Cd/tghtoVYh0WHDdaYCrM1OZaCq7FEM2PVxFdrF3CTiM/QmDxBnHe4fEVcdzjmXh5/jGHA+/cleZuIce0POyo8wTJSpkKk8tKLaHll3686H5gqga5N+QPVm0CWDe17B5u2FfufRqNQ89to7/mNgUo6ZBvdh0YkU1vk6jLUG55snl+IKIOMPJ27xMXUzS53dVVs79lSmISVz3i1CbE29EqhOa5CWcHUyLwiCwqqm9nsSq8Sy9EGDl3M38nFE9g4nU+8XAK5Fa7XrK9uBzJxD9sfWxRCPlz3soPJKLjfWBeb65Awu4AxocZs8h8B2vyN5th/2hFbRvLkwaJxw6CuYxxw9vAykG9S29Ed4RVYql9bm1d3KMrF1IuZijSMFJyi2sF3bYROPjuOIOMDcS7HOFCTltDmJ+BIQusAS+oc3h5sc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d0c341-25a0-494d-c213-08d6b77ed9a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 15:21:16.8547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD processors, the detection of an overflowed PMC counter in the NMI
handler relies on the current value of the PMC. So, for example, to check
for overflow on a 48-bit counter, bit 47 is checked to see if it is 1 (not
overflowed) or 0 (overflowed).

When the perf NMI handler executes it does not know in advance which PMC
counters have overflowed. As such, the NMI handler will process all active
PMC counters that have overflowed. NMI latency in newer AMD processors can
result in multiple overflowed PMC counters being processed in one NMI and
then a subsequent NMI, that does not appear to be a back-to-back NMI, not
finding any PMC counters that have overflowed. This may appear to be an
unhandled NMI resulting in either a panic or a series of messages,
depending on how the kernel was configured.

To mitigate this issue, add an AMD handle_irq callback function,
amd_pmu_handle_irq(), that will invoke the common x86_pmu_handle_irq()
function and upon return perform some additional processing that will
indicate if the NMI has been handled or would have been handled had an
earlier NMI not handled the overflowed PMC. Using a per-CPU variable, a
minimum value of the number of active PMCs or 2 will be set whenever a
PMC is active. This is used to indicate the possible number of NMIs that
can still occur. The value of 2 is used for when an NMI does not arrive
at the LAPIC in time to be collapsed into an already pending NMI. Each
time the function is called without having handled an overflowed counter,
the per-CPU value is checked. If the value is non-zero, it is decremented
and the NMI indicates that it handled the NMI. If the value is zero, then
the NMI indicates that it did not handle the NMI.

Cc: <stable@vger.kernel.org> # 4.14.x-
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/events/amd/core.c | 56 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index beb132593622..8f06ec0e673b 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -4,10 +4,13 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/nmi.h>
 #include <asm/apicdef.h>
=20
 #include "../perf_event.h"
=20
+static DEFINE_PER_CPU(unsigned int, perf_nmi_counter);
+
 static __initconst const u64 amd_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -487,6 +490,57 @@ static void amd_pmu_disable_all(void)
 	}
 }
=20
+/*
+ * Because of NMI latency, if multiple PMC counters are active or other so=
urces
+ * of NMIs are received, the perf NMI handler can handle one or more overf=
lowed
+ * PMC counters outside of the NMI associated with the PMC overflow. If th=
e NMI
+ * doesn't arrive at the LAPIC in time to become a pending NMI, then the k=
ernel
+ * back-to-back NMI support won't be active. This PMC handler needs to tak=
e into
+ * account that this can occur, otherwise this could result in unknown NMI
+ * messages being issued. Examples of this is PMC overflow while in the NM=
I
+ * handler when multiple PMCs are active or PMC overflow while handling so=
me
+ * other source of an NMI.
+ *
+ * Attempt to mitigate this by using the number of active PMCs to determin=
e
+ * whether to return NMI_HANDLED if the perf NMI handler did not handle/re=
set
+ * any PMCs. The per-CPU perf_nmi_counter variable is set to a minimum of =
the
+ * number of active PMCs or 2. The value of 2 is used in case an NMI does =
not
+ * arrive at the LAPIC in time to be collapsed into an already pending NMI=
.
+ */
+static int amd_pmu_handle_irq(struct pt_regs *regs)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+	int active, handled;
+
+	/*
+	 * Obtain the active count before calling x86_pmu_handle_irq() since
+	 * it is possible that x86_pmu_handle_irq() may make a counter
+	 * inactive (through x86_pmu_stop).
+	 */
+	active =3D __bitmap_weight(cpuc->active_mask, X86_PMC_IDX_MAX);
+
+	/* Process any counter overflows */
+	handled =3D x86_pmu_handle_irq(regs);
+
+	/*
+	 * If a counter was handled, record the number of possible remaining
+	 * NMIs that can occur.
+	 */
+	if (handled) {
+		this_cpu_write(perf_nmi_counter,
+			       min_t(unsigned int, 2, active));
+
+		return handled;
+	}
+
+	if (!this_cpu_read(perf_nmi_counter))
+		return NMI_DONE;
+
+	this_cpu_dec(perf_nmi_counter);
+
+	return NMI_HANDLED;
+}
+
 static struct event_constraint *
 amd_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
@@ -679,7 +733,7 @@ static ssize_t amd_event_sysfs_show(char *page, u64 con=
fig)
=20
 static __initconst const struct x86_pmu amd_pmu =3D {
 	.name			=3D "AMD",
-	.handle_irq		=3D x86_pmu_handle_irq,
+	.handle_irq		=3D amd_pmu_handle_irq,
 	.disable_all		=3D amd_pmu_disable_all,
 	.enable_all		=3D x86_pmu_enable_all,
 	.enable			=3D x86_pmu_enable_event,
--=20
2.17.1

