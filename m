Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067E1C5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1062173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oeTL4d0Z";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hMBTU+v/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfKFRko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:40:44 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36200 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727633AbfKFRkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:40:43 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xA6HdCjT012333;
        Wed, 6 Nov 2019 09:40:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YCjv91o9CIDPPScmVOkDhYVIlfc5/JDZ5on/sLiRirg=;
 b=oeTL4d0ZiM+NJFJLO7ahIiG41vIOrEYz2BDa4d627aQECI/hiEioW/FUgTKQOgDjpVab
 bB0ZoWSE1atrESRvDlG1NF02Ey4PxFWlQ2uTkK0sZ4UzbJaWWJdNIlB//kUp9//CPwj5
 B3kh6ONCubC+HCfn6S1ijq3dX4GjIpnGAj0= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2w41w1gajf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 09:40:32 -0800
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 6 Nov 2019 09:40:31 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 6 Nov 2019 09:40:31 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 6 Nov 2019 09:40:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDoR/jNHD815YlTOIdPyx9+t2ttBdo80sRW4jhdJg9gJtTt8QhnsNYOQGXMrdvTURd3NTYp2HtLVmSDWLoIVUmz3rZOzhH5CuQIJo3HDYfg6Jes5Z0GwIzTNA6M2BooTTlHszDoXvnDtBSLvOvM4yo/yOLXyExXw2K/SgJ2z/LmbY1LWbvIqTG4U1O5RKfkiI7Rv9BBTPrS4qXxrpJAepoAYR0Fooq6Dy7Km+BlWwkoKTlILxjOFxXwR18FKA5oRXNqamV0t8kST5hKc/yHCteyPuDCXrzavJp2fQs6Mvm51Q4Z99AVZzqQOQ+45QQ56O1PzmDCUODqOI03fQ6RwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCjv91o9CIDPPScmVOkDhYVIlfc5/JDZ5on/sLiRirg=;
 b=mLQS/u85G8BAmj1n+SrbdbgozV87HuANEr2MOV6qlmTYX8Sn3aw+vNkI/dLXeTuKL3cPjDjRkp5kA7QyHZdU2tH3x73bAOb4W9uW1R0Z7n85pxZ3Xe5uGziWZ2sFZj2Lbv0HbYjlrouVCu04bow8ZG6KtxwezN2EWS8ccb9Gietr9NvScLJn9MHI+bHp5SrLeIVZXlu2yP8ue7VZvnf+O1Pa5esTZLOAksYtts2P89bd9TjOL0sgcqgQlR6Ds/Qrk2gcYNCuv87lcWRKzVShzHWxKIvmu9hYuv5XzUQ1wDwpBawvpIq/wBZHnoASUXu6rBLAC3+jpUYF5rz/7xXgGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCjv91o9CIDPPScmVOkDhYVIlfc5/JDZ5on/sLiRirg=;
 b=hMBTU+v/K0TExPtk0tOILTc8T1Yza04cvtzeskjclr/k2j2hSh62KW52zaTytbn020oKxGdApQi1TYJRXQTmeEgRmuByPZkRpviq92bSqCoaeiAcDnMZRWBZm/QntnrB9qN7p78vX30PupLtT1gxEsqLBtOW6cUf9Lkrn2aWjas=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1758.namprd15.prod.outlook.com (10.174.255.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 17:40:29 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 17:40:29 +0000
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
Thread-Index: AQHVbqpjjWjaDbp/ikSYoLFTNk8qM6d09EYAgAA/EQCAB+dbAIAAM8KAgAAvaoCAAKofAIAAjTwA
Date:   Wed, 6 Nov 2019 17:40:29 +0000
Message-ID: <168F3761-98CF-4E91-B911-ECB9FCD68F0C@fb.com>
References: <20190919052314.2925604-1-songliubraving@fb.com>
 <20191031124332.GQ4131@hirez.programming.kicks-ass.net>
 <19AE6C78-C54C-4C37-BBD2-0396BB97A474@fb.com>
 <98A6264C-B833-4930-95A0-2A3186519D87@fb.com>
 <20191105201623.GG3079@worktop.programming.kicks-ass.net>
 <23D48724-55B7-45A3-A77A-56BAD57937F9@fb.com>
 <20191106091458.GS4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191106091458.GS4131@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::fc23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30b4b78a-9062-4d0f-6b95-08d762e06a98
x-ms-traffictypediagnostic: MWHPR15MB1758:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB17585AD1BA72C74422FFC5E1B3790@MWHPR15MB1758.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(76116006)(66446008)(229853002)(71200400001)(66556008)(446003)(66946007)(66476007)(4326008)(186003)(6246003)(33656002)(2906002)(64756008)(5660300002)(6486002)(6512007)(2616005)(54906003)(11346002)(476003)(486006)(25786009)(6916009)(81166006)(71190400001)(99286004)(478600001)(256004)(102836004)(14454004)(36756003)(6436002)(8936002)(50226002)(76176011)(6116002)(8676002)(6506007)(53546011)(86362001)(316002)(305945005)(7736002)(81156014)(46003)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1758;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eksIXQFNWPF9MRGU7WmGFHOOwML8C8n0iddHh70kcbhXiZLltsI71MLBDCx9MuhPzUspHdmMLIKyWsamLUeDolhHurvLeqcKZj+mHOX/5EZUdU7hgUH7LUXlcS0a9cLf9fwxGR6IETpXuTaqggyQm60vmlj43Ny6dVAuaZ5Oci5Nwz46+tnIkGNcxdWTubwxLze7zFgWBloP+HC2+98vuPngInJeJdCC2dWqb1RrI5f8aY4Zt5PVfY+GnOCK8FsyuZANnCFEESKOv4Tok+EUqOSUwiyoAqG0ZB3jkhmYHBh4zsp3bhHfhFBkDWNHAUlNekiSj91bjYZCcPQyf3z9mcqQQYmy2uV1lSUr9p6U4rQ7b+gSXUWNpdTTFYGuAOjtj4AMVVId6fQXsSKwXTNKL72SO3OV/nRdObLdkqbHicnASZbyvY09ikl2DzBUDoQG
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E18CA7A8C78DD468F93B420D00024AD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b4b78a-9062-4d0f-6b95-08d762e06a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 17:40:29.5285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9w6Wwr3wojyNuSl0dZTcHu9MYjR3Wmu0bcdr9niQ5Gks+XicBzrfdqJzTKqbTM7QTtGVFKDkRh/BP2/hwl/zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1758
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_06:2019-11-06,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911060171
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 6, 2019, at 1:14 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Nov 05, 2019 at 11:06:06PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Nov 5, 2019, at 12:16 PM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
>>>=20
>>> On Tue, Nov 05, 2019 at 05:11:08PM +0000, Song Liu wrote:
>>>=20
>>>>> I think we can use one of the event as master. We need to be careful =
when
>>>>> the master event is removed, but it should be doable. Let me try.=20
>>>>=20
>>>> Actually, there is a bigger issue when we use one event as the master:=
 what
>>>> shall we do if the master event is not running? Say it is an cgroup ev=
ent,=20
>>>> and the cgroup is not running on this cpu. An extra master (and all th=
ese
>>>> array hacks) help us get O(1) complexity in such scenario.=20
>>>>=20
>>>> Do you have suggestions on how to solve this problem? Maybe we can kee=
p the=20
>>>> extra master, and try get rid of the double alloc?=20
>>>=20
>>> Right, you have to consider scope when sharing. The master should be th=
e
>>> largest scope event and any slaves should be complete subsets.
>>>=20
>>> Without much thought this seems a fairly straight forward constraint;
>>> that is, given cgroups I'm not immediately seeing how we can violate
>>> that.
>>>=20
>>> Basically, pick the cgroup event nearest to the root as the master.
>>> We have to have logic to re-elect the master anyway for deletion, so
>>> changing it on add shouldn't be different.
>>>=20
>>> (obviously the root-cgroup is cpu-wide and always on, and if you have
>>> two events from disjoint subtrees they have no overlap, so it doesn't
>>> make sense to share anyway)
>>=20
>> Hmm... I didn't think about cgroup structure with this much detail. And=
=20
>> this is very interesting idea.=20
>>=20
>> OTOH, non-cgroup event could also be inactive. For example, when we have=
=20
>> to rotate events, we may schedule slave before master.=20
>=20
> Right, although I suppose in that case you can do what you did in your
> patch here. If someone did IOC_DISABLE on the master, we'd have to
> re-elect a master -- obviously (and IOC_ENABLE).

Re-elect master on IOC_DISABLE is good. But we still need work for ctx
rotation. Otherwise, we need keep the master on at all time.=20

>=20
>> And if the master is in an event group, it will be more complicated...
>=20
> Hurmph, do you actually have that use-case? And yes, this one is tricky.
>=20
> Would it be sufficient if we disallow group events to be master (but
> allow them to be slaves) ?

Maybe we can solve this with an extra "first_active" pointer in perf_event.
first_active points to the first event that being added by event_pmu_add().=
=20
Then we need something like:

event_pmu_add(event)
{
	if (event->dup_master->first_active) {
		/* sync with first_active */
	} else {
		/* this event will be the first_active */
		event->dup_master->first_active =3D event;
		pmu->add(event);
	}
}

However, I just realized the event_pmu_del() path need some more thoughts,=
=20
because first_active is likely the first one get sched_out().=20

Merging another email here:

>> If we do GFP_ATOMIC in perf_event_alloc(), maybe with an extra option, w=
e
>> don't need the tmp_master hack. So we only allocate master when we will=
=20
>> use it.=20
>=20
> You can't, that's broken on -RT. ctx->lock is a raw_spinlock_t and
> allocator locks are spinlock_t.

How about we add another step in __perf_install_in_context(), like

__perf_install_in_context()
{
	bool alloc_master;

	perf_ctx_lock();
	alloc_master =3D find_new_sharing(event, ctx);
	perf_ctx_unlock();
=09
	if (alloc_master)
		event->dup_master =3D perf_event_alloc();

	/* existing logic of __perf_install_in_context() */

}

In this way, we only allocate the master event when necessary, and it
is outside of the locks.=20

Thanks,
Song


