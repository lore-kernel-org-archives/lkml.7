Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A946DC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 23:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE0E20685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 23:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="N2YJNore";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZPWylkRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbfDVXWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 19:22:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33470 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728831AbfDVXWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 19:22:46 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3MNM5Uj028188;
        Mon, 22 Apr 2019 16:22:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=2CeFzKtjISHNTJ/GhmGMb7VMMUY0rdl1YKbLZO0t+Js=;
 b=N2YJNoreyA6Oe3YUYV1tuIU3K2H0yI/ohY5XC6g8Q9EpjDZo5Aa6vxuW/KwFk7YDfzya
 y02+4LBAy2DxzAXuPX137osMp5J7LH1zoT6wBYRrcIz8SCQK2pXEgVKK+8/ooyqxeoNj
 7kCnF+Sz8SX7QgJUamJbrZjYDtmVqqTlehw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2s1kjt0vm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Apr 2019 16:22:25 -0700
Received: from frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 16:22:25 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 16:22:24 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Apr 2019 16:22:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CeFzKtjISHNTJ/GhmGMb7VMMUY0rdl1YKbLZO0t+Js=;
 b=ZPWylkRRKeVTgSHE3O7VXrrM3wecNHiYgYNXTO4rPiB80DDI/vsG6ayK/5c9LUvhSUI2aHb+GMZ0gsg5o0vuMFIYLRJ6Zyg65EbGw5m6E8rCJg2gnovPzdWYeMDi5NzL/QX2/9gfE0vS5RWwPEEddncmzKpHBj7QyzVaLunWwFw=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1119.namprd15.prod.outlook.com (10.175.2.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Mon, 22 Apr 2019 23:22:22 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::5185:8137:2f1d:7171%2]) with mapi id 15.20.1792.023; Mon, 22 Apr 2019
 23:22:22 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Thread-Topic: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Thread-Index: AQHU7lSD68FtcB4UGUOYupgC9AfmOKY1TPCAgACBxACACo6VgIAIioaA
Date:   Mon, 22 Apr 2019 23:22:21 +0000
Message-ID: <E97E73F4-CE8C-4CD7-B6B6-5F63A4E881B1@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
 <20190410115907.GE19434@e105550-lin.cambridge.arm.com>
 <A2E9A149-9EAA-478D-A096-1D4D4BA442B3@fb.com>
 <CAKfTPtAFB3gSZYJN1BcjU_XoY=Pfu2xtea+2MEw7FkVc3mwTSA@mail.gmail.com>
In-Reply-To: <CAKfTPtAFB3gSZYJN1BcjU_XoY=Pfu2xtea+2MEw7FkVc3mwTSA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::1:3699]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 928d65fd-fb48-412a-4e77-08d6c7795f30
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1119;
x-ms-traffictypediagnostic: MWHPR15MB1119:
x-microsoft-antispam-prvs: <MWHPR15MB11198D8DA3A18121F7E8D03CB3220@MWHPR15MB1119.namprd15.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(51914003)(189003)(199004)(6506007)(53546011)(6436002)(186003)(102836004)(99286004)(229853002)(561944003)(46003)(11346002)(2616005)(76176011)(6916009)(446003)(33656002)(476003)(486006)(5660300002)(2906002)(6116002)(6486002)(36756003)(97736004)(54906003)(316002)(53936002)(8676002)(83716004)(25786009)(14454004)(81166006)(50226002)(81156014)(93886005)(305945005)(6512007)(7736002)(86362001)(71190400001)(71200400001)(82746002)(6246003)(8936002)(256004)(73956011)(478600001)(76116006)(66446008)(64756008)(66556008)(66476007)(57306001)(4326008)(66946007)(68736007)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1119;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ppL7bwlg6vKFhPbhXPtxeJWhZrZ4qDE7kkq3EYqgII+Mciviniu50AJ7uKkxMRQZTDLKJUGr+HXFC/8HufgDWxxsXMzpz++acn4qdgdYGmF0jvGlTcwXpKNQWa4BC1ynAqXTCcauqZU5Ih3JbsuilOLmEEDZWvGaUXqpxxgo6rFiu8flFZApQdprTbzbQOGFiRdOsFAvZScHOWirHNPCey25Xi/+uOx6pYImBGBFrhYa8PZ8K42+w1NK/FGkVDrDp9mWQw2saymebiqIBJFt63qpTjQpArJYNgsAlY55IyZ66YVre7M8DAplZRyoZd94f5IXOfhi3v78/QSPdM3ejohWL/lcimlLQMoI/8iPeIlUq3ZOmm2OjuHwN0TVvWYBrYMrFm5K9rzJD4zaceOClXcfI5LAvkJf5RsnU0y3Ch0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EF24496EEDBE124C9CEFF658E8571CDA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 928d65fd-fb48-412a-4e77-08d6c7795f30
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 23:22:21.9683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1119
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

> On Apr 17, 2019, at 5:56 AM, Vincent Guittot <vincent.guittot@linaro.org>=
 wrote:
>=20
> On Wed, 10 Apr 2019 at 21:43, Song Liu <songliubraving@fb.com> wrote:
>>=20
>> Hi Morten,
>>=20
>>> On Apr 10, 2019, at 4:59 AM, Morten Rasmussen <morten.rasmussen@arm.com=
> wrote:
>>>=20
>=20
>>>=20
>>> The bit that isn't clear to me, is _why_ adding idle cycles helps your
>>> workload. I'm not convinced that adding headroom gives any latency
>>> improvements beyond watering down the impact of your side jobs. AFAIK,
>>=20
>> We think the latency improvements actually come from watering down the
>> impact of side jobs. It is not just statistically improving average
>> latency numbers, but also reduces resource contention caused by the side
>> workload. I don't know whether it is from reducing contention of ALUs,
>> memory bandwidth, CPU caches, or something else, but we saw reduced
>> latencies when headroom is used.
>>=20
>>> the throttling mechanism effectively removes the throttled tasks from
>>> the schedule according to a specific duty cycle. When the side job is
>>> not throttled the main workload is experiencing the same latency issues
>>> as before, but by dynamically tuning the side job throttling you can
>>> achieve a better average latency. Am I missing something?
>>>=20
>>> Have you looked at your distribution of main job latency and tried to
>>> compare with when throttling is active/not active?
>>=20
>> cfs_bandwidth adjusts allowed runtime for each task_group each period
>> (configurable, 100ms by default). cpu.headroom logic applies gentle
>> throttling, so that the side workload gets some runtime in every period.
>> Therefore, if we look at time window equal to or bigger than 100ms, we
>> don't really see "throttling active time" vs. "throttling inactive time"=
.
>>=20
>>>=20
>>> I'm wondering if the headroom solution is really the right solution for
>>> your use-case or if what you are really after is something which is
>>> lower priority than just setting the weight to 1. Something that
>>=20
>> The experiments show that, cpu.weight does proper work for priority: the
>> main workload gets priority to use the CPU; while the side workload only
>> fill the idle CPU. However, this is not sufficient, as the side workload
>> creates big enough contention to impact the main workload.
>>=20
>>> (nearly) always gets pre-empted by your main job (SCHED_BATCH and
>>> SCHED_IDLE might not be enough). If your main job consist
>>> of lots of relatively short wake-ups things like the min_granularity
>>> could have significant latency impact.
>>=20
>> cpu.headroom gives benefits in addition to optimizations in pre-empt
>> side. By maintaining some idle time, fewer pre-empt actions are
>> necessary, thus the main workload will get better latency.
>=20
> I agree with Morten's proposal, SCHED_IDLE should help your latency
> problem because side job will be directly preempted unlike normal cfs
> task even lowest priority.
> In addition to min_granularity, sched_period also has an impact on the
> time that a task has to wait before preempting the running task. Also,
> some sched_feature like GENTLE_FAIR_SLEEPERS can also impact the
> latency of a task.
>=20
> It would be nice to know if the latency problem comes from contention
> on cache resources or if it's mainly because you main load waits
> before running on a CPU
>=20
> Regards,
> Vincent

Thanks for these suggestions. Here are some more tests to show the impact=20
of scheduler knobs and cpu.headroom.

side-load | cpu.headroom | side/cpu.weight | min_gran | cpu-idle | main/lat=
ency
---------------------------------------------------------------------------=
-----
  none    |      0       |     n/a         |    1 ms  |  45.20%  |   1.00
 ffmpeg   |      0       |      1          |   10 ms  |   3.38%  |   1.46
 ffmpeg   |      0       |   SCHED_IDLE    |    1 ms  |   5.69%  |   1.42
 ffmpeg   |    20%       |   SCHED_IDLE    |    1 ms  |  19.00%  |   1.13
 ffmpeg   |    30%       |   SCHED_IDLE    |    1 ms  |  27.60%  |   1.08

In all these cases, the main workload is loaded with same level of=20
traffic (request per second). Main workload latency numbers are normalized=
=20
based on the baseline (first row).=20

For the baseline, the main workload runs without any side workload, the=20
system has about 45.20% idle CPU.=20

The next two rows compare the impact of scheduling knobs cpu.weight and=20
sched_min_granularity. With cpu.weight of 1 and min_granularity of 10ms,=20
we see a latency of 1.46; with SCHED_IDLE and min_granularity of 1ms, we=20
see a latency of 1.42. So SCHED_IDLE and min_granularity help protecting=20
the main workload. However, it is not sufficient, as the latency overhead=20
is high (>40%).=20

The last two rows show the benefit of cpu.headroom. With 20% headroom,=20
the latency is 1.13; while with 30% headroom, the latency is 1.08.=20

We can also see a clear correlation between latency and global idle CPU:=20
more idle CPU yields better lower latency.=20

Over all, these results show that cpu.headroom provides effective=20
mechanism to control the latency impact of side workloads. Other knobs=20
could also help the latency, but they are not as effective and flexible=20
as cpu.headroom.=20

Does this analysis address your concern?=20

Thanks,
Song

>=20
>>=20
>> Thanks,
>> Song
>>=20
>>>=20
>>> Morten
>>=20

