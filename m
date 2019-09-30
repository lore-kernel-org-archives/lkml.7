Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2973C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD1921855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Yup0RoAv";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jaNWuSXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbfI3FhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 01:37:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8138 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbfI3FhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 01:37:23 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8U5S2BC022743;
        Sun, 29 Sep 2019 22:37:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=KPS756U3AoOLQ8fzMxHQDnA2DYy5luBKI1+ypX0wTuk=;
 b=Yup0RoAvgHWcjqAIsrUSrOdJUPLsTZyHA8Xo3gAvW7ZxC6+yIm4WgqrhBGtawHzjdYci
 qt5h8A8/RG7qpcACO+IqPL69DG+tdmxxYEKK7jiy+uAyDv1ftiXZEpZwUNuFjyXWt9PS
 bPxX5GT7hyGmxVaUfgkpRctZzmzyp/wPSX4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vaqu63ueh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 29 Sep 2019 22:37:14 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 29 Sep 2019 22:37:13 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 29 Sep 2019 22:37:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqlVm8kURcrYvRW9EtOZtMfxZrtK541xVZZ45YPrTrMhhAVxIk+cFDDjI/W63P1a3JSIUbqada1pGdV4qvu0OZSiR1Qd9Sszn2m9SaXRldKFlXwrTHBp1N0Rv0AjPZIBSezLc0ktt/jLP4da+vzsk9q2BqIUfrjfqZqvN4kYGRoZUdH4IbxJIIOdegWSJak0rx/up1ELxAUpnZaeLqe4IQ+Jtb5SfTRJEhs9Vn44RpVy/bqkc8RzfsYbuIhYCHihaPual/q+AkBo2p/0eeyKieUomeDRCJJ36AjX52labYiz3eGo5nlS9le0X8ij4WNW3Tncdx8wqc/2uZJo+NEKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPS756U3AoOLQ8fzMxHQDnA2DYy5luBKI1+ypX0wTuk=;
 b=eHCHIBplFrMA60mjG7jrN/JTraSVTAQEwsrxU0dzCZiVrm6aTAvt6ja7P+etEvoROOOJ/IYh0UV/yBuM339D1sPgMdrFxEz0WUG0OYGWMceX8DfbEW9rPm554IlQVsWhGN1F84Hjlb8/CEtz00gp1Nau5+yB07+WJxDz8G8mjny+AstcJFToe5mwqTNA+lpLb+zEGsjbv+SDfgI55t00cEWeTnidWPGA4+5SpaUMEVcieknTWlHNiDhvjJLruqyxs/Vdf3HCudc/qgYev8OYt4VYcmxRjeZERlBMaVHOVSjG0wroakQI3/fBJkTPHVxQZX8e1ta9489v9bwBczd5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPS756U3AoOLQ8fzMxHQDnA2DYy5luBKI1+ypX0wTuk=;
 b=jaNWuSXJmbr27iIpYRnhjUVzhnSthCxWqR3GUMHKWOgLac5zXQ/k8Ww14nVgJksXtZWVVwjmXng0AFimOpsppcljkCDFJ2QPCju85Ejo/3ZNWZLTM6FyawltlTUYbAWrjmXm+rjbf5Os7i/kj+aRZfE0qYyHr6yxEqq+V8smZPE=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1870.namprd15.prod.outlook.com (10.174.96.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 05:36:55 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 05:36:55 +0000
From:   Song Liu <songliubraving@fb.com>
To:     open list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v6] perf: Sharing PMU counters across compatible events
Thread-Topic: [PATCH v6] perf: Sharing PMU counters across compatible events
Thread-Index: AQHVbqpjjWjaDbp/ikSYoLFTNk8qM6dDxM0A
Date:   Mon, 30 Sep 2019 05:36:55 +0000
Message-ID: <9FD34CD1-E8C4-48EE-90EE-F0ACABEE5909@fb.com>
References: <20190919052314.2925604-1-songliubraving@fb.com>
In-Reply-To: <20190919052314.2925604-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::387f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 907e9868-1483-4a9d-c87a-08d745683465
x-ms-traffictypediagnostic: MWHPR15MB1870:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB18706ECFAC1B07B4F5A7F996B3820@MWHPR15MB1870.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(39860400002)(346002)(396003)(189003)(199004)(6116002)(64756008)(2906002)(316002)(54906003)(33656002)(50226002)(8676002)(81156014)(81166006)(110136005)(2616005)(76116006)(66946007)(66476007)(66556008)(66446008)(11346002)(8936002)(478600001)(25786009)(186003)(102836004)(14454004)(53546011)(6506007)(76176011)(99286004)(486006)(476003)(446003)(4326008)(6436002)(229853002)(6486002)(36756003)(86362001)(6246003)(6512007)(5660300002)(7736002)(256004)(305945005)(71200400001)(71190400001)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1870;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2pfNY2uNjhf5EcxE5QieWNhSaVfUzMLweUaxeaRyKphwkbJpcdrs0vSfpoS0igEHA96YjFmnZVsj0pdDTsjTDwyn1vPk+ufyS7vMhvObFXMzb39p8F0UuoE2GKRoHLKfGCnW8YqxkfYwxVICoicccFUOx2rgyHEFgCWSak1kgw7bNTZo8TXEq/Md0XiCDk/M4oDGR8eg9HZIn2hcoDjb5aGaGp1n5wlESf6K8/vx5CIl5K4vaQjeSQOrvGlnUcTlSVE5dhbXjd3xWobs+/WLygbN2gmUi2glpicTCS/XczFVoxVyt1gf9JgFkjLLY7e6DS+Gx1fbHaB3YCvG2hL1fepgLIlAmO9+s0nqtpf8TOK8yQ1BLsxgMhdiVnXdtveuPECcXWztpkUBasGctbrg6JJQgYwPqDPLbbKB93UUlMU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <148FF85624E80F4C9A55B029FE3A8B3F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 907e9868-1483-4a9d-c87a-08d745683465
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 05:36:55.2746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0JKU91G6ukmZ7YJBfP9dfIeR1+y4uZL5QkhL+8JoGpCHzLjMOP17LKLV8D6VWpScyhjRq26Cfvhh0N83rdkPcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1870
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_02:2019-09-25,2019-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=735
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909300057
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> On Sep 18, 2019, at 10:23 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> This patch tries to enable PMU sharing. To make perf event scheduling
> fast, we use special data structures.
>=20
> An array of "struct perf_event_dup" is added to the perf_event_context,
> to remember all the duplicated events under this ctx. All the events
> under this ctx has a "dup_id" pointing to its perf_event_dup. Compatible
> events under the same ctx share the same perf_event_dup. The following
> figure shows a simplified version of the data structure.
>=20
>      ctx ->  perf_event_dup -> master
>                     ^
>                     |
>         perf_event /|
>                     |
>         perf_event /
>=20
> Connection among perf_event and perf_event_dup are built when events are
> added or removed from the ctx. So these are not on the critical path of
> schedule or perf_rotate_context().
>=20
> On the critical paths (add, del read), sharing PMU counters doesn't
> increase the complexity. Helper functions event_pmu_[add|del|read]() are
> introduced to cover these cases. All these functions have O(1) time
> complexity.
>=20
> We allocate a separate perf_event for perf_event_dup->master. This needs
> extra attention, because perf_event_alloc() may sleep. To allocate the
> master event properly, a new pointer, tmp_master, is added to perf_event.
> tmp_master carries a separate perf_event into list_[add|del]_event().
> The master event has valid ->ctx and holds ctx->refcount.
>=20
> Details about the handling of the master event is added to
> include/linux/perf_event.h, before struct perf_event_dup.

Could you please share your comments/suggestions on this work?

Thanks,
Song
