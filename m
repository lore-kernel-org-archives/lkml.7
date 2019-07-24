Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695E8C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CFE227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SMvT3Dlc";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ca0p8e1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfGXIuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:50:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58910 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725870AbfGXIuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:50:17 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6O8lQSu016526;
        Wed, 24 Jul 2019 01:49:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=mU/pelyxib3rivb1xl0xQxqhEwELESRXJc3IauAo1zk=;
 b=SMvT3DlcTGy4Y5cBgL4nxICE4U35AL/NjD5JaCYksNQwbnO5kx1vwUwxnRUSrFY6A5Qg
 ggy/KWMbI2zavuLkfY+qqvSVcPaRa06SGecBcR9xEnv5p4TFZOaU9ik1skz4aV+TShBB
 LadcxQSholi+z0g1xghNLE4EelXB/N3v8V4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2txcwahb8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Jul 2019 01:49:21 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 24 Jul 2019 01:49:20 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 24 Jul 2019 01:49:19 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 24 Jul 2019 01:49:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9GNFVKCi9JLutRLyaaNFi8rITmxAv54fdZXhkwNaGGZ55lf8vdTLwse1duIyIRP4uFnGwfIHkl85MrvBAveNmVTFm/IGH85N6KcyOiYV7o1RzbnhgqiUu7o/CnFGQFM8kfNAc4KkoiI6aKSdWp2rbpw05T4GkwIRf5NRhclAh4iP+lPynGzurvcd6ePlAYWX2b7idQYfBpO3woU9pKWAHXXd3l1K3kqebZ+oI6H5VKFgxkhZNI9kfy/OAE7iBbtiwDCjholG0dzDbvkGWcZKMN7DYoLV1rFDuaEa0SoHXdhcfvtiT4IsdvAnYWp36nYZWN/JGvJEca0BXFVQsfZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU/pelyxib3rivb1xl0xQxqhEwELESRXJc3IauAo1zk=;
 b=dI57Rx1IU+oVk/UHDThM/UTdJ8Qh639CF75T+RyD6qYhnXW5yN51Tj2AHZjJHJ5WEhnSY97YvhMYF4RlRy5Ss11ncQL9CVfk9PnZK09JlxYrsFHt+ufHjslRNpml/AkbrRzF1lIWZ4gBoFPGd87/u3ORLDZZi/1DKEqT0fO/m2SW7TqYShpKzA6PyH2LSQOdOAAUBcI17Qcrsf0aYZvVCFZ/Rl53eWFERqFAt/q37m2K1+qiiW6t5ecaMRMagqBBFWC1pBbpRVkE1HcUalzh0mo07LkbafogqNaa9PEI4CG6q9CPkyB5afbyxk/6dK6UbZu1YCcK6LQws84jM1NmFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU/pelyxib3rivb1xl0xQxqhEwELESRXJc3IauAo1zk=;
 b=ca0p8e1qm+u07H9qFHZBODCzv5dgLAZC2ExpKf/3pVUL+ZazzvjM0ZxOTzv+yHFoGtKxOgmR4Z6z/GLAMVpNBR7deyHMXUhRPi1r2crNS7pFxLDCka8MjWjY6yAgrRGj7SqvIS1x5KczWXaH7mX/wwavbBj/7XxpvEMLHAz6Zqw=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1744.namprd15.prod.outlook.com (10.174.255.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Wed, 24 Jul 2019 08:49:19 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7%7]) with mapi id 15.20.2094.013; Wed, 24 Jul 2019
 08:49:19 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFC 00/79] perf tools: Initial libperf separation
Thread-Topic: [RFC 00/79] perf tools: Initial libperf separation
Thread-Index: AQHVP7b8omKid2yF70mY04HbAJ4cv6bZZ1qAgAAOO4CAAARYAA==
Date:   Wed, 24 Jul 2019 08:49:18 +0000
Message-ID: <367ECF0F-F9F4-430D-9BF4-9B87B45ECD6F@fb.com>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <327EF79F-4573-4387-8DA5-24FFD9EDBBB1@fb.com> <20190724083345.GA5860@krava>
In-Reply-To: <20190724083345.GA5860@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:87bf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c58cb5b-a811-414a-7613-08d71013d0de
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1744;
x-ms-traffictypediagnostic: MWHPR15MB1744:
x-microsoft-antispam-prvs: <MWHPR15MB174478BD2A05CAC05AC2350BB3C60@MWHPR15MB1744.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39860400002)(136003)(51914003)(54534003)(189003)(199004)(51444003)(53546011)(99286004)(5660300002)(6506007)(76176011)(71200400001)(14454004)(71190400001)(25786009)(102836004)(478600001)(6916009)(4326008)(486006)(476003)(11346002)(2616005)(316002)(6486002)(6436002)(46003)(54906003)(446003)(186003)(229853002)(57306001)(64756008)(66476007)(66556008)(66446008)(68736007)(66946007)(33656002)(50226002)(2906002)(81156014)(8676002)(81166006)(8936002)(256004)(305945005)(53936002)(7736002)(6246003)(14444005)(86362001)(36756003)(6116002)(6512007)(7416002)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1744;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JdyYuHsLLJuWt+JqiEdQW7WN7+NRtI739qEV6Qm4x6TkTBPp4H/wN0dT438kgAQjmGIKqzJoAwDI4vq7htOjulW38HtGuk+tyaK6WHeFoF2WUs0k2soErLjNdAiy2/wjVjW3BklVvr9c3J9RtnjhCO3WJAyyaiDsB1usD3PzgqzNcZrzY6D4zz0+sUAs6IUrJl11OdJudWOIkfmmSHfavKA5ARqgfP0VhIffUminqHYyjccs1lDv8bhlOiUdTzY43zZnvfCh3M/zwfd10zpahRbIwSIuURio9DZ+L79bOfOdWgiooLF1nS+kirrBviF42yRSlYPvK713VfWkh+TQ7X20YCVDykR9iTBc82Bv1sS9HTuqX0Bmrj0T8Uu7YTG9GXU8pyip8qgRNyfL3ikfdAIRoT42sN242Rl7aOHKsW0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9EABB956AAD3DF4CB744505B7D21FB76@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c58cb5b-a811-414a-7613-08d71013d0de
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 08:49:18.9856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1744
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-24_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907240099
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 24, 2019, at 1:33 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Jul 24, 2019 at 07:42:50AM +0000, Song Liu wrote:
>> Hi Jiri,
>>=20
>>> On Jul 21, 2019, at 4:23 AM, Jiri Olsa <jolsa@kernel.org> wrote:
>>>=20
>>> hi,
>>> we have long term goal to separate some of the perf functionality
>>> into library. This patchset is initial effort on separating some
>>> of the interface.
>>>=20
>>> Currently only the basic counting interface is exported, it allows
>>> to:
>>> - create cpu/threads maps
>>> - create evlist/evsel objects
>>> - add evsel objects into evlist
>>> - open/close evlist/evsel objects
>>> - enable/disable events
>>> - read evsel counts
>>=20
>> Based on my understanding, evsel and evlist are abstractions in
>> perf utilities. I think most other tools that use perf UAPIs are=20
>> not built based on these abstractions. I looked at a few internal
>=20
> AFAICS some abstraction is needed to carry on the needed stuff
> like mmaps, counts, group links, PMU details (type, cpus..)
>=20
>> tools. Most of them just uses sys_perf_event_open() and struct=20
>> perf_event_attr. I am not sure whether these tools would adopt
>> libperf, as libperf changes their existing concepts/abstractions.
>=20
> well, besides that we wanted to do this separation for tools/* sake,
> I think that once libperf shares more interface on sampling and pmu
> events parsing, it will be considerable choice also for out of the
> tree tools

Yeah, in tree tools would benefit from it for sure. And they should
also motivate out of the tree tools to use libperf.=20

>=20
>>>=20
>>> The initial effort was to have total separation of the objects
>>> from perf code, but it showed not to be a good way. The amount
>>> of changed code was too big with high chance for regressions,
>>> mainly because of the code embedding one of the above objects
>>> statically.
>>>=20
>>> We took the other approach of sharing the objects/struct details
>>> within the perf and libperf code. This way we can keep perf
>>> functionality without any major changes and the libperf users
>>> are still separated from the object/struct details. We can move
>>> to total libperf's objects separation gradually in future.
>>=20
>> I found some duplicated logic between libperf and perf, for=20
>> example, perf_evlist__open() and evlist__open(). Do we plan to=20
>> merge them in the future?=20
>=20
> yea, as I wrote in the perf_evsel__open patch changelog:
>=20
>  It's a simplified version of evsel__open without fallback
>  stuff. We can try to merge it in the future to libperf,
>  but it has many glitches.

I was reading the code in your git tree and missed the change=20
log.=20

Thanks for the explanations.=20

Song


