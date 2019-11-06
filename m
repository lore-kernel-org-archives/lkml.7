Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3B4C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3B72166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dbAPfe6w";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Wkk1tVPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfKFWXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:23:42 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39014 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbfKFWXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:23:41 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6MLCLN026110;
        Wed, 6 Nov 2019 14:23:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0Bu79A3Kie8Zls85z7yjcV4RdlnCsTFuXg/wgFnKWcg=;
 b=dbAPfe6wvBsm6sLz/HF+iy5sM21oyqR9fzlz4L6j522M3yWtgvuUoZTAXYYNTSTcXNsC
 UGuzbR/1jQbQISgal2loVqhi8ObCS9mj5x78yNEPq+h/Q+b12YAnIncmIFMIEtniSSeH
 EbfXgpyxNa/C9JfhCEl8IQaCNUle3LaEi5E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w41uj9nc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 Nov 2019 14:23:32 -0800
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Nov 2019 14:23:31 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 6 Nov 2019 14:23:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdqHs76cO5pMygcfbPSWWJeeG+H3tKFXG9tTF880MMgedr+BQxerRgpNadlzISLP6UEvddoQBuv8d7RCbwJ9OEvQzzxfJYINm4/1VobtL8mg9ZOD/lwUxWmhwv2dwk6HQ4QFZOYsTQOqEU8ks7xgYqLXPOBvc7jqEGx5zkgb6j12Vgq9RZX04zZD9LlG5BwMmvskhPKMRnCo1JiJ3/Sj5kCYBBwc1Io/bdzchtjf9OG2GO90xIMi9C8pqww8mpj7bD1XdSR4ORUv/u33Gr8DKXpoLFIhU9ai0Zr7a9oWjQHOFVsKSQDzEF8P3P5jtKDJRnwb0/HfksINwASqDiHhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Bu79A3Kie8Zls85z7yjcV4RdlnCsTFuXg/wgFnKWcg=;
 b=QyfVsC6tUoX9JnCnLze3Fx5GoCUldPjqCNVlHZ+rlmJ/AGRgfDsCwd9tL8tEhLlm/EddxJOAsYAe2JTG5Tlj9PWYK0DCgjcLnVrAhVv+AoZMczgTZ1a4bfA3PdgEtVIH9iUxykvut9zm12DWp602pWdtAXZc3FlOkWLjpLCURy20VsAON3UrU47HhYSh/Rj1ioVA7huwaEY0tRKxRpsdxm8/mfFyZc12asIEkj2vIfm6ZQihHtDbD5Uk+GzlIm4AKu5v7/tu2WrawHyxLqZLpqO1rweUQi2iiopfSWNCPgyl5O924G5rOTXcxeDbx/x/dkXleA/Tf8IVUX8GcConBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Bu79A3Kie8Zls85z7yjcV4RdlnCsTFuXg/wgFnKWcg=;
 b=Wkk1tVPc+dosR1BbxH5vJNR+qc7TFJt1rbb1GGBhPACKiTtMtx1CwGb0q5ret1cyr/KBDWjVJxdRTP+gaVbuOLaWCSLD5mDp4EB0jM4dR/ZzJf1Tg4nPqzREzG9khV/6ABFZtpfd6dneBqdBOhspqbq9Nxb1Da5P7l7MKQH89r4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1840.namprd15.prod.outlook.com (10.174.99.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 22:23:14 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 22:23:14 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, "Tejun Heo" <tj@kernel.org>
Subject: Re: [PATCH v6] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v6] perf: Sharing PMU counters across compatible events
Thread-Index: AQHVbqpjjWjaDbp/ikSYoLFTNk8qM6d09EYAgAA/EQCAB+dbAIAAM8KAgAAvaoCAAKofAIAAjTwAgAAzXoCAABuigA==
Date:   Wed, 6 Nov 2019 22:23:14 +0000
Message-ID: <01B0B855-9433-4DFC-B4B5-A7A68F2B17FB@fb.com>
References: <20190919052314.2925604-1-songliubraving@fb.com>
 <20191031124332.GQ4131@hirez.programming.kicks-ass.net>
 <19AE6C78-C54C-4C37-BBD2-0396BB97A474@fb.com>
 <98A6264C-B833-4930-95A0-2A3186519D87@fb.com>
 <20191105201623.GG3079@worktop.programming.kicks-ass.net>
 <23D48724-55B7-45A3-A77A-56BAD57937F9@fb.com>
 <20191106091458.GS4131@hirez.programming.kicks-ass.net>
 <168F3761-98CF-4E91-B911-ECB9FCD68F0C@fb.com>
 <20191106204419.GI3079@worktop.programming.kicks-ass.net>
In-Reply-To: <20191106204419.GI3079@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::46e1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4a0c730-835a-48b8-9e17-08d76307ea50
x-ms-traffictypediagnostic: MWHPR15MB1840:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB184087C7E84F499FBACDAF20B3790@MWHPR15MB1840.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(14444005)(71200400001)(71190400001)(36756003)(25786009)(256004)(6246003)(6486002)(6512007)(186003)(46003)(229853002)(4326008)(6506007)(86362001)(14454004)(53546011)(102836004)(76176011)(478600001)(7736002)(66556008)(66446008)(64756008)(66476007)(66946007)(76116006)(2906002)(6916009)(5660300002)(99286004)(54906003)(316002)(11346002)(33656002)(8936002)(50226002)(81166006)(6436002)(486006)(476003)(2616005)(446003)(6116002)(81156014)(8676002)(305945005)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1840;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lSkRFVlZKnLFMLxT93JJrWueLxHG2PckEF2Wa51XwA+X7D9rE+9li2yYmdvL0pGUPCbrR/DS9lzfDA64oGMzRDjawf55C61y32X9b0q9JLXw1uviNjbyjc+Qt4ygvpMhqxBDEMu6R2ICHhHYPwxHDWQS8gPPD2nHjY+0HRfevvuJcp6Co5kiDBPDb52vizikrOsdF/6AoSns1eAZ+Qjr82gCjhXgdxSerbSWGOs7a7RZA/TfAUQsYRIMWh4HnB/hbTU/xIGk4bSA758YD1HdedwkkXKMK3zjHHtiVv3BjHadkAefMqbkk5ENyULjOe07n17z23Mjh91qkmCnhjCkGnn35SeikVUhjCdhYS5lpLmeJNgroxb4ihxj9Kvp8eOBPHQ2r1nWgMHXFKZAHk3MGrqxtD6oJV1/dMDnDOwmFPgmpnJxdkqvWlIOSLoWX/bf
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB5EFAEB7EE2E8428469F98B5E64A83C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a0c730-835a-48b8-9e17-08d76307ea50
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 22:23:14.1688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1My9S/S9YcBdsCKRvHyhXN/oWM6SUnOa4u1IELkMMJhCEW6Sn7rKd4+VfYSxE4JGRRYC+qWeN8sa/7ivnmZhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1840
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_08:2019-11-06,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911060214
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 6, 2019, at 12:44 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Wed, Nov 06, 2019 at 05:40:29PM +0000, Song Liu wrote:
>>> On Nov 6, 2019, at 1:14 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
>>>> OTOH, non-cgroup event could also be inactive. For example, when we ha=
ve=20
>>>> to rotate events, we may schedule slave before master.=20
>>>=20
>>> Right, although I suppose in that case you can do what you did in your
>>> patch here. If someone did IOC_DISABLE on the master, we'd have to
>>> re-elect a master -- obviously (and IOC_ENABLE).
>>=20
>> Re-elect master on IOC_DISABLE is good. But we still need work for ctx
>> rotation. Otherwise, we need keep the master on at all time.=20
>=20
> I meant to says that for the rotation case we can do as you did here, if
> we do add() on a slave, add the master if it wasn't add()'ed yet.

Maybe an "add-but-don't-count" state would solve this, even with event grou=
ps?
Say "PERF_EVENT_STATE_ACTIVE_NOT_COUNTING". Let me think more about it.=20

>=20
>>>> And if the master is in an event group, it will be more complicated...
>>>=20
>>> Hurmph, do you actually have that use-case? And yes, this one is tricky=
.
>>>=20
>>> Would it be sufficient if we disallow group events to be master (but
>>> allow them to be slaves) ?
>>=20
>> Maybe we can solve this with an extra "first_active" pointer in perf_eve=
nt.
>> first_active points to the first event that being added by event_pmu_add=
().=20
>> Then we need something like:
>>=20
>> event_pmu_add(event)
>> {
>> 	if (event->dup_master->first_active) {
>> 		/* sync with first_active */
>> 	} else {
>> 		/* this event will be the first_active */
>> 		event->dup_master->first_active =3D event;
>> 		pmu->add(event);
>> 	}
>> }
>=20
> I'm confused on what exactly you're trying to solve with the
> first_active thing. The problem with the group event as master is that
> you then _must_ schedule the whole group, which is obviously difficult.

With first_active, we are not required to schedule the master. A slave=20
could be the first_active, and other slaves could read data from it.=20

For group event use cases, I think only allowing non-group event to be
the master would be a good start.=20

>=20
>>>> If we do GFP_ATOMIC in perf_event_alloc(), maybe with an extra option,=
 we
>>>> don't need the tmp_master hack. So we only allocate master when we wil=
l=20
>>>> use it.=20
>>>=20
>>> You can't, that's broken on -RT. ctx->lock is a raw_spinlock_t and
>>> allocator locks are spinlock_t.
>>=20
>> How about we add another step in __perf_install_in_context(), like
>>=20
>> __perf_install_in_context()
>> {
>> 	bool alloc_master;
>>=20
>> 	perf_ctx_lock();
>> 	alloc_master =3D find_new_sharing(event, ctx);
>> 	perf_ctx_unlock();
>> =09
>> 	if (alloc_master)
>> 		event->dup_master =3D perf_event_alloc();
>> 	/* existing logic of __perf_install_in_context() */
>>=20
>> }
>>=20
>> In this way, we only allocate the master event when necessary, and it
>> is outside of the locks.=20
>=20
> It's still broken on -RT, because __perf_install_in_context() is in
> hardirq context (IPI) and the allocator locks are spinlock_t.

Hmm... how about perf_install_in_context()? Something like:

diff --git i/kernel/events/core.c w/kernel/events/core.c
index e8bec0823763..f55a7a8b9de4 100644
--- i/kernel/events/core.c
+++ w/kernel/events/core.c
@@ -2860,6 +2860,13 @@ perf_install_in_context(struct perf_event_context *c=
tx,
         */
        smp_store_release(&event->ctx, ctx);

+       raw_spin_lock_irq(&ctx->lock);
+       alloc_master =3D find_new_sharing(event, ctx);
+       raw_spin_unlock_irq(&ctx->lock);
+
+       if (alloc_master)
+               event->dup_master =3D perf_event_alloc(xxx);
+

If this works, we won't need PERF_EVENT_STATE_ACTIVE_NOT_COUNTING.=20

Thanks,
Song


