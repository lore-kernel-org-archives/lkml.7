Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18334CA9EA2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE60621925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="M92wgYAE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="T7xkdP5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407629AbfJRGOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:14:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44320 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392014AbfJRGOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:14:08 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I6Diru021074;
        Thu, 17 Oct 2019 23:13:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jvyVMO+0uSnVa1UKart2N89mdDYaouahIMCL8wAnrMI=;
 b=M92wgYAEcPLeUmDOnjNimap1lavdNlfH2NubTPFX969bqRcIaQwD5OEXx12bKKI+xcr7
 EN4g2NaC+7KDPxuL+bX63/Uh3o7HjiIe2BckulFk9rBnJbg/2mG3qAK5TKFKPWRSIg2Z
 v5auFWa/DJmo0Ju2TVfWyiiliL/vF8pF3uA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpsd6btma-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 23:13:45 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 17 Oct 2019 23:13:22 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 17 Oct 2019 23:13:22 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 17 Oct 2019 23:13:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9xqaAKPJfsGeoMKujTWaiBCH3xrXk37HswehWoYXvf1fR2Wnp/BO8y8l65xgWMYlWzYzRN+jnxu4TNYGgewg7QS0y20L5h8CFi8nzFECJWhnKo/EjUxyT9U+rmn0341ey2SHSlagOimfbAU+bGub3d3naruZgM7bK7A6mZpKpkRqkNmh55174pVXwBaQJulMdTascQQF4uhg+N444KqCIDUkFKyeaUbsUImxI2KJpFiqXhDaCnARqPR69NXEk46/2ZcJG1IIOGpF2XFGxWxRN2MXXnWdfAfV7PO3GCdRd4OCbfdW9S9ybwHZmSale54BWzPRyMAmxsvCnW9D8Z/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvyVMO+0uSnVa1UKart2N89mdDYaouahIMCL8wAnrMI=;
 b=BzDQeNE0/oulnk5r6tO+LnMgUq03DFlaVSqDY2s9/HTgPREBJgvLHDCxAMo8WVXtuMu8q8FMvPtS92ip5cZk+mN9H2UI9TajoWM5glK9f1TP3axJtaSC00o5+BH1wVz0Tc+hnOcCUUwXJYJ4oeobUWeG4ygIn5A4EJdk15bW8BsajdY7rSZ71A5SJIUHBZ1Ytv5gtxBZXwg+ls7fFzBQugC6PxXKw4x3+1kCmyLUHfbDsVxggXT3TlnojHSD+709j+hvPionurfCYZXBO0r+Nph+B1iEeqvzBV2sjAUOqk8QB7AgEOI/+YhcScDlDUUsoTJUra0bmBqc74hl1mgHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvyVMO+0uSnVa1UKart2N89mdDYaouahIMCL8wAnrMI=;
 b=T7xkdP5+Ezs7Zf5JVqw4JUUiWX6Jhyyh2It4Wyyve71lh/oyCZeMtcn9UnDyeitom+uOn+OTtCuwS0V+NUGawRJxsmAHCy2+HFrCYlchn9z9WZqySj4lsBct/tXTF9PmIpG4+lDrps08YXPo/AZyYTibys+AAaBVD2YiLekOv+Q=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.215.141) by
 DM5PR15MB1770.namprd15.prod.outlook.com (10.174.247.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 06:13:21 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::fd80:2c41:5666:8e67]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::fd80:2c41:5666:8e67%11]) with mapi id 15.20.2347.024; Fri, 18 Oct
 2019 06:13:21 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Stephane Eranian <eranian@google.com>
CC:     open list <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@elte.hu" <mingo@elte.hu>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "kan.liang@intel.com" <kan.liang@intel.com>,
        "irogers@google.com" <irogers@google.com>
Subject: Re: [PATCH] perf/core: fix multiplexing event scheduling issue
Thread-Topic: [PATCH] perf/core: fix multiplexing event scheduling issue
Thread-Index: AQHVhUsMoVyDSFs26kucCFo0fCE/0adf67AA
Date:   Fri, 18 Oct 2019 06:13:21 +0000
Message-ID: <7B6B74DF-53E0-42DA-97D6-3F04E84D688B@fb.com>
References: <20191018002746.149200-1-eranian@google.com>
In-Reply-To: <20191018002746.149200-1-eranian@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:180::37f8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87725262-e7b1-4d98-5ded-08d7539246c4
x-ms-traffictypediagnostic: DM5PR15MB1770:
x-microsoft-antispam-prvs: <DM5PR15MB17705985587FE8D38F41F035B36C0@DM5PR15MB1770.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(189003)(199004)(36756003)(33656002)(5660300002)(8676002)(46003)(14454004)(446003)(11346002)(81166006)(81156014)(71190400001)(4326008)(6116002)(6436002)(53546011)(6506007)(102836004)(99286004)(486006)(6512007)(2616005)(76176011)(186003)(6246003)(476003)(8936002)(50226002)(6916009)(66476007)(305945005)(7736002)(86362001)(64756008)(66946007)(71200400001)(76116006)(66556008)(2906002)(316002)(229853002)(25786009)(478600001)(54906003)(6486002)(14444005)(256004)(66446008)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1770;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R2ImW8H78jvyrtcw99vDxaHuEfGKTAo2hoC8LjVGGXA+QN92Gd+D6NzUqNy1yOSFr1RVIUFzH8hBWLPQ5qgF/Mb2kbLRbAvHPNkc77+ZV0PiCa5HmeBe1j5T3NxXZfE12aBnEMER7cfR5x+XlskEO7RkXQ0h8T0Uv7RUMxjuQn9mITfBSUVjyMnPbnWXFndscu8ysHcsmP/Z8J5WgBRbpXFJ1oIAVq0/cjitCMQRPLcI7TwTUwg8GsY7cYXbCHrUpqzgUNp6NV2XuRyJv/owNV5bWhaUe1ofCw6+LbXfa9xfvAbLeScprNNCWfAuBX1PAREyKKAjVvJKN575azxqwJDzy4cb2K4YhFawh2VjgXF3zoWGLmc2Yu7u/XAyRRQWo6o96yck7nr9+ihkMyVQMiGXe+BpLDj9SP24etF9HtA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3BD5F9E019BD74EB5D6C995E5ACD1D1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 87725262-e7b1-4d98-5ded-08d7539246c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 06:13:21.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJcbt3XuKlKz3vhwzeHXORnQjLI3SnSb1BwcXtcHYaHnPODrI+260CLVR39vrEDdX0uktiwYNF3AVwKKhKS27A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1770
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-18_01:2019-10-17,2019-10-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 clxscore=1011 phishscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910180060
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 17, 2019, at 5:27 PM, Stephane Eranian <eranian@google.com> wrote:
>=20
> This patch complements the following commit:
> 7fa343b7fdc4 ("perf/core: Fix corner case in perf_rotate_context()")
>=20
> The fix from Song addresses the consequences of the problem but
> not the cause. This patch fixes the causes and can sit on top of
> Song's patch.
>=20
> This patch fixes a scheduling problem in the core functions of
> perf_events. Under certain conditions, some events would not be
> scheduled even though many counters would be available. This
> is related to multiplexing and is architecture agnostic and
> PMU agnostic (i.e., core or uncore).
>=20
> This problem can easily be reproduced when you have two perf
> stat sessions. The first session does not cause multiplexing,
> let's say it is measuring 1 event, E1. While it is measuring,
> a second session starts and causes multiplexing. Let's say it
> adds 6 events, B1-B6. Now, 7 events compete and are multiplexed.
> When the second session terminates, all 6 (B1-B6) events are
> removed. Normally, you'd expect the E1 event to continue to run
> with no multiplexing. However, the problem is that depending on
> the state Of E1 when B1-B6 are removed, it may never be scheduled
> again. If E1 was inactive at the time of removal, despite the
> multiplexing hrtimer still firing, it will not find any active
> events and will not try to reschedule. This is what Song's patch
> fixes. It forces the multiplexing code to consider non-active events.

Good analysis! I kinda knew the example I had (with pinned event)
was not the only way to trigger this issue. But I didn't think=20
about event remove path.=20

> However, the cause is not addressed. The kernel should not rely on
> the multiplexing hrtimer to unblock inactive events. That timer
> can have abitrary duration in the milliseconds. Until the timer
> fires, counters are available, but no measurable events are using
> them. We do not want to introduce blind spots of arbitrary durations.
>=20
> This patch addresses the cause of the problem, by checking that,
> when an event is disabled or removed and the context was multiplexing
> events, inactive events gets immediately a chance to be scheduled by
> calling ctx_resched(). The rescheduling is done on  event of equal
> or lower priority types.  With that in place, as soon as a counter
> is freed, schedulable inactive events may run, thereby eliminating
> a blind spot.
>=20
> This can be illustrated as follows using Skylake uncore CHA here:
>=20
> $ perf stat --no-merge -a -I 1000 -C 28 -e uncore_cha_0/event=3D0x0/
>    42.007856531      2,000,291,322      uncore_cha_0/event=3D0x0/
>    43.008062166      2,000,399,526      uncore_cha_0/event=3D0x0/
>    44.008293244      2,000,473,720      uncore_cha_0/event=3D0x0/
>    45.008501847      2,000,423,420      uncore_cha_0/event=3D0x0/
>    46.008706558      2,000,411,132      uncore_cha_0/event=3D0x0/
>    47.008928543      2,000,441,660      uncore_cha_0/event=3D0x0/
>=20
> Adding second sessiont with 4 events for 4s
>=20
> $ perf stat -a -I 1000 -C 28 --no-merge -e uncore_cha_0/event=3D0x0/,unco=
re_cha_0/event=3D0x0/,uncore_cha_0/event=3D0x0/,uncore_cha_0/event=3D0x0/ s=
leep 4
>    48.009114643      1,983,129,830      uncore_cha_0/event=3D0x0/        =
                               (99.71%)
>    49.009279616      1,976,067,751      uncore_cha_0/event=3D0x0/        =
                               (99.30%)
>    50.009428660      1,974,448,006      uncore_cha_0/event=3D0x0/        =
                               (98.92%)
>    51.009524309      1,973,083,237      uncore_cha_0/event=3D0x0/        =
                               (98.55%)
>    52.009673467      1,972,097,678      uncore_cha_0/event=3D0x0/        =
                               (97.11%)
>=20
> End of 4s, second session is removed. But the first event does not schedu=
le and never will
> unless new events force multiplexing again.
>=20
>    53.009815999      <not counted>      uncore_cha_0/event=3D0x0/        =
                               (95.28%)
>    54.009961809      <not counted>      uncore_cha_0/event=3D0x0/        =
                               (93.52%)
>    55.010110972      <not counted>      uncore_cha_0/event=3D0x0/        =
                               (91.82%)
>    56.010217579      <not counted>      uncore_cha_0/event=3D0x0/        =
                               (90.18%)

Does this still happen after my patch? I was not able to repro this.=20

> Signed-off-by: Stephane Eranian <eranian@google.com>

Maybe add:
Fixes: 8d5bce0c37fa ("perf/core: Optimize perf_rotate_context() event sched=
uling")

Thanks,
Song=
