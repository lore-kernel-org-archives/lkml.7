Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704A2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3405B2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H4qed8wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfCYRcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:32:47 -0400
Received: from mail-eopbgr820045.outbound.protection.outlook.com ([40.107.82.45]:9826
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729473AbfCYRcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQCJIpMcxRCq4Qq0Hu1F6GFVog9fr76dZwOg+HNdcqg=;
 b=H4qed8wxmcdybdOpBZCIra1DtoisHuakuibHTHaJOYWlSQLFPacWWDH47s6v0SEU6daUMmVyXe7L4Y7ohGm+fICI9ls0IWOlV1WQNKKWRVESxxze4msDGL75qGAaI6W3iEI6uIti7dHZc9LL0MDFPrB5PmQYagHxlODHu4cKdDs=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2782.namprd12.prod.outlook.com (52.135.107.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 17:32:42 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 17:32:42 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>
Subject: [PATCH] tools/power turbostat: Make interval calculation per thread
 to reduce jitter
Thread-Topic: [PATCH] tools/power turbostat: Make interval calculation per
 thread to reduce jitter
Thread-Index: AQHU4zDAw6kMdRt2pEeSvDZqbzvAVQ==
Date:   Mon, 25 Mar 2019 17:32:42 +0000
Message-ID: <20190325173232.216357-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0148.namprd05.prod.outlook.com
 (2603:10b6:803:2c::26) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea406879-15c6-4f98-3125-08d6b147e2c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2782;
x-ms-traffictypediagnostic: SN6PR12MB2782:
x-microsoft-antispam-prvs: <SN6PR12MB27821F2ED9E351FEFE168EB8F85E0@SN6PR12MB2782.namprd12.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(199004)(189003)(81156014)(53936002)(316002)(305945005)(7736002)(8676002)(54906003)(81166006)(8936002)(4326008)(66066001)(6916009)(68736007)(386003)(99286004)(97736004)(72206003)(71200400001)(478600001)(50226002)(106356001)(14454004)(105586002)(2351001)(71190400001)(2501003)(5660300002)(14444005)(256004)(1076003)(486006)(25786009)(2616005)(476003)(86362001)(36756003)(6512007)(6436002)(6486002)(2906002)(6116002)(3846002)(186003)(102836004)(26005)(52116002)(5640700003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2782;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:3;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q1ZsdjZ1GL/MDmrL8BEeGFS1IppEusS1l47pc+I4tSf/2gpukHOq/bidSMLDrKSMXoBuMKSt9vob5Ofo5PxsKnYD2BG8UCj+04yOBcvj/WdI/N6VZUE4egW0ScIypM4sA1TVkbebovBscunBNB8fUeIxwsXZCdkMLC4eKJD0D/q8zC8Xa2s8K4a1BxBKOBWvoYs0h/wa4TXZYZG3QzD5iD2xy1lUm1yT+3AAF68SHI+l2LbB7mLvOyJSnGR/+msDOVZjWo9Da+cqPcAhJBsxhF3y0v5R1xWg40ejdtR8vzmwmbazY6TDTCwveK6cC6M/WJBtDd0hPO6wq/DODrRftcl0Vlc5YOMwizaD48q20DoEa22w0eZrIkVXxu5IUZhRXx58uhXmZSjVQa1/mSx5AOtTIkvupRgS7jW6QedtToM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea406879-15c6-4f98-3125-08d6b147e2c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 17:32:42.7665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2782
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Turbostat currently normalizes TSC and other values by dividing by an
interval. This interval is the delta between the start of one global
(all counters on all CPUs) sampling and the start of another. However,
this introduces a lot of jitter into the data.

In order to reduce jitter, the interval calculation should be based on
timestamps taken per thread and close to the start of the thread's
sampling.

Define a per thread time value to hold the delta between samples taken
on the thread.

Use the timestamp taken at the beginning of sampling to calculate the
delta.

Move the thread's beginning timestamp to after the CPU migration to
avoid jitter due to the migration.

Use the global time delta for the average time delta.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 tools/power/x86/turbostat/turbostat.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbos=
tat/turbostat.c
index c3fad065c89c..6ebcc420021f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -166,6 +166,7 @@ size_t cpu_present_setsize, cpu_affinity_setsize, cpu_s=
ubset_size;
 struct thread_data {
 	struct timeval tv_begin;
 	struct timeval tv_end;
+	struct timeval tv_delta;
 	unsigned long long tsc;
 	unsigned long long aperf;
 	unsigned long long mperf;
@@ -896,7 +897,7 @@ int format_counters(struct thread_data *t, struct core_=
data *c,
 	if (DO_BIC(BIC_TOD))
 		outp +=3D sprintf(outp, "%10ld.%06ld\t", t->tv_end.tv_sec, t->tv_end.tv_=
usec);
=20
-	interval_float =3D tv_delta.tv_sec + tv_delta.tv_usec/1000000.0;
+	interval_float =3D t->tv_delta.tv_sec + t->tv_delta.tv_usec/1000000.0;
=20
 	tsc =3D t->tsc * tsc_tweak;
=20
@@ -1279,6 +1280,7 @@ delta_thread(struct thread_data *new, struct thread_d=
ata *old,
 	 * over-write old w/ new so we can print end of interval values
 	 */
=20
+	timersub(&new->tv_begin, &old->tv_begin, &old->tv_delta);
 	old->tv_begin =3D new->tv_begin;
 	old->tv_end =3D new->tv_end;
=20
@@ -1374,6 +1376,8 @@ void clear_counters(struct thread_data *t, struct cor=
e_data *c, struct pkg_data
 	t->tv_begin.tv_usec =3D 0;
 	t->tv_end.tv_sec =3D 0;
 	t->tv_end.tv_usec =3D 0;
+	t->tv_delta.tv_sec =3D 0;
+	t->tv_delta.tv_usec =3D 0;
=20
 	t->tsc =3D 0;
 	t->aperf =3D 0;
@@ -1540,6 +1544,9 @@ void compute_average(struct thread_data *t, struct co=
re_data *c,
=20
 	for_all_cpus(sum_counters, t, c, p);
=20
+	/* Use the global time delta for the average. */
+	average.threads.tv_delta =3D tv_delta;
+
 	average.threads.tsc /=3D topo.num_cpus;
 	average.threads.aperf /=3D topo.num_cpus;
 	average.threads.mperf /=3D topo.num_cpus;
@@ -1729,13 +1736,13 @@ int get_counters(struct thread_data *t, struct core=
_data *c, struct pkg_data *p)
 	struct msr_counter *mp;
 	int i;
=20
-	gettimeofday(&t->tv_begin, (struct timezone *)NULL);
-
 	if (cpu_migrate(cpu)) {
 		fprintf(outf, "Could not migrate to CPU %d\n", cpu);
 		return -1;
 	}
=20
+	gettimeofday(&t->tv_begin, (struct timezone *)NULL);
+
 	if (first_counter_read)
 		get_apic_id(t);
 retry:
--=20
2.17.1

