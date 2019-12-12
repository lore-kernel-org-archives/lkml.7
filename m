Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135E8C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCF7214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="M3eY/b2Z";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EqMLEGLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfLLPqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:46:19 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49870 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729260AbfLLPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:46:19 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCFdftJ008094;
        Thu, 12 Dec 2019 07:46:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=E6bTAcuAHZLvbl61fzHTSFWH+ZWnYSACE7/5sO4llaA=;
 b=M3eY/b2Zu59yzvWAvqj7O7WIi4UIhvy3mXSBATUmroMJ3d739m68Szxlg+ZLMO5gxJ3h
 B/jnqYnfTXgsIITcAjq8vJDJWGKNrMMG35LT5R5TBoRZeOh1n7GU+ifIDo3mwni38cZI
 dgp7j8YS/+B6/Gjw+k5z8F/bF3QULcTWIsk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wukessc5u-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 07:46:05 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 12 Dec 2019 07:45:50 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Dec 2019 07:45:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWQVx9qrqiW6dzPFfYWmLRmpL2x3+XI+PmjaEs1TX6DiT/MT3hDWMoBJaxrJj2OjxQSXc3lbIxyGgB4ptqBESf+bDy453DftWGGlWTbnbbiuxd8ngqRmWj0DosP79DhVhpZ27KyzPM29XnPdeRgmUg8rRa7mHAH5gfT4xs3HM+vxERnyPSufswZmBb0kI84phxQabOrp3QCsGzHf/rbhkdqwm4vjWtOM+JtX4tE8sdrNdQY/B7TYr3vNX/S3OycwAqUbkmGTlkkRTyG5sqdRZJbQn6BN2odmkzXd6WNXUHUmi4n6+kq7L8JIkj44iDp+HfNjKpKnpn+sGXmDtgQ51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6bTAcuAHZLvbl61fzHTSFWH+ZWnYSACE7/5sO4llaA=;
 b=bjM0hPDAqsQD0Zv+EpORby4621d/rSnB55wwzwWduj6q9bB/FYi4lVbH8Pwxtk3VwjiQHCtZmrou9OxfC828ebDhe2kijAqjty/yRfCBqhI21Bq57HNWYf7J++4QWtYcedNz/FoXge0bU/mXygw7y7CQ25+/SQ/SDZMZoiZrot0IdWfz+vYT0Hfku5Eh1DfrAdvmh+0ckmiqpGHyhCfMPMGOrxLPNgq0LRktOa8dvQeV7sb28PbbS21R8vuYzTBRgu/J/S+/+vKLXFb4nRwRuBZHBHsC8IOw1MTEahogycBWUa6k7jTCr3rtkiRYPicXvVpMY3ul/iQb0z9C01oCoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6bTAcuAHZLvbl61fzHTSFWH+ZWnYSACE7/5sO4llaA=;
 b=EqMLEGLnKUAm5RJ6yX7sXtdXFgw710R4l7axVfD832ggSeDNaLdh+YgFOo/QuWpz7RKnhy42xE+sWX+7RfVdWsw8hptOordHlCwef96CiuKrOAg9cMTX9FC+LO7JNZbTtEiblV6BLc8q6+7AhRpOQ79T0UgTRBbP/s/QA0llMqQ=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1727.namprd15.prod.outlook.com (10.174.96.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Thu, 12 Dec 2019 15:45:49 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 15:45:49 +0000
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
Thread-Index: AQHVrJTJGmqRAKGiXEWGIEJPQu1yRae2q5qAgAABrgA=
Date:   Thu, 12 Dec 2019 15:45:49 +0000
Message-ID: <990C21F3-A93B-414A-9DB7-C17AADF037C7@fb.com>
References: <20191207002447.2976319-1-songliubraving@fb.com>
 <20191212153947.GY2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191212153947.GY2844@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::d1f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab19f103-34bc-4a36-7989-08d77f1a5c94
x-ms-traffictypediagnostic: MWHPR15MB1727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB172729C2CF7E19193B1214F5B3550@MWHPR15MB1727.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(33656002)(2906002)(86362001)(36756003)(54906003)(4326008)(66946007)(66446008)(64756008)(66476007)(66556008)(6512007)(81166006)(8676002)(76116006)(5660300002)(71200400001)(6916009)(2616005)(81156014)(8936002)(6486002)(498600001)(53546011)(186003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1727;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t0D0yGXOSsgqJxqkmU814LO5zHtk/G3SWX1wutAB88p4MyeQvvLKjWicDaSr7lkiOU7llEZnqJaj6KqLM77Y9sB0Dhu9yhdlvhM/w4jlTMQ9Rvg7isfCdgR+z1gc+PsO4IBhT1XhkVsT8dE12eZ/HmYTO/GS5RpFhF2fJVqRPsBMpvQfmZ/uFAdq5TCNDJ749qd4Lj8ALeGLawO2I/jIBRRqrrYjJ3bhEGhnnCAY+MJwSURwmnqQoBNWP1hc/KiqFeZNEd9yH+wlFglhtvjI7zCdmOa91HBAYDEvMMb5uFFpWB87lbaaYAA2QBeGxXXWxVhGWjNyz/xG0Tw0PRrssoetDXprxcKrD8qzGYK+LmBL2KmXc1c00psJ3F5ltDY1nPNasU76TdsZHmNuiHxC9a6K6XMaq4pT8+8n6uxaTzCx8cx60raXn4lhtx5A3tLZ
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3231A7B79C3D904EA371484A776547FA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ab19f103-34bc-4a36-7989-08d77f1a5c94
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 15:45:49.3087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFFjGiyrtq4RenHW0Ia1QC0vNuQ1egMGBExOQ3rsDdfY28VNvU9wI3ElzyDhoEQNh/JxqN25V52OwbX/+mxY6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1727
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_03:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxlogscore=786 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120122
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 12, 2019, at 7:39 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Fri, Dec 06, 2019 at 04:24:47PM -0800, Song Liu wrote:
>=20
>> @@ -2174,6 +2410,14 @@ __perf_remove_from_context(struct perf_event *eve=
nt,
>> 		update_cgrp_time_from_cpuctx(cpuctx);
>> 	}
>>=20
>> +	if (event->dup_master =3D=3D event) {
>> +		if (ctx->is_active)
>> +			ctx_resched(cpuctx, cpuctx->task_ctx,
>> +				    get_event_type(event), NULL, event);
>> +		else
>> +			perf_event_remove_dup(event, ctx);
>> +	}
>> +
>> 	event_sched_out(event, cpuctx, ctx);
>> 	if (flags & DETACH_GROUP)
>> 		perf_group_detach(event);
>> @@ -2241,6 +2485,14 @@ static void __perf_event_disable(struct perf_even=
t *event,
>> 		update_cgrp_time_from_event(event);
>> 	}
>>=20
>> +	if (event->dup_master =3D=3D event) {
>> +		if (ctx->is_active)
>> +			ctx_resched(cpuctx, cpuctx->task_ctx,
>> +				    get_event_type(event), NULL, event);
>> +		else
>> +			perf_event_remove_dup(event, ctx);
>> +	}
>> +
>> 	if (event =3D=3D event->group_leader)
>> 		group_sched_out(event, cpuctx, ctx);
>> 	else
>=20
>> @@ -2544,7 +2793,9 @@ static void perf_event_sched_in(struct perf_cpu_co=
ntext *cpuctx,
>>  */
>> static void ctx_resched(struct perf_cpu_context *cpuctx,
>> 			struct perf_event_context *task_ctx,
>> -			enum event_type_t event_type)
>> +			enum event_type_t event_type,
>> +			struct perf_event *event_add_dup,
>> +			struct perf_event *event_del_dup)
>> {
>> 	enum event_type_t ctx_event_type;
>> 	bool cpu_event =3D !!(event_type & EVENT_CPU);
>> @@ -2574,6 +2825,18 @@ static void ctx_resched(struct perf_cpu_context *=
cpuctx,
>> 	else if (ctx_event_type & EVENT_PINNED)
>> 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>>=20
>> +	if (event_add_dup) {
>> +		if (event_add_dup->ctx->is_active)
>> +			ctx_sched_out(event_add_dup->ctx, cpuctx, EVENT_ALL);
>> +		perf_event_setup_dup(event_add_dup, event_add_dup->ctx);
>> +	}
>> +
>> +	if (event_del_dup) {
>> +		if (event_del_dup->ctx->is_active)
>> +			ctx_sched_out(event_del_dup->ctx, cpuctx, EVENT_ALL);
>> +		perf_event_remove_dup(event_del_dup, event_del_dup->ctx);
>> +	}
>> +
>> 	perf_event_sched_in(cpuctx, task_ctx, current);
>> 	perf_pmu_enable(cpuctx->ctx.pmu);
>> }
>=20
> Yuck!
>=20
> Why do you do a full reschedule when you take out a master?

If there is active slave using this master, we need to schedule out
them before removing the master.=20

We can improve the check though. We only need to do it if the master
is in state PERF_EVENT_STATE_ENABLED.=20

Or we can add a different function to only schedule out slaves.=20

Thanks,
Song

