Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0F4C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A4E21D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PqrpMmjk";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RTnB3Kwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfJBST2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 14:19:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33138 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbfJBST2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:19:28 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92II1J0013093;
        Wed, 2 Oct 2019 11:19:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=cL3ydCQS+AOYB8nsJDBJ97cV7dhwLA2/EZ73W0Cl89w=;
 b=PqrpMmjkURdO/e82L0Hw7PXMVdYLAz4Nmsj942j8mJg85AEIkDDNFGU+YjrlOkXMn74Q
 y5mi+OEVugWEC9jDgZMd0jszGONyquToZ6ARce612bUxHJrjiY0kRFi+L0poRL3ecZpB
 08kNDuWwMwslkNEE/dteqUJegsFSXidhiQU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vc9fw6cjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 02 Oct 2019 11:19:22 -0700
Received: from prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 2 Oct 2019 11:19:21 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx01.TheFacebook.com (2620:10d:c081:6::15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 2 Oct 2019 11:19:21 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 2 Oct 2019 11:19:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsqcvmC6udK3z2OUPVU27JZnEULyLTw4Hti3oYk28ckyMsYuH3fNkZ0DDQRdZ8UbGlA9S3DIML6lkayIAm4Qn4GQsElu+vwenTWgWtcyo+WdbiLrwbj3wReU9rOsek28MN8jttyCmf//wB/+9GqrvOzKFTmfTc92cEU7sp5oUwR9FuohXCPwkzvnPYclcHZvDcMRkmkGbgwjSocvjYGuK7CAPvSFyUfd/neiVDi3NjENIgVnRtCXFqvsyev9qQWRb5BXb8t2h9y17dCay674GJtPxBQ+jNG4Dp0grcbvYseJLAiVeAwuP53fxCX1bbKnfl4ZTRuSrCV0nPpEqynGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cL3ydCQS+AOYB8nsJDBJ97cV7dhwLA2/EZ73W0Cl89w=;
 b=YFvneVh2Pmujwrt+D9K4Sze1BEW/KQ2QgQrvNl0EvDIhykik+dL2ZcIG7ITLu6tKKmxhO9EojqP+TGC8q5BJ0d0kGKYDEQiJ5kxLR/Vx14YLSyB8r0z6k6zRTXsrGlYXQOv+rBkl15T8DtYPyWSvy/m71XPSCfc+fVx4q8Ig9H1nXtqul50QNnItVVd4JJYYyURlkCK4yK0k/LKwa5fEUV78ptrZvPcRN5bIF4ml7d526fXQudwMTxKRO572OL6u8HsnkHG1hF8Mvx9EgSD1VnRLlIutQGS01pTNF3czx+Voz0JTqgbsjHrR/XJiqYkfg1fuCwRtEyTMqLzy9qd/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cL3ydCQS+AOYB8nsJDBJ97cV7dhwLA2/EZ73W0Cl89w=;
 b=RTnB3KwysWgxLm+kj/alU9uJOH60ak9Md/sPhGJxrKm8+a2auJJ+09FCHEhZQNjdxKZMGEQaZXTLiRShdVHYndHYMphTHRenbyc3bT5b1VM2fK2BIf0JCQ7zIWj0ONxWBDQ0g0SV7+bWgiwsKvDTAbROTBdNVikfyNPOs8hjMjc=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2819.namprd15.prod.outlook.com (20.179.138.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Wed, 2 Oct 2019 18:19:19 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4%5]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 18:19:19 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Bruce Ashfield <bruce.ashfield@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        "oleg@redhat.com" <oleg@redhat.com>
Subject: Re: ptrace/strace and freezer oddities and v5.2+ kernels
Thread-Topic: ptrace/strace and freezer oddities and v5.2+ kernels
Thread-Index: AQHVeHNRdeEItaYf7UK2FXG2TrAmk6dGmZIAgAAmiACAAOrJAA==
Date:   Wed, 2 Oct 2019 18:19:19 +0000
Message-ID: <20191002181914.GA7617@castle.DHCP.thefacebook.com>
References: <CADkTA4PBT374CY+UNb85WjQEaNCDodMZu=MgpG8aMYbAu2eOGA@mail.gmail.com>
 <20191002020100.GA6436@castle.dhcp.thefacebook.com>
 <CADkTA4Mbai=Q5xgKH9-md_g73UsHiKnEauVgMWev+-sG8FVNSA@mail.gmail.com>
In-Reply-To: <CADkTA4Mbai=Q5xgKH9-md_g73UsHiKnEauVgMWev+-sG8FVNSA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0041.namprd21.prod.outlook.com
 (2603:10b6:300:129::27) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::bd5d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf3a3e3f-f976-4d4f-5390-08d747650aa1
x-ms-traffictypediagnostic: BN8PR15MB2819:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BN8PR15MB281961EAFAE2AD8A05668EA5BE9C0@BN8PR15MB2819.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(39860400002)(396003)(53754006)(189003)(199004)(6306002)(6916009)(229853002)(6486002)(6436002)(6116002)(7736002)(305945005)(2906002)(478600001)(14444005)(256004)(1076003)(54906003)(316002)(8936002)(6246003)(9686003)(6512007)(81166006)(81156014)(8676002)(25786009)(46003)(66446008)(71190400001)(71200400001)(66556008)(66476007)(64756008)(33656002)(66946007)(11346002)(486006)(5660300002)(446003)(4326008)(14454004)(52116002)(102836004)(76176011)(53546011)(6506007)(386003)(86362001)(186003)(99286004)(476003)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2819;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G1+TPNqeiD6UY1lEI0nEhpv1L5fsOiJmqsgmDjS4cYdDR92VX9O/gIO7FoHhl7RM3tjk1+SBi1Gc/psao6KGF59SrTffjnccNsH1PggdF5CfsXpk8HRtADuipiBhylpKlpC2nYIGjsYuAOSOR8trTzalmO5BIiPRRoRlh8lTS7nTuRljI9k5i02SI9vqeJaBfNS1WpXT+xAzxhV+oA0YUZy4tZxKTQAhR9cysGOblI28osu4vqfUJkY1aT1upG682AISldjOwxeMwhfdO3QQHps6adi7vs69y4O86PGXq/FV1VuJBdNgU8yryzEOr5GPZSaF6C6j9D28rItiw0G5N15RtwC075xpVtWcprt/N/1Bv4IL7J9ONYjVSxXDV7gc0/PL0kyJzCoNQGdKrhmDpV6OTifDTbIB2htqyd9QuWX4ywkNrGdRGP91KJC7E8tgS/yGr1IIYEZ1Vf+I+eIhbA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9B65DCA7DE133449A171214816B10EA7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3a3e3f-f976-4d4f-5390-08d747650aa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 18:19:19.4626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmcT2iVgh39RwEBKEGBNPY0farzXoXMABV6YnbuFGxow/qQNEsr3DvxcU4NEDIhX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2819
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-02_08:2019-10-01,2019-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910020149
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 12:18:54AM -0400, Bruce Ashfield wrote:
> On Tue, Oct 1, 2019 at 10:01 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Oct 01, 2019 at 12:14:18PM -0400, Bruce Ashfield wrote:
> > > Hi all,
> > >
> >
> > Hi Bruce!
> >
> > > The Yocto project has an upcoming release this fall, and I've been tr=
ying to
> > > sort through some issues that are happening with kernel 5.2+ .. altho=
ugh
> > > there is a specific yocto kernel, I'm testing and seeing this with
> > > normal / vanilla
> > > mainline kernels as well.
> > >
> > > I'm running into an issue that is *very* similar to the one discussed=
 in the
> > > [REGRESSION] ptrace broken from "cgroup: cgroup v2 freezer" (76f969e)
> > > thread from this past may: https://lkml.org/lkml/2019/5/12/272
> > >
> > > I can confirm that I have the proposed fix for the initial regression=
 report in
> > > my build (05b2892637 [signal: unconditionally leave the frozen state
> > > in ptrace_stop()]),
> > > but yet I'm still seeing 3 or 4 minute runtimes on a test that used t=
o take 3 or
> > > 4 seconds.
> >
> > So, the problem is that you're experiencing a severe performance regres=
sion
> > in some test, right?
>=20
> Hi Roman,
>=20
> Correct. In particular, running some of the tests that ship with strace i=
tself.
> The performance change is so drastic, that it definitely makes you wonder
> "What have I done wrong? Since everyone must be seeing this" .. and I
> always blame myself first.
>=20
> >
> > >
> > > This isn't my normal area of kernel hacking, so I've so far come up e=
mpty
> > > at either fixing it myself, or figuring out a viable workaround. (wel=
l, I can
> > > "fix" it by remove the cgroup_enter_frozen() call in ptrace_stop ...
> > > but obviously,
> > > that is just me trying to figure out what could be causing the issue)=
.
> > >
> > > As part of the release, we run tests that come with various applicati=
ons. The
> > > ptrace test that is causing us issues can be boiled down to this:
> > >
> > > $ cd /usr/lib/strace/ptest/tests
> > > $ time ../strace -o log -qq -esignal=3Dnone -e/clock ./printpath-umov=
estr>ttt
> > >
> > > (I can provide as many details as needed, but I wanted to keep this i=
nitial
> > > email relatively short).
> > >
> > > I'll continue to debug and attempt to fix this myself, but I grabbed =
the
> > > email list from the regression report in May to see if anyone has any=
 ideas
> > > or angles that I haven't covered in my search for a fix.
> >
> > I'm definitely happy to help, but it's a bit hard to say anything from =
what
> > you've provided. I'm not aware of any open issues with the freezer exce=
pt
> > some spurious cgroup frozen<->not frozen transitions which can happen i=
n some
> > cases. If you'll describe how can I reproduce the issue, and I'll try t=
o take
> > a look asap.
>=20
> That would be great.
>=20
> I'll attempt to remove all of the build system specifics out of this
> (and Richard Purdie
> on the cc' of this can probably help provide more details / setup info as=
 well).
>=20
> We are running the built-in tests of strace. So here's a cut and paste of=
 what I
> did to get the tests available (ignore/skip what is common sense or isn't=
 needed
> in your test rig).
>=20
> % git clone https://github.com/strace/strace.git
> % cd strace
> % ./bootstrap
> # the --enable flag isn't strictly required, but may break on some
> build machines
> % ./configure --enable-mpers=3Dno
> % make
> % make check-TESTS
>=20
> That last step will not only build the tests, but run them all .. so
> ^c the run once
> it starts, since it is a lot of noise (we carry a patch to strace that
> allows us to build
> the tests without running them).
>=20
> % cd tests
> % time strace -o log -qq -esignal=3Dnone -e/clock ./printpath-umovestr > =
fff
> real    0m2.566s
> user    0m0.284s
> sys     0m2.519
>=20
> On pre-cgroup2 freezer kernels, you see a run time similar to what I have=
 above.
> On the newer kernels we are testing, it is taking 3 or 4 minutes to
> run the test.
>=20
> I hope that is simple enough to setup and try. Since I've been seeing
> this on both
> mainline kernels and the yocto reference kernels, I don't think it is
> something that
> I'm carrying in the distro/reference kernel that is causing this (but
> again, I always
> blame myself first). If you don't see that same run time, then that
> does point the finger
> back at what we are doing and I'll have to apologize for chewing up some =
of your
> time.

Thank you for the detailed description!
I'll try to reproduce the issue and will be back
by the end of the week.

Thank you!

Roman
