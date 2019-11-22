Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634E8C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178AA20731
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hlXDtDtP";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jdtU+hS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfKVTui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:50:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34688 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727846AbfKVTuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:50:25 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMJnj0k003774;
        Fri, 22 Nov 2019 11:50:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tDRflOi42V3bZOEkhw/Pxdz+c0KJqylobCvQ4QnERZc=;
 b=hlXDtDtP2j7L/PFd4mkbJv77WDj75nehXtWrL9n76/VZvl8yAlS4lpgvhIImxHfh5ZkF
 2wNOUlqI8e6FzaJp3CXe1SLnfhbm2aYoxMOZH0vBIsl8eOYGTqqLRdr6so9zOOJpr5Ty
 Vc9YxoZ/yaB9o219Hx//yNYvGWiSL8V3dD4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wea1rka9q-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 Nov 2019 11:50:12 -0800
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 22 Nov 2019 11:50:08 -0800
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 22 Nov 2019 11:50:08 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 22 Nov 2019 11:50:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Axj+ZNJs/RNads+z/oQsJ3ReS3uB/1vMFK0vhEsPS81SZOvVlMgaxRFKNcEY9MS2qYkMpRqbRh6wjAor4nDCdtTK8xVC0uzYxGbUjH4GiFqqRcX6tsGwDS+TiwBfkYxux2nYGK8gAQtFzioMZN5SFLJUCPd0vPMY8x4/Or2nJs7Z2glT8fZ12ZvoVsqqMsRdgvJh0dVnREKnbsoAR8sAI1lsWfs/SqN0fAlzNC05GJIDBEfItbgzWr9vGUbop7iFUJWLWkiDhH7OOgtFk2+dMSp6MV61TfXVWNUSJ3K3iiCVqGaM9FsOijcJwer6sFXMP18nhGQjgBPbd3vMOtzeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDRflOi42V3bZOEkhw/Pxdz+c0KJqylobCvQ4QnERZc=;
 b=KF2DHT53MTDsWHfnT2bVbWn2gtpKTFh0NHVARnYh/80R41AsIrhgEkv+xdEQp61RzuGySGVj79JLsqcgZ6pdoIxNyCJr68+cepHGNi1C0UwrV9KQsWnTYpBfso6MM3eowCqjF0jpJ9BQaX1ASVdjmCNqOJrw5tzaBW8txliOSHY0qlDgwCtXoICPKOQfBusVrrVEoWDmb23fvkMoJ6czE50i+g20MToLKKrPWguUvoshTY/Lp4Vk6DOkQLae0GwDzBbWwNnYkR9kEedyc6D7xOaM4iyv7AHRaIXFmdDzU9riqXshzRM02n+zE3XV+YnNLWOZ76pgX4+vvvheIv/Wvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDRflOi42V3bZOEkhw/Pxdz+c0KJqylobCvQ4QnERZc=;
 b=jdtU+hS+zaXeszet4n7JNRGBEmIMnRWQtCEaO4OuTh3qxwBZF9x5K+uZwZ5FmLEcwiIMgYXbQLDGr5lenRWZrBW8Z8ER49aFpsRJvoveX3WIn6jQUp1uMGtFqE4D/plT436xlECx2kyf26yrU1L3K8ZI1YDGErRDNhzuYUziscI=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1743.namprd15.prod.outlook.com (10.174.98.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 22 Nov 2019 19:50:06 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2474.021; Fri, 22 Nov 2019
 19:50:06 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        David Carrillo Cisneros <davidca@fb.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, "Tejun Heo" <tj@kernel.org>
Subject: Re: [PATCH v7] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v7] perf: Sharing PMU counters across compatible events
Thread-Index: AQHVnBAlgYxvir4ozkO3bLas1TlApqeXn1+AgAAEk4A=
Date:   Fri, 22 Nov 2019 19:50:06 +0000
Message-ID: <951F0EE1-5DCC-46CA-8891-39A891512CEE@fb.com>
References: <20191115235504.4034879-1-songliubraving@fb.com>
 <20191122193343.GB2157@krava>
In-Reply-To: <20191122193343.GB2157@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:200::ec92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b46dbcd-56a6-43b1-d896-08d76f852cbf
x-ms-traffictypediagnostic: MWHPR15MB1743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1743FBC19CFCA174851ACE01B3490@MWHPR15MB1743.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(366004)(396003)(199004)(189003)(6486002)(46003)(4326008)(11346002)(76176011)(229853002)(76116006)(8936002)(446003)(2906002)(6116002)(6246003)(6436002)(6512007)(14444005)(256004)(5024004)(102836004)(99286004)(50226002)(6506007)(53546011)(2616005)(81156014)(14454004)(66446008)(305945005)(316002)(66946007)(7736002)(8676002)(71190400001)(71200400001)(30864003)(36756003)(5660300002)(86362001)(25786009)(66476007)(478600001)(6916009)(186003)(64756008)(81166006)(33656002)(66556008)(54906003)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1743;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3kyf1omccRvrbDEBgJ1J+kB5IoSoMrMhtGw+VtXujL0X6NYAw8q/GSTd6j/MrkT9K+f/JKpvFd4IC4OtiBgsxqSuaBh3YoI64Q4JEW5Tn1jS0wDnBbuKI+vTxlQT+7dZIWF/ZaSLPEUxg7VLHN4BwH/vrkYazJSLVCZapIoTDwY6sgsCamrt4uJyZlNtF0Fg0aQgN5fmEiSXg6DfHnif1Fdzg/xPSSXocOKWJTyoN17bzJUY0TvomxJVt7OSarPKGQaNj8v2cbLoaewsHeuEC2n7cG/4bFdpKyMg3oyqG8ONe6K3ttpawSVOu02vH9KTiac/Jgk6cxNKW3d0ullCW8phvdWhjTnP5nHggdTDwvrios/UWj8Arc2XN+bVOvqKWAfnR6djYowLXncrkMzSLnq+8tG4OBf4JwirkSpcb6parl1kN/Q+wORhPrW7IP3G
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F79B3C424A04E04D9E3F316BB9A5A063@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b46dbcd-56a6-43b1-d896-08d76f852cbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 19:50:06.5969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ah6NUqaGPDMwOfcXenk1zwZCFXR6bjFmZJefF5e29X//45i4NK9mcBpGU2tEbc01sDsJ1miuRM3Zzhvj2hTcOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1743
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_04:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220163
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 22, 2019, at 11:33 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Fri, Nov 15, 2019 at 03:55:04PM -0800, Song Liu wrote:
>> This patch tries to enable PMU sharing. When multiple perf_events are
>> counting the same metric, they can share the hardware PMU counter. We
>> call these events as "compatible events".
>>=20
>> The PMU sharing are limited to events within the same perf_event_context
>> (ctx). When a event is installed or enabled, search the ctx for compatib=
le
>> events. This is implemented in perf_event_setup_dup(). One of these
>> compatible events are picked as the master (stored in event->dup_master)=
.
>> Similarly, when the event is removed or disabled, perf_event_remove_dup(=
)
>> is used to clean up sharing.
>>=20
>> A new state PERF_EVENT_STATE_ENABLED is introduced for the master event.
>> This state is used when the slave event is ACTIVE, but the master event
>> is not.
>>=20
>> On the critical paths (add, del read), sharing PMU counters doesn't
>> increase the complexity. Helper functions event_pmu_[add|del|read]() are
>> introduced to cover these cases. All these functions have O(1) time
>> complexity.
>>=20
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>=20
>> ---
>> Changes in v7:
>> Major rewrite to avoid allocating extra master event.
>=20
> hi,
> what is this based on? I can't apply it on tip/master:
>=20
> 	Applying: perf: Sharing PMU counters across compatible events
> 	error: patch failed: include/linux/perf_event.h:722
> 	error: include/linux/perf_event.h: patch does not apply
> 	Patch failed at 0001 perf: Sharing PMU counters across compatible events
> 	hint: Use 'git am --show-current-patch' to see the failed patch
> 	When you have resolved this problem, run "git am --continue".
> 	If you prefer to skip this patch, run "git am --skip" instead.
> 	To restore the original branch and stop patching, run "git am --abort".

I was using Linus's master branch. This one is specifically based on=20

commit 96b95eff4a591dbac582c2590d067e356a18aacb
Merge: 4e84608c7836 80591e61a0f7
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   8 days ago

    Merge tag 'kbuild-fixes-v5.4-3' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/masahiroy/linux-kbuild

    Pull Kbuild fixes from Masahiro Yamada:

     - fix build error when compiling SPARC VDSO with CONFIG_COMPAT=3Dy

     - pass correct --arch option to Sparse

    * tag 'kbuild-fixes-v5.4-3' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/masahiroy/linux-kbuild:
      kbuild: tell sparse about the $ARCH
      sparc: vdso: fix build error of vdso32

>=20
> also I'm getting this when trying to see/apply plain text patch:
>=20
> 	[jolsa@dell-r440-01 linux-perf]$ git am --show-current-patch | tail
> 	 =3D09=3D09for_each_sibling_event(sibling, group_leader) {
> 	 =3D09=3D09=3D09perf_remove_from_context(sibling, 0);
> 	 =3D09=3D09=3D09put_ctx(gctx);
> 	+=3D09=3D09=3D09WARN_ON_ONCE(sibling->dup_master);
> 	 =3D09=3D09}
> 	=3D20
> 	 =3D09=3D09/*
> 	--=3D20


I also get these =3D09, =3D20 issues. I am not sure how to fix them. Attach=
ing=20
the patch here to see whether it fixes it.=20

Thanks!
Song




From bb83b28deca52a2376d8b9d0b1d54e7fec797aa9 Mon Sep 17 00:00:00 2001
From: Song Liu <songliubraving@fb.com>
Date: Wed, 6 Jun 2018 23:24:10 -0700
Subject: [PATCH v7] perf: Sharing PMU counters across compatible events

This patch tries to enable PMU sharing. When multiple perf_events are
counting the same metric, they can share the hardware PMU counter. We
call these events as "compatible events".

The PMU sharing are limited to events within the same perf_event_context
(ctx). When a event is installed or enabled, search the ctx for compatible
events. This is implemented in perf_event_setup_dup(). One of these
compatible events are picked as the master (stored in event->dup_master).
Similarly, when the event is removed or disabled, perf_event_remove_dup()
is used to clean up sharing.

A new state PERF_EVENT_STATE_ENABLED is introduced for the master event.
This state is used when the slave event is ACTIVE, but the master event
is not.

On the critical paths (add, del read), sharing PMU counters doesn't
increase the complexity. Helper functions event_pmu_[add|del|read]() are
introduced to cover these cases. All these functions have O(1) time
complexity.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Song Liu <songliubraving@fb.com>

---
Changes in v7:
Major rewrite to avoid allocating extra master event.
---
 include/linux/perf_event.h |  14 +-
 kernel/events/core.c       | 319 ++++++++++++++++++++++++++++++++++---
 2 files changed, 309 insertions(+), 24 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 68ccc5b1913b..bb05b178841d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -522,7 +522,9 @@ enum perf_event_state {
 	PERF_EVENT_STATE_ERROR		=3D -2,
 	PERF_EVENT_STATE_OFF		=3D -1,
 	PERF_EVENT_STATE_INACTIVE	=3D  0,
-	PERF_EVENT_STATE_ACTIVE		=3D  1,
+	/* the hw PMC is enabled, but this event is not counting */
+	PERF_EVENT_STATE_ENABLED	=3D  1,
+	PERF_EVENT_STATE_ACTIVE		=3D  2,
 };
=20
 struct file;
@@ -722,6 +724,16 @@ struct perf_event {
 #endif
=20
 	struct list_head		sb_list;
+
+	/* for PMU sharing */
+	struct perf_event		*dup_master;
+	/* check event_sync_dup_count() for the use of dup_base_* */
+	u64				dup_base_count;
+	u64				dup_base_child_count;
+	/* when this event is master,  read from master*count */
+	local64_t			master_count;
+	atomic64_t			master_child_count;
+	int				dup_active_count;
 #endif /* CONFIG_PERF_EVENTS */
 };
=20
diff --git a/kernel/events/core.c b/kernel/events/core.c
index aec8dba2bea4..00b1e19e70fd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1657,6 +1657,139 @@ perf_event_groups_next(struct perf_event *event)
 		event =3D rb_entry_safe(rb_next(&event->group_node),	\
 				typeof(*event), group_node))
=20
+static inline bool perf_event_can_share(struct perf_event *event)
+{
+	/* only share hardware counting events */
+	return !is_software_event(event) && !is_sampling_event(event);
+}
+
+/*
+ * Returns whether the two events can share a PMU counter.
+ *
+ * Note: This function does NOT check perf_event_can_share() for
+ * the two events, they should be checked before this function
+ */
+static inline bool perf_event_compatible(struct perf_event *event_a,
+					 struct perf_event *event_b)
+{
+	return event_a->attr.type =3D=3D event_b->attr.type &&
+		event_a->attr.config =3D=3D event_b->attr.config &&
+		event_a->attr.config1 =3D=3D event_b->attr.config1 &&
+		event_a->attr.config2 =3D=3D event_b->attr.config2;
+}
+
+/* prepare the dup_master, this event is its own dup_master */
+static void perf_event_init_dup_master(struct perf_event *event)
+{
+	event->dup_master =3D event;
+	/*
+	 * dup_master->count is used by the hw PMC, and shared with other
+	 * events, so we have to read from dup_master->master_count. Copy
+	 * event->count to event->master_count.
+	 *
+	 * Same logic for child_count and master_child_count.
+	 */
+	local64_set(&event->master_count, local64_read(&event->count));
+	atomic64_set(&event->master_child_count,
+		     atomic64_read(&event->child_count));
+
+	event->dup_active_count =3D 0;
+}
+
+/* tear down dup_master, no more sharing for this event */
+static void perf_event_exit_dup_master(struct perf_event *event)
+{
+	WARN_ON_ONCE(event->dup_active_count);
+
+	event->dup_master =3D NULL;
+	/* restore event->count and event->child_count */
+	local64_set(&event->count, local64_read(&event->master_count));
+	atomic64_set(&event->child_count,
+		     atomic64_read(&event->master_child_count));
+}
+
+/* After adding a event to the ctx, try find compatible event(s). */
+static void perf_event_setup_dup(struct perf_event *event,
+				 struct perf_event_context *ctx)
+
+{
+	struct perf_event *tmp;
+
+	if (event->dup_master ||
+	    event->state !=3D PERF_EVENT_STATE_INACTIVE ||
+	    !perf_event_can_share(event))
+		return;
+
+	/* look for dup with other events */
+	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
+		WARN_ON_ONCE(tmp->state > PERF_EVENT_STATE_INACTIVE);
+
+		if (tmp =3D=3D event ||
+		    tmp->state !=3D PERF_EVENT_STATE_INACTIVE ||
+		    !perf_event_can_share(tmp) ||
+		    !perf_event_compatible(event, tmp))
+			continue;
+
+		/* first dup, pick tmp as the master */
+		if (!tmp->dup_master)
+			perf_event_init_dup_master(tmp);
+
+		event->dup_master =3D tmp->dup_master;
+		break;
+	}
+}
+
+/* Remove dup_master for the event */
+static void perf_event_remove_dup(struct perf_event *event,
+				  struct perf_event_context *ctx)
+
+{
+	struct perf_event *tmp, *new_master;
+	int count;
+
+	/* no sharing */
+	if (!event->dup_master)
+		return;
+
+	WARN_ON_ONCE(event->state !=3D PERF_EVENT_STATE_INACTIVE &&
+		     event->state !=3D PERF_EVENT_STATE_OFF);
+
+	/* this event is not the master */
+	if (event->dup_master !=3D event) {
+		event->dup_master =3D NULL;
+		return;
+	}
+
+	/* this event is the master */
+	perf_event_exit_dup_master(event);
+	count =3D 0;
+	new_master =3D NULL;
+	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
+		WARN_ON_ONCE(tmp->state > PERF_EVENT_STATE_INACTIVE);
+		if (tmp->dup_master =3D=3D event) {
+			count++;
+			if (!new_master)
+				new_master =3D tmp;
+		}
+	}
+
+	if (!count)
+		return;
+
+	if (count =3D=3D 1) {
+		/* no more sharing */
+		new_master->dup_master =3D NULL;
+		return;
+	}
+
+	perf_event_init_dup_master(new_master);
+
+	/* switch to new_master */
+	list_for_each_entry(tmp, &ctx->event_list, event_entry)
+		if (tmp->dup_master =3D=3D event)
+			tmp->dup_master =3D new_master;
+}
+
 /*
  * Add an event from the lists for its context.
  * Must be called with ctx->mutex and ctx->lock held.
@@ -1689,6 +1822,7 @@ list_add_event(struct perf_event *event, struct perf_=
event_context *ctx)
 		ctx->nr_stat++;
=20
 	ctx->generation++;
+	perf_event_setup_dup(event, ctx);
 }
=20
 /*
@@ -1861,6 +1995,7 @@ list_del_event(struct perf_event *event, struct perf_=
event_context *ctx)
 	if (!(event->attach_state & PERF_ATTACH_CONTEXT))
 		return;
=20
+	perf_event_remove_dup(event, ctx);
 	event->attach_state &=3D ~PERF_ATTACH_CONTEXT;
=20
 	list_update_cgroup_event(event, ctx, false);
@@ -2069,6 +2204,98 @@ event_filter_match(struct perf_event *event)
 	       perf_cgroup_match(event) && pmu_filter_match(event);
 }
=20
+/* PMU sharing aware version of event->pmu->add() */
+static int event_pmu_add(struct perf_event *event,
+			 struct perf_event_context *ctx)
+{
+	struct perf_event *master;
+	int ret;
+
+	/* no sharing, just do event->pmu->add() */
+	if (!event->dup_master)
+		return event->pmu->add(event, PERF_EF_START);
+
+	master =3D event->dup_master;
+
+	if (!master->dup_active_count) {
+		ret =3D event->pmu->add(master, PERF_EF_START);
+		if (ret)
+			return ret;
+
+		if (master !=3D event)
+			perf_event_set_state(master, PERF_EVENT_STATE_ENABLED);
+	}
+
+	master->dup_active_count++;
+	master->pmu->read(master);
+	event->dup_base_count =3D local64_read(&master->count);
+	event->dup_base_child_count =3D atomic64_read(&master->child_count);
+	return 0;
+}
+
+/*
+ * sync data count from dup->master to event, called on event_pmu_read()
+ * and event_pmu_del()
+ */
+static void event_sync_dup_count(struct perf_event *event,
+				 struct perf_event *master)
+{
+	u64 new_count;
+	u64 new_child_count;
+
+	WARN_ON_ONCE(event->state !=3D PERF_EVENT_STATE_ACTIVE);
+
+	event->pmu->read(master);
+	new_count =3D local64_read(&master->count);
+	new_child_count =3D atomic64_read(&master->child_count);
+
+	if (event =3D=3D master) {
+		local64_add(new_count - event->dup_base_count,
+			    &event->master_count);
+		atomic64_add(new_child_count - event->dup_base_child_count,
+			     &event->master_child_count);
+	} else {
+		local64_add(new_count - event->dup_base_count, &event->count);
+		atomic64_add(new_child_count - event->dup_base_child_count,
+			     &event->child_count);
+	}
+
+	/* save dup_base_* for next sync */
+	event->dup_base_count =3D new_count;
+	event->dup_base_child_count =3D new_child_count;
+}
+
+/* PMU sharing aware version of event->pmu->del() */
+static void event_pmu_del(struct perf_event *event,
+			  struct perf_event_context *ctx)
+{
+	struct perf_event *master;
+
+	if (event->dup_master =3D=3D NULL) {
+		event->pmu->del(event, 0);
+		return;
+	}
+
+	master =3D event->dup_master;
+	event_sync_dup_count(event, master);
+	if (--master->dup_active_count =3D=3D 0) {
+		event->pmu->del(master, 0);
+		perf_event_set_state(master, PERF_EVENT_STATE_INACTIVE);
+	} else if (master =3D=3D event) {
+		perf_event_set_state(master, PERF_EVENT_STATE_ENABLED);
+	}
+}
+
+/* PMU sharing aware version of event->pmu->read() */
+static void event_pmu_read(struct perf_event *event)
+{
+	if (event->dup_master =3D=3D NULL) {
+		event->pmu->read(event);
+		return;
+	}
+	event_sync_dup_count(event, event->dup_master);
+}
+
 static void
 event_sched_out(struct perf_event *event,
 		  struct perf_cpu_context *cpuctx,
@@ -2091,7 +2318,7 @@ event_sched_out(struct perf_event *event,
=20
 	perf_pmu_disable(event->pmu);
=20
-	event->pmu->del(event, 0);
+	event_pmu_del(event, ctx);
 	event->oncpu =3D -1;
=20
 	if (READ_ONCE(event->pending_disable) >=3D 0) {
@@ -2140,6 +2367,14 @@ group_sched_out(struct perf_event *group_event,
=20
 #define DETACH_GROUP	0x01UL
=20
+static void ctx_sched_out(struct perf_event_context *ctx,
+			  struct perf_cpu_context *cpuctx,
+			  enum event_type_t event_type);
+
+static void ctx_resched(struct perf_cpu_context *cpuctx,
+			struct perf_event_context *task_ctx,
+			enum event_type_t event_type);
+
 /*
  * Cross CPU call to remove a performance event
  *
@@ -2153,13 +2388,17 @@ __perf_remove_from_context(struct perf_event *event=
,
 			   void *info)
 {
 	unsigned long flags =3D (unsigned long)info;
+	bool resched =3D (event->dup_master =3D=3D event);
=20
 	if (ctx->is_active & EVENT_TIME) {
 		update_context_time(ctx);
 		update_cgrp_time_from_cpuctx(cpuctx);
 	}
=20
-	event_sched_out(event, cpuctx, ctx);
+	if (resched)
+		ctx_sched_out(ctx, cpuctx, EVENT_ALL);
+	else
+		event_sched_out(event, cpuctx, ctx);
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	list_del_event(event, ctx);
@@ -2171,6 +2410,9 @@ __perf_remove_from_context(struct perf_event *event,
 			cpuctx->task_ctx =3D NULL;
 		}
 	}
+	if (resched)
+		ctx_resched(cpuctx, cpuctx->task_ctx,
+			    EVENT_ALL | (ctx->task ? 0 : EVENT_CPU));
 }
=20
 /*
@@ -2226,6 +2468,16 @@ static void __perf_event_disable(struct perf_event *=
event,
 		update_cgrp_time_from_event(event);
 	}
=20
+	if (event->dup_master =3D=3D event) {
+		/* disabling master, resched all */
+		ctx_sched_out(ctx, cpuctx, EVENT_ALL);
+		perf_event_remove_dup(event, ctx);
+		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
+		ctx_resched(cpuctx, cpuctx->task_ctx,
+			    EVENT_ALL | (ctx->task ? 0 : EVENT_CPU));
+		return;
+	}
+
 	if (event =3D=3D event->group_leader)
 		group_sched_out(event, cpuctx, ctx);
 	else
@@ -2364,7 +2616,7 @@ event_sched_in(struct perf_event *event,
=20
 	perf_log_itrace_start(event);
=20
-	if (event->pmu->add(event, PERF_EF_START)) {
+	if (event_pmu_add(event, ctx)) {
 		perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 		event->oncpu =3D -1;
 		ret =3D -EAGAIN;
@@ -2478,9 +2730,6 @@ static void add_event_to_ctx(struct perf_event *event=
,
 	perf_group_attach(event);
 }
=20
-static void ctx_sched_out(struct perf_event_context *ctx,
-			  struct perf_cpu_context *cpuctx,
-			  enum event_type_t event_type);
 static void
 ctx_sched_in(struct perf_event_context *ctx,
 	     struct perf_cpu_context *cpuctx,
@@ -2625,9 +2874,13 @@ static int  __perf_install_in_context(void *info)
 #endif
=20
 	if (reprogram) {
-		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
+		int event_type =3D perf_event_can_share(event) ? EVENT_ALL : 0;
+
+		/* if perf_event_can_share() resched EVENT_ALL */
+		ctx_sched_out(ctx, cpuctx, event_type);
 		add_event_to_ctx(event, ctx);
-		ctx_resched(cpuctx, task_ctx, get_event_type(event));
+		ctx_resched(cpuctx, task_ctx,
+			    event_type | (ctx->task ? 0 : EVENT_CPU));
 	} else {
 		add_event_to_ctx(event, ctx);
 	}
@@ -2745,21 +2998,26 @@ static void __perf_event_enable(struct perf_event *=
event,
 {
 	struct perf_event *leader =3D event->group_leader;
 	struct perf_event_context *task_ctx;
+	int was_active;
+	int event_type;
=20
 	if (event->state >=3D PERF_EVENT_STATE_INACTIVE ||
 	    event->state <=3D PERF_EVENT_STATE_ERROR)
 		return;
=20
+	event_type =3D perf_event_can_share(event) ? EVENT_ALL : EVENT_TIME;
+	was_active =3D ctx->is_active;
 	if (ctx->is_active)
-		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
+		ctx_sched_out(ctx, cpuctx, event_type);
=20
 	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
+	perf_event_setup_dup(event, ctx);
=20
-	if (!ctx->is_active)
+	if (!was_active)
 		return;
=20
 	if (!event_filter_match(event)) {
-		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
+		ctx_sched_in(ctx, cpuctx, event_type, current);
 		return;
 	}
=20
@@ -2767,8 +3025,8 @@ static void __perf_event_enable(struct perf_event *ev=
ent,
 	 * If the event is in a group and isn't the group leader,
 	 * then don't put it on unless the group is on.
 	 */
-	if (leader !=3D event && leader->state !=3D PERF_EVENT_STATE_ACTIVE) {
-		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
+	if (leader !=3D event && leader->state <=3D PERF_EVENT_STATE_INACTIVE) {
+		ctx_sched_in(ctx, cpuctx, event_type, current);
 		return;
 	}
=20
@@ -2776,7 +3034,8 @@ static void __perf_event_enable(struct perf_event *ev=
ent,
 	if (ctx->task)
 		WARN_ON_ONCE(task_ctx !=3D ctx);
=20
-	ctx_resched(cpuctx, task_ctx, get_event_type(event));
+	/* if perf_event_can_share() resched EVENT_ALL */
+	ctx_resched(cpuctx, task_ctx, get_event_type(event) | event_type);
 }
=20
 /*
@@ -3115,7 +3374,7 @@ static void __perf_event_sync_stat(struct perf_event =
*event,
 	 * don't need to use it.
 	 */
 	if (event->state =3D=3D PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+		event_pmu_read(event);
=20
 	perf_event_update_time(event);
=20
@@ -3979,14 +4238,14 @@ static void __perf_event_read(void *info)
 		goto unlock;
=20
 	if (!data->group) {
-		pmu->read(event);
+		event_pmu_read(event);
 		data->ret =3D 0;
 		goto unlock;
 	}
=20
 	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
=20
-	pmu->read(event);
+	event_pmu_read(event);
=20
 	for_each_sibling_event(sub, event) {
 		if (sub->state =3D=3D PERF_EVENT_STATE_ACTIVE) {
@@ -3994,7 +4253,7 @@ static void __perf_event_read(void *info)
 			 * Use sibling's PMU rather than @event's since
 			 * sibling could be on different (eg: software) PMU.
 			 */
-			sub->pmu->read(sub);
+			event_pmu_read(sub);
 		}
 	}
=20
@@ -4006,6 +4265,9 @@ static void __perf_event_read(void *info)
=20
 static inline u64 perf_event_count(struct perf_event *event)
 {
+	if (event->dup_master =3D=3D event)
+		return local64_read(&event->master_count) +
+			atomic64_read(&event->master_child_count);
 	return local64_read(&event->count) + atomic64_read(&event->child_count);
 }
=20
@@ -4064,9 +4326,12 @@ int perf_event_read_local(struct perf_event *event, =
u64 *value,
 	 * oncpu =3D=3D -1).
 	 */
 	if (event->oncpu =3D=3D smp_processor_id())
-		event->pmu->read(event);
+		event_pmu_read(event);
=20
-	*value =3D local64_read(&event->count);
+	if (event->dup_master =3D=3D event)
+		*value =3D local64_read(&event->master_count);
+	else
+		*value =3D local64_read(&event->count);
 	if (enabled || running) {
 		u64 now =3D event->shadow_ctx_time + perf_clock();
 		u64 __enabled, __running;
@@ -6288,7 +6553,7 @@ static void perf_output_read_group(struct perf_output=
_handle *handle,
=20
 	if ((leader !=3D event) &&
 	    (leader->state =3D=3D PERF_EVENT_STATE_ACTIVE))
-		leader->pmu->read(leader);
+		event_pmu_read(leader);
=20
 	values[n++] =3D perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
@@ -6301,7 +6566,7 @@ static void perf_output_read_group(struct perf_output=
_handle *handle,
=20
 		if ((sub !=3D event) &&
 		    (sub->state =3D=3D PERF_EVENT_STATE_ACTIVE))
-			sub->pmu->read(sub);
+			event_pmu_read(sub);
=20
 		values[n++] =3D perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
@@ -9566,7 +9831,7 @@ static enum hrtimer_restart perf_swevent_hrtimer(stru=
ct hrtimer *hrtimer)
 	if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
 		return HRTIMER_NORESTART;
=20
-	event->pmu->read(event);
+	event_pmu_read(event);
=20
 	perf_sample_data_init(&data, 0, event->hw.last_period);
 	regs =3D get_irq_regs();
@@ -11202,9 +11467,17 @@ SYSCALL_DEFINE5(perf_event_open,
 		perf_remove_from_context(group_leader, 0);
 		put_ctx(gctx);
=20
+		/*
+		 * move_group only happens to sw events, from sw ctx to hw
+		 * ctx. The sw events should not have valid dup_master. So
+		 * it is not necessary to handle dup_events.
+		 */
+		WARN_ON_ONCE(group_leader->dup_master);
+
 		for_each_sibling_event(sibling, group_leader) {
 			perf_remove_from_context(sibling, 0);
 			put_ctx(gctx);
+			WARN_ON_ONCE(sibling->dup_master);
 		}
=20
 		/*
--=20
2.17.1










