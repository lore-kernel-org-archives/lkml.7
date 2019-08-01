Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1D2C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABBF20679
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VWzXlNfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfHAS5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:57:45 -0400
Received: from mail-eopbgr680065.outbound.protection.outlook.com ([40.107.68.65]:37774
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728404AbfHAS5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:57:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCLF583LwaaF0kDlW2krW8nncGp5zhDzmlUJf45K3BDyrbALqDw7epbqwd1A/TSNUoMBG4r2U3h/vfCuVoJcmNBggdnDc2anI0bGQGtcDwFRx4g3aQCjnB06Lf4fPK0fnsMo9LL8Od2DiGxtf0JpXflJcZuL3IqjoecXprOnZO9kIK0MnrYaknOxj/szXgv/kCXKgXdW1ZoomYaYSxgBsUV3Qhof2/ysJCCXwFfHTKEo6e39A33W0+nwranvLTu7IObJz1+MbZlhfXyXruLUUE5ONETBAOkojJRZK5MrjwlZ6XUlk09PMB/OIiMlGPGTFHSVTRbWSp5blA2LfiwgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1ryHqguBSmluxLiQAh1S4MjeCleR6gn5vshzJiMcwY=;
 b=Q8GzW2364z6E1ylPs26NErCgxtrT2B4JOZv1iCLhtjggTirVmZPtLYUTVK/SY57PSYwlB9MpMcRjZMS55x+NPTi5eQ+BG7ZFKHf2zKq8N8YEkoc0mKgBrPc5paHfpD2aIXV/FzHpCHe4ClcXc55NagkJydgVNuIS0Ben1+q9slkYf7QTMKfBgxiYqs2lLozwzSxWtd/jd8m7SZ+eeqsF8PEovSr5jR6Q9RCgA+RZvaYK7X1n7lMHyhwwI61Snv4Ba+02Ld05idDJFFT6wfBczCzc8UfDVE3YTB5gkLlm1zeOxaYKenqWs8oNzVhd4Nr66vNorvJ9cL9I2CtZTe7f2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1ryHqguBSmluxLiQAh1S4MjeCleR6gn5vshzJiMcwY=;
 b=VWzXlNfZD31pnknqK1Wgg6moDK7aIbtg8mk2Ldn27qGbJnIj/kIbYIcn8kBItwJxRoSQC5k6kFq48xlg4OVdACzXWKvJdMtDmaMQy7PzixOL6HABHoHt0uITWFpYLO4atOCTkbPUKfiyXAFxb5y+RSrYW1/Hb7pahkqY++TQVjs=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2604.namprd12.prod.outlook.com (20.176.116.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Thu, 1 Aug 2019 18:57:41 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 18:57:41 +0000
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
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH] perf/x86/amd: Change NMI latency mitigation to use a
 timestamp
Thread-Topic: [PATCH] perf/x86/amd: Change NMI latency mitigation to use a
 timestamp
Thread-Index: AQHVSJr+u3qRs4Wxu0KQl/8M+KLjNw==
Date:   Thu, 1 Aug 2019 18:57:41 +0000
Message-ID: <833ee307989ac6bfb45efe823c5eca4b2b80c7cf.1564685848.git.thomas.lendacky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SN2PR01CA0002.prod.exchangelabs.com (2603:10b6:804:2::12)
 To DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12ebcfdf-a824-414c-e858-08d716b2213e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2604;
x-ms-traffictypediagnostic: DM6PR12MB2604:
x-microsoft-antispam-prvs: <DM6PR12MB2604ACF2B4A0A6F4D4560C1EECDE0@DM6PR12MB2604.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(66066001)(476003)(68736007)(52116002)(3846002)(6116002)(486006)(305945005)(316002)(4326008)(2501003)(86362001)(386003)(99286004)(54906003)(478600001)(110136005)(6506007)(2616005)(81166006)(8676002)(81156014)(14454004)(7736002)(25786009)(71190400001)(50226002)(26005)(5660300002)(186003)(102836004)(8936002)(256004)(14444005)(6512007)(71200400001)(36756003)(7416002)(2906002)(118296001)(64756008)(66946007)(66476007)(6486002)(66446008)(66556008)(6436002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2604;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jMQ4CFN93WkJIWfs9imAR9UB8YpwQxCV0XlK+PVk81e3vbACrmsiIW4AMKM8EXsXqYztW4wLi65XC1I5uWa+9igahMy8h8ye1vsa4mTPlCyyLjzjI+o2rXmPxKVG50vmqKw/HSt4I/S3bUyhJUt+MaX0Wm+q6qy+rUW5ZkNpTov63cTLQT7LDRAtikM+ces/wtSaiVpmImXPYSBM2etMxfdmzHeLJabXyPOU4/iBszsW2dzj7sAiUnEEuSi84XkiJ5FP8urqDlExDmmMoYk0472ejZmMkVsgGTYmAPTCfNWQL2hvqvPB/Stdbcl7WnXBV1i3b5m+7Gha8S5Wdu83QPJclvLCAdIxh1rbP1YjxFtxrb9aLnzGSWHPTQxOzblpLhd/Q57dBHtZVI6tJ7ZEwKnuAEjTMkKza1wWkRhtpwo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB4B42C062B8D740A8AEC717E432AB73@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ebcfdf-a824-414c-e858-08d716b2213e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 18:57:41.6673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2604
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

It turns out that the NMI latency workaround from commit 6d3edaae16c6
("x86/perf/amd: Resolve NMI latency issues for active PMCs") ends up
being too conservative and results in the perf NMI handler claiming NMIs
to easily on AMD hardware when the NMI watchdog is active.

This has an impact, for example, on the hpwdt (HPE watchdog timer) module.
This module can produce an NMI that is used to reset the system. It
registers an NMI handler for the NMI_UNKNOWN type and relies on the fact
that nothing has claimed an NMI so that its handler will be invoked when
the watchdog device produces an NMI. After the referenced commit, the
hpwdt module is unable to process its generated NMI if the NMI watchdog is
active, because the current NMI latency mitigation results in the NMI
being claimed by the perf NMI handler.

Update the AMD perf NMI latency mitigation workaround to, instead, use a
window of time. Whenever a PMC is handled in the perf NMI handler, set a
timestamp which will act as a perf NMI window. Any NMIs arriving within
that window will be claimed by perf. Anything outside that window will
not be claimed by perf. The value for the NMI window is set to 100 msecs.
This is a conservative value that easily covers any NMI latency in the
hardware. While this still results in a window in which the hpwdt module
will not receive its NMI, the window is now much, much smaller.

Cc: Jerry Hoemann <jerry.hoemann@hpe.com>
Fixes: 6d3edaae16c6 ("x86/perf/amd: Resolve NMI latency issues for active P=
MCs")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/events/amd/core.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index e7d35f60d53f..64c3e70b0556 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -5,12 +5,14 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <asm/apicdef.h>
 #include <asm/nmi.h>
=20
 #include "../perf_event.h"
=20
-static DEFINE_PER_CPU(unsigned int, perf_nmi_counter);
+static DEFINE_PER_CPU(unsigned long, perf_nmi_tstamp);
+static unsigned long perf_nmi_window;
=20
 static __initconst const u64 amd_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
@@ -641,11 +643,12 @@ static void amd_pmu_disable_event(struct perf_event *=
event)
  * handler when multiple PMCs are active or PMC overflow while handling so=
me
  * other source of an NMI.
  *
- * Attempt to mitigate this by using the number of active PMCs to determin=
e
- * whether to return NMI_HANDLED if the perf NMI handler did not handle/re=
set
- * any PMCs. The per-CPU perf_nmi_counter variable is set to a minimum of =
the
- * number of active PMCs or 2. The value of 2 is used in case an NMI does =
not
- * arrive at the LAPIC in time to be collapsed into an already pending NMI=
.
+ * Attempt to mitigate this by creating an NMI window in which un-handled =
NMIs
+ * received during this window will be claimed. This prevents extending th=
e
+ * window past when it is possible that latent NMIs should be received. Th=
e
+ * per-CPU perf_nmi_tstamp will be set to the window end time whenever per=
f has
+ * handled a counter. When an un-handled NMI is received, it will be claim=
ed
+ * only if arriving within that window.
  */
 static int amd_pmu_handle_irq(struct pt_regs *regs)
 {
@@ -663,21 +666,19 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 	handled =3D x86_pmu_handle_irq(regs);
=20
 	/*
-	 * If a counter was handled, record the number of possible remaining
-	 * NMIs that can occur.
+	 * If a counter was handled, record a timestamp such that un-handled
+	 * NMIs will be claimed if arriving within that window.
 	 */
 	if (handled) {
-		this_cpu_write(perf_nmi_counter,
-			       min_t(unsigned int, 2, active));
+		this_cpu_write(perf_nmi_tstamp,
+			       jiffies + perf_nmi_window);
=20
 		return handled;
 	}
=20
-	if (!this_cpu_read(perf_nmi_counter))
+	if (time_after(jiffies, this_cpu_read(perf_nmi_tstamp)))
 		return NMI_DONE;
=20
-	this_cpu_dec(perf_nmi_counter);
-
 	return NMI_HANDLED;
 }
=20
@@ -909,6 +910,9 @@ static int __init amd_core_pmu_init(void)
 	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
 		return 0;
=20
+	/* Avoid calulating the value each time in the NMI handler */
+	perf_nmi_window =3D msecs_to_jiffies(100);
+
 	switch (boot_cpu_data.x86) {
 	case 0x15:
 		pr_cont("Fam15h ");
--=20
2.17.1

