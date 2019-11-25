Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DFAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ADA207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="O5Jz/u1w";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="H5FtRgdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKYJkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:40:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6200 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727052AbfKYJkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:40:13 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAP9dtdN023248;
        Mon, 25 Nov 2019 01:39:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=o/DFQoeRJ7BUy0Ru+vCmyoHQfheeSCE9ajod8mUIwYw=;
 b=O5Jz/u1wnCUYNG04kXeNc42vfF3r45GN/r7ICvzK2N9ll3sVCewebrMawE6kjMj0NyIB
 MbHfoz+Qo7GZnZw8cq4UUpoTxZRi2enmPWh9IFPqQDQIJpZhesNnisfWnfQ2Pv2umN9M
 CrLSIMXcjWQkJ7izZz/BN+TCK6yb3fYE+PQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wfnds4rps-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Nov 2019 01:39:59 -0800
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 25 Nov 2019 01:39:51 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 25 Nov 2019 01:39:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkLWB0CgdGulLWxe6US0ZTkY6GxqtaxPvIuVgui2SL4kQfjBFTrZoy8d3HHbB7S9wtPP8Dp5xSMqax88fj0u7WAn2vdJBKuRCfz7NskvcQiVhbYmiYdLHQnxSaFDFJKjLJtE4RW0RwXJYQ23TM2OcQiRRMHRDVePA7I7MTq2fQK0awl79PF+BfzOmx/hg2MR4I7o/z6rWgsEdj0M60fasreJLDSH/h43NCjb5lmXSeM/vv3DzIXlGQXjHfU9WhbycZ00i+I+zlt0rn3lIL1uW0nZ/ap2CK/Gq+udZe83xF+r0YCsCNdYt9mCK16/cq+fjSnKdjubaDPrxJvshEh2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/DFQoeRJ7BUy0Ru+vCmyoHQfheeSCE9ajod8mUIwYw=;
 b=oCZ8WG008P5rG9uGlZeGmolVQ+UWsKOJW/a/Zgc72ZmXir2H5gEllZrOdpzZyBr7ikDKwjS+Pt7pft+5HoihXJ7MvWYv0zyLfGOR/VAdszkM4Bm+EnKfgwDKnxez54Y4inDUw8iihWCps3D4Ngkm2yiV3kTnNav12h8W0R2Q99kAOXyIuRPWRLchnJeZtpybWz8qBR0h8FLWf6j7qpSEA69sgCPaadcRGFXqLX5PsSL1AtDM24BWRp7wgKqTe7/8J2lQ9KdpSnuyBtv7V0Aic/yjXC7YklRjNVnSbKkpoSNmYPKC3XkRz/jdbbotB6QIJJMiBwdc4Y6UsO5YrwsqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/DFQoeRJ7BUy0Ru+vCmyoHQfheeSCE9ajod8mUIwYw=;
 b=H5FtRgdJDJwsIgCJlt/BNbTqNB41WNXuL54mTkntQ6g10gZna4ug+vO16ZogZM77NKDkrLzI93/vbIicqD0aTDxiCPY0T0UsPjqD5RsaPzeqFxcs9M+AvRZyQXwl5RPOEkSQIZTvge2UeKhI4i4MbEgOWWGAVLBxvBrjQDmpd5Q=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1295.namprd15.prod.outlook.com (10.175.2.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Mon, 25 Nov 2019 09:39:50 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 09:39:50 +0000
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
Thread-Index: AQHVnBAlgYxvir4ozkO3bLas1TlApqeXn1+AgAAEk4CABAeEAIAABPiA
Date:   Mon, 25 Nov 2019 09:39:49 +0000
Message-ID: <0906DAE0-52F4-4F58-8912-19A45ADAA189@fb.com>
References: <20191115235504.4034879-1-songliubraving@fb.com>
 <20191122193343.GB2157@krava> <951F0EE1-5DCC-46CA-8891-39A891512CEE@fb.com>
 <20191125092202.GB20575@krava>
In-Reply-To: <20191125092202.GB20575@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::b32d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9578a775-e436-4444-bd91-08d7718b6ac3
x-ms-traffictypediagnostic: MWHPR15MB1295:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB12955E195F24EDEFA64B9893B34A0@MWHPR15MB1295.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(136003)(39860400002)(376002)(189003)(199004)(51914003)(76116006)(66946007)(54906003)(36756003)(2906002)(6436002)(6116002)(66476007)(50226002)(14454004)(86362001)(446003)(25786009)(33656002)(11346002)(102836004)(4326008)(46003)(81156014)(256004)(6486002)(305945005)(8676002)(186003)(7736002)(478600001)(2616005)(6916009)(6512007)(229853002)(81166006)(99286004)(8936002)(6246003)(5660300002)(316002)(66446008)(64756008)(66556008)(71190400001)(71200400001)(76176011)(6506007)(53546011)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1295;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/3jgDjNKiZ/3E5q/xHVlxKqwFf+FkZOXOUhHExgY4YV/I4UuyCtJHUZUTSVYugb0RIC4MFhlEzU2VcBRTiqTZP6GpSe4p2HTHcrNde7SZzX8HRsl5bPqQ0rlh62qu4Rpf+HjtKBtoixtKXlkZltrzmcnHPeAbJIvs0GFvUZ9WrkcIcbG3ORcsokpoSWqK5xeqWgezoiKB3fjShfZf6UO8dStRzoeom8p34Q3O+cgGzI04R76E76Gx9EwixiRFLUXQTDnxApfc7OuAGh7zk+b1WcLgQ27/QW+GT97gXv/MONWSsrp+ku16ib1Te3uTic7n3BEeSiwnBxd4qUXHwsP893/DTyzZj8FZLr6yCoxFKRoGEIZjagO4Am8TOz4tsLTEp1xyoKIkyJQIPoCBD5Pzy/6f3fk5dpw70d47962gTh8WWYA1vWEGGNQwNCVyuG
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7616E1034323CB47A2528834F8E47B31@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9578a775-e436-4444-bd91-08d7718b6ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 09:39:50.0221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMPEN7uvcrpG8F6yQiefbc4+XSl4QBNeOP5tYZRw/f39sT4nWPAm9gHRW+sM5qMfEQQ5Egfwf0Ru5zkBqXUHAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1295
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_02:2019-11-21,2019-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911250089
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 24, 2019, at 11:22 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Fri, Nov 22, 2019 at 07:50:06PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Nov 22, 2019, at 11:33 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>>=20
>>> On Fri, Nov 15, 2019 at 03:55:04PM -0800, Song Liu wrote:
>>>> This patch tries to enable PMU sharing. When multiple perf_events are
>>>> counting the same metric, they can share the hardware PMU counter. We
>>>> call these events as "compatible events".
>>>>=20
>>>> The PMU sharing are limited to events within the same perf_event_conte=
xt
>>>> (ctx). When a event is installed or enabled, search the ctx for compat=
ible
>>>> events. This is implemented in perf_event_setup_dup(). One of these
>>>> compatible events are picked as the master (stored in event->dup_maste=
r).
>>>> Similarly, when the event is removed or disabled, perf_event_remove_du=
p()
>>>> is used to clean up sharing.
>>>>=20
>>>> A new state PERF_EVENT_STATE_ENABLED is introduced for the master even=
t.
>>>> This state is used when the slave event is ACTIVE, but the master even=
t
>>>> is not.
>>>>=20
>>>> On the critical paths (add, del read), sharing PMU counters doesn't
>>>> increase the complexity. Helper functions event_pmu_[add|del|read]() a=
re
>>>> introduced to cover these cases. All these functions have O(1) time
>>>> complexity.
>>>>=20
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>>> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>>> Cc: Tejun Heo <tj@kernel.org>
>>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>>>=20
>>>> ---
>>>> Changes in v7:
>>>> Major rewrite to avoid allocating extra master event.
>>>=20
>>> hi,
>>> what is this based on? I can't apply it on tip/master:
>>>=20
>>> 	Applying: perf: Sharing PMU counters across compatible events
>>> 	error: patch failed: include/linux/perf_event.h:722
>>> 	error: include/linux/perf_event.h: patch does not apply
>>> 	Patch failed at 0001 perf: Sharing PMU counters across compatible even=
ts
>>> 	hint: Use 'git am --show-current-patch' to see the failed patch
>>> 	When you have resolved this problem, run "git am --continue".
>>> 	If you prefer to skip this patch, run "git am --skip" instead.
>>> 	To restore the original branch and stop patching, run "git am --abort"=
.
>>=20
>=20
> hi,
> I'm getting warning below when running 'perf test',
> not sure what's the reason yet..

Thanks for the heads-up. I will try to look into it. I am on vacation this=
=20
week, so please expect some delay.=20

Best,
Song




