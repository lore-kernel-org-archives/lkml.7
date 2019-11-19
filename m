Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9303BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F29522304
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="o9orLdgK";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CbS4KiD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfKSP3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:29:05 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57310 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727849AbfKSP3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:29:04 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJFSjCQ017048;
        Tue, 19 Nov 2019 07:28:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=R/89fxSsfc5srHc7hY9RYm564AgIFKkRisPGI4leWAU=;
 b=o9orLdgKwBlpg3spFkvx7LN1Ch3pCjE0XZ4n8WGAMkmRxu8aHJjuOcD1OEmLhUSrnN3b
 nEeYWBazKRZbA9RnrHLl/DGTKJBUY5koWAJD25enU5sIhs3d9PQCcvveYVv3GRs6518Y
 I1vRfsc791V8AqeG1l1+dsZnWcLVqaGia+8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wb1pwax1a-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 19 Nov 2019 07:28:51 -0800
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Nov 2019 07:28:40 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 19 Nov 2019 07:28:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTmH2bEnmrD2HV3Nt9TvBbEjY49OmDEoO0hGWnd/lI7hBpO9S9ccrnjHkCxFQZeiU5SsAh8/AlcSFoKb2iGfmqb/eLhhTyjZCjOjp+yjE6p7MVXybsVknZtERpv11LGdIEmQqX967C9zXWpgfNIkE0nN0R1Z/zJtFKb6wqj5lw4GLtco0TqOq/bksKwIcQAvl8G2VMTkjiupm97tCnPkds/wd9r5K7XxX59Ek1uyy2EWwdE5cdnz2Kbc2SYXy2fs9W89pVmnD5AVlCwIp9CkP9vWhlKqFjouiSe/XGwGXscps0zoRGABjHnhG/CpBL+yG40YCiaIjxP3QQPIqVjNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/89fxSsfc5srHc7hY9RYm564AgIFKkRisPGI4leWAU=;
 b=fE9Cabbs3pAxpO9Qatr0Euhqfq/GzA3+tfBHk0J5YOEJudj7touHqYmpFuHsLzQXAdsJI64uudBittiZHIi/5TxVykpTTHvEher5k2qTWXNRqmmnk2hM9WUr4XUbW5ihhkFK+iM4BWzg3/czHLSqGAsoWEG0dWHT5HE/5I5uggkTcb/AAvUYoO7DZjslTNt5vX2dJKpg3m0qLS7YZ5ZSkOj2mUlo3pdmiGztodcHdT8QXqzeE21WS76yLnjMgSlT+lM6dplZqcZlBTm/1VHgDCXqrel54xeJLmsKI8oBkUDdk4laYk2YYnNjOS3Hnfyejw1XrD40OoZ+8SZYo7uw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/89fxSsfc5srHc7hY9RYm564AgIFKkRisPGI4leWAU=;
 b=CbS4KiD1ZehfDane6Ls/06k5tj/90LQlk8vMzdIMgQolj3iMgRBv4PIisaXlFX5wPs8IM9zBqbqJv8UY8pUw2yznAC3gkI/9s/E9MC13HYPhfI88Ixb5u3UmumtelqTYzy5YqC/hwhwsvzOHjOUz7WywrWQQ4CVgLGgzeamNnbM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1519.namprd15.prod.outlook.com (10.173.234.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 15:28:39 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 15:28:39 +0000
From:   Song Liu <songliubraving@fb.com>
To:     open list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Kernel Team <Kernel-team@fb.com>,
        David Carrillo Cisneros <davidca@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v7] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v7] perf: Sharing PMU counters across compatible events
Thread-Index: AQHVnBAlgYxvir4ozkO3bLas1TlApqeSo+cA
Date:   Tue, 19 Nov 2019 15:28:39 +0000
Message-ID: <AB684919-5C5D-4228-BA78-54FE8F609D8E@fb.com>
References: <20191115235504.4034879-1-songliubraving@fb.com>
In-Reply-To: <20191115235504.4034879-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::dd7a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccca36f0-b832-42ec-88e9-08d76d05270d
x-ms-traffictypediagnostic: MWHPR15MB1519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB15198AE2896A83655DDBDF3EB34C0@MWHPR15MB1519.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(5660300002)(46003)(99286004)(229853002)(7736002)(305945005)(446003)(86362001)(6436002)(2906002)(6486002)(14444005)(256004)(76176011)(11346002)(71190400001)(76116006)(71200400001)(25786009)(4326008)(33656002)(8936002)(54906003)(2616005)(81156014)(6246003)(81166006)(50226002)(66556008)(66476007)(66946007)(36756003)(8676002)(316002)(6512007)(6116002)(476003)(486006)(66446008)(186003)(53546011)(110136005)(64756008)(6506007)(102836004)(14454004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1519;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VoXNQ06osGANQGCtRUrs6Xb20Dif1+/6eIMwvmCdk/VETOhpOBxT7EMp/MSoZScfoB9WIBf6iATyGXtNONw0Uf0iFBSbR+R9CUaZSbweVBOMS3ESeYe9d9E7HsT8N8ZBcs7YFVSsmu1sV6VnyOSCQ2Q23C+lYsuGzi+MIT52S3XW01DIm0QuId2MsVOIz1guw4NuEjD52EjwqPvXydYjJTS+doXWgvlFUD0mBjTwo10dBb51zaOJxz9vTvVOlzKd71S2csCLMOpYLkHAXsq8YUaOK0nMm19VKIiLmPLTFumxIw0ZN32QOwTxLqwHI6SrCkKcL/T+7rTxJj55wFdH0DzHUot07iZGlmIr3OiGSuTOjOJq7s6XBJ7da+h0DIjqf3SScpbO8FsRWv6lOvdIMmzKPKD+Fl1FCIex6BlKfTlZjmSjfWUMVPtk0KUY/fV6
Content-Type: text/plain; charset="us-ascii"
Content-ID: <108E7A0AAE10B44184177B3D439F9904@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ccca36f0-b832-42ec-88e9-08d76d05270d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 15:28:39.1797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hiPXODmSw8gOnovrEpEAhHUTALoJ9UrC/MURwx/AC8+4Rpvxj370JzmcVvVLr3w3pvsGtOlnqHKvwvpll2KQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1519
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_05:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911190140
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Alexander

On Nov 15, 2019, at 3:55 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> This patch tries to enable PMU sharing. When multiple perf_events are
> counting the same metric, they can share the hardware PMU counter. We
> call these events as "compatible events".
>=20
> The PMU sharing are limited to events within the same perf_event_context
> (ctx). When a event is installed or enabled, search the ctx for compatibl=
e
> events. This is implemented in perf_event_setup_dup(). One of these
> compatible events are picked as the master (stored in event->dup_master).
> Similarly, when the event is removed or disabled, perf_event_remove_dup()
> is used to clean up sharing.
>=20
> A new state PERF_EVENT_STATE_ENABLED is introduced for the master event.
> This state is used when the slave event is ACTIVE, but the master event
> is not.
>=20
> On the critical paths (add, del read), sharing PMU counters doesn't
> increase the complexity. Helper functions event_pmu_[add|del|read]() are
> introduced to cover these cases. All these functions have O(1) time
> complexity.
>=20

[...]

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index aec8dba2bea4..00b1e19e70fd 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1657,6 +1657,139 @@ perf_event_groups_next(struct perf_event *event)
> 		event =3D rb_entry_safe(rb_next(&event->group_node),	\
> 				typeof(*event), group_node))
>=20
> +static inline bool perf_event_can_share(struct perf_event *event)
> +{
> +	/* only share hardware counting events */
> +	return !is_software_event(event) && !is_sampling_event(event);
> +}
> +
> +/*
> + * Returns whether the two events can share a PMU counter.
> + *
> + * Note: This function does NOT check perf_event_can_share() for
> + * the two events, they should be checked before this function
> + */
> +static inline bool perf_event_compatible(struct perf_event *event_a,
> +					 struct perf_event *event_b)
> +{
> +	return event_a->attr.type =3D=3D event_b->attr.type &&
> +		event_a->attr.config =3D=3D event_b->attr.config &&
> +		event_a->attr.config1 =3D=3D event_b->attr.config1 &&
> +		event_a->attr.config2 =3D=3D event_b->attr.config2;

In a discussion on the IRC, Alexander highlighted that we need to=20
compare event->hw.config as well (or something equivalent). I will=20
fix this in the next version (will need cover a few different=20
cases).=20

Hi Peter, could you please share your feedback on this? Does the=20
overall direction look right?

Thanks,
Song

