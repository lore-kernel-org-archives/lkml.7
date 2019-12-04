Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAC6C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC9821823
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nMhdW8gK";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AWYS0N4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfLDWRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:17:39 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60578 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727989AbfLDWRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 17:17:39 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xB4MCLRc024798;
        Wed, 4 Dec 2019 14:16:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=NNyP+6pfDQFgzLwnVEm/j4fd3IWeVSIcnVs+sB31cZM=;
 b=nMhdW8gKsNffdpAZMessO342mjcmX+8VhRnQdG8Ps/udL5vV3CU7urVk4KY0q2O6h6j2
 LGDvfhmYFDB/f/Z6k5YM5Dr4BcLbb/8UkSKcW0RZPwX1hr3aARpOTfx6vpyzoB/WLak9
 rdddJGZj/Gv8Vm5AXVUQJSQTP2lWJYWYy7U= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2wp7khv7sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 14:16:25 -0800
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 4 Dec 2019 14:16:23 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 4 Dec 2019 14:16:23 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 4 Dec 2019 14:16:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFGo9rPwuZz7uLUqje0/5rMnpTWARWIqF7mOAgZz1bJ+KfwVVo0xZnFwAdTF3TQfDZvYl+uVeNBvMQB55Tp8Bn2hcdCgXPg2fWUp/b53JCAfTXaU5nY8vYMPmPd5P8FCE7pVkl5QwneN5H62be26wARdVaTymZI+Yx6/Uw7DmnF3b+vMXTiLKtQXgbMU83iCHa+xyWWf6dxFxWO8w4NO35PjhARtq7zMJrVvcrTHLxE1ZMiXpUv/f8f30/lJe0x6o+opV+AgzjsW9P7mvQ8FrkeC8wyDDocTsJx6ggCVUwZRTPsIL/0nLCACLLQA+x+KX89hu9TYeUyc8JG/bCATdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNyP+6pfDQFgzLwnVEm/j4fd3IWeVSIcnVs+sB31cZM=;
 b=jtR+o6Zv3Vb7A9m785nT+zfYfVCNOpaN+dvUmGZ02e1UAnxWxBC11ia1SASRRlaUJoeSAHOIOO73EjsYFePn6JF6YostNIcd7H+2IIQZUQOZhWnPrTH10f3XEtPHeW4HpmqE7egfZSialQUz3ojzxcG705z3YJK1qyTOdXNimWz1jjoI0hSdgtcF6uKslxam1Pqhvf1cfQGBj12cR0V3V26Z2TS0ST0uBkyeoJQrmnvaIufTe07QebOrYUE6p0Cw7O7u4bA64AA/RC4V8shB4oeooimHAAwmiaYRKGABd2NGvK6Al82WqoCK1WTxVT6moxmD2iAaZNf1NNIbm57XRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNyP+6pfDQFgzLwnVEm/j4fd3IWeVSIcnVs+sB31cZM=;
 b=AWYS0N4R6wXhq2MuAbm9ma8uHA9Df83Ca0alc7NjKd8oz4osNBGRmbY6XbrHcIrUrP6L+dxZRb6db2fN+AGElVpvq3QbokY+lXKJKtbMglKpebHmqUqIAXIj62Yrf5eVykG1tvtXooYgc/dsbRNVfg164tZOGGTul2glqGwV7Mc=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1838.namprd15.prod.outlook.com (10.174.255.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 22:16:22 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2516.014; Wed, 4 Dec 2019
 22:16:22 +0000
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
Thread-Index: AQHVnBAlgYxvir4ozkO3bLas1TlApqegVCGAgAowrIA=
Date:   Wed, 4 Dec 2019 22:16:21 +0000
Message-ID: <F5CCA199-1DA6-4688-8B36-82D9565BF5DC@fb.com>
References: <20191115235504.4034879-1-songliubraving@fb.com>
 <20191128083045.GB1209@krava>
In-Reply-To: <20191128083045.GB1209@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::5940]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ce7991a-3927-4cc2-729b-08d779079823
x-ms-traffictypediagnostic: MWHPR15MB1838:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB18387FD36E88061AF34B7E6EB35D0@MWHPR15MB1838.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(5660300002)(6512007)(33656002)(2906002)(6916009)(4326008)(6246003)(229853002)(6436002)(14454004)(2616005)(76116006)(6486002)(36756003)(99286004)(54906003)(71190400001)(8676002)(81166006)(102836004)(25786009)(6506007)(64756008)(86362001)(305945005)(186003)(71200400001)(11346002)(66556008)(7736002)(66476007)(53546011)(66946007)(76176011)(8936002)(81156014)(50226002)(498600001)(66446008)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1838;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2lrauFKtkFKoRyx/AmLgPdQaJRnjEC/IKBqsb7CWM5eHF7C4L0PBtSjrYD0FsUQKhbIIgJGy8bvVTBz/E/hdABXWpP5H8mUylFs77izLel5RT4d6JkWjqwgyY8Un5eiNldaAgofkMqviIhFEDPIPb5zMXM9Kj2G3Ni25mZJWlFlox1fBGqHJUcVyFsGLd0kKxiQR7rVWyatLPhSoTTMjaHzmDpyLsACjUO9lILn+nadq6Jjf1LR73/IG/s7Frx0MaqtA59ODsoY08X84hOkRrJu4g/SLV/HgoVRs9jXJlo/qMwtyiEvB9siriSS+gm+QOxln/biCq9aVRnwxrxL9/WBw4LJ990n3NxbLdpT6JRMHtVUR8Dg9kGi4WUf7japbNUhBDL3Ac7THJCPaEb4wkp7rQvcmJ3lXZbmHciysQcgBriNQtb18Y24NkE2iX6U9
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A133C9A16FC95B4D9CF5D0888CA1A54A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce7991a-3927-4cc2-729b-08d779079823
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 22:16:21.8157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xlvY9JfwKWtMwT0zSGlwRZINBFzlcPPerMYVju327ByJ6pz53+fX5f5v0FJCvDWEHchDHSnCWB49N1PNT3Tcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1838
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=944 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040184
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 28, 2019, at 12:30 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Fri, Nov 15, 2019 at 03:55:04PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> 		add_event_to_ctx(event, ctx);
>> 	}
>> @@ -2745,21 +2998,26 @@ static void __perf_event_enable(struct perf_even=
t *event,
>> {
>> 	struct perf_event *leader =3D event->group_leader;
>> 	struct perf_event_context *task_ctx;
>> +	int was_active;
>> +	int event_type;
>>=20
>> 	if (event->state >=3D PERF_EVENT_STATE_INACTIVE ||
>> 	    event->state <=3D PERF_EVENT_STATE_ERROR)
>> 		return;
>>=20
>> +	event_type =3D perf_event_can_share(event) ? EVENT_ALL : EVENT_TIME;
>> +	was_active =3D ctx->is_active;
>> 	if (ctx->is_active)
>> -		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
>> +		ctx_sched_out(ctx, cpuctx, event_type);
>=20
> you're scheduling everything out in here, so cpuctx->task_ctx
> will become NULL and trigger the check below

Good point!

>=20
> I dont think you need to do it here, ctx_resched will do that
> for you later, this here is just to keep the time updated

We will need to schedule out all events for perf_event_setup_dup()
though. Let me try to move perf_event_setup_dup() to ctx_resched().=20

Thanks,
Song=
