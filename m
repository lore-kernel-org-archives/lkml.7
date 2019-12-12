Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA98C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6251121655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 23:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NqiDZ8Dg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WczDqmoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbfLLXuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 18:50:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13374 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731401AbfLLXuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 18:50:17 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCNmuIT019821;
        Thu, 12 Dec 2019 15:49:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=C/XaW/0x3XEaWVFh/csSRBmUGrmlm+Xt8rrMPUpeVL8=;
 b=NqiDZ8Dg3ZpNeRDebEGg1czzcIDPtKrdahEV1UCRY0rxiwVw8LI4ZV/pextJ0ru4a5wZ
 7GUIkFHgb8itvy0Xo34JaeVGe8zTtEBHR3g5vgVNqX64J/5MSi+pNgF13Fggd9zXFTan
 Vx4320yGLsaDI92InEebzKCg++odZqf0ues= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wu4ehqb88-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Dec 2019 15:49:07 -0800
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Dec 2019 15:49:06 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Dec 2019 15:49:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAQ0rY9LjU6v1xVyCmOL9kz29t2XXHTVxWrw0YUhnSnxJBUDb0jgrSvwwoK1vTFYu4FpbgGHwvJ0p5j6rOs2kcbGjPknIXy9VW/42iiHQ+tErudiuWh98HlSM1RLh3/3mKMwkt6UUnAsamjOVHfCWq4j+DX3JKXpgKa+5NF2mFQb0VKH8WVl7nQIY7JKv5FD2zZ+Zwk+Q/b9Xf5Ir1EPNNa8TDG+Xggu2gW/GPl9Ax+3f3sUgDYJMzvwRmoTfNiekDpwUGvYAcgYIYPYWADEfkFANQDPiphzs4Fb0OLlJ6axA5fV/U0D7FTcvEvJYHpRMfwxhCVq9NAB6YI9A9CLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/XaW/0x3XEaWVFh/csSRBmUGrmlm+Xt8rrMPUpeVL8=;
 b=dWwcmt341qGGZ87diJ5ST2JV3z9xdyYtvoTrYTWgng9uWBNA+nWANQE9dYs/gX1wB1VNbSR5c8QOAYin23X6eg2lylIJxr6vNk4zzR8yLoMJxPblqckotg0VgwCI627jX9vOk5/00f9rtOFLPBgTHdYKYipKSjHvrXgbATes2fhFr3jiOOfyCPc9wNJzcrKYUsI7K47/614Q1WUYvmVczsIYIi7xvFRjL4385K7KEqT9viML3kXAh2Az7gpANx5DqosNPcSMQLVonpnRgv+P4cHavuF8eZsNj1NJmK7+UOKv7nqCm5zhkEHSxIwXdV1agIcNh8gPdMjKdlK/ggiDBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/XaW/0x3XEaWVFh/csSRBmUGrmlm+Xt8rrMPUpeVL8=;
 b=WczDqmoUyDGvQ35sXLIsd6oXcp5tzL7ak1mjmzWB+Dw7EwXlLysO1UH0bDWnvLKv4bS0licz79EMv0z8vLnBoRrNeN+gyBvYUDTV4VWrA7ImrpFTI+qAJtUrVSWasbwM8Jiy7MktMurpF1Ar0haGpVLV5MX2fjgQa5jjRaMZsQg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1375.namprd15.prod.outlook.com (10.173.233.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 23:49:05 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 23:49:05 +0000
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
Thread-Index: AQHVrJTJGmqRAKGiXEWGIEJPQu1yRae2q5qAgAABrgCAADQeAIAAUugA
Date:   Thu, 12 Dec 2019 23:49:05 +0000
Message-ID: <65ABF2DB-69CC-429E-AC31-8E7327B4369A@fb.com>
References: <20191207002447.2976319-1-songliubraving@fb.com>
 <20191212153947.GY2844@hirez.programming.kicks-ass.net>
 <990C21F3-A93B-414A-9DB7-C17AADF037C7@fb.com>
 <20191212185220.GD2827@hirez.programming.kicks-ass.net>
In-Reply-To: <20191212185220.GD2827@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:200::1:6bd7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 708e7148-a6c2-4412-44d9-08d77f5ddfa3
x-ms-traffictypediagnostic: MWHPR15MB1375:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1375D65211EF24D00139A6BBB3550@MWHPR15MB1375.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(376002)(346002)(396003)(51914003)(199004)(189003)(71200400001)(186003)(36756003)(2616005)(5660300002)(6506007)(53546011)(2906002)(6486002)(4326008)(478600001)(86362001)(316002)(76116006)(54906003)(33656002)(8936002)(8676002)(81156014)(81166006)(6512007)(6916009)(66446008)(66476007)(64756008)(66556008)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1375;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rrnhRluSvnM7dFVtPYfsAzWJotpQxBQIdrPaeRifEgUr1TsClZNhxjxwOZCwMlnOx0PDPRJRm2nWcGwBbB6GimY7ur5LbaRq7wqJRfVl148BBsF8nWd3xpkqmOzhm1Qjcr5Yu7E8thnZ9ps+uFabGOrIh/eaxQhSMMz+u2GEcLZZpBT2xayWagW3IpIaz1MLno9fXTzGf+5TuomvUCQcozWp8bll9hZBWZAN9ha3WqlUZL2u3Vq7GJcyfscPyWFBJyjWvMh1UocHrYzPjaaZhYbeDKZ2Lf8hiWa7I9LlaoMjW31LZhERWLDQoJCix1Z5nV5TpymqLMANfhd1KVihZu1aNk1XgczUBGQ3nKWuik40yJgunI0cRmIRixqn7IgHjdjvgXiZhe7owb3B07pCY9xzWRaJ4+HI6VxzUZWAv79GW6a4tgavx2m77mxda5RyGrLUMzwB3O6oTCxwtJVe7bvqfNjNkXjNyEZIB2z97v8PmQOPMry1/I2qpnUG2eCW
Content-Type: text/plain; charset="us-ascii"
Content-ID: <107231131266B040BC9CB656DF874B0E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 708e7148-a6c2-4412-44d9-08d77f5ddfa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 23:49:05.4740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMrngPRr9QhXspWA+dY6pGmW/XDDMt8EJRtDsut/si78Qfyz2tUwvrX75KKyx8OXnvIsLrOzMUKFwUPZ7wgg4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1375
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_08:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120184
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 12, 2019, at 10:52 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
> On Thu, Dec 12, 2019 at 03:45:49PM +0000, Song Liu wrote:
>>> On Dec 12, 2019, at 7:39 AM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
>=20
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
> So I've been thinking, this is because an NMI from another event can
> come in and then does PERF_SAMPLE_READ which covers our event, right?
>=20
> AFAICT every other case will run under ctx->lock, which we own at this
> point.

Right, we hold ctx->lock here, so it should be safe in most case.=20

>=20
> So can't we:
>=20
> 1 - stop the current master (such that the counts are frozen)
> 2 - pick the new master
> 3 - initialize the new master (such that the counts match)
> 4 - set the new master on all other events
> 5 - start the new master (counters run again)
>=20
> Then, no matter where the NMI lands, it will always find either the old
> or the new master and their counts will match.
>=20
> You really don't need to stop all events.

I think this should work. Let me try it.=20

Thanks for the suggestion,
Song
