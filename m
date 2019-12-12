Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91C5C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8473B206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qFv/QQAv";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="U66yrlFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfLLSB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:01:57 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64742 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730034AbfLLSB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:01:56 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCHwGVC019126;
        Thu, 12 Dec 2019 10:01:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ZBV68L3qHWSsWhSXh/FEIID9TppBXT91JMsmwirtJDk=;
 b=qFv/QQAva6Q/ooMWErzZDnZ0wJ0Q1hcVZOiEZ/JXjm4I2t4qir027DqQ28VQ07eeQHzn
 iknbiuwMIcm4BLT5AvFgC5+Lb30dW6hWQ2BgT4R4bKYj8VE1pz/ERwZr0BO+5+hjMgP/
 5XOFyB72+k1yYi8rQv/XgXaw5HsvwotmqSc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wub46bqxp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Dec 2019 10:01:45 -0800
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Dec 2019 10:01:44 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Dec 2019 10:01:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiLNBQ6A2BTRNtESTllHFU6olh2ubJQHmfJZlOvO1LyMDRs6uza1Yqznucsx7iMlDin4fGUzxkndRzI9LfqlrsFf9HOqBmxg3x0GgCLfm3yGf+d91n+SteEyPehYzUGEp/Q/VJK5ggq/eJWe/82LRtvlPe+gsvTwUJceOACUdRkLjPzh5WfX4m8km16lXOQWU3MOvIQn9EOC4AwKG3gFPZ5z/qjHSOUqueSWdP3HugS1bEiCxW07M3l1MF2++b/PG930Tq0Kv1WulpDqhq2LjsYpA83iu679RhqtMKwSPLeOKCohvrDohQO+kPPLowUneejyA5epwkyBMmUoW7txvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBV68L3qHWSsWhSXh/FEIID9TppBXT91JMsmwirtJDk=;
 b=N/eevSVfa7A6TDnfhOYQ1Gzn/OxbR335RCnmhFUX/OSs7s757na3kqCfDVKGBy5REMgeJ82IWMQ8rVYLxtAPYJ3K0BqWu9jMlTbI/HNThW1uLtEU+IvlKTT4bMY4ve2v6y3rF4dRWrjP5WaJCho6LPTMJiydAHyY+VgOVx47yYx5OfnQOAvapE077CpjcH1M3g77ouoH30G7sTK8DuyKmnSt/UnNFcZdMpvoz6fi+YioUaPEVDH5Gls3tnCQqSXay4ZlMFlmOgvzTnaZGLPnzErrUhGYXkWAY2nRt346uedOSLzqpZXjnoUcdWmXzX63Nbt5BeflC23Ch/z15dfGbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBV68L3qHWSsWhSXh/FEIID9TppBXT91JMsmwirtJDk=;
 b=U66yrlFaNi+1M0kLiuptQI9/V/BB3zKy+EdBxSRG9GyEfOrVh9xhTkN39ueHsatMxngY4ow7BxyikAqpLip+O8tTEw6JbhB9hb7Ywx7I7YHJW2FrHZhDNEYGOuRKL8oCq5kCtVrfSqf7Jd/zBCG8VKcsaPm8hHXaXIjrEF2zo3c=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1840.namprd15.prod.outlook.com (10.174.99.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Thu, 12 Dec 2019 18:01:42 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 18:01:42 +0000
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
Thread-Index: AQHVrJTJGmqRAKGiXEWGIEJPQu1yRae2q5qAgAABrgCAAAQVAIAAIeKA
Date:   Thu, 12 Dec 2019 18:01:41 +0000
Message-ID: <B2B991F1-2D03-480D-A7F7-130519BA0F81@fb.com>
References: <20191207002447.2976319-1-songliubraving@fb.com>
 <20191212153947.GY2844@hirez.programming.kicks-ass.net>
 <990C21F3-A93B-414A-9DB7-C17AADF037C7@fb.com>
 <E8B60E4B-AC39-4D53-9B37-08A7D4903CE2@fb.com>
In-Reply-To: <E8B60E4B-AC39-4D53-9B37-08A7D4903CE2@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:200::1:6bd7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23937327-66b8-4efb-b32b-08d77f2d57df
x-ms-traffictypediagnostic: MWHPR15MB1840:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1840F8208F9C818A0304A7ABB3550@MWHPR15MB1840.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(376002)(39860400002)(346002)(189003)(199004)(33656002)(316002)(4326008)(86362001)(54906003)(36756003)(2906002)(66446008)(66556008)(64756008)(66946007)(66476007)(6512007)(81166006)(76116006)(8676002)(5660300002)(186003)(6916009)(71200400001)(2616005)(81156014)(6486002)(8936002)(53546011)(6506007)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1840;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: On63SgvDC9uUMK2uRyYi+MFO3RaAK7c75LDG0P8xk7O+B+V0rPF6MEsM/ltEuw77fzq/5A6s7yScU/YZDVGkMcryo6bG5ZyRW4Xz5TMLZ9uSzV75ZJ5OReGETb4iieG1JQljU3eqgrufSKqZcZgeBAz1E08j57nmwohH95x2Mq2psUO0gCGSm6C0nk0zGz6Gen+eUw41Su2tV1xeKNOLS2LDZ+s7+d6CbVx9DHKS4it/0Amk33m8iZ7cJU/wNsHLfq7j5B2kxkGm/6uOKzgvccP/ujxTeWkt1T4nnQqn9Elb0NrlJQwpRRtnde9CoJsDzd/ELIcnhpb0awdxX92JPI27y1rUu0hHnl7dnIsRdmf4mpik1f7dYm8NfW0zOza6g/dZjks93hV8dbCLEweJS9Ll4fSPykzO8C39BfVf4FablkEubKFEKfNhHJ+wI2IV
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B01DB8EBB5E90D4B97D64C5DAC4A7FD7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 23937327-66b8-4efb-b32b-08d77f2d57df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 18:01:41.8449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjwEcEhS6Qo6IqPo9Bh72Hr8QUJ34Nz9FHtK6hE2cZdGZXzB0xK7QbQVkO4diUbmDNAEVyveOMrTD3cmDOsjRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1840
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_05:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxlogscore=969
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120140
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> On Dec 12, 2019, at 8:00 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Dec 12, 2019, at 7:45 AM, Song Liu <songliubraving@fb.com> wrote:
>>=20
>>=20
>>=20
>>> On Dec 12, 2019, at 7:39 AM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
>>>=20
>>> On Fri, Dec 06, 2019 at 04:24:47PM -0800, Song Liu wrote:
>>>=20
>>>> @@ -2174,6 +2410,14 @@ __perf_remove_from_context(struct perf_event *e=
vent,
>>>> 		update_cgrp_time_from_cpuctx(cpuctx);
>>>> 	}
>>>>=20
>>>> +	if (event->dup_master =3D=3D event) {
>>>> +		if (ctx->is_active)
>>>> +			ctx_resched(cpuctx, cpuctx->task_ctx,
>>>> +				    get_event_type(event), NULL, event);
>>>> +		else
>>>> +			perf_event_remove_dup(event, ctx);
>>>> +	}
>>>> +
>>>> 	event_sched_out(event, cpuctx, ctx);
>>>> 	if (flags & DETACH_GROUP)
>>>> 		perf_group_detach(event);
>>>> @@ -2241,6 +2485,14 @@ static void __perf_event_disable(struct perf_ev=
ent *event,
>>>> 		update_cgrp_time_from_event(event);
>>>> 	}
>>>>=20
>>>> +	if (event->dup_master =3D=3D event) {
>>>> +		if (ctx->is_active)
>>>> +			ctx_resched(cpuctx, cpuctx->task_ctx,
>>>> +				    get_event_type(event), NULL, event);
>>>> +		else
>>>> +			perf_event_remove_dup(event, ctx);
>>>> +	}
>>>> +
>>>> 	if (event =3D=3D event->group_leader)
>>>> 		group_sched_out(event, cpuctx, ctx);
>>>> 	else
>>>=20
>>>> @@ -2544,7 +2793,9 @@ static void perf_event_sched_in(struct perf_cpu_=
context *cpuctx,
>>>> */
>>>> static void ctx_resched(struct perf_cpu_context *cpuctx,
>>>> 			struct perf_event_context *task_ctx,
>>>> -			enum event_type_t event_type)
>>>> +			enum event_type_t event_type,
>>>> +			struct perf_event *event_add_dup,
>>>> +			struct perf_event *event_del_dup)
>>>> {
>>>> 	enum event_type_t ctx_event_type;
>>>> 	bool cpu_event =3D !!(event_type & EVENT_CPU);
>>>> @@ -2574,6 +2825,18 @@ static void ctx_resched(struct perf_cpu_context=
 *cpuctx,
>>>> 	else if (ctx_event_type & EVENT_PINNED)
>>>> 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>>>>=20
>>>> +	if (event_add_dup) {
>>>> +		if (event_add_dup->ctx->is_active)
>>>> +			ctx_sched_out(event_add_dup->ctx, cpuctx, EVENT_ALL);
>>>> +		perf_event_setup_dup(event_add_dup, event_add_dup->ctx);
>>>> +	}
>>>> +
>>>> +	if (event_del_dup) {
>>>> +		if (event_del_dup->ctx->is_active)
>>>> +			ctx_sched_out(event_del_dup->ctx, cpuctx, EVENT_ALL);
>>>> +		perf_event_remove_dup(event_del_dup, event_del_dup->ctx);
>>>> +	}
>>>> +
>>>> 	perf_event_sched_in(cpuctx, task_ctx, current);
>>>> 	perf_pmu_enable(cpuctx->ctx.pmu);
>>>> }
>>>=20
>>> Yuck!
>>>=20
>>> Why do you do a full reschedule when you take out a master?
>>=20
>> If there is active slave using this master, we need to schedule out
>> them before removing the master.=20
>>=20
>> We can improve the check though. We only need to do it if the master
>> is in state PERF_EVENT_STATE_ENABLED.=20
>>=20
>> Or we can add a different function to only schedule out slaves.=20
>=20
> It is tricky to only schedule out slaves, because the slave could be in
> a group. If we don't reschedule all events, we need to make sure that
> "swapping master" always succeed.=20

What would you suggest for this one? Maybe we can keep this as-is and=20
optimize later?=20

Thanks,
Song

