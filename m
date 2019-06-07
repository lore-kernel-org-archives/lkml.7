Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BB3C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23DD20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="m2kClsUV";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="OA9a2qbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfFGH1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:27:16 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:36532 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726956AbfFGH1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:27:16 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x577QKiH022054;
        Fri, 7 Jun 2019 00:27:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=d9tUm8qvaZ7QAT6fGnnMsgcspRMuCjYcSQYT++CPYq8=;
 b=m2kClsUVS94E+FFnzPfXWfnCjarfGpqkg5hzMr9CdInsrphtwX3WV7/2vbMFTASlHQWH
 iP7vX2AnvI8JrzfmsuxHSozCb1JgavlfJ805LShzTB+Vg0Sf2E/KRNTnN3EkuTJDShkZ
 4bk+tSJw66xnKJ04RG1/qFGbxYzRdvY88QRLd/ZTiwJTmF4lxjxCISGZ/q1s0Mf4z3AI
 vh98knd/wEtAGn2IX70tKnWGQTOyR2YGPu0ZnJ2ZP4LvMggz+EB1x7/8f9/sMXC/tLNu
 3zHEXH9lyeTIVx3JPzGYYG0s2ujlWMT9R9UliSiRonUAe1Wl60T6TvFHKK8fw9Duh15F sw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sydhfs67u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 07 Jun 2019 00:27:04 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 7 Jun
 2019 00:27:03 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.58) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Jun 2019 00:27:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9tUm8qvaZ7QAT6fGnnMsgcspRMuCjYcSQYT++CPYq8=;
 b=OA9a2qbX4hg+iytFbWvBsNY0o4hS603zMO6bxg88w+iyYXVhsIp9evshv0e2c9iy2bhL4cUlYuEYPsIoOwfoi0XGiv85dB1Era3GZXH04/j8cFiXzO1WbHLypeqLCZ4lJgHLOJ2TVqrID5XgCV9itleGGoxoUmPCGidZyZBBOvc=
Received: from DM5PR18MB1578.namprd18.prod.outlook.com (10.175.224.136) by
 DM5PR18MB2198.namprd18.prod.outlook.com (52.132.143.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Fri, 7 Jun 2019 07:27:02 +0000
Received: from DM5PR18MB1578.namprd18.prod.outlook.com
 ([fe80::e42c:8f1f:ac4d:c16e]) by DM5PR18MB1578.namprd18.prod.outlook.com
 ([fe80::e42c:8f1f:ac4d:c16e%6]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 07:27:02 +0000
From:   Jan Glauber <jglauber@marvell.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Glauber <jglauber@cavium.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Jayachandran Chandrasekharan Nair" <jnair@marvell.com>
Subject: Re: [PATCH] lockref: Limit number of cmpxchg loop retries
Thread-Topic: [PATCH] lockref: Limit number of cmpxchg loop retries
Thread-Index: AQHVHFKKV4nY33iz10+fZHwc2kb4SKaPzBsA
Date:   Fri, 7 Jun 2019 07:27:01 +0000
Message-ID: <20190607072652.GA5522@hc>
References: <CAHk-=wjPqcPYkiWKFc=R3+18DXqEhV+Nfbo=JWa32Xp8Nze67g@mail.gmail.com>
 <20190605134849.28108-1-jglauber@marvell.com>
 <CAHk-=whPbMBGWiTdC3wqXMGMaCCHQ4WQh5ObB5iwa9gk-nCtzA@mail.gmail.com>
 <20190606080317.GA10606@hc> <20190606094154.GB6795@fuggles.cambridge.arm.com>
 <20190606102803.GA15499@hc>
In-Reply-To: <20190606102803.GA15499@hc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:203:91::15) To DM5PR18MB1578.namprd18.prod.outlook.com
 (2603:10b6:3:14d::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [78.43.215.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5ca3509-632c-4a9c-4446-08d6eb198787
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR18MB2198;
x-ms-traffictypediagnostic: DM5PR18MB2198:
x-microsoft-antispam-prvs: <DM5PR18MB2198451FA5A9B5DE70BF9E2AD8100@DM5PR18MB2198.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(7916004)(346002)(366004)(136003)(39850400004)(396003)(376002)(199004)(189003)(6436002)(53936002)(486006)(99286004)(14454004)(386003)(68736007)(256004)(14444005)(2906002)(478600001)(9686003)(6506007)(316002)(6512007)(102836004)(54906003)(53546011)(446003)(86362001)(6486002)(26005)(81156014)(8676002)(81166006)(229853002)(52116002)(11346002)(186003)(476003)(71200400001)(64756008)(8936002)(76176011)(71190400001)(107886003)(4326008)(6916009)(3846002)(6246003)(6116002)(1076003)(66476007)(305945005)(73956011)(5660300002)(66946007)(33716001)(66446008)(33656002)(7736002)(66066001)(66556008)(25786009)(40753002)(133343001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB2198;H:DM5PR18MB1578.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kdb45I9MamZwrgxYR/3ixNtMjmFwYV8ot2CxSZevOsBckIxTQHfW0yks7shwV6/86iOEAyicDsS+dUn6JpORlB3BOVGViyLvhrdhHyWvNwA2dvnxK/4gK1Ze/ZA8AHPDsYQcTD41gZ0DGeiTso8vFplhiZRm1ftStO8WYJJkJP0ZvQV/CmZTIuZP9d5bhanTa1azHvbFA149fFK/66BZAcYne+DqEFmY0HjAjzkosPM429BdQ49T39QOtJUh1UIJJKt2Zwzy2o+0vM0RrxqZC/bioNeg9XzIP1AldZNjmq0ZQgtJuOieLfdDzl8srToIe9eiNTrXnwy3T2HVNaI1cjDpIh/2n/bZsfYhcc6HXRuGU6I2+ygaoCU4qv3MF8NZ24dVs8xX4ML9unIc5LurFTZ/7ZNhUUDTPgCEBskfjr4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <74CB74D9CE3D1A429DCFC8639679F123@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ca3509-632c-4a9c-4446-08d6eb198787
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 07:27:02.0009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jglauber@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB2198
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-07_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:28:12AM +0000, Jan Glauber wrote:
> On Thu, Jun 06, 2019 at 10:41:54AM +0100, Will Deacon wrote:
> > On Thu, Jun 06, 2019 at 08:03:27AM +0000, Jan Glauber wrote:
> > > On Wed, Jun 05, 2019 at 01:16:46PM -0700, Linus Torvalds wrote:
> > > > On Wed, Jun 5, 2019 at 6:49 AM Jan Glauber <jglauber@cavium.com> wr=
ote:
> > > > >
> > > > > Add an upper bound to the loop to force the fallback to spinlocks
> > > > > after some time. A retry value of 100 should not impact any hardw=
are
> > > > > that does not have this issue.
> > > > >
> > > > > With the retry limit the performance of an open-close testcase
> > > > > improved between 60-70% on ThunderX2.
> > > >=20
> > > > Btw, did you do any kind of performance analysis across different
> > > > retry limit values?
> > >=20
> > > I tried 15/50/100/200/500, results were largely identical up to 100.
> > > For SMT=3D4 a higher retry value might be better, but unless we can a=
dd a
> > > sysctl value 100 looked like a good compromise to me.
> >=20
> > Perhaps I'm just getting confused pre-morning-coffee, but I thought the
> > original complaint (and the reason for this patch even existing) was th=
at
> > when many CPUs were hammering the lockref then performance tanked? In w=
hich
> > case, increasing the threshold as the number of CPUs increases seems
> > counter-intuitive to me because it suggests that the larger the system,
> > the harder we should try to make the cmpxchg work.
>=20
> For SMT=3D4 the top hit I see is queued_spin_lock_slowpath(). Maybe this =
is more
> costly with more threads, so trying harder to use lockref-cmpxchg makes
> the microbenchmark faster in that case?

To clarify, with 224 threads & CPUs queued_spin_lock_slowpath is the top hi=
t
even without a retry limit in lockref. This could be unrelated to the lockr=
ef
fallback, it looks like it's coming from the spinlock in:
	do_sys_open -> get_unused_fd_flags -> __alloc_fd

--Jan
