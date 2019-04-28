Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE381C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D69D20679
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 19:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UkrNgUqe";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CqRMZmNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfD1TsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 15:48:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32862 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbfD1TsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 15:48:03 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3SJbpgv015649;
        Sun, 28 Apr 2019 12:47:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=fvqllITTRQUbdcOYVYcjo77A/GDSd1qE7aFF0ORjs/A=;
 b=UkrNgUqeQzKuWf652hPrTCs6PLovu+bvaUTxxqjKPmLzACGnJ3RbgWpyxUbpnkF3Jqwk
 llqsrFu9G9EgZohWbePKaNv4wQ86tMJjktKAitb+4XMIwJfR6eTOqiLb4fDTcxjO37Rs
 3cpuEauZoCwWCZnknCUSYkJXp7mQnZfUu7M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2s4m6ab4ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 28 Apr 2019 12:47:41 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 28 Apr 2019 12:47:39 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 28 Apr 2019 12:47:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvqllITTRQUbdcOYVYcjo77A/GDSd1qE7aFF0ORjs/A=;
 b=CqRMZmNi8oDLh+umEThABfPJMmQujyjeY5ifH8Wa4iPVrtnNjqQLuW9MOPCLED37fTUaEkK/YuhqHRukEQt6SPyYDwux6D49R0jQIWfH2FoqoFW6CRObWHJH6DgoECpNbMXW1voKLPYw12PiI8IhmancMA+Fwo3EnfpoC/Yh35U=
Received: from CY4PR15MB1159.namprd15.prod.outlook.com (10.172.175.138) by
 CY4PR15MB1527.namprd15.prod.outlook.com (10.172.156.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Sun, 28 Apr 2019 19:47:24 +0000
Received: from CY4PR15MB1159.namprd15.prod.outlook.com
 ([fe80::4d3e:b957:8d66:e54b]) by CY4PR15MB1159.namprd15.prod.outlook.com
 ([fe80::4d3e:b957:8d66:e54b%7]) with mapi id 15.20.1835.010; Sun, 28 Apr 2019
 19:47:24 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Thread-Topic: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Thread-Index: AQHU7lSD68FtcB4UGUOYupgC9AfmOKY1TPCAgACBxACACo6VgIAIioaAgAkx7AA=
Date:   Sun, 28 Apr 2019 19:47:24 +0000
Message-ID: <F0A127DD-F9B6-4FBE-B9AD-8E8B00A7D676@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
 <20190410115907.GE19434@e105550-lin.cambridge.arm.com>
 <A2E9A149-9EAA-478D-A096-1D4D4BA442B3@fb.com>
 <CAKfTPtAFB3gSZYJN1BcjU_XoY=Pfu2xtea+2MEw7FkVc3mwTSA@mail.gmail.com>
 <E97E73F4-CE8C-4CD7-B6B6-5F63A4E881B1@fb.com>
In-Reply-To: <E97E73F4-CE8C-4CD7-B6B6-5F63A4E881B1@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:180::8520]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0ebbb4f-9fd8-4965-8fcc-08d6cc12560d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:CY4PR15MB1527;
x-ms-traffictypediagnostic: CY4PR15MB1527:
x-microsoft-antispam-prvs: <CY4PR15MB1527671CCC2B5AC607CBDBAEB3380@CY4PR15MB1527.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0021920B5A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(51914003)(76116006)(93886005)(99286004)(73956011)(14454004)(33656002)(7736002)(76176011)(6246003)(97736004)(561944003)(305945005)(478600001)(53936002)(6512007)(91956017)(68736007)(229853002)(57306001)(66556008)(66476007)(64756008)(66946007)(66446008)(82746002)(8936002)(25786009)(8676002)(6436002)(54906003)(110136005)(316002)(81156014)(50226002)(4326008)(6116002)(6486002)(5660300002)(36756003)(486006)(83716004)(476003)(446003)(2616005)(11346002)(46003)(71200400001)(53546011)(256004)(14444005)(6506007)(71190400001)(102836004)(86362001)(186003)(2906002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1527;H:CY4PR15MB1159.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uwFuMGQclLIdbCT4jY0f3KR22BFrMGjWj9nYfwLEBDpTVJR3t2fat9LUN7scgBIUojzA2TUJJao6489BfT3UACXsyO09DQQuOs9LWgebg7BRd53OkXFHYi7wWd0UaTQYVtKOc4ENqn8gT3gLVmFjYMoRTIvsbjJq0/SBYOj+zsA1TtX4ylprSv1x2WiK+7R0qag1QsMqjV/T12uVSvC5VLmlS4M7X3lNv1rhR/FmLe01fmRktnZu2nfqfdqLzVsfdN7ASoq3PSNEn2r1tbitl24+Wyn/dC1xEGoQ75Dh2L94K9UEICdWnUnR82kVAn0bUqalYkeMYct0gqqh9ZE3/HQeCFpkEkJelC3bcEO7KmoAi207IZb9aDP9B9TbRV2nBq/XL7hmgOaA/PRJmCshXaFFAeASllOf77ToEfRezXQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E274646D4D5DC84AB9DB7A9F308DA3DF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ebbb4f-9fd8-4965-8fcc-08d6cc12560d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2019 19:47:24.3880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1527
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-28_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904280144
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morten and Vincent,

> On Apr 22, 2019, at 6:22 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> Hi Vincent,
>=20
>> On Apr 17, 2019, at 5:56 AM, Vincent Guittot <vincent.guittot@linaro.org=
> wrote:
>>=20
>> On Wed, 10 Apr 2019 at 21:43, Song Liu <songliubraving@fb.com> wrote:
>>>=20
>>> Hi Morten,
>>>=20
>>>> On Apr 10, 2019, at 4:59 AM, Morten Rasmussen <morten.rasmussen@arm.co=
m> wrote:
>>>>=20
>>=20
>>>>=20
>>>> The bit that isn't clear to me, is _why_ adding idle cycles helps your
>>>> workload. I'm not convinced that adding headroom gives any latency
>>>> improvements beyond watering down the impact of your side jobs. AFAIK,
>>>=20
>>> We think the latency improvements actually come from watering down the
>>> impact of side jobs. It is not just statistically improving average
>>> latency numbers, but also reduces resource contention caused by the sid=
e
>>> workload. I don't know whether it is from reducing contention of ALUs,
>>> memory bandwidth, CPU caches, or something else, but we saw reduced
>>> latencies when headroom is used.
>>>=20
>>>> the throttling mechanism effectively removes the throttled tasks from
>>>> the schedule according to a specific duty cycle. When the side job is
>>>> not throttled the main workload is experiencing the same latency issue=
s
>>>> as before, but by dynamically tuning the side job throttling you can
>>>> achieve a better average latency. Am I missing something?
>>>>=20
>>>> Have you looked at your distribution of main job latency and tried to
>>>> compare with when throttling is active/not active?
>>>=20
>>> cfs_bandwidth adjusts allowed runtime for each task_group each period
>>> (configurable, 100ms by default). cpu.headroom logic applies gentle
>>> throttling, so that the side workload gets some runtime in every period=
.
>>> Therefore, if we look at time window equal to or bigger than 100ms, we
>>> don't really see "throttling active time" vs. "throttling inactive time=
".
>>>=20
>>>>=20
>>>> I'm wondering if the headroom solution is really the right solution fo=
r
>>>> your use-case or if what you are really after is something which is
>>>> lower priority than just setting the weight to 1. Something that
>>>=20
>>> The experiments show that, cpu.weight does proper work for priority: th=
e
>>> main workload gets priority to use the CPU; while the side workload onl=
y
>>> fill the idle CPU. However, this is not sufficient, as the side workloa=
d
>>> creates big enough contention to impact the main workload.
>>>=20
>>>> (nearly) always gets pre-empted by your main job (SCHED_BATCH and
>>>> SCHED_IDLE might not be enough). If your main job consist
>>>> of lots of relatively short wake-ups things like the min_granularity
>>>> could have significant latency impact.
>>>=20
>>> cpu.headroom gives benefits in addition to optimizations in pre-empt
>>> side. By maintaining some idle time, fewer pre-empt actions are
>>> necessary, thus the main workload will get better latency.
>>=20
>> I agree with Morten's proposal, SCHED_IDLE should help your latency
>> problem because side job will be directly preempted unlike normal cfs
>> task even lowest priority.
>> In addition to min_granularity, sched_period also has an impact on the
>> time that a task has to wait before preempting the running task. Also,
>> some sched_feature like GENTLE_FAIR_SLEEPERS can also impact the
>> latency of a task.
>>=20
>> It would be nice to know if the latency problem comes from contention
>> on cache resources or if it's mainly because you main load waits
>> before running on a CPU
>>=20
>> Regards,
>> Vincent
>=20
> Thanks for these suggestions. Here are some more tests to show the impact=
=20
> of scheduler knobs and cpu.headroom.
>=20
> side-load | cpu.headroom | side/cpu.weight | min_gran | cpu-idle | main/l=
atency
> -------------------------------------------------------------------------=
-------
>  none    |      0       |     n/a         |    1 ms  |  45.20%  |   1.00
> ffmpeg   |      0       |      1          |   10 ms  |   3.38%  |   1.46
> ffmpeg   |      0       |   SCHED_IDLE    |    1 ms  |   5.69%  |   1.42
> ffmpeg   |    20%       |   SCHED_IDLE    |    1 ms  |  19.00%  |   1.13
> ffmpeg   |    30%       |   SCHED_IDLE    |    1 ms  |  27.60%  |   1.08
>=20
> In all these cases, the main workload is loaded with same level of=20
> traffic (request per second). Main workload latency numbers are normalize=
d=20
> based on the baseline (first row).=20
>=20
> For the baseline, the main workload runs without any side workload, the=20
> system has about 45.20% idle CPU.=20
>=20
> The next two rows compare the impact of scheduling knobs cpu.weight and=20
> sched_min_granularity. With cpu.weight of 1 and min_granularity of 10ms,=
=20
> we see a latency of 1.46; with SCHED_IDLE and min_granularity of 1ms, we=
=20
> see a latency of 1.42. So SCHED_IDLE and min_granularity help protecting=
=20
> the main workload. However, it is not sufficient, as the latency overhead=
=20
> is high (>40%).=20
>=20
> The last two rows show the benefit of cpu.headroom. With 20% headroom,=20
> the latency is 1.13; while with 30% headroom, the latency is 1.08.=20
>=20
> We can also see a clear correlation between latency and global idle CPU:=
=20
> more idle CPU yields better lower latency.=20
>=20
> Over all, these results show that cpu.headroom provides effective=20
> mechanism to control the latency impact of side workloads. Other knobs=20
> could also help the latency, but they are not as effective and flexible=20
> as cpu.headroom.=20
>=20
> Does this analysis address your concern?=20
>=20
> Thanks,
> Song
>=20

Could you please share your comments and suggestions on this work? Did
the results address your questions/concerns?=20

Thanks again,
Song=20

>>=20
>>>=20
>>> Thanks,
>>> Song
>>>=20
>>>>=20
>>>> Morten

