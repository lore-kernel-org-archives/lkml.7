Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D485CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1BB208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jBIbKENQ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="SUQZ9jQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfJaQ3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:29:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23208 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbfJaQ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:29:52 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9VGTSpd014258;
        Thu, 31 Oct 2019 09:29:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+cQRCfbxHk/RoMd+R5aRUSRcmyW/3H3eixgKBZwPKWU=;
 b=jBIbKENQxUgiK7Ljo0WAZSmtp1Eb7mUw+PcXMaLAJYhxVnzRLJOgReNgr6sko9b1m9XE
 TKkJC8AmQFLQl9fDOYECRQJMP/0GbZ3dTgzYHDYQ2id31O1GZwTkhqJwc8mHCtVuSQFj
 evFmM9ztkiyBDZrYId2p/FCZb6kAq+17OU4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2w00t50uen-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 31 Oct 2019 09:29:40 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 31 Oct 2019 09:29:19 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 31 Oct 2019 09:29:18 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 31 Oct 2019 09:29:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drHiuBWC8YZIl2A76fyhYbj4t2+yYAdH94L8KtTAIY6lGsttqYaLXzrC6Gazi1siP/RcfM3+Bfe5Us2pTR0wk6fOmmpWTryYpleAThw2aoCtuhZ5xoBQrWbHSeVkZFQjBx7tnDwv6qszbMHr96mCnT6727640vDD6zAi99zK9T4Fwc7SYFkMnIYOKQMJCRCMkEO2Ktgxewc6A/QqGoWtbJMdCwswoE0L//tjXDX75cEmx4ZCDISHjcMXp+g7SgZRPiIBcXSFt92whpktEOQCyT1L20rDoIW3k09DibkoZmdQJ66LZMVDnw9T2IlAngpCHzr+622vl/plmVrYOcJwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cQRCfbxHk/RoMd+R5aRUSRcmyW/3H3eixgKBZwPKWU=;
 b=YJbqYdfYe8DxBQe0hIe3QxzPEyGp0GHJr66fblaCHF4zZMYgPHGUUZ8H25hrxg6COe1hkenLSaQTgFYJz1cNqqYJH6dNzIz036C1VTF2Fo5kXepbZa1HV84+nKRG6JSLDYTswjKwqaFSvYuyzLUFyfgI4ZYS4FPlgb8xo5XzNUOQPsTu+73ezFrJyCa6fzalQF0Q7Ft9AEXX5OMOrqzUVU/9gQUGdVrzqpMetb2T09GanBi3a+6PNuvk/gMnUlGJe+1u462JXM3eiG2nHo9d7vG7DR6O9fvwy3RrTfhHNOTYYTUljO6BP3II2O8Nu/qOHDE2fdGq7hX0KL3OimsOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cQRCfbxHk/RoMd+R5aRUSRcmyW/3H3eixgKBZwPKWU=;
 b=SUQZ9jQak++2BXruKkD4be0syL3a+qU8NUKvUgiJ3q1tIObd95N7TJodu4NUipB+WHuGkWlGI9WtMQlG59RXopiKv/Vc/GANfJwv2sX8Rm+QpyGnruleQgSI2tivrgSbRBh/zd5G6bWKoIPM5o30xzt/FukOdqcZoCeylg6T6BA=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1743.namprd15.prod.outlook.com (10.174.98.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 31 Oct 2019 16:29:17 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2387.027; Thu, 31 Oct 2019
 16:29:16 +0000
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
Thread-Index: AQHVbqpjjWjaDbp/ikSYoLFTNk8qM6d09EYAgAA/EQA=
Date:   Thu, 31 Oct 2019 16:29:16 +0000
Message-ID: <19AE6C78-C54C-4C37-BBD2-0396BB97A474@fb.com>
References: <20190919052314.2925604-1-songliubraving@fb.com>
 <20191031124332.GQ4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191031124332.GQ4131@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:200::992f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 979e26e5-3fd5-4cc6-1ee0-08d75e1f795d
x-ms-traffictypediagnostic: MWHPR15MB1743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB17434316FBAE24338EC11538B3630@MWHPR15MB1743.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(51914003)(199004)(189003)(6486002)(6916009)(14444005)(256004)(76176011)(316002)(6506007)(50226002)(53546011)(6116002)(76116006)(5024004)(102836004)(8936002)(229853002)(81156014)(81166006)(6436002)(5660300002)(14454004)(186003)(8676002)(478600001)(7736002)(2616005)(446003)(305945005)(25786009)(6512007)(99286004)(6246003)(46003)(54906003)(66476007)(476003)(66556008)(66446008)(64756008)(66946007)(486006)(36756003)(4326008)(86362001)(2906002)(71190400001)(71200400001)(33656002)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1743;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NCvCMl8ah0jU65z2UXsEt6keAJo2x0c51znxkDRtoCmxYxE1E7vXlBlfFaMxt/ZLEA6qn7Evi3Fb8ZqcbttnKX+K3J2IAUcZlKlgx9cnoJ3zFoq02NgKNDrjneju/cR9YpV6KT3ocGgv1JZhUQn2tijQrz05vN0qJiTmUeihngE0jJNwfPwaXNoPeoI02gHo0GT2koVho1tlyZmjlkiEwkOWEBvb2vtNnX47qx9S0C787hJxVdQJIcZSMkmM/DvKwFr9T3Etk6zfRs90MSzmAYMJimaO7YPBUS7yHqrek5krAieAzRU3oQt09DdP4qMMp3IWJ2ku3ji8xDzt9PX2iPXk8r3Nr5fhmRW642bKArSxK3FJAdyTScD16gjjH73w/y3BiUVica/3HnO8zE8y/+6RXPpGtMHsgcEnT3Tvb3isbtwG/vuBxiANJWLHqbhn
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79623FAE5888F949A8AEB7981C7D960A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 979e26e5-3fd5-4cc6-1ee0-08d75e1f795d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 16:29:16.6188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obJI6Fz8JXLJzus93XTFuxXr8arSgyoHn2srTVv2n9NHaUrxRdj7RHcN1ReEOkHJwl8zKUuAEyHJPa1gIH844A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1743
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-31_06:2019-10-30,2019-10-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910310165
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 31, 2019, at 5:43 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Wed, Sep 18, 2019 at 10:23:14PM -0700, Song Liu wrote:
>> This patch tries to enable PMU sharing. To make perf event scheduling
>> fast, we use special data structures.
>>=20
>> An array of "struct perf_event_dup" is added to the perf_event_context,
>> to remember all the duplicated events under this ctx. All the events
>> under this ctx has a "dup_id" pointing to its perf_event_dup. Compatible
>> events under the same ctx share the same perf_event_dup. The following
>> figure shows a simplified version of the data structure.
>>=20
>>      ctx ->  perf_event_dup -> master
>>                     ^
>>                     |
>>         perf_event /|
>>                     |
>>         perf_event /
>>=20
>> Connection among perf_event and perf_event_dup are built when events are
>> added or removed from the ctx. So these are not on the critical path of
>> schedule or perf_rotate_context().
>>=20
>> On the critical paths (add, del read), sharing PMU counters doesn't
>> increase the complexity. Helper functions event_pmu_[add|del|read]() are
>> introduced to cover these cases. All these functions have O(1) time
>> complexity.
>>=20
>> We allocate a separate perf_event for perf_event_dup->master. This needs
>> extra attention, because perf_event_alloc() may sleep. To allocate the
>> master event properly, a new pointer, tmp_master, is added to perf_event=
.
>> tmp_master carries a separate perf_event into list_[add|del]_event().
>> The master event has valid ->ctx and holds ctx->refcount.
>=20
> That is realy nasty and expensive, it basically means every !sampling
> event carries a double allocate.
>=20
> Why can't we use one of the actual events as master?

I think we can use one of the event as master. We need to be careful when
the master event is removed, but it should be doable. Let me try.=20

>=20
>> +/*
>> + * Sharing PMU across compatible events
>> + *
>> + * If two perf_events in the same perf_event_context are counting same
>> + * hardware events (instructions, cycles, etc.), they could share the
>> + * hardware PMU counter.
>> + *
>> + * When a perf_event is added to the ctx (list_add_event), it is compar=
ed
>> + * against other events in the ctx. If they can share the PMU counter,
>> + * a perf_event_dup is allocated to represent the sharing.
>> + *
>> + * Each perf_event_dup has a virtual master event, which is called by
>> + * pmu->add() and pmu->del(). We cannot call perf_event_alloc() in
>> + * list_add_event(), so it is allocated and carried by event->tmp_maste=
r
>> + * into list_add_event().
>> + *
>> + * Virtual master in different cases/paths:
>> + *
>> + * < I > perf_event_open() -> close() path:
>> + *
>> + * 1. Allocated by perf_event_alloc() in sys_perf_event_open();
>> + * 2. event->tmp_master->ctx assigned in perf_install_in_context();
>> + * 3.a. if used by ctx->dup_events, freed in perf_event_release_kernel(=
);
>> + * 3.b. if not used by ctx->dup_events, freed in perf_event_open().
>> + *
>> + * < II > inherit_event() path:
>> + *
>> + * 1. Allocated by perf_event_alloc() in inherit_event();
>> + * 2. tmp_master->ctx assigned in inherit_event();
>> + * 3.a. if used by ctx->dup_events, freed in perf_event_release_kernel(=
);
>> + * 3.b. if not used by ctx->dup_events, freed in inherit_event().
>> + *
>> + * < III > perf_pmu_migrate_context() path:
>> + * all dup_events removed during migration (no sharing after the move).
>> + *
>> + * < IV > perf_event_create_kernel_counter() path:
>> + * not supported yet.
>> + */
>> +struct perf_event_dup {
>> +	/*
>> +	 * master event being called by pmu->add() and pmu->del().
>> +	 * This event is allocated with perf_event_alloc(). When
>> +	 * attached to a ctx, this event should hold ctx->refcount.
>> +	 */
>> +	struct perf_event       *master;
>> +	/* number of events in the ctx that shares the master */
>> +	int			total_event_count;
>> +	/* number of active events of the master */
>> +	int			active_event_count;
>> +};
>> +
>> +#define MAX_PERF_EVENT_DUP_PER_CTX 4
>> /**
>>  * struct perf_event_context - event context structure
>>  *
>> @@ -791,6 +849,9 @@ struct perf_event_context {
>> #endif
>> 	void				*task_ctx_data; /* pmu specific data */
>> 	struct rcu_head			rcu_head;
>> +
>> +	/* for PMU sharing. array is needed for O(1) access */
>> +	struct perf_event_dup		dup_events[MAX_PERF_EVENT_DUP_PER_CTX];
>=20
> Yuck!
>=20
> event_pmu_{add,del,read}() appear to be the consumer of this array
> thing, but I'm not seeing why we need it.
>=20
> That is, again, why can't we use one of the actual events as master and
> have a dup_master pointer per event and then do something like:
>=20
> event_pmu_add()
> {
> 	if (event->dup_master !=3D event)
> 		return;
>=20
> 	event->pmu->add(event, PERF_EF_START);
> }
>=20
> Such that we only schedule the master events and ignore all duplicates.
>=20
> Then on read it can do something like:
>=20
> event_pmu_read()
> {
> 	if (event->dup_master =3D=3D event)
> 		return;
>=20
> 	/* use event->dup_master as counter */
> again:
> 	prev_count =3D local64_read(&hwc->prev_count);
> 	count =3D local64_read(&event->dup_master->count);
> 	if (local64_cmpxchg(&hwc->prev_count, prev_count, count) !=3D prev_count=
)
> 		goto again;
>=20
> 	delta =3D count - prev_count;
> 	local64_add(delta, &event->count);
> }
>=20
>> };
>=20
>> +/* Returns whether a perf_event can share PMU counter with other events=
 */
>> +static inline bool perf_event_can_share(struct perf_event *event)
>> +{
>> +	/* only do sharing for hardware events */
>> +	if (is_software_event(event))
>> +		return false;
>> +
>> +	/*
>> +	 * limit sharing to counting events.
>> +	 * perf-stat sets PERF_SAMPLE_IDENTIFIER for counting events, so
>> +	 * let that in.
>> +	 */
>> +	if (event->attr.sample_type & ~PERF_SAMPLE_IDENTIFIER)
>> +		return false;
>=20
> Why is is_sampling_event() not usable?

Hmm... let me try it. Thanks for the pointer.=20

>=20
>> +
>> +	return true;
>> +}
>> +
>> +/*
>> + * Returns whether the two events can share a PMU counter.
>> + *
>> + * Note: This function does NOT check perf_event_can_share() for
>> + * the two events, they should be checked before this function
>> + */
>> +static inline bool perf_event_compatible(struct perf_event *event_a,
>> +					 struct perf_event *event_b)
>> +{
>> +	return event_a->attr.type =3D=3D event_b->attr.type &&
>> +		event_a->attr.config =3D=3D event_b->attr.config &&
>> +		event_a->attr.config1 =3D=3D event_b->attr.config1 &&
>> +		event_a->attr.config2 =3D=3D event_b->attr.config2;
>> +}
>=20
> Slightly scared by this one.

I feel a little nervous too. Maybe we should memcmp the two attr?

>=20
>=20
>> @@ -2612,20 +2828,9 @@ static int  __perf_install_in_context(void *info)
>> 		raw_spin_lock(&task_ctx->lock);
>> 	}
>>=20
>> -#ifdef CONFIG_CGROUP_PERF
>> -	if (is_cgroup_event(event)) {
>> -		/*
>> -		 * If the current cgroup doesn't match the event's
>> -		 * cgroup, we should not try to schedule it.
>> -		 */
>> -		struct perf_cgroup *cgrp =3D perf_cgroup_from_task(current, ctx);
>> -		reprogram =3D cgroup_is_descendant(cgrp->css.cgroup,
>> -					event->cgrp->css.cgroup);
>> -	}
>> -#endif
>=20
> Why is this removed?

e... I bet I messed this up during a rebase... Sorry..

>=20
>> @@ -10986,6 +11198,14 @@ SYSCALL_DEFINE5(perf_event_open,
>> 		goto err_cred;
>> 	}
>>=20
>> +	if (perf_event_can_share(event)) {
>> +		event->tmp_master =3D perf_event_alloc(&event->attr, cpu,
>> +						     task, NULL, NULL,
>> +						     NULL, NULL, -1);
>> +		if (IS_ERR(event->tmp_master))
>> +			event->tmp_master =3D NULL;
>> +	}
>=20
>=20
>> @@ -11773,6 +12005,14 @@ inherit_event(struct perf_event *parent_event,
>> 	if (IS_ERR(child_event))
>> 		return child_event;
>>=20
>> +	if (perf_event_can_share(child_event)) {
>> +		child_event->tmp_master =3D perf_event_alloc(&parent_event->attr,
>> +							   parent_event->cpu,
>> +							   child, NULL, NULL,
>> +							   NULL, NULL, -1);
>> +		if (IS_ERR(child_event->tmp_master))
>> +			child_event->tmp_master =3D NULL;
>> +	}
>=20
> So this is terrible!

Let me try get rid of the double alloc.=20

Thanks for these feedback!
Song

