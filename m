Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C20BC00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5556E2073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oIzOhx+Q";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bA6wwvY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfLLQAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:00:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36094 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729247AbfLLQAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:00:52 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCFvrc5004730;
        Thu, 12 Dec 2019 08:00:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5Vrfh2CvmlPTOVIkEAIEG0RY8oW2jsaf6Xxlcg75bjY=;
 b=oIzOhx+Qi2VtdYled1IwIZ24KGByegGjyLdO28ETDG8xyJCWD0ni0PVCtRy4jPQ86GTa
 HaQcuoOBE7AeIBILV5+y3ai2y3VzCLzrNlGK4+WJZlvAz5km7pigARHSZSSinMFasfPl
 FOBrPrEdawHTaFNT7MjJV7K7rBRhKL3utzQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wu87qkvas-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Dec 2019 08:00:41 -0800
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Dec 2019 08:00:39 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Dec 2019 08:00:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrHQiHxNCjEMui4qQr/wbjLVAXVQ99lz1rWINjHo0J7Y9xYf0g/vTPaQJ+vYwkaVFmSiu4jesZusKdN9IjixGBwcKX4nadJySkTM9ca81AVpdox3Xrl5jF6GO+VAVwWr86ubVi20rLQOW2I5q6DjFpKguHbTY5pLteD5YbuO/mfMJ6WFvd9DHmqcqnK2rRBTO6d6fenwpOxbIhG/DPCuMywjxiUCEvyCoCZO+ymlTRnBHqFL8qTA3Ko6olzo748ZNxBc8vRSe8YK6K8FerOQLQafjovtg05J5X4/7tXjbpcNb+i9tttKtFRtM9EOU4qBZempAMAjMe71peCvFyBb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Vrfh2CvmlPTOVIkEAIEG0RY8oW2jsaf6Xxlcg75bjY=;
 b=npgjxjFOe3D88S7gqhCO11Ta/iMUxlbPhIupLw0V+9vJKDqaY7/S3R0R6QlMDZ1rgt92owv05/J8KTD6lHX8LiFlF6kfVOVfbI65nq8n80kGC5DTQAppCiciiWIQ+XkKTO3evz0gxpldXFktKW0AwgaeQHFOEV6yWtHbqMC3AR77MfmN3qKTcfjP7zaGa3KfWfUj0//R6PH8U9W1JrcqZfm4RBuub8tIE8kXDm6FOdBDFgj9ErPJiOQk4zXMxg6w8jtsR/MX+ToNA1Fj/i0LV4hfPheSlxA2a6zB2Hi1wwNbpJEqS9vAm9YmUKPEaaupMc/qijTcc1qg5v0JmThdcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Vrfh2CvmlPTOVIkEAIEG0RY8oW2jsaf6Xxlcg75bjY=;
 b=bA6wwvY7dmhEjeZbkOn7MLq9CxZ84IxsJL+scS65iZj42OASn/GOddY3d3Ps5FlMrI0b4Ix9ZwBgiFkaX7FIgExq4aFgbMoMGe227bM7ERlqIOafH9h0vilbtvVwNOjPNa5R7dGnL8x0hwbD51gyknS/0j4ygxi8zzpHsNDVVVM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1757.namprd15.prod.outlook.com (10.174.96.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Thu, 12 Dec 2019 16:00:25 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 16:00:25 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v8] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v8] perf: Sharing PMU counters across compatible events
Thread-Index: AQHVrJTJGmqRAKGiXEWGIEJPQu1yRae2q5qAgAABrgCAAAQVAA==
Date:   Thu, 12 Dec 2019 16:00:24 +0000
Message-ID: <E8B60E4B-AC39-4D53-9B37-08A7D4903CE2@fb.com>
References: <20191207002447.2976319-1-songliubraving@fb.com>
 <20191212153947.GY2844@hirez.programming.kicks-ass.net>
 <990C21F3-A93B-414A-9DB7-C17AADF037C7@fb.com>
In-Reply-To: <990C21F3-A93B-414A-9DB7-C17AADF037C7@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::d1f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25cbcb49-4e52-4bc9-847d-08d77f1c6666
x-ms-traffictypediagnostic: MWHPR15MB1757:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB175709A37C1CB0836C320755B3550@MWHPR15MB1757.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(396003)(39860400002)(346002)(189003)(199004)(86362001)(4326008)(6512007)(2616005)(6486002)(8936002)(33656002)(8676002)(81166006)(81156014)(186003)(71200400001)(6506007)(2906002)(53546011)(66946007)(66446008)(76116006)(66556008)(66476007)(64756008)(54906003)(6916009)(316002)(5660300002)(478600001)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1757;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fM6jE5/a9nNX/Ec3+/61leI34xgY0dsffsmhWLephvl7hC7YIHmooFmWcU063CLI85C+G2tfTRW85is1vw7F4Fw6zDdiApNcSnpT8N/xSK1Rcsfk+H1fRgmmbG7Azh+9giw5DAnH0POpKgeY1LZBaT0GpUH4EFRgu/UQfPR4YDJVRh+OimPwzyNK/8qLZQggu6n0YGDxnhZ7n00N8NiFc4yzm0sRgKrK9qudnOgVVoxQdLITMjzHRiI2axxfD8onkhUJXL0RqrgY7Rm20rEOcP1bPnffMI9UMovhwVErPXycgq5UAtdxiagoOC7gBUqMOG55unsWZDovy5xXroG9X2spuvcJChF7x1j+T5Oupv3BuEsVLs+ulsGkc0LaeZNzkJLm4I/WlkUmp4T0uzhbBmfCecm/FG6MPMHo84DbDKaEYinTA0jIlMHSHIwjLo3X
Content-Type: text/plain; charset="us-ascii"
Content-ID: <39DA35B3B0D56F439F16138B8EA36CAE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cbcb49-4e52-4bc9-847d-08d77f1c6666
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 16:00:24.8581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HHPy4uhDbR+cZsifWsMNFX02MyzplYgdaBjq9M1fHHLWWPAnOpy0fAIFcQYaAfR7eVlx737nJwPwTTY/IBo4yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1757
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_03:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 spamscore=0 mlxscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=914 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912120124
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 12, 2019, at 7:45 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Dec 12, 2019, at 7:39 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>>=20
>> On Fri, Dec 06, 2019 at 04:24:47PM -0800, Song Liu wrote:
>>=20
>>> @@ -2174,6 +2410,14 @@ __perf_remove_from_context(struct perf_event *ev=
ent,
>>> 		update_cgrp_time_from_cpuctx(cpuctx);
>>> 	}
>>>=20
>>> +	if (event->dup_master =3D=3D event) {
>>> +		if (ctx->is_active)
>>> +			ctx_resched(cpuctx, cpuctx->task_ctx,
>>> +				    get_event_type(event), NULL, event);
>>> +		else
>>> +			perf_event_remove_dup(event, ctx);
>>> +	}
>>> +
>>> 	event_sched_out(event, cpuctx, ctx);
>>> 	if (flags & DETACH_GROUP)
>>> 		perf_group_detach(event);
>>> @@ -2241,6 +2485,14 @@ static void __perf_event_disable(struct perf_eve=
nt *event,
>>> 		update_cgrp_time_from_event(event);
>>> 	}
>>>=20
>>> +	if (event->dup_master =3D=3D event) {
>>> +		if (ctx->is_active)
>>> +			ctx_resched(cpuctx, cpuctx->task_ctx,
>>> +				    get_event_type(event), NULL, event);
>>> +		else
>>> +			perf_event_remove_dup(event, ctx);
>>> +	}
>>> +
>>> 	if (event =3D=3D event->group_leader)
>>> 		group_sched_out(event, cpuctx, ctx);
>>> 	else
>>=20
>>> @@ -2544,7 +2793,9 @@ static void perf_event_sched_in(struct perf_cpu_c=
ontext *cpuctx,
>>> */
>>> static void ctx_resched(struct perf_cpu_context *cpuctx,
>>> 			struct perf_event_context *task_ctx,
>>> -			enum event_type_t event_type)
>>> +			enum event_type_t event_type,
>>> +			struct perf_event *event_add_dup,
>>> +			struct perf_event *event_del_dup)
>>> {
>>> 	enum event_type_t ctx_event_type;
>>> 	bool cpu_event =3D !!(event_type & EVENT_CPU);
>>> @@ -2574,6 +2825,18 @@ static void ctx_resched(struct perf_cpu_context =
*cpuctx,
>>> 	else if (ctx_event_type & EVENT_PINNED)
>>> 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>>>=20
>>> +	if (event_add_dup) {
>>> +		if (event_add_dup->ctx->is_active)
>>> +			ctx_sched_out(event_add_dup->ctx, cpuctx, EVENT_ALL);
>>> +		perf_event_setup_dup(event_add_dup, event_add_dup->ctx);
>>> +	}
>>> +
>>> +	if (event_del_dup) {
>>> +		if (event_del_dup->ctx->is_active)
>>> +			ctx_sched_out(event_del_dup->ctx, cpuctx, EVENT_ALL);
>>> +		perf_event_remove_dup(event_del_dup, event_del_dup->ctx);
>>> +	}
>>> +
>>> 	perf_event_sched_in(cpuctx, task_ctx, current);
>>> 	perf_pmu_enable(cpuctx->ctx.pmu);
>>> }
>>=20
>> Yuck!
>>=20
>> Why do you do a full reschedule when you take out a master?
>=20
> If there is active slave using this master, we need to schedule out
> them before removing the master.=20
>=20
> We can improve the check though. We only need to do it if the master
> is in state PERF_EVENT_STATE_ENABLED.=20
>=20
> Or we can add a different function to only schedule out slaves.=20

It is tricky to only schedule out slaves, because the slave could be in
a group. If we don't reschedule all events, we need to make sure that
"swapping master" always succeed.=20

Song=
