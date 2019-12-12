Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E158CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FAE20637
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GHcP8Zeg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ijunQi1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbfLLPt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:49:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33122 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729152AbfLLPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:49:56 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCFdgAt008140;
        Thu, 12 Dec 2019 07:47:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=IwchZlBGmMRj3WF+9tcP4Yz+t7300rT9FDkdFqoF2KM=;
 b=GHcP8Zeg2baU9e1dGBTNZwixxTLseB9lLX/Nd5gJeRzNn/8wSbWx6r4U+vz9B+q1zC8/
 x1s+hFVNVJiw6/VOmRKsYRDHqFRSIprwm+8YaRkPd+Y9faRVEmg/gidARUso3JC9Q1iT
 lHz2ETcGnYeVcTh3Bu2sdGI6iPFOptqmsbU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wukesscgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 07:47:43 -0800
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 12 Dec 2019 07:47:42 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 12 Dec 2019 07:47:41 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Dec 2019 07:47:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAwX4YMaoDuNdKLka9O7fIEatjaWavj13jAzC4qXcN7FUB7iKDpDJmWkSuFuUIxeVJSEYsnpTA3NAjJirCZpWEa2GZgDb9GUbFpM7Mcvxem49f8WIYhZz32Y/oJgeWXCRsPsKncFKc6SpJB3YlJkf7MEFakE/y+UvDhM+f3RW2aWJDBT08Zd7bBd/czsaZ2YU8LCnG/oIQnK5M9QNDiOEbm6G1y3ZoXFdxyr+i7MAoFQuH/6u90RNKydc/kSPFjBRxi+D8HXf21XHPg1cB3Yaapw9GrYwTyxE/WZ2y5UeMfDeX9obc5sXtQNgTX036veLTmuaPvIAjrEnqutJjkpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwchZlBGmMRj3WF+9tcP4Yz+t7300rT9FDkdFqoF2KM=;
 b=Y7w78q/RhiUQ8CojxktloaGy+ObX5ZkpIc8pythyAmqUeLstjtskiXu0SxdPiSASvwSrsGVFFLtpTsVTMcg1G3wGob5oHUiSW2wGjTYHiCDafNIEOCbo1xzrMOKOvahYh8bQRb9G4MnqzZrk/Q9TCcPE9dnZwbjqd10+gkPm9klmXL7NU76iOwVIrMCwZaKvjC8Ha2CdQi9m6cwWKjFo6fydzc72tgK0FgrWH3Gwp5JgloZKBMMDrMO0l8iFgtkP5XGmaRAmYp08yvpb1kuFCXv/qTXmhQrPINAU21SemjRS2wOXX5PCv4aXgs14Fd6+dWTBZBx8/0b7FopD2yx0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwchZlBGmMRj3WF+9tcP4Yz+t7300rT9FDkdFqoF2KM=;
 b=ijunQi1V+gPlWSFh/STLIXDdegr/PfCGCEKfijXvUrqQtmNv/1LXCZPmzNIkYSVc2XYIm0DIaDtlKVnh45BzB+tqeC8KKhNnjDL9QhB5+psTOszU0pimnmEw1c0zgm4v/sMRTtjauQASy94xaqe1HlXiCzatL9iX7H7sHxiGpsM=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1727.namprd15.prod.outlook.com (10.174.96.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Thu, 12 Dec 2019 15:47:39 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 15:47:39 +0000
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
Thread-Index: AQHVrJTJGmqRAKGiXEWGIEJPQu1yRae2jOOAgAAd9QCAAAIcgIAAANcA
Date:   Thu, 12 Dec 2019 15:47:39 +0000
Message-ID: <15418C90-C6ED-43C1-810B-CE010CD1C84D@fb.com>
References: <20191207002447.2976319-1-songliubraving@fb.com>
 <20191212134951.GX2844@hirez.programming.kicks-ass.net>
 <5D5BC3C8-427D-4983-AAEB-0E8001751BA0@fb.com>
 <20191212154437.GC2827@hirez.programming.kicks-ass.net>
In-Reply-To: <20191212154437.GC2827@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::d1f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89e28bd5-3604-411b-6a75-08d77f1a9dfa
x-ms-traffictypediagnostic: MWHPR15MB1727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1727D05391A85150285713E0B3550@MWHPR15MB1727.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(376002)(39860400002)(346002)(199004)(189003)(33656002)(316002)(2906002)(86362001)(36756003)(54906003)(4326008)(66946007)(66446008)(64756008)(66476007)(66556008)(6512007)(81166006)(8676002)(76116006)(5660300002)(71200400001)(6916009)(2616005)(81156014)(8936002)(6486002)(53546011)(186003)(478600001)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1727;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yaVDjYWwiievcHthY5B937RblHYxF5pV98kxDeP7DWmVE0FI18YpPTZczFGvrY2+stbTFPJNnZISwnf/7AI4A66fO2xrIN94/9lAnSlyXVbS0OotCKC1uJKmtWIPOFMNrXdvpoFOnWA7CxWWmhPccE+nipazE/bH0zH76haQMI6fcMyLHLMyF1SonQUYIgKpP07JVjT3AlbpRHUsbFlMl+p0ZVTdVejjt+qQCWwMjfOd0DAfrpvfYHhIVb4vzdCRZPnMZwDFT7QmOABmWp2pGbH5M8M3jP3Jh3hApe3ETA6SLctp9LsOZqUCWJkyQ4h83enRXqC+NTWpiBNegMcS+4gLu7QfEI/LC8pT/w87JNHxbHvGVazqeHfaE+XRUx3IjFdFfwyp70ZXcY9yG4GRuUQdyKk+p1lSfKBtzSHNbtRsBNxcHNmltEFZXm4x5Efq
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1E8A82591426B4E8641F25071629327@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e28bd5-3604-411b-6a75-08d77f1a9dfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 15:47:39.0396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15Nh9T3gQE/2nG6ibGhbsCGjoTNB5fWrP56CoL2yWOHujU6IXYoLRmqon1dtg+FhTAkeQOOx5rUorL5IpsL0hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1727
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_03:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120122
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 12, 2019, at 7:44 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Thu, Dec 12, 2019 at 03:37:05PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Dec 12, 2019, at 5:49 AM, Peter Zijlstra <peterz@infradead.org> wrot=
e:
>>>=20
>>> On Fri, Dec 06, 2019 at 04:24:47PM -0800, Song Liu wrote:
>>>=20
>>>> @@ -750,6 +752,16 @@ struct perf_event {
>>>> 	void *security;
>>>> #endif
>>>> 	struct list_head		sb_list;
>>>> +
>>>> +	/* for PMU sharing */
>>>> +	struct perf_event		*dup_master;
>>>> +	/* check event_sync_dup_count() for the use of dup_base_* */
>>>> +	u64				dup_base_count;
>>>> +	u64				dup_base_child_count;
>>>> +	/* when this event is master,  read from master*count */
>>>> +	local64_t			master_count;
>>>> +	atomic64_t			master_child_count;
>>>> +	int				dup_active_count;
>>>> #endif /* CONFIG_PERF_EVENTS */
>>>> };
>>>=20
>>>> +/* PMU sharing aware version of event->pmu->add() */
>>>> +static int event_pmu_add(struct perf_event *event,
>>>> +			 struct perf_event_context *ctx)
>>>> +{
>>>> +	struct perf_event *master;
>>>> +	int ret;
>>>> +
>>>> +	/* no sharing, just do event->pmu->add() */
>>>> +	if (!event->dup_master)
>>>> +		return event->pmu->add(event, PERF_EF_START);
>>>=20
>>> Possibly we should look at the location of perf_event::dup_master to be
>>> in a hot cacheline. Because I'm thinking you just added a guaranteed
>>> miss here.
>>=20
>> I am not quite sure the best location for these. How about:
>>=20
>> diff --git i/include/linux/perf_event.h w/include/linux/perf_event.h
>> index 7d49f9251621..218cc7f75775 100644
>> --- i/include/linux/perf_event.h
>> +++ w/include/linux/perf_event.h
>> @@ -643,6 +643,16 @@ struct perf_event {
>>        local64_t                       count;
>>        atomic64_t                      child_count;
>>=20
>> +       /* for PMU sharing */
>> +       struct perf_event               *dup_master;
>> +       /* check event_sync_dup_count() for the use of dup_base_* */
>> +       u64                             dup_base_count;
>> +       u64                             dup_base_child_count;
>> +       /* when this event is master,  read from master*count */
>> +       local64_t                       master_count;
>> +       atomic64_t                      master_child_count;
>> +       int                             dup_active_count;
>> +
>>        /*
>>         * These are the total time in nanoseconds that the event
>>         * has been enabled (i.e. eligible to run, and the task has
>=20
> Ah, no. Only put dup_master somewhere hot. The rest is not that
> important. For instance, you can put it right next to event->pmu,
> because that's going to be used right next to it, right?

I see. Will fix in that way.=20

Thanks,
Song

