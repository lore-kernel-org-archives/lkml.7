Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE81FC10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 00:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9457C2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 00:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VnIBO36n";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="URRenmUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbfJDAJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 20:09:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12718 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729940AbfJDAJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 20:09:28 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9407xNe003118;
        Thu, 3 Oct 2019 17:09:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=IBmN0kLaTp0rvlZlNDmvt39x8j29GC53xnh0vhOFLHs=;
 b=VnIBO36nFvI31/MNT0eD4NKmQmimzeODywrCKcAHzhxkAzHEns0dOUfKbkmJTp3mCdTl
 ar2gpkpgGzqZdS64xxfjSiMYt+JmW73mrmySVO8ynbA78PYib+9kJ6NEAVrztKrml5+M
 TNFZ48hw5fEFhwFWm7BclK2CCtwrX6GQtBM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2vdjadau3u-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 03 Oct 2019 17:09:20 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 3 Oct 2019 17:09:18 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 3 Oct 2019 17:09:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6bvTwh+g3iC4UJc0sk9sdD2qutd8lmivQ1JDEHxueTDamqiSISAtyepe+AVj+8tWOkS4p86+DE2FVekTTT1nbl/pxKmuzxH11od5sCQMfWvzul8bR7FwDJmWGRBtgEuMEdyXYcdXE/olGAaDihX0+HGHdiT3gRcihSZo3bLHuW+ZbYKGzDxN4lfaWuc+8ctloMJ11RJV7ovpCLzGkioH4zHRjl4I8yExOciNoAaXHdFpNFbH+AmU9SV/eL7r1J0fd58RjFTvsKAh+b3+uS8RynVe0G1LAA3PmVWGGjS2SZ1ncqcvBzSAaVHpeWWBiC1rb4VPsjabLOfLAnxOHQnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBmN0kLaTp0rvlZlNDmvt39x8j29GC53xnh0vhOFLHs=;
 b=jgS0ylpNcU9a077F17M+HixCXmprWE+mEQcK2MRTyHQTKjVlHM6Yam7LmEwDzjMUF70s2gFX7eFrUKIcVL0G3m6RkEn7138GLQbyHS3hB+k+yQ0yFaOzU2hAX4kszl0KHNjewza8ovF71V7SPDSiiF/P5a391DhlYMZUVnkBcYuRJ+pW58FV3RirR3c+Zz9gOxhHewNCGccPA4YOFYlvKracava6Bx16OtszwTCDL963awYd5SkQr5/TT5mTpckrOcHG98SVGXW+RB/4Yn7Mcwjxq58ht8RDNZxfV+CmKPjXLX71BSaTvtvM/h1FJIzncmxqHaKjGcokDPUAIMRslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBmN0kLaTp0rvlZlNDmvt39x8j29GC53xnh0vhOFLHs=;
 b=URRenmUjTzNnR0jpGcidkpzZy28wekHs57PX1aFaYA+F2GI64KOOnDiefTEf4Zwu3Dnedx9CNFDLP3oZY/o9M7buEe4RCML8VxC5aeh8W0ilaC5uHxZ+nZkacg7ExP/4ur74FYR6L00X+8enQ0BlWV602Z4icHfCvWzwXEzgEBk=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2786.namprd15.prod.outlook.com (20.179.136.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Fri, 4 Oct 2019 00:09:17 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4%5]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 00:09:17 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Bruce Ashfield <bruce.ashfield@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        "oleg@redhat.com" <oleg@redhat.com>
Subject: Re: ptrace/strace and freezer oddities and v5.2+ kernels
Thread-Topic: ptrace/strace and freezer oddities and v5.2+ kernels
Thread-Index: AQHVeHNRdeEItaYf7UK2FXG2TrAmk6dGmZIAgAAmiACAAOrJAIAAPZIAgAG2jIA=
Date:   Fri, 4 Oct 2019 00:09:17 +0000
Message-ID: <20191004000913.GA5519@castle.DHCP.thefacebook.com>
References: <CADkTA4PBT374CY+UNb85WjQEaNCDodMZu=MgpG8aMYbAu2eOGA@mail.gmail.com>
 <20191002020100.GA6436@castle.dhcp.thefacebook.com>
 <CADkTA4Mbai=Q5xgKH9-md_g73UsHiKnEauVgMWev+-sG8FVNSA@mail.gmail.com>
 <20191002181914.GA7617@castle.DHCP.thefacebook.com>
 <CADkTA4PmGBR7YdOXvi6sEDJ+uztuB7x2G95TCcW2u_iqjwhUNQ@mail.gmail.com>
In-Reply-To: <CADkTA4PmGBR7YdOXvi6sEDJ+uztuB7x2G95TCcW2u_iqjwhUNQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0047.namprd11.prod.outlook.com
 (2603:10b6:a03:80::24) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::8b7a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c0cbb3d-720a-44eb-e5ff-08d7485f18b0
x-ms-traffictypediagnostic: BN8PR15MB2786:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BN8PR15MB2786A2428BEB604626B12757BE9E0@BN8PR15MB2786.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39860400002)(366004)(396003)(189003)(199004)(53754006)(229853002)(66476007)(66556008)(66446008)(64756008)(305945005)(25786009)(186003)(11346002)(54906003)(446003)(478600001)(4326008)(99286004)(46003)(14454004)(2906002)(1076003)(6916009)(6116002)(8936002)(81166006)(33656002)(8676002)(316002)(476003)(486006)(81156014)(966005)(5660300002)(6436002)(6246003)(6486002)(71200400001)(76176011)(71190400001)(7736002)(52116002)(6506007)(53546011)(6306002)(256004)(9686003)(6512007)(14444005)(102836004)(386003)(86362001)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2786;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7NYEERwaGLNNKmLSpKbYuGR8fAnq0fxT9mrighhBWQ5ZSVmk9VPDbXRQooekLGEzHxsjdXi6xLwCFuQUZwMTTkszfJ9D6+ldRqzozhwi9D5sQSgGWzbdbBr+5PHplX/7CVNHyVASszM/vJDjSTNLUlEHJ4S8dNGmuqfzZ20s3gAoSSQdcbMlABCAIp/ioSbFTjnEuNqmaTcTfn2VLM77VHFyPsT0nbPsMf+z2+9jOIzkElIg5lYoASbEKW7tMZIOHkoVxOHKnv3bIgYlZsHy9s5XPxiWuw6wSfIxZaPayg625VK7lx2gT0GY/GM6UhDU+t/TY1R9+5FizzEm11ASUK79JZbc7L5TXlhaDuyyHr5xQKRDcMKv8h8cL5foUI1t2t3PeCaBXZ6nTobYGAmiGEI2bgsg4Q0eylucYet+Y16vEeI/vN0Nx6A5N71JbGjX9DLozkBTlelOTBNZBiSJwQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9683C1777926F24ABAEC0C0E04FC7985@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0cbb3d-720a-44eb-e5ff-08d7485f18b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 00:09:17.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yE6ERgoImo2qj/2GWbVZZnaGRjo9LaxOg3Tki0Mt6xFYWGlg/3Qm27p6pqXjLddW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2786
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-03_09:2019-10-03,2019-10-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910030196
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 05:59:36PM -0400, Bruce Ashfield wrote:
> On Wed, Oct 2, 2019 at 2:19 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Wed, Oct 02, 2019 at 12:18:54AM -0400, Bruce Ashfield wrote:
> > > On Tue, Oct 1, 2019 at 10:01 PM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Tue, Oct 01, 2019 at 12:14:18PM -0400, Bruce Ashfield wrote:
> > > > > Hi all,
> > > > >
> > > >
> > > > Hi Bruce!
> > > >
> > > > > The Yocto project has an upcoming release this fall, and I've bee=
n trying to
> > > > > sort through some issues that are happening with kernel 5.2+ .. a=
lthough
> > > > > there is a specific yocto kernel, I'm testing and seeing this wit=
h
> > > > > normal / vanilla
> > > > > mainline kernels as well.
> > > > >
> > > > > I'm running into an issue that is *very* similar to the one discu=
ssed in the
> > > > > [REGRESSION] ptrace broken from "cgroup: cgroup v2 freezer" (76f9=
69e)
> > > > > thread from this past may: https://lkml.org/lkml/2019/5/12/272
> > > > >
> > > > > I can confirm that I have the proposed fix for the initial regres=
sion report in
> > > > > my build (05b2892637 [signal: unconditionally leave the frozen st=
ate
> > > > > in ptrace_stop()]),
> > > > > but yet I'm still seeing 3 or 4 minute runtimes on a test that us=
ed to take 3 or
> > > > > 4 seconds.
> > > >
> > > > So, the problem is that you're experiencing a severe performance re=
gression
> > > > in some test, right?
> > >
> > > Hi Roman,
> > >
> > > Correct. In particular, running some of the tests that ship with stra=
ce itself.
> > > The performance change is so drastic, that it definitely makes you wo=
nder
> > > "What have I done wrong? Since everyone must be seeing this" .. and I
> > > always blame myself first.
> > >
> > > >
> > > > >
> > > > > This isn't my normal area of kernel hacking, so I've so far come =
up empty
> > > > > at either fixing it myself, or figuring out a viable workaround. =
(well, I can
> > > > > "fix" it by remove the cgroup_enter_frozen() call in ptrace_stop =
...
> > > > > but obviously,
> > > > > that is just me trying to figure out what could be causing the is=
sue).
> > > > >
> > > > > As part of the release, we run tests that come with various appli=
cations. The
> > > > > ptrace test that is causing us issues can be boiled down to this:
> > > > >
> > > > > $ cd /usr/lib/strace/ptest/tests
> > > > > $ time ../strace -o log -qq -esignal=3Dnone -e/clock ./printpath-=
umovestr>ttt
> > > > >
> > > > > (I can provide as many details as needed, but I wanted to keep th=
is initial
> > > > > email relatively short).
> > > > >
> > > > > I'll continue to debug and attempt to fix this myself, but I grab=
bed the
> > > > > email list from the regression report in May to see if anyone has=
 any ideas
> > > > > or angles that I haven't covered in my search for a fix.
> > > >
> > > > I'm definitely happy to help, but it's a bit hard to say anything f=
rom what
> > > > you've provided. I'm not aware of any open issues with the freezer =
except
> > > > some spurious cgroup frozen<->not frozen transitions which can happ=
en in some
> > > > cases. If you'll describe how can I reproduce the issue, and I'll t=
ry to take
> > > > a look asap.
> > >
> > > That would be great.
> > >
> > > I'll attempt to remove all of the build system specifics out of this
> > > (and Richard Purdie
> > > on the cc' of this can probably help provide more details / setup inf=
o as well).
> > >
> > > We are running the built-in tests of strace. So here's a cut and past=
e of what I
> > > did to get the tests available (ignore/skip what is common sense or i=
sn't needed
> > > in your test rig).
> > >
> > > % git clone https://github.com/strace/strace.git
> > > % cd strace
> > > % ./bootstrap
> > > # the --enable flag isn't strictly required, but may break on some
> > > build machines
> > > % ./configure --enable-mpers=3Dno
> > > % make
> > > % make check-TESTS
> > >
> > > That last step will not only build the tests, but run them all .. so
> > > ^c the run once
> > > it starts, since it is a lot of noise (we carry a patch to strace tha=
t
> > > allows us to build
> > > the tests without running them).
> > >
> > > % cd tests
> > > % time strace -o log -qq -esignal=3Dnone -e/clock ./printpath-umovest=
r > fff
> > > real    0m2.566s
> > > user    0m0.284s
> > > sys     0m2.519
> > >
> > > On pre-cgroup2 freezer kernels, you see a run time similar to what I =
have above.
> > > On the newer kernels we are testing, it is taking 3 or 4 minutes to
> > > run the test.
> > >
> > > I hope that is simple enough to setup and try. Since I've been seeing
> > > this on both
> > > mainline kernels and the yocto reference kernels, I don't think it is
> > > something that
> > > I'm carrying in the distro/reference kernel that is causing this (but
> > > again, I always
> > > blame myself first). If you don't see that same run time, then that
> > > does point the finger
> > > back at what we are doing and I'll have to apologize for chewing up s=
ome of your
> > > time.
> >
> > Thank you for the detailed description!
> > I'll try to reproduce the issue and will be back
> > by the end of the week.
>=20
> Thanks again!
>=20
> While discussing the issue with a few yocto folks today, it came up that
> someone wasn't seeing the same behaviour on the opensuse v5.2 kernel
> (but I've yet to figure out exactly where to find that tree) .. but when =
I do,
> I'll try and confirm that and will look for patches or config differences=
 that
> could explain the results.
>=20
> I did confirm that 5.3 shows the same thing today, and I'll do a 5.4-rc1 =
test
> tomorrow.
>=20
> We are also primarily reproducing the issue on qemux86-64, so I'm also
> going to try and rule out qemu (but the same version of qemu with just
> the kernel changing shows the issue).

Hi Bruce!

I've tried to follow your steps, but unfortunately failed to reproduce the =
issue.
I've executed the test on my desktop running 5.2 and cgroup v1 (Fedora 30),
and also a qemu vm with vanilla 5.1 and 5.3 and cgroup v2 mounted by defaul=
t.
In all cases the test execution time was about 4.5 seconds.

Looks like something makes your setup special. If you'll provide your
build config, qemu arguments or any other configuration files, I can try
to reproduce it on my side.

Thanks!

Roman
