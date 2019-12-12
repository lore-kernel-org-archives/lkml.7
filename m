Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7B7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F8422527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bLOmSdwv";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DXgSXF4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfLLPST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:18:19 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1284 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728929AbfLLPST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:18:19 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCFFfWh015968;
        Thu, 12 Dec 2019 07:18:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+swVOdgF5RaJEvniZvFBP6gVf+9OysdUN190zQlwVQA=;
 b=bLOmSdwvhJEG7JvjfZAvXY349WvgBaARXRWIXjaz38/61RyIry5nuNvWBOQAQUUum3wX
 lW8O4ybroRRDYIofy1KWDiJbciiPGGFADHooRZk0hr4T95BXS/LgiAXB20/yI/lcQ0fm
 x7ajLd8aBmQx+HemnULUwJXjdQlmbYM3gT8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wu87qkp2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Dec 2019 07:18:07 -0800
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Dec 2019 07:18:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Dec 2019 07:18:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT6AiYRkpt4/yr4YWNLKRfwO+JcG15TL2Vvnn8QTLDVADHlYAYTeFheCHRJGexMox2hQwPY557mlFNYyhwbRbX6MjJ3yCdeRL7+9WgnsKgPC5nXs7lnfYoznZiwGs08bjIuM3NX+MiDMpxhIx58ojs8rxzRsUa8vh/qjAJHpODyR5MvDplc/7oH8DZrvPwvsRGJusRw0iUg52h3CctZ0AtFsBNnfWpIewWPqh3Ey+lRHF1Kk5TVl92lTSFrkBqy1oenmHKSiBVbDF2r6rskm4Gi5OCSx7emx+zFGp5U1XOaHcv7+YLau6KxkeMSSsjCM4hmPl7WRvpoZd1fSDCCt3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+swVOdgF5RaJEvniZvFBP6gVf+9OysdUN190zQlwVQA=;
 b=ZnZ6sNTzvP7YWaugkyFTrmrRdavgOhuXvS6dQ1myIO+BIVO2a1Z0aO+IIaABt90h8ebZOcuN6W5aHHaUG38jo+cvkQnrH4vTtmvWZy1xAgRbU8DwHiri1QmLmszo/dGctFKTQWQr6MG5BtdKjj2fGu+IT6LFcGJch95MasmBu1CsxG8PY/PFHnyQPJ7ZSCbWRZUoEh7nl6JcVc+QEzad9zIBz8stGe67BwZb+1KOE7K4ePbPaFj2CYV9k+Jmz0n9s/waci8KSitJwSlg3dcVKc74F5ziy+6XGEF8QQhT/fXdD3OjKN+4ypThTFEPzGI7PTw4IO0ks6XTL+9YOB5qtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+swVOdgF5RaJEvniZvFBP6gVf+9OysdUN190zQlwVQA=;
 b=DXgSXF4iZUuVyMfyDmjINbPS0iMWuwP4LrcQhhy4MDPyp3s9zpVjblszgG1aNISLkXQm2GeQM+lheUmP+2xucJXZ6rgbfixhWGUJlZ63IGCy+zx+Z8vHpvlHNGtOaJtVe2phHUXAA4+FeN/er8oIYKE7PFHZJYWk7Gd4LHi9hDo=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1120.namprd15.prod.outlook.com (10.175.8.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 12 Dec 2019 15:18:05 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 15:18:05 +0000
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
Thread-Index: AQHVrJTJGmqRAKGiXEWGIEJPQu1yRae2itaAgAAasYA=
Date:   Thu, 12 Dec 2019 15:18:05 +0000
Message-ID: <02350C29-3A23-4773-BC51-922B866EDA9A@fb.com>
References: <20191207002447.2976319-1-songliubraving@fb.com>
 <20191212134231.GW2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191212134231.GW2844@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::d1f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfb0ab47-3cab-4123-6beb-08d77f167c9c
x-ms-traffictypediagnostic: MWHPR15MB1120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB112054350D0DA6DBCC89657FB3550@MWHPR15MB1120.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(6916009)(71200400001)(6506007)(53546011)(4326008)(33656002)(5660300002)(6486002)(54906003)(316002)(86362001)(81166006)(8936002)(81156014)(8676002)(2616005)(64756008)(2906002)(66446008)(66946007)(478600001)(76116006)(36756003)(186003)(66476007)(66556008)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1120;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dVsNI46F87CBwq8Dl8AB9YXYg4lUCAfitpQFZp7W7a2MqoKLW2iW9eIQL+lCD/Qx6SavGaNXsS4nyW8rhgaTyAsww5O0ajRKHtgpjGMyhPzXt5Ju89/h4qabRA9VP++x/reZEFw6owBc+0Pux/H4rxR7lD4nkrlmjF8Xaxqr8dV0GtTCrNm7EvNfeGUxypSrT3Llizj5mYfvuXE0YwJtlLfxzfzd8K5TuGJhPRItM/bzIFm8eVvhi2uqGm1vTwaBa1PkpAy9Bp4b1p4UP5lOmevzpVaYPRfvbrUc9ACxsch/QK6b4gIVSSSws199HyHMjmtMS5XhAJ0GpWlgO0NnJ0GMZf6LVxBF5eGKp0+aDIA4mNfLJJ8ER2mQZfdczcBFRAwvZ4Zneg5qTGtsf9u6KhU/3VjmhCmhWWKYqRlZQy2b7WvDxn2AAJgDB6yIyq7c
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0E39BC4112A5E4DA7585EF77E9D6C8D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb0ab47-3cab-4123-6beb-08d77f167c9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 15:18:05.1489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRLmw/qLOS6d7sG8CejFm7hyqDYKMDesXqWO6Ip4oJik6+Z8MRp7qIPnxL6/nKvC6zSXcDGChJmoZc9QkfSnqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1120
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_03:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 spamscore=0 mlxscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=950 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912120118
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 12, 2019, at 5:42 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Fri, Dec 06, 2019 at 04:24:47PM -0800, Song Liu wrote:
>> +/* Remove dup_master for the event */
>> +static void perf_event_remove_dup(struct perf_event *event,
>> +				  struct perf_event_context *ctx)
>> +
>> +{
>> +	struct perf_event *tmp, *new_master;
>> +	int count;
>> +
>> +	/* no sharing */
>> +	if (!event->dup_master)
>> +		return;
>> +
>> +	WARN_ON_ONCE(event->state !=3D PERF_EVENT_STATE_INACTIVE &&
>> +		     event->state !=3D PERF_EVENT_STATE_OFF);
>> +
>> +	/* this event is not the master */
>> +	if (event->dup_master !=3D event) {
>> +		event->dup_master =3D NULL;
>> +		return;
>> +	}
>> +
>> +	/* this event is the master */
>> +	perf_event_exit_dup_master(event);
>> +
>> +	count =3D 0;
>> +	new_master =3D NULL;
>> +	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
>> +		WARN_ON_ONCE(tmp->state > PERF_EVENT_STATE_INACTIVE);
>> +		if (tmp->dup_master =3D=3D event) {
>> +			count++;
>> +			if (!new_master)
>> +				new_master =3D tmp;
>> +		}
>> +	}
>> +
>> +	if (!count)
>> +		return;
>> +
>> +	if (count =3D=3D 1) {
>> +		/* no more sharing */
>> +		new_master->dup_master =3D NULL;
>> +		return;
>> +	}
>> +
>> +	perf_event_init_dup_master(new_master);
>> +
>> +	/* switch to new_master */
>> +	list_for_each_entry(tmp, &ctx->event_list, event_entry)
>> +		if (tmp->dup_master =3D=3D event)
>> +			tmp->dup_master =3D new_master;
>> +}
>=20
> I'm thinking you can do that in a single iteration:
>=20
> 	list_for_each_entry(tmp, &ctx->event_list, event_entry) {
> 		if (tmp->dup_master !=3D event)
> 			continue;
>=20
> 		if (!new_master)
> 			new_master =3D tmp;
>=20
> 		tmp->dup_master =3D new_master;
> 		count++;
> 	}
>=20
> 	if (count =3D=3D 1)
> 		new_master->dup_master =3D NULL;
> 	else
> 		perf_event_init_dup_master(new_master);
>=20
> Hmm?

This should work. Let me fix in v9.=20

Thanks,
Song
