Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A915EC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C2D20656
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XCC5jYlp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QREseIEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbfKERL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 12:11:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48566 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728734AbfKERL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:11:26 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA5H8TJ8008426;
        Tue, 5 Nov 2019 09:11:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=sFHvR/RgGYuxGvCuJDbs5wHGwdkSgjzbs6NdZNkcXFY=;
 b=XCC5jYlpsGUnPqKykG0KNZLmk9DguXbxkHcpJUrsRUENhBOL/CsSUhdxKK74q9haJ2dH
 3LWn/8VAHNGwL/83M9RMGn9ikyLyzVIacy0Yxmeu0jbncEgNJSeAe+5d1cu/SHdvqmnz
 g8X2ual+ZFawfzfLuCTVfqBiYmbbWRnCRVw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2w302aktf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 09:11:12 -0800
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 5 Nov 2019 09:11:11 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 5 Nov 2019 09:11:10 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 5 Nov 2019 09:11:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKAPIlimT8M6CvokJZpkQmysyB4wZ5J1OiRT++yaHXSQiLhDc2O3UOiMJDoh+LIoZDHeYqF2VJ8mO50sVxSkvDnaeHTGk65GHk6AwHgR3ufzwEx2otCN0GeT1HTNNiz/g/+Jkd3y1L4U5rRP424wlvL4k4dyp77b+xB0UtTZq0yFZhDVOz1TF1ICJ2KdcJfFbtKbvCJqqrf4LBv9SlSJ+E/jNL2K2dz09Fkits9pw5HWYl1QxE9L9BzwAn05Au4GaQUC+PtGcihFTSdUFuk/15NIfLwXIBfKtBlAyVO1MJKZlWK994PJ1vbNbAbk6VDWE1jzMP+n9iTHpIozUAtpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFHvR/RgGYuxGvCuJDbs5wHGwdkSgjzbs6NdZNkcXFY=;
 b=bzcfppFxyj6mdFDk9H1PdJ7x/emAUiz2ZhJalIq1v8oWdblPTITDhN9QrL35r5Vxo4hKosbn2TTIPTQCKVgJbWnsXYf4j+5pVKcg2GSX3EKwAS9o8V+CgotNCBfLHdTFTpGecpPmFBxcoqdTS3VVMqvr/RAyt4t+S/bbc87xrGAgTKM8Jt4nsKpcoCDCQf5ZviZ3yfRPmPhhvlCnFt1QwbELIft3ZIr5EHQ8quNsD6qCDEhg+/fWeqZlZOi74EAXXxbLg+M+CXVoOc5mrkuo9s+t2BTtnXLo0yn4ykWWVDUv9N9A7Qhk5rHfaXz7FynOGx+/zF+pfovahmC61hLZUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFHvR/RgGYuxGvCuJDbs5wHGwdkSgjzbs6NdZNkcXFY=;
 b=QREseIEKI7YsYYuVNMlwcZygsiYi9YlOsQdJxxauys+Dtr3g8v6Qu96QmqJnn63OovN00jWHXgbTQtRwQr7xArPDQBl5rG4kz2NU75nxmuoi1AC+hf7NhKcQWXL5pPzbVbvUd1/HD3EhJY+LVzNabwx/VpBMMih4pTEk53FzScI=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1390.namprd15.prod.outlook.com (10.173.231.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 17:11:08 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2430.020; Tue, 5 Nov 2019
 17:11:08 +0000
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
Thread-Index: AQHVbqpjjWjaDbp/ikSYoLFTNk8qM6d09EYAgAA/EQCAB+dbAA==
Date:   Tue, 5 Nov 2019 17:11:08 +0000
Message-ID: <98A6264C-B833-4930-95A0-2A3186519D87@fb.com>
References: <20190919052314.2925604-1-songliubraving@fb.com>
 <20191031124332.GQ4131@hirez.programming.kicks-ass.net>
 <19AE6C78-C54C-4C37-BBD2-0396BB97A474@fb.com>
In-Reply-To: <19AE6C78-C54C-4C37-BBD2-0396BB97A474@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:200::de21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c055f0bf-5815-436d-547e-08d7621326ac
x-ms-traffictypediagnostic: MWHPR15MB1390:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB139043FF779453BB0553A2C1B37E0@MWHPR15MB1390.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(189003)(6246003)(14454004)(81156014)(8936002)(8676002)(81166006)(71190400001)(71200400001)(2616005)(86362001)(76116006)(66946007)(66476007)(66556008)(476003)(11346002)(446003)(64756008)(66446008)(33656002)(486006)(36756003)(305945005)(53546011)(46003)(186003)(6506007)(76176011)(54906003)(102836004)(316002)(6436002)(6116002)(229853002)(7736002)(6512007)(6486002)(2906002)(25786009)(478600001)(99286004)(50226002)(4326008)(5660300002)(256004)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1390;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kVMegJ4DfPn6QPU6PMLISXl5Eog7dm3uF6GwbFIqKaZQOOK6x5d8lJh8A74nqDrK2XJNB0/RFmTKTACIld4p0/tVfhDRZE8UCF/G9oGpL8QVG7DWBjsVvVmpQmkNSmc/sxBa4HCAhohUG79ayNaxkedpHAVL5CnqizQiLzcWOUuncNHxnQvtkQknjLUm79b5CUVSRcbbz9n1JvwkHKsaJxgYptBLoKGrq9nTp0VnB22Xi6EwTDveVozPLmSVM2DdYexrGPbDsfLDIbJhYwv9T8osdbBaoIxA6yRm/v71apsIKFquxQcpqh6xGI+X+CnEE5OPHYjOCj8BFEt2fZ87pqQ1f9DE1QKieO0aeE36TeHXnUxxmLWJvlnhOvASG+uP32jbPS/zmScCLNAmuT79TAbNh88DDjyIS24M7rWu9Y6j4pbygsuieU62ME6DY8nU
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29589CE947DF3E43AB034DA13180DCDF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c055f0bf-5815-436d-547e-08d7621326ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 17:11:08.7833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P65pA6Rdlbh/DvymrGDPtRNGrCllr70JqekLX9QoVdRO620C7GlHQjQSi85fG/MVtwebdAOM7QSF7PmVs3g31g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1390
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_06:2019-11-05,2019-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 mlxlogscore=720
 adultscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1911050142
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Peter,=20

> On Oct 31, 2019, at 9:29 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
>> On Oct 31, 2019, at 5:43 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>>=20
>> On Wed, Sep 18, 2019 at 10:23:14PM -0700, Song Liu wrote:
>>> This patch tries to enable PMU sharing. To make perf event scheduling
>>> fast, we use special data structures.
>>>=20
>>> An array of "struct perf_event_dup" is added to the perf_event_context,
>>> to remember all the duplicated events under this ctx. All the events
>>> under this ctx has a "dup_id" pointing to its perf_event_dup. Compatibl=
e
>>> events under the same ctx share the same perf_event_dup. The following
>>> figure shows a simplified version of the data structure.
>>>=20
>>>     ctx ->  perf_event_dup -> master
>>>                    ^
>>>                    |
>>>        perf_event /|
>>>                    |
>>>        perf_event /
>>>=20
>>> Connection among perf_event and perf_event_dup are built when events ar=
e
>>> added or removed from the ctx. So these are not on the critical path of
>>> schedule or perf_rotate_context().
>>>=20
>>> On the critical paths (add, del read), sharing PMU counters doesn't
>>> increase the complexity. Helper functions event_pmu_[add|del|read]() ar=
e
>>> introduced to cover these cases. All these functions have O(1) time
>>> complexity.
>>>=20
>>> We allocate a separate perf_event for perf_event_dup->master. This need=
s
>>> extra attention, because perf_event_alloc() may sleep. To allocate the
>>> master event properly, a new pointer, tmp_master, is added to perf_even=
t.
>>> tmp_master carries a separate perf_event into list_[add|del]_event().
>>> The master event has valid ->ctx and holds ctx->refcount.
>>=20
>> That is realy nasty and expensive, it basically means every !sampling
>> event carries a double allocate.
>>=20
>> Why can't we use one of the actual events as master?
>=20
> I think we can use one of the event as master. We need to be careful when
> the master event is removed, but it should be doable. Let me try.=20

Actually, there is a bigger issue when we use one event as the master: what
shall we do if the master event is not running? Say it is an cgroup event,=
=20
and the cgroup is not running on this cpu. An extra master (and all these
array hacks) help us get O(1) complexity in such scenario.=20

Do you have suggestions on how to solve this problem? Maybe we can keep the=
=20
extra master, and try get rid of the double alloc?=20

Thanks,
Song


