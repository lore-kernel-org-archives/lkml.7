Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC6AC2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC0921D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gBL6QNPe";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="adk9FaGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgABSr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 13:47:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10602 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727951AbgABSr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 13:47:26 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 002IZ2Yv027034;
        Thu, 2 Jan 2020 10:46:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=aPb/q2355WgLWZdeTqvrApQYnk1OWCFPW+xteaAtqfs=;
 b=gBL6QNPearzCphoJPeuvzfoaK0H804bUpZOh8eg/PI/F05o+WHdXrTkI1ZKPAdd7OWNL
 Anf8ZVp0eLhNAZaRHW+O9MdPUuA50HAq9uax6EUfc9qhA0wSYJN2YzoDiXS6tMz1Kj3a
 SVfEMwfsuwinxbHsUleT8UqGHdWNn7P3rAM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2x9bucj7mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 02 Jan 2020 10:46:14 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 2 Jan 2020 10:46:12 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 2 Jan 2020 10:46:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fn4N6GbbbU97yRAgjMc0wrIWALqA7i/+E0/7hMUqlDnfX22iVCwRG13Tv+7sKs47ktRWIWZR2c6/26W5jh36yguf+HfmoRE7SytumRzqSMMSCko5Eg3nJJmiAWeY2ROP6Nx8pKrcX8SlpWlHDWAZtEm4nNoQpJLa4iwO3O5z9F2zWnfrJiQWqptUt7SbaTOuDpbML7PKxq4mmu77iZrpABcRowGIq4o2ESnzM/KGmitcg+bPiHX3IvMzuWZPQqEts+Nk/UAWsQ/NBoVKXH0Rj8bfydhjEIVfuFmg7D4BO5RtEnzCk80frG4FNJWEvNx7QPEUq8bVC1W+JEpvYIj/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPb/q2355WgLWZdeTqvrApQYnk1OWCFPW+xteaAtqfs=;
 b=FbF2npUy8bXWQxt8erCDXEVdolAgajKMVY2+uy7x1nc/3lcvp6MATCfCECi7vSmH+b22+SDA0prpZIDZZvP43OU/S0MTSEEEl8HjEFQhueiswb7oO1WokCc06GuOWuJa03k32rgVlzwcyBcKrHZGPO+4tbKL/kPhVZ2G0K8RdgMS/8mw2oCk4+HFXMa06Eh6W7aaMksjIS+c7CDkJBQFaPAgbfuyG/A3VWHsRWRxT0pUYeVfg1roLNuqn78tnfmwDbtvPgnPUg6oqmvHZGDgHxOV0MbO14O4PYAmOgTaurqqR36LvejecjtftJO03ecZadYbjcU5Er+pNAoWSGuNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPb/q2355WgLWZdeTqvrApQYnk1OWCFPW+xteaAtqfs=;
 b=adk9FaGlHCAxBsf5g+ay3aFkraq/Dj0zd0jwvr8es0itgFvJ3AZcINdvj2MGObu3z8b4C7NVgNMct1huBoCKR/74HVp8PLb1SwISqwOzyv6RqULXd+9aK2iLj1V8chh4MfpxfcgC+8Xs3eV2venfCZEh7p4SCgTzR2uVXCgKFUA=
Received: from BYAPR15MB3029.namprd15.prod.outlook.com (20.178.238.208) by
 BYAPR15MB2949.namprd15.prod.outlook.com (20.178.237.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Thu, 2 Jan 2020 18:45:57 +0000
Received: from BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d]) by BYAPR15MB3029.namprd15.prod.outlook.com
 ([fe80::3541:85d8:c4c8:760d%3]) with mapi id 15.20.2602.012; Thu, 2 Jan 2020
 18:45:57 +0000
From:   Song Liu <songliubraving@fb.com>
To:     open list <linux-kernel@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v9] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v9] perf: Sharing PMU counters across compatible events
Thread-Index: AQHVtQPKZjAIrpT67EGLkBjlWidLzafXz7WA
Date:   Thu, 2 Jan 2020 18:45:57 +0000
Message-ID: <856C187D-56B4-49D8-9716-79900DD80246@fb.com>
References: <20191217175948.3298747-1-songliubraving@fb.com>
In-Reply-To: <20191217175948.3298747-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::af49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dddd2585-0cec-4077-07c1-08d78fb40178
x-ms-traffictypediagnostic: BYAPR15MB2949:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2949A908999A361ABBD3B3A0B3200@BYAPR15MB2949.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(376002)(136003)(396003)(189003)(199004)(33656002)(478600001)(4326008)(5660300002)(53546011)(8936002)(64756008)(66556008)(66476007)(316002)(2906002)(66446008)(54906003)(2616005)(186003)(86362001)(6486002)(81156014)(36756003)(6512007)(81166006)(6506007)(6916009)(66946007)(76116006)(91956017)(71200400001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2949;H:BYAPR15MB3029.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LB+9DVNClgOcr9IzmFi7A4dDwnc3fLZBc5djuIaOsC2gnUC16m85iWZ3LdsLXtUip5vKXVajf6zmJlHQM9t9OAGZPTsfOPQkUberB16Hn9SR7mK1ctoj76Hw44bCzyMqP+PCxCBPZ5Zgjpt5dYh6VKLHqXNvbtlQIwJ90vr13+NUTal/ctJLwYw26zguq4+XnyCHMmWgi90/BhQse0L7N1BrhaVaHmAwBfPaaSmYsW06ggkb21kAlsoWydTmnAxIUkfwm+t8Z9U0/2zFbTkuxDiCwg2DA3hk3YX3Yt9yBcWN2mKF0jz2DkXTlwrPkumWZJcvuCl9WnSpkMou7ENH3L8re6ep7hb9RGREV9QODe9nmq74hUVEUFrcWajs8GTSGSsiM3NEKVlpDEzADiHy8e2l5kv+rwpZec7psVk5dfQxooLRXYLOYzvnbAO6Ssxj
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B241F3F109B4D3499C78382A94D9A32C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dddd2585-0cec-4077-07c1-08d78fb40178
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 18:45:57.6743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVnaOzRrY++qkAKy1R2kPICqXCbAG6nyY7NqhnhfThzLHOFUDzd0MD7dxq7MqF90nz4jR2sD6fsGrOi3Di9eng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2949
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_06:2020-01-02,2020-01-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=923 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001020154
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,=20

> On Dec 17, 2019, at 9:59 AM, Song Liu <songliubraving@fb.com> wrote:
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
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Happy New Year! Wish you a great 2020!

Could you please share feedbacks on this version?=20

Thanks,
Song

