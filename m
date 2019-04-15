Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55823C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103822077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lKiG0NU7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iaQh6zZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfDOQt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:49:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47866 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbfDOQt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:49:26 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FGiHEs032436;
        Mon, 15 Apr 2019 09:49:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=TEHzZEZdrC/d6Tz1Tbgw+1V5dE4hw4LpftnJuRBmkIk=;
 b=lKiG0NU7AuW8j5d9CbQnIdh6q/xCFGANTsZBbtH4YLENqLbbay2H21q86xfSdv0H5298
 OopqPUMmfBMgE+Y5rX+NQDliMb8fp8/uLIjG4e0WEu1i+wUXjJJaB7G6PVgxQPb0PzJe
 OfLxCRLy8U5pIQynvnx/ZuoY3tSR0TfKDgU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rvn2fhrdm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 15 Apr 2019 09:49:06 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 15 Apr 2019 09:49:05 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 15 Apr 2019 09:49:04 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 15 Apr 2019 09:49:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEHzZEZdrC/d6Tz1Tbgw+1V5dE4hw4LpftnJuRBmkIk=;
 b=iaQh6zZTAg6UtBTRAjBuRwznQrkN+Omt+83Y9bzYViZezciqaoQdNMVqt+Xw1SQW+okUsrQylXbtEddKB+y1p/Y2jNzsmUoZkrz9ZMwL3Yj0eu/3K1VrrDDTnTnE3q7w2pm3VPH06OoSVfRE+8wcn+VRgyY/hnjSyXEvTLJnU4Q=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1533.namprd15.prod.outlook.com (10.173.235.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Mon, 15 Apr 2019 16:48:49 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 16:48:49 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Morten Rasmussen" <morten.rasmussen@arm.com>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Thread-Topic: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Thread-Index: AQHU7lSD68FtcB4UGUOYupgC9AfmOKY9eYgA
Date:   Mon, 15 Apr 2019 16:48:49 +0000
Message-ID: <2A377F4D-8A84-4D90-9C59-48B865EB34D1@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
In-Reply-To: <20190408214539.2705660-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:180::76d3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc90bf8f-5a2b-4629-47ff-08d6c1c23bdf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1533;
x-ms-traffictypediagnostic: MWHPR15MB1533:
x-microsoft-antispam-prvs: <MWHPR15MB153399D188B2D4D504964D62B32B0@MWHPR15MB1533.namprd15.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(396003)(376002)(136003)(199004)(189003)(2616005)(86362001)(11346002)(229853002)(83716004)(76176011)(446003)(102836004)(6506007)(53546011)(50226002)(186003)(2906002)(14444005)(81156014)(46003)(106356001)(14454004)(486006)(476003)(256004)(4326008)(81166006)(99286004)(105586002)(6486002)(82746002)(8936002)(5660300002)(478600001)(54906003)(7736002)(6246003)(6916009)(8676002)(316002)(68736007)(305945005)(71200400001)(6512007)(6436002)(36756003)(53936002)(97736004)(33656002)(25786009)(57306001)(71190400001)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1533;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0WFKGP2sv9F7vMcUYy7KhQA5YG/n5LyddVmbGpdqRBafndF/ezYjNR1YtZwCLAZSCpiVcb8EMUE6rhfFlAJozixFeEdH3VzwL39ICNFCCsEzvi7ue7gQlnF1GS4oiz44vyWvAXy3l7TcdtsXKq3zmWpJutG3xO8uYh3fx1gmvUZuIDmoe5zujFsBX+8XoEM8m+NYjxX9N1EOTJIyHY0YFAm0tnoNEpRTZWiwjZKCe4k/suj9i1aRAB5el+8LlaIS0c2HmjOvL7KbVuT6gRLAuEHdKoDUmrqPVXGP9KIgd+VaVTGEaqpew4ZYMFxzzUmLLod4n4yTYhblAkk4LwmHPmRlfn53XJ8gp6VqgXpd2NKp9uoTYoM9qrHQFUoslmVPwtBE/hdJgXe3+4Md0yCKjl7PH7FAuDZIiGT7oFNzouk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA114A4AFB606A44AAE4F9B2F011544F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cc90bf8f-5a2b-4629-47ff-08d6c1c23bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 16:48:49.0557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1533
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> On Apr 8, 2019, at 2:45 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> Servers running latency sensitive workload usually aren't fully loaded fo=
r=20
> various reasons including disaster readiness. The machines running our=20
> interactive workloads (referred as main workload) have a lot of spare CPU=
=20
> cycles that we would like to use for optimistic side jobs like video=20
> encoding. However, our experiments show that the side workload has strong
> impact on the latency of main workload:
>=20
>  side-job   main-load-level   main-avg-latency
>     none          1.0              1.00
>     none          1.1              1.10
>     none          1.2              1.10=20
>     none          1.3              1.10
>     none          1.4              1.15
>     none          1.5              1.24
>     none          1.6              1.74
>=20
>     ffmpeg        1.0              1.82
>     ffmpeg        1.1              2.74
>=20
> Note: both the main-load-level and the main-avg-latency numbers are
> _normalized_.
>=20
> In these experiments, ffmpeg is put in a cgroup with cpu.weight of 1=20
> (lowest priority). However, it consumes all idle CPU cycles in the=20
> system and causes high latency for the main workload. Further experiments
> and analysis (more details below) shows that, for the main workload to me=
et
> its latency targets, it is necessary to limit the CPU usage of the side
> workload so that there are some _idle_ CPU. There are various reasons
> behind the need of idle CPU time. First, shared CPU resouce saturation=20
> starts to happen way before time-measured utilization reaches 100%.=20
> Secondly, scheduling latency starts to impact the main workload as CPU=20
> reaches full utilization.=20
>=20
> Currently, the cpu controller provides two mechanisms to protect the main=
=20
> workload: cpu.weight and cpu.max. However, neither of them is sufficient=
=20
> in these use cases. As shown in the experiments above, side workload with=
=20
> cpu.weight of 1 (lowest priority) would still consume all idle CPU and ad=
d=20
> unacceptable latency to the main workload. cpu.max can throttle the CPU=20
> usage of the side workload and preserve some idle CPU. However, cpu.max=20
> cannot react to changes in load levels. For example, when the main=20
> workload uses 40% of CPU, cpu.max of 30% for the side workload would yiel=
d=20
> good latencies for the main workload. However, when the workload=20
> experiences higher load levels and uses more CPU, the same setting (cpu.m=
ax=20
> of 30%) would cause the interactive workload to miss its latency target.=
=20
>=20
> These experiments demonstrated the need for a mechanism to effectively=20
> throttle CPU usage of the side workload and preserve idle CPU cycles.=20
> The mechanism should be able to adjust the level of throttling based on
> the load level of the main workload.=20
>=20
> This patchset introduces a new knob for cpu controller: cpu.headroom.=20
> cgroup of the main workload uses cpu.headroom to ensure side workload to=
=20
> use limited CPU cycles. For example, if a main workload has a cpu.headroo=
m=20
> of 30%. The side workload will be throttled to give 30% overall idle CPU.=
=20
> If the main workload uses more than 70% of CPU, the side workload will on=
ly=20
> run with configurable minimal cycles. This configurable minimal cycles is
> referred as "tolerance" of the main workload.=20
>=20
> The following is a detailed example:
>=20
> main/cpu.headroom    main-cpu-load    low-pri-cpu-cycle   idle-cpu
>      30%                 30%                40%              30%
>      30%                 40%                30%              30%
>      30%                 50%                20%              30%
>      30%                 60%                10%              30%
>      30%                 70%                minimal          ~30%
>      30%                 80%                minimal          ~20%
>=20
> In the example, we use a constant cpu.headroom setting of 30%. As main jo=
b
> experiences different level of load, the cpu controller adjusts CPU cycle=
s
> used by the low-pri jobs.
>=20
> We experiemented with a web server as the main workload and ffmpeg as the=
=20
> side workload. The following table compares latency impact on the main=20
> workload under different cpu.headroom settings and load levels. In all=20
> tests, the side workload cgroup is configured with cpu.weight of 1. When=
=20
> throttled, the side workload can only run 1ms per 100ms period.
>=20
>                               average-latency
> main-load-level   w/o-side    w/-side-      w/-side-       w/-side-
>                            no-headroom   30%-headroom   20%-headroom
>     1.0            1.00       1.82          1.26           1.14          =
           =20
>     1.1            1.10       2.74          1.26           1.32          =
           =20
>     1.2            1.10                     1.29           1.38          =
           =20
>     1.3            1.10                     1.32           1.49          =
           =20
>     1.4            1.15                     1.29           1.85          =
           =20
>     1.5            1.24                     1.32                         =
      =20
>     1.6            1.74                     1.50                         =
    =20
>=20
> Each row of the table shows a normalized load level and average latencies=
=20
> for 4 scenarios: w/o side workload, w/ side workload but no headroom; w/=
=20
> side workload and 30% headroom; with side workload and 20% headroom.=20
>=20
>=20
> When there is no side workload, average latency of main job falls in the=
=20
> 0.7x range, except the very high load scenarios. When there is side=20
> workload but no headroom, latency of the main job goes very high at=20
> moderate load levels. With 30% headroom, the average latency falls in the=
=20
> 0.8x range. With 20% headroom, the average latency falls in the 0.9x to=20
> 1.x range. We didn't finish tests in some cases with high load, because=20
> the latency is too high.=20
>=20
> This experiment demonstrated cpu.headroom is an effective and efficient
> knob to control the latency of the main job.
>=20
> Thanks!

Could you please kindly share your feedback and comments on this work?

Thanks and Regards,
Song

> Song Liu (7):
>  sched: refactor tg_set_cfs_bandwidth()
>  cgroup: introduce hook css_has_tasks_changed
>  cgroup: introduce cgroup_parse_percentage
>  sched, cgroup: add entry cpu.headroom
>  sched/fair: global idleness counter for cpu.headroom
>  sched/fair: throttle task runtime based on cpu.headroom
>  Documentation: cgroup-v2: add information for cpu.headroom
>=20
> Documentation/admin-guide/cgroup-v2.rst |  18 +
> fs/proc/stat.c                          |   4 +-
> include/linux/cgroup-defs.h             |   2 +
> include/linux/cgroup.h                  |   1 +
> include/linux/kernel_stat.h             |   2 +
> kernel/cgroup/cgroup.c                  |  51 +++
> kernel/sched/core.c                     | 425 ++++++++++++++++++++++--
> kernel/sched/fair.c                     | 143 +++++++-
> kernel/sched/sched.h                    |  30 ++
> 9 files changed, 634 insertions(+), 42 deletions(-)
>=20
> --=20
> 2.17.1
>=20

