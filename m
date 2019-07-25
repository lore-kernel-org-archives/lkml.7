Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59C1C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0342190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GFcS1dgM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BI8kgdVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390592AbfGYFYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:24:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59900 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390562AbfGYFYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:24:16 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6P5N4m2010693;
        Wed, 24 Jul 2019 22:23:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Zdebzrx01UtTcpyF15JZgpjThL6yds2FH1a2D1KihOE=;
 b=GFcS1dgMYrHGZSksI8Nd2a+E9IuVmjYn9aT4GHlF56gDUPraB7buCdd2bCm34ClM8lFD
 ziaNROCQb1H9yVlGkyiYSK86ZpsR5tpPUdjiwDxDn5lj9qxxgCyQSDf5yBugy8shfzu6
 qaM2qU3fmtpKMYDORNtVB56GnmAGa22FaHQ= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2txv2da4x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Jul 2019 22:23:21 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 24 Jul 2019 22:23:19 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 24 Jul 2019 22:23:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9OuB40Gc01rdUFVbjPGOBVd8Ser98E0mqNH4BahbmAlX1Fvesvegd7seydfQ8jNxAwFlhJJk6WgMpuGFDE74icOcsBEY7MDDv4h7MZWutcox24zDk7IHyjN3jsNMpkkwavhisbwPl77SLndPf8KGGQbrwn0tLrQ9Ipw1GnzRee3rhjGfu9r/TB9s2U4K/cQDC4zfF74bURq6yF+UFljcUClMrSb3LQWjN4mKS0rMKCl0QKypYs9VeBh+dDCv8QCdrgFKilflMYsonlyhMfxT5lZurVGAp3Nh9duQSerSsxOoqoCSdkJYz5xci619zW9lxA3FTNWz1/QT1L5w3om5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zdebzrx01UtTcpyF15JZgpjThL6yds2FH1a2D1KihOE=;
 b=K0YiktmWtLL2YSnliXI6Xtu63E6p3uNJZyrw8vULbzr1SscrUGVqKJ09osho+x36dRJ92guMqkvPPsUhMp6jE3c6kawMW5nnGNG80iyTyTF87i0Nzxz/WTtohwz6xDWrkG5Ew9Lh4pdJUd5Es0VqQGtAx6bfSGe73fQrBEc3kGD8WWVIEK+0MyG972XdjHj+Uqr0QxQKeiQx6I8eXdk7bpAHjVr8og7+KBhs3FRmiVTZtZrZzPhtLqSwjbJjBjAeRkPA7I8NZ6rtxs5oFCnXE2D14beDlNaJTVTsSOI4Wz/BJW5WI3HNaqo5ahgG1E6brUDk7H9QXH6A1p3y0nEXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zdebzrx01UtTcpyF15JZgpjThL6yds2FH1a2D1KihOE=;
 b=BI8kgdVuA7b0xM8WfHNEjs3lVCcv2p9KYZ7bPFndzvMbNuDTGE0jntwVFWUBTtQJFSE4bgvvV0O52j1P/RQlktuupDYfPPFnwtkOiX1BgoOhQw4FI8fU7iEM761Ita5gKDCZnj57Mm7K1dCQl8Hp6U9aMYW/nkpb/5P5CEwhDwA=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1616.namprd15.prod.outlook.com (10.175.142.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 05:23:17 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7%7]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 05:23:17 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Stephane Eranian" <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFC 00/79] perf tools: Initial libperf separation
Thread-Topic: [RFC 00/79] perf tools: Initial libperf separation
Thread-Index: AQHVP7b8omKid2yF70mY04HbAJ4cv6bZZ1qAgABmxgCAAQSSgA==
Date:   Thu, 25 Jul 2019 05:23:17 +0000
Message-ID: <AC63679B-8F4F-4C15-9072-71D1F0CABEDD@fb.com>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <327EF79F-4573-4387-8DA5-24FFD9EDBBB1@fb.com>
 <20190724135040.GA5727@kernel.org>
In-Reply-To: <20190724135040.GA5727@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:7bbf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3177cf4c-45cb-463c-56d4-08d710c03368
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1616;
x-ms-traffictypediagnostic: MWHPR15MB1616:
x-microsoft-antispam-prvs: <MWHPR15MB16162D1D75C86B0C9DDB46FCB3C10@MWHPR15MB1616.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(136003)(199004)(189003)(51914003)(6512007)(8676002)(53936002)(14444005)(36756003)(81156014)(99286004)(71190400001)(229853002)(50226002)(71200400001)(6246003)(33656002)(57306001)(4326008)(7736002)(256004)(14454004)(81166006)(8936002)(53546011)(7416002)(486006)(68736007)(5660300002)(6506007)(305945005)(66556008)(102836004)(6436002)(11346002)(316002)(476003)(6486002)(66946007)(446003)(478600001)(46003)(2616005)(64756008)(66476007)(186003)(6116002)(2906002)(25786009)(86362001)(76116006)(76176011)(6916009)(66446008)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1616;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y1J8PdlQLxi0o3D9eJWKVFpiaAHscnuk+Cr0uR0QbGpn+PBscVlYJxi9jIQtjUMnqtPSijLsJw1SHb1VhRcFPp143ifI4KsCNkRYRGTYmnTSR9oNS7cn1ZUzCd/JZ2F25USDipH63g3T2CzG58e/8J1w3KG7XbbOhmtrongeXfdyJ+0FtlGyLY5OO/5eVl1iEp0RYkKRk2qBDAklf0Uf1Qfo6KxkQwwEzJcuoGTXk4lcUno0xiP8OSZ6YHRzHa2jmSwjTvEd6wzH4Ns39fxKbG3zmLn+a0+xeTHYtDmpe2wsNYGdr7FSCpWDSJKsF66VKAjXZAHNnSLoTncJEg99wy9ilqlKRuM+SFh9/18Jv+MNinSHRH/Twza2EUqEt5iqz/blmqdpuEz+3Wy2d1m5mZg4S+5SpCABft+JsGwQWVw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1FD8DB258A76EA418915D5ED2F9DA703@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3177cf4c-45cb-463c-56d4-08d710c03368
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 05:23:17.5203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1616
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250064
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 24, 2019, at 6:50 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail=
.com> wrote:
>=20
> Em Wed, Jul 24, 2019 at 07:42:50AM +0000, Song Liu escreveu:
>>> On Jul 21, 2019, at 4:23 AM, Jiri Olsa <jolsa@kernel.org> wrote:
>=20
>>> we have long term goal to separate some of the perf functionality
>>> into library. This patchset is initial effort on separating some
>>> of the interface.
>=20
>>> Currently only the basic counting interface is exported, it allows
>>> to:
>>> - create cpu/threads maps
>>> - create evlist/evsel objects
>>> - add evsel objects into evlist
>>> - open/close evlist/evsel objects
>>> - enable/disable events
>>> - read evsel counts
>=20
>> Based on my understanding, evsel and evlist are abstractions in
>> perf utilities. I think most other tools that use perf UAPIs are=20
>> not built based on these abstractions. I looked at a few internal
>> tools. Most of them just uses sys_perf_event_open() and struct=20
>> perf_event_attr. I am not sure whether these tools would adopt
>> libperf, as libperf changes their existing concepts/abstractions.
>=20
> Right, and for now we're just trying to have something that is not so
> tied to perf and could possibly be useful outside tools/perf/ when the
> need arises for whatever new tool or pre-existing one.
>=20
> There are features there that may be interesting to use outside perf,
> time will tell.

Thanks for the explanation. This is not an easy task. :)

>=20
>>> The initial effort was to have total separation of the objects
>>> from perf code, but it showed not to be a good way. The amount
>>> of changed code was too big with high chance for regressions,
>>> mainly because of the code embedding one of the above objects
>>> statically.
>=20
>>> We took the other approach of sharing the objects/struct details
>>> within the perf and libperf code. This way we can keep perf
>>> functionality without any major changes and the libperf users
>>> are still separated from the object/struct details. We can move
>>> to total libperf's objects separation gradually in future.
>=20
>> I found some duplicated logic between libperf and perf, for=20
>> example, perf_evlist__open() and evlist__open(). Do we plan to=20
>> merge them in the future?=20
>=20
> He is just slowly moving things to a public libperf while keeping perf
> working, in the end the goal is to have as much stuff that is not
> super specific to some of the existing perf tools
> (tools/perf/builtin-*.c) in libperf as possible.
>=20
> It is still early in this effort, that is why he is still leaving it in
> tools/perf/lib/ and not in tools/lib/perf/ :-)

I saw that discussion. It is a good strategy.=20

Thanks,
Song

