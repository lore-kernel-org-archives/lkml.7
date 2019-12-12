Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F9DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931C42173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CEtix6mQ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="J2M3gW8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfLLPhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:37:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63628 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729013AbfLLPhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:37:18 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCFZcWV031517;
        Thu, 12 Dec 2019 07:37:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RYLwGR6h/DqodiWXmmLX3iU37xlgi2fjFQ72n7gsttw=;
 b=CEtix6mQG6L6/uICkUuH7f1NLbRdq6j+cxBGdu9Y4RHmeC+cee2cZV/QTcAvFtSpIGxs
 kPeyjCXbT1aspQ4DoZsqgVULi0N0uz2gVyciyTG+e2I2GknoJA3UsL8x8Cfgkw3ZWcCJ
 UD1FHb3yMbdC0U3AA1nDNjZMJgadKU/MPUk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wu87qkrmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Dec 2019 07:37:08 -0800
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Dec 2019 07:37:07 -0800
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Dec 2019 07:37:07 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Dec 2019 07:37:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfHcLg+DYM/YGM6aWoiW0WkhzWlfaarYiEjXcGxcce85L/YRLxEKC4VF8dPhdyoOKmHKucTVdSatVMMLfpcHWg2+Z12Be2FF6KUC1mwdntw/93HdvSb0B7MFlWgvVjxRFT/2s2xii0BJWaBHmMOAsg7P6KYRWDQq6yeMXzWHLKV+KlnwIxo+feo2nhOtG26s2Z+WyPtc3L0E5qOiqorTCFNsnsO1TwzvBKSZFVQft9ef1HT8tZp1+9TI3sjtRMyUjuwMB3pbqJgJ6U5vw4UC8rhc2LlQ3niTzWSpUMMvwHum9E2P5MpDZI9DF+6kdy1QjxzHLOW9o2WLhw5J95Rjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYLwGR6h/DqodiWXmmLX3iU37xlgi2fjFQ72n7gsttw=;
 b=d82aZpNmZC6ZyLY9S5P1QMioEKpgQ7HHqRnBFlmcomCnRHd2t3weJIPEpO63DmKgKQSQ4EFzOjHU6grGpsDqtQHQmNgJ3ekh0N59IdBmqxBDKVTkjIBK9SY2TJ/HW2lFhumvKJAmvF3RKDtpl3CvLyZNLLBsosS7kvkODYGRDk4iDfxyvcXqB9Yf+j0yc6s4jhVduEa+95NFE+u4r+zXbp3TE/Mj+aKlUXeKJ02oMvnZCQ6dflZ6+5MIa9xNxPs1FESVRaBggH5pyX89Cl1M10Yopicy4+A2cRTDZbWvmfEtNGGlvcw8CHXvqkojPd3WpwxnnEKTyhKB+xD3gzVQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYLwGR6h/DqodiWXmmLX3iU37xlgi2fjFQ72n7gsttw=;
 b=J2M3gW8xd33CZtVKxxqFehpps2ppJ9zyg8It+KPgolWiRAdn0J6orUOS12la8nX09Zmcr/v/lFuZ0NoOpOKNAFMniLZm3C59jlPQv/C7901gBwIGop7ho4eDpqcVcAHD904SxDbB6XmPP+lCzXyXEbN4d4ynAp9yaslY2vNx2n0=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1423.namprd15.prod.outlook.com (10.173.229.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Thu, 12 Dec 2019 15:37:05 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 15:37:05 +0000
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
Thread-Index: AQHVrJTJGmqRAKGiXEWGIEJPQu1yRae2jOOAgAAd9QA=
Date:   Thu, 12 Dec 2019 15:37:05 +0000
Message-ID: <5D5BC3C8-427D-4983-AAEB-0E8001751BA0@fb.com>
References: <20191207002447.2976319-1-songliubraving@fb.com>
 <20191212134951.GX2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191212134951.GX2844@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::d1f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 838a2e82-63b4-4427-84d8-08d77f192428
x-ms-traffictypediagnostic: MWHPR15MB1423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1423BB5745DC7D0527A55B1FB3550@MWHPR15MB1423.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(6916009)(71200400001)(53546011)(6506007)(33656002)(4326008)(6486002)(54906003)(5660300002)(316002)(86362001)(81166006)(8936002)(81156014)(8676002)(2616005)(2906002)(66446008)(64756008)(478600001)(76116006)(186003)(36756003)(66476007)(66556008)(66946007)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1423;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 403/DxcNVaw/LHN5udcgzcZdl2GRlGhg8o53ie2mEt+ieoyT5C6HUmYjiz9p4xpaeGY5A2+Mnvsp/Yay3xJfgnz8G9Zb518mf8pdNDRgNVwkxrCpfW632GDwJUzgcDuNAESsI+ZihM60huLmpcsoMPcjnERdiMzQlGgNjr05lj8CQQNYpgs9ipJ78nE7fs9jetKz8bHNNAERKHqNGSeq91T74rOFsTfH61mZC6VWytqEp7n9Ya/Erat/G27ugAMg95Zfflxc5qDt8FB5Y4kt7Gqf1d0UYtmg6GF7HcDLBdCg9QVVfS/P1qX0B1+Ssa/zDABOry2YFRit2+VWmNxA9VpAUkHYQRwBObzREG2slYUE/SZ5IdmP/FikYM5YSSjFbnGGShBp0JLlImljVK2M55RyGbNnS/p3vPXPQLuJi9asBKlYL4qasra+72uXVX9G
Content-Type: text/plain; charset="us-ascii"
Content-ID: <81E32D670BF36543AE581FFA9570C2A5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 838a2e82-63b4-4427-84d8-08d77f192428
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 15:37:05.1950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbv3xK8kTGgIP2kKtWGFjO316O/gQF+KhupO0t63uTR82VKG4tenVePOvHslsFxkJeRzP8lDVt2WtNu0Nw8vwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1423
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_03:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 spamscore=0 mlxscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912120121
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 12, 2019, at 5:49 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Fri, Dec 06, 2019 at 04:24:47PM -0800, Song Liu wrote:
>=20
>> @@ -750,6 +752,16 @@ struct perf_event {
>> 	void *security;
>> #endif
>> 	struct list_head		sb_list;
>> +
>> +	/* for PMU sharing */
>> +	struct perf_event		*dup_master;
>> +	/* check event_sync_dup_count() for the use of dup_base_* */
>> +	u64				dup_base_count;
>> +	u64				dup_base_child_count;
>> +	/* when this event is master,  read from master*count */
>> +	local64_t			master_count;
>> +	atomic64_t			master_child_count;
>> +	int				dup_active_count;
>> #endif /* CONFIG_PERF_EVENTS */
>> };
>=20
>> +/* PMU sharing aware version of event->pmu->add() */
>> +static int event_pmu_add(struct perf_event *event,
>> +			 struct perf_event_context *ctx)
>> +{
>> +	struct perf_event *master;
>> +	int ret;
>> +
>> +	/* no sharing, just do event->pmu->add() */
>> +	if (!event->dup_master)
>> +		return event->pmu->add(event, PERF_EF_START);
>=20
> Possibly we should look at the location of perf_event::dup_master to be
> in a hot cacheline. Because I'm thinking you just added a guaranteed
> miss here.

I am not quite sure the best location for these. How about:

diff --git i/include/linux/perf_event.h w/include/linux/perf_event.h
index 7d49f9251621..218cc7f75775 100644
--- i/include/linux/perf_event.h
+++ w/include/linux/perf_event.h
@@ -643,6 +643,16 @@ struct perf_event {
        local64_t                       count;
        atomic64_t                      child_count;

+       /* for PMU sharing */
+       struct perf_event               *dup_master;
+       /* check event_sync_dup_count() for the use of dup_base_* */
+       u64                             dup_base_count;
+       u64                             dup_base_child_count;
+       /* when this event is master,  read from master*count */
+       local64_t                       master_count;
+       atomic64_t                      master_child_count;
+       int                             dup_active_count;
+
        /*
         * These are the total time in nanoseconds that the event
         * has been enabled (i.e. eligible to run, and the task has

?

>=20
>> +
>> +	master =3D event->dup_master;
>> +
>> +	if (!master->dup_active_count) {
>> +		ret =3D event->pmu->add(master, PERF_EF_START);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (master !=3D event)
>> +			perf_event_set_state(master, PERF_EVENT_STATE_ENABLED);
>> +	}
>> +
>> +	master->dup_active_count++;
>> +	master->pmu->read(master);
>> +	event->dup_base_count =3D local64_read(&master->count);
>> +	event->dup_base_child_count =3D atomic64_read(&master->child_count);
>> +	return 0;
>> +}
>=20
>> +/* PMU sharing aware version of event->pmu->del() */
>> +static void event_pmu_del(struct perf_event *event,
>> +			  struct perf_event_context *ctx)
>> +{
>> +	struct perf_event *master;
>> +
>> +	if (event->dup_master =3D=3D NULL) {
>> +		event->pmu->del(event, 0);
>> +		return;
>> +	}
>=20
> How about you write it exactly like the add version:
>=20
> 	if (!event->dup_master)
> 		return event->pmu->del(event, 0);
>=20
> ?

Sure, will fix in v9.=20

Thanks,
Song
>=20
>> +
>> +	master =3D event->dup_master;
>> +	event_sync_dup_count(event, master);
>> +	if (--master->dup_active_count =3D=3D 0) {
>> +		event->pmu->del(master, 0);
>> +		perf_event_set_state(master, PERF_EVENT_STATE_INACTIVE);
>> +	} else if (master =3D=3D event) {
>> +		perf_event_set_state(master, PERF_EVENT_STATE_ENABLED);
>> +	}
>> +}
>> +
>> +/* PMU sharing aware version of event->pmu->read() */
>> +static void event_pmu_read(struct perf_event *event)
>> +{
>> +	if (event->dup_master =3D=3D NULL) {
>> +		event->pmu->read(event);
>> +		return;
>> +	}
>=20
> And here too.
>=20
>> +	event_sync_dup_count(event, event->dup_master);
>> +}

