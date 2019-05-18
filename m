Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16399C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 04:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C481920833
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 04:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="qF14xO1W";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="SiMcBe4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfEREY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 00:24:59 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49446 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725294AbfEREY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 00:24:59 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4I4K4oc021126;
        Fri, 17 May 2019 21:24:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=y1QCWpZuTmXMBKO6gpiTRMOFitJY070kzSvDaMh9c5M=;
 b=qF14xO1Wu1z8BH7E8x5/xPikyU8k3M3Q2TjW8Fmf1iAWXKsmfT2n47DnMH1Qj6KdxaIv
 1FOJwGN36NV+y04VOhql48bOUo0B1fWX5vsK6EREkv5hX6k2YB/9KH7SBQ9DZn2pBcMc
 sq9zyhLLvB8NpwcR5MJFF/5VoAcmZmw6VTeW8fcAbgIFxK3nqhocql5TAB/6CNLZgy49
 K3mmjpjJGoJu3jZDrWxvbv6+ZAfNC5pooFuHQZ6jDbaDL7pfWcKILi6srxJ/rhYK0Z0i
 l7dyc5vc26gSgkbG0Gng4XAMROwaex3rK4Bj4xT6XeEr5TrJaYTOgm6bpywwM+4kMRO1 mw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2shv92kr5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 17 May 2019 21:24:47 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 17 May
 2019 21:24:45 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.50) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 17 May 2019 21:24:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1QCWpZuTmXMBKO6gpiTRMOFitJY070kzSvDaMh9c5M=;
 b=SiMcBe4uzhsiLSDvWDcNBN8g7e3rWJsVByJB+tYqssIjAIIoh52S3bkSZyZLZ1L1Rcndt6ZppAzPLavOkrVcr5n7Keoc7UWZqsx2pCGPNOu7QvVSrYJKmFj/O+BIJRjJTgHbFwY8YQKJbiX7PmCcaG5TcBxIEB+KhiXwi7IDeTk=
Received: from CY4PR1801MB1942.namprd18.prod.outlook.com (10.171.255.33) by
 CY4PR1801MB1989.namprd18.prod.outlook.com (10.171.255.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Sat, 18 May 2019 04:24:43 +0000
Received: from CY4PR1801MB1942.namprd18.prod.outlook.com
 ([fe80::f4b5:9677:2811:41f4]) by CY4PR1801MB1942.namprd18.prod.outlook.com
 ([fe80::f4b5:9677:2811:41f4%7]) with mapi id 15.20.1900.010; Sat, 18 May 2019
 04:24:43 +0000
From:   Jayachandran Chandrasekharan Nair <jnair@marvell.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Glauber <jglauber@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Disable lockref on arm64
Thread-Topic: [RFC] Disable lockref on arm64
Thread-Index: AQHVDTGeOFsW4ymLfEiMCmPnsI63vA==
Date:   Sat, 18 May 2019 04:24:43 +0000
Message-ID: <20190518042424.GA28517@dc5-eodlnx05.marvell.com>
References: <20190429145159.GA29076@hc>
 <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
 <20190502082741.GE13955@hc>
 <CAHk-=wjmtMrxC1nSEHarBn8bW+hNXGv=2YeAWmTw1o54V8GKWA@mail.gmail.com>
 <20190502231858.GB13168@dc5-eodlnx05.marvell.com>
 <CAHk-=wiEahkwDXpoy=-SzJHNMRXKVSjPa870+eKKenufhO_Hgw@mail.gmail.com>
 <20190506061100.GA8465@dc5-eodlnx05.marvell.com>
 <20190506181039.GA2875@brain-police>
In-Reply-To: <20190506181039.GA2875@brain-police>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::40) To CY4PR1801MB1942.namprd18.prod.outlook.com
 (2603:10b6:910:7a::33)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2cdd682-2e64-4204-e083-08d6db48c079
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:CY4PR1801MB1989;
x-ms-traffictypediagnostic: CY4PR1801MB1989:
x-microsoft-antispam-prvs: <CY4PR1801MB1989423AE70737FB3F878676A6040@CY4PR1801MB1989.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0041D46242
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(66556008)(66476007)(66946007)(73956011)(64756008)(66446008)(6116002)(3846002)(229853002)(2906002)(86362001)(5660300002)(6916009)(68736007)(1076003)(66066001)(53936002)(305945005)(8676002)(26005)(6436002)(8936002)(11346002)(478600001)(486006)(446003)(186003)(6486002)(6512007)(71190400001)(71200400001)(81166006)(81156014)(6246003)(52116002)(14444005)(25786009)(14454004)(102836004)(316002)(256004)(7736002)(476003)(76176011)(33656002)(99286004)(54906003)(4326008)(6506007)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1801MB1989;H:CY4PR1801MB1942.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BpEglSbQ0nif9+5dbdgz1y2XVeFBaBrCotTK/ediHEA3rsQUVOwNWG6jF1vn4ohNCrqDsiiyvrge+VA0kHSxEOgyMA5yl1/mbOnvYfC1BQ/0Mg2opaHBmGH0rDeNxr9dKjrYq7yE/lnV8xprx539DQgsvjP1hjff9sKn/HJjPEI5wk8ukYSY0lL5tGV2CJ5RaEbEf6XyUuza1KjUHZoyZ0+vwexgwpKvy4DVnqU/J14zDC8yNIlLfzq6UwYWsws6Qy/+80pdykjvvj6ibZHRZCQ78PVLoBg1yeDmrsVYGkKbaAVknDQxKYuDUMu6rSZ8F74VbGKLwSc60Tm/kg6JvHoTVMIjLwIYKvpsUr2RTRK45fbhQ0eOhIjrPKpQEpxCruwEKYqy+IaY49GWEop9xXqB9kcMurZYXnz9Kv3AFsU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06B7D208A28DEC478C224F6259B6479C@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cdd682-2e64-4204-e083-08d6db48c079
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2019 04:24:43.6812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1801MB1989
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-18_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 07:10:40PM +0100, Will Deacon wrote:
> On Mon, May 06, 2019 at 06:13:12AM +0000, Jayachandran Chandrasekharan Na=
ir wrote:
> > Perhaps someone from ARM can chime in here how the cas/yield combo
> > is expected to work when there is contention. ThunderX2 does not
> > do much with the yield, but I don't expect any ARM implementation
> > to treat YIELD as a hint not to yield, but to get/keep exclusive
> > access to the last failed CAS location.
>=20
> Just picking up on this as "someone from ARM".
>=20
> The yield instruction in our implementation of cpu_relax() is *only* ther=
e
> as a scheduling hint to QEMU so that it can treat it as an internal
> scheduling hint and run some other thread; see 1baa82f48030 ("arm64:
> Implement cpu_relax as yield"). We can't use WFE or WFI blindly here, as =
it
> could be a long time before we see a wake-up event such as an interrupt. =
Our
> implementation of smp_cond_load_acquire() is much better for that kind of
> thing, but doesn't help at all for a contended CAS loop where the variabl=
e
> is actually changing constantly.

Looking thru the perf output of this case (open/close of a file from
multiple CPUs), I see that refcount is a significant factor in most
kernel configurations - and that too uses cmpxchg (without yield).
x86 has an optimized inline version of refcount that helps
significantly. Do you think this is worth looking at for arm64?
=20
> Implementing yield in the CPU may generally be beneficial for SMT designs=
 so
> that the hardware resources aren't wasted when spinning round a busy loop=
.

Yield is probably used in sub-optimal implementations of delay or wait.
It is going to be different across multiple implementations and
revisions (given the description in ARM spec). Having a more yielding(?)
implementation would be equally problematic especially in the lockref
case.

> For this particular discussion (i.e. lockref), however, it seems as thoug=
h
> the cpu_relax() call is questionable to start with.

In case of lockref, taking out the yield/pause and dropping to queued
spinlock after some cycles appears to me to be a better approach.
Relying on the quality of cpu_relax() on the specific processor to
mitigate against contention is going to be tricky anyway.

We will do some more work here, but would appreciate any pointers
based on your experience here.

Thanks,
JC
