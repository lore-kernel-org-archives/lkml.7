Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C096C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D9420645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fCxI14pu";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="gGNSFudS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfDJToB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:44:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56502 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbfDJToA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:44:00 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3AJhcmF022683;
        Wed, 10 Apr 2019 12:43:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=9nmGSS5VRXZzKeOCMgnLGJ1C0FfBs4PrZ2TdJWWWPf0=;
 b=fCxI14puBAjvgB0tXHbj8UGkk5tI7uI8JfPImHeublgHDbjaVouC2rpVjqKGdUinjG4N
 RXhGtnz+uRotCESGPQqs4ecsp7LQPR955BqYoPzVTG+lvuMyZeMrkWjDVx4dboi6w454
 wq/0wURsdvtLuyqaYX7jcjDtwC32iHakS9M= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rsppbr1pb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Apr 2019 12:43:38 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 10 Apr 2019 12:43:37 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 10 Apr 2019 12:43:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nmGSS5VRXZzKeOCMgnLGJ1C0FfBs4PrZ2TdJWWWPf0=;
 b=gGNSFudSYaVoO2LlINJIlN4Sx1nSAceMYqz8/ngv6W546beHDsuw0QVQJhY+dDAQZbXmQ8FJBp0zukhHv2+T5hBK/7Gx5oNhg4RAjVhBTxugrgVWHVRZYhkuZ7bN4yQw9IE0V0IudCGKEFndELc1hZ+PmsPe3i8f9ScpNEr4FVg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1759.namprd15.prod.outlook.com (10.174.255.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Wed, 10 Apr 2019 19:43:35 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1771.019; Wed, 10 Apr 2019
 19:43:35 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Thread-Topic: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Thread-Index: AQHU7lSD68FtcB4UGUOYupgC9AfmOKY1TPCAgACBxAA=
Date:   Wed, 10 Apr 2019 19:43:35 +0000
Message-ID: <A2E9A149-9EAA-478D-A096-1D4D4BA442B3@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
 <20190410115907.GE19434@e105550-lin.cambridge.arm.com>
In-Reply-To: <20190410115907.GE19434@e105550-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::1:5d1d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d11dcc37-7197-40f1-8d7d-08d6bdecd1fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1759;
x-ms-traffictypediagnostic: MWHPR15MB1759:
x-microsoft-antispam-prvs: <MWHPR15MB17599CE18A015722119BC44CB32E0@MWHPR15MB1759.namprd15.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(366004)(136003)(346002)(189003)(199004)(57306001)(76176011)(36756003)(229853002)(6486002)(71190400001)(81156014)(81166006)(6512007)(86362001)(6436002)(8676002)(14454004)(6116002)(68736007)(33656002)(71200400001)(53546011)(25786009)(105586002)(83716004)(478600001)(102836004)(106356001)(82746002)(6506007)(6916009)(2906002)(2616005)(11346002)(46003)(4326008)(6246003)(316002)(8936002)(486006)(186003)(97736004)(476003)(446003)(14444005)(7736002)(256004)(5660300002)(50226002)(54906003)(305945005)(53936002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1759;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q3QMH5pls7hXK2MWonu+vylPEnZyN3V6tSsSka4asrN2UUyq216uAW6dG7qOK8vtgdR3uCy5562w5J31XduC2KAVUjnzZkNizpX9vIhWgPe0P2JeFqbfFHSsmkbe0CB6oMr7Y5WjllztZ12EEZI/T7vnFLowV8zzz0Rl8wKdsjuZlShXQB0yv28IJ/50bS+Hk1WGZ8RXPyXazNara/YAusiv14oajT06vhYxZvyAKznybuGA+NO4Dn2lJvTv2TcsnjW1T4andeoGlrceJXmUs8XWTuMse/1JZXlK30m0nEXRfg1B/Yvwm8eRRk8pVDY35XXDKY7OoRujBNxBo3fBvb6SaZ1jKMDMOGFc42mOjVfRywGz5BYsrGcsw0eHhqS/9RC8uHvRqLNlfUaonY9VHJdWQKzPxoOBaXJbGABTmwo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98126E7250EA9C438F4B34D1597C1A20@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d11dcc37-7197-40f1-8d7d-08d6bdecd1fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 19:43:35.0332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1759
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morten,

> On Apr 10, 2019, at 4:59 AM, Morten Rasmussen <morten.rasmussen@arm.com> =
wrote:
>=20
> Hi,
>=20
> On Mon, Apr 08, 2019 at 02:45:32PM -0700, Song Liu wrote:
>> Servers running latency sensitive workload usually aren't fully loaded f=
or=20
>> various reasons including disaster readiness. The machines running our=20
>> interactive workloads (referred as main workload) have a lot of spare CP=
U=20
>> cycles that we would like to use for optimistic side jobs like video=20
>> encoding. However, our experiments show that the side workload has stron=
g
>> impact on the latency of main workload:
>>=20
>>  side-job   main-load-level   main-avg-latency
>>     none          1.0              1.00
>>     none          1.1              1.10
>>     none          1.2              1.10=20
>>     none          1.3              1.10
>>     none          1.4              1.15
>>     none          1.5              1.24
>>     none          1.6              1.74
>>=20
>>     ffmpeg        1.0              1.82
>>     ffmpeg        1.1              2.74
>>=20
>> Note: both the main-load-level and the main-avg-latency numbers are
>> _normalized_.
>=20
> Could you reveal what level of utilization those main-load-level numbers
> correspond to? I'm trying to understand why the latency seems to
> increase rapidly once you hit 1.5. Is that the point where the system
> hits 100% utilization?

The load level above is measured as requests-per-second.=20

When there is no side workload, the system has about 45% busy CPU with=20
load level of 1.0; and about 75% busy CPU at load level of 1.5.=20

The saturation starts before the system hitting 100% utilization. This is
true for many different resources: ALUs in SMT systems, cache lines,=20
memory bandwidths, etc.=20

>=20
>> In these experiments, ffmpeg is put in a cgroup with cpu.weight of 1=20
>> (lowest priority). However, it consumes all idle CPU cycles in the=20
>> system and causes high latency for the main workload. Further experiment=
s
>> and analysis (more details below) shows that, for the main workload to m=
eet
>> its latency targets, it is necessary to limit the CPU usage of the side
>> workload so that there are some _idle_ CPU. There are various reasons
>> behind the need of idle CPU time. First, shared CPU resouce saturation=20
>> starts to happen way before time-measured utilization reaches 100%.=20
>> Secondly, scheduling latency starts to impact the main workload as CPU=20
>> reaches full utilization.=20
>>=20
>> Currently, the cpu controller provides two mechanisms to protect the mai=
n=20
>> workload: cpu.weight and cpu.max. However, neither of them is sufficient=
=20
>> in these use cases. As shown in the experiments above, side workload wit=
h=20
>> cpu.weight of 1 (lowest priority) would still consume all idle CPU and a=
dd=20
>> unacceptable latency to the main workload. cpu.max can throttle the CPU=
=20
>> usage of the side workload and preserve some idle CPU. However, cpu.max=
=20
>> cannot react to changes in load levels. For example, when the main=20
>> workload uses 40% of CPU, cpu.max of 30% for the side workload would yie=
ld=20
>> good latencies for the main workload. However, when the workload=20
>> experiences higher load levels and uses more CPU, the same setting (cpu.=
max=20
>> of 30%) would cause the interactive workload to miss its latency target.=
=20
>>=20
>> These experiments demonstrated the need for a mechanism to effectively=20
>> throttle CPU usage of the side workload and preserve idle CPU cycles.=20
>> The mechanism should be able to adjust the level of throttling based on
>> the load level of the main workload.=20
>>=20
>> This patchset introduces a new knob for cpu controller: cpu.headroom.=20
>> cgroup of the main workload uses cpu.headroom to ensure side workload to=
=20
>> use limited CPU cycles. For example, if a main workload has a cpu.headro=
om=20
>> of 30%. The side workload will be throttled to give 30% overall idle CPU=
.=20
>> If the main workload uses more than 70% of CPU, the side workload will o=
nly=20
>> run with configurable minimal cycles. This configurable minimal cycles i=
s
>> referred as "tolerance" of the main workload.
>=20
> IIUC, you are proposing to basically apply dynamic bandwidth throttling t=
o
> side-jobs to preserve a specific headroom of idle cycles.

This is accurate. The effect is similar to cpu.max, but more dynamic.=20

>=20
> The bit that isn't clear to me, is _why_ adding idle cycles helps your
> workload. I'm not convinced that adding headroom gives any latency
> improvements beyond watering down the impact of your side jobs. AFAIK,

We think the latency improvements actually come from watering down the=20
impact of side jobs. It is not just statistically improving average=20
latency numbers, but also reduces resource contention caused by the side
workload. I don't know whether it is from reducing contention of ALUs,=20
memory bandwidth, CPU caches, or something else, but we saw reduced=20
latencies when headroom is used.=20

> the throttling mechanism effectively removes the throttled tasks from
> the schedule according to a specific duty cycle. When the side job is
> not throttled the main workload is experiencing the same latency issues
> as before, but by dynamically tuning the side job throttling you can
> achieve a better average latency. Am I missing something?
>=20
> Have you looked at your distribution of main job latency and tried to
> compare with when throttling is active/not active?

cfs_bandwidth adjusts allowed runtime for each task_group each period=20
(configurable, 100ms by default). cpu.headroom logic applies gentle=20
throttling, so that the side workload gets some runtime in every period.=20
Therefore, if we look at time window equal to or bigger than 100ms, we
don't really see "throttling active time" vs. "throttling inactive time".=20

>=20
> I'm wondering if the headroom solution is really the right solution for
> your use-case or if what you are really after is something which is
> lower priority than just setting the weight to 1. Something that

The experiments show that, cpu.weight does proper work for priority: the=20
main workload gets priority to use the CPU; while the side workload only=20
fill the idle CPU. However, this is not sufficient, as the side workload=20
creates big enough contention to impact the main workload.=20

> (nearly) always gets pre-empted by your main job (SCHED_BATCH and
> SCHED_IDLE might not be enough). If your main job consist
> of lots of relatively short wake-ups things like the min_granularity
> could have significant latency impact.

cpu.headroom gives benefits in addition to optimizations in pre-empt
side. By maintaining some idle time, fewer pre-empt actions are=20
necessary, thus the main workload will get better latency.=20

Thanks,
Song

>=20
> Morten

