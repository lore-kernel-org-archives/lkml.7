Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0232C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A5420830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Fg6yIS7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbfDBPV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:21:27 -0400
Received: from mail-eopbgr810041.outbound.protection.outlook.com ([40.107.81.41]:9184
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727525AbfDBPVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P30Ck+bfonuK5aDwsqTcfk5eTi0QSnfuMkaflIFvqBI=;
 b=Fg6yIS7KSnw4dVLqRjYjwkDaNx6/ACqwh2XArbq73bsmmyRJRrraUyV1S/2DnabgQKpE5W9YOFl4juoB4fTxTVPExN1z8aQ+w2YdNaUVUFSfmkirWcfhvHNpPY97leJDaqeay60uyxqpBP2DSYjMbhJ4dfbhHGZQaS7OUMkOgME=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3257.namprd12.prod.outlook.com (20.179.105.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Tue, 2 Apr 2019 15:21:19 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b%5]) with mapi id 15.20.1750.014; Tue, 2 Apr 2019
 15:21:19 +0000
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
Subject: [PATCH v4 3/3] x86/perf/amd: Remove need to check "running" bit in
 NMI handler
Thread-Topic: [PATCH v4 3/3] x86/perf/amd: Remove need to check "running" bit
 in NMI handler
Thread-Index: AQHU6We44l0L00uiFESByVAPrTj2og==
Date:   Tue, 2 Apr 2019 15:21:18 +0000
Message-ID: <9a9195641915b347277bf65173ff9367b7c9bb37.1554218314.git.thomas.lendacky@amd.com>
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
x-ms-office365-filtering-correlation-id: 940d8766-56a7-4ff3-2d73-08d6b77edade
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3257;
x-ms-traffictypediagnostic: DM6PR12MB3257:
x-microsoft-antispam-prvs: <DM6PR12MB3257952A8581F39334A11951EC560@DM6PR12MB3257.namprd12.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(366004)(396003)(43544003)(189003)(199004)(106356001)(7416002)(110136005)(50226002)(66066001)(105586002)(102836004)(2906002)(476003)(2616005)(5660300002)(386003)(256004)(486006)(6506007)(99286004)(6436002)(36756003)(446003)(186003)(6486002)(118296001)(11346002)(14444005)(76176011)(97736004)(2501003)(81156014)(81166006)(8936002)(316002)(3846002)(72206003)(14454004)(4326008)(26005)(6512007)(68736007)(52116002)(8676002)(25786009)(54906003)(305945005)(7736002)(71200400001)(53936002)(86362001)(71190400001)(478600001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3257;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QYn18Fc39Xde0vHsKOCcg2yM3/huae/vyU89W73Pl6T5KDNNvXL8srZ9ZkAAsutK5DHQbFoZsInL+kY7KM75GeqxfTSq+qs30TFgFYiifSqOq0fPlrjrox6EMeDd+w1o0vbzOB30TM0FmunlfKPECOKHxIiYt6fB2XalfCbqC+fmiO70BYHxLomlcX3qs4obZHczJa53e/szvO/MNxpXHuNUKuLEBxEwaaM9NcZkfFJ7n02hH0+r34PhL3bcPFcD8JvdQJemXn/gaEoBUG9E9ihkJ45GfRv/Q9oUx2Zha6+VTYuJZ/uCpBCD1v9k2eEv76v5K2J0r7+VO9IoJQ9cesyw2LUigr0gbJ97rijsWAmKep0bPZzuT/pH1hRGgEoPdaQZHVi3m3r/hdvOhFWkjXc8mBKXJkapTm5hLRCMYEk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940d8766-56a7-4ff3-2d73-08d6b77edade
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 15:21:19.0233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spurious interrupt support was adding to perf in:
commit 63e6be6d98e1 ("perf, x86: Catch spurious interrupts after disabling =
counters")

The two previous patches (resolving the race condition when disabling a
PMC and NMI latency mitigation) allow for the removal of this older
spurious interrupt support.

Currently in x86_pmu_stop(), the bit for the PMC in the active_mask bitmap
is cleared before disabling the PMC, which sets up a race condition. This
race condition was mitigated by introducing the running bitmap. That race
condition can be eliminated by first disabling the PMC, waiting for PMC
reset on overflow and then clearing the bit for the PMC in the active_mask
bitmap. The NMI handler will not re-enable a disabled counter.

If x86_pmu_stop() is called from the perf NMI handler, the NMI latency
mitigation support will guard against any unhandled NMI messages.

Cc: <stable@vger.kernel.org> # 4.14.x-
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/events/amd/core.c | 19 ++++++++++++++++++-
 arch/x86/events/core.c     | 13 +++----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8f06ec0e673b..22d6667c7063 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -490,6 +490,23 @@ static void amd_pmu_disable_all(void)
 	}
 }
=20
+static void amd_pmu_disable_event(struct perf_event *event)
+{
+	x86_pmu_disable_event(event);
+
+	/*
+	 * This can be called from NMI context (via x86_pmu_stop). The counter
+	 * may have overflowed, but either way, we'll never see it get reset
+	 * by the NMI if we're already in the NMI. And the NMI latency support
+	 * below will take care of any pending NMI that might have been
+	 * generated by the overflow.
+	 */
+	if (in_nmi())
+		return;
+
+	amd_pmu_wait_on_overflow(event->hw.idx);
+}
+
 /*
  * Because of NMI latency, if multiple PMC counters are active or other so=
urces
  * of NMIs are received, the perf NMI handler can handle one or more overf=
lowed
@@ -737,7 +754,7 @@ static __initconst const struct x86_pmu amd_pmu =3D {
 	.disable_all		=3D amd_pmu_disable_all,
 	.enable_all		=3D x86_pmu_enable_all,
 	.enable			=3D x86_pmu_enable_event,
-	.disable		=3D x86_pmu_disable_event,
+	.disable		=3D amd_pmu_disable_event,
 	.hw_config		=3D amd_pmu_hw_config,
 	.schedule_events	=3D x86_schedule_events,
 	.eventsel		=3D MSR_K7_EVNTSEL0,
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e2b1447192a8..81911e11a15d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1349,8 +1349,9 @@ void x86_pmu_stop(struct perf_event *event, int flags=
)
 	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc =3D &event->hw;
=20
-	if (__test_and_clear_bit(hwc->idx, cpuc->active_mask)) {
+	if (test_bit(hwc->idx, cpuc->active_mask)) {
 		x86_pmu.disable(event);
+		__clear_bit(hwc->idx, cpuc->active_mask);
 		cpuc->events[hwc->idx] =3D NULL;
 		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 		hwc->state |=3D PERF_HES_STOPPED;
@@ -1447,16 +1448,8 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
=20
 	for (idx =3D 0; idx < x86_pmu.num_counters; idx++) {
-		if (!test_bit(idx, cpuc->active_mask)) {
-			/*
-			 * Though we deactivated the counter some cpus
-			 * might still deliver spurious interrupts still
-			 * in flight. Catch them:
-			 */
-			if (__test_and_clear_bit(idx, cpuc->running))
-				handled++;
+		if (!test_bit(idx, cpuc->active_mask))
 			continue;
-		}
=20
 		event =3D cpuc->events[idx];
=20
--=20
2.17.1

