Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F16C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8312166E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WqK60o5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbfKFPWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:22:37 -0500
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:22595
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727631AbfKFPWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:22:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMMLz30/+2JT3q2PD2iDEtQRCV1jVHz9fVIutsp3rY9CGCMcpyyrwhYE/6lzXQLnQaUvsSwBPw5WzK8iqnI3LZZzw8YOC8X44fJlDLw9mRI3AAfzr2wfkd8eqoeULnX7zH4wOnvuKiPxjhtsGwkjIl0hW34NyV8hiEi6+c9oZeiLTwSsyAE6nPodkovk4BBItvEJ0iyonusnf2cNbALfiDHRMboNmP0vLFemteuYWW2zPvMc5PXe4KnlMh9kbAxHDLrbAgiY7i/tu1wW080Nq6HIgoRm1Z81nzMrFIk/S040ddrccd28VU1JSoV66jD6ZlfPVZFLyj7KtkPxb+0LLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnIDRHv2jZCJTGNPT+IEkgl7BGgllzxiBeZ/8daEZPA=;
 b=V5yV9MBPC7fafF29O9LxjPtN015th13hfzq0kE7LqGr0MRnEMtwsXXxe4IVHdY+H+iRXJKMmX+rXieZNj2O1JlKP0mDkKEJSWfki1/fKBncA1WCj1J7sMLIDMxQgBZjD67iMQrK2Pk5Ei1wdUYjDL+mUwiLzHdc5L3sC0QTMocR8Ko+YricvVV3tlKkUEM/jn4NbMsD6Ezaic1a4gFKkgCZ06IttKqaN0+Ub4hmHr/FS7H1e1IYFCflSHTRZktQH+wq8J4hd8doTMo9vexhWiZtklenuHlSsmM/33DGxIp9jyxb9k2lf/U+CKvZ/jdz7QT5qwOqEHvwrNGN7M5wBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnIDRHv2jZCJTGNPT+IEkgl7BGgllzxiBeZ/8daEZPA=;
 b=WqK60o5CvXWpjw4pu6GikZik7Xm1Bz7MJtOvAIKN5oP+UlMFLw3+onoZcCsmiKAP5bPdqeNAViCcQodRbsUolHZoh3X6E/JAp4Eshhao9dnwXj9kJ1Qej4Bj9k6ogLPGD/qFGAK0U0dH5lMvnfF28QDSDMeNw5bi11cKRSy4Uy0=
Received: from DB6PR0402MB2789.eurprd04.prod.outlook.com (10.172.245.7) by
 DB6PR0402MB2805.eurprd04.prod.outlook.com (10.172.245.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 15:22:31 +0000
Received: from DB6PR0402MB2789.eurprd04.prod.outlook.com
 ([fe80::4a8:4223:6954:59b9]) by DB6PR0402MB2789.eurprd04.prod.outlook.com
 ([fe80::4a8:4223:6954:59b9%9]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 15:22:31 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: RE: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to redirect STP
 to CPU
Thread-Topic: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to redirect
 STP to CPU
Thread-Index: AQHVk9VwUttQp4rnGEyeNWyFfbjmDKd8oR0AgAAAhWCAABrTAIABX2xAgAAfjgCAAAVHsA==
Date:   Wed, 6 Nov 2019 15:22:30 +0000
Message-ID: <DB6PR0402MB27896E3229CC3397F26122EAE0790@DB6PR0402MB2789.eurprd04.prod.outlook.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
 <1572957275-23383-7-git-send-email-ioana.ciornei@nxp.com>
 <20191105142202.GC7189@lunn.ch>
 <VI1PR0402MB28007254BB7614477CED4DBCE07E0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
 <20191105155954.GE17620@lunn.ch>
 <DB6PR0402MB27899B298481E7A3460BB9BFE0790@DB6PR0402MB2789.eurprd04.prod.outlook.com>
 <20191106145038.GB30762@lunn.ch>
In-Reply-To: <20191106145038.GB30762@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ed0293e-94df-46bc-6b1b-08d762cd2434
x-ms-traffictypediagnostic: DB6PR0402MB2805:
x-microsoft-antispam-prvs: <DB6PR0402MB280525B7A72CC58E13FD95B4E0790@DB6PR0402MB2805.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(189003)(199004)(26005)(6116002)(2906002)(66066001)(186003)(102836004)(8676002)(229853002)(55016002)(54906003)(25786009)(316002)(9686003)(476003)(446003)(6506007)(6436002)(11346002)(52536014)(5660300002)(71200400001)(81156014)(81166006)(86362001)(6246003)(7736002)(33656002)(64756008)(66556008)(74316002)(66476007)(66446008)(76116006)(305945005)(8936002)(256004)(7696005)(66946007)(71190400001)(14454004)(4326008)(478600001)(6916009)(99286004)(3846002)(76176011)(44832011)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2805;H:DB6PR0402MB2789.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tTPlp0sI/ZMi2/rXbv3POjC6LgJ3s78E6KO1HP8eCgNg3o4tBjNHPsaME+G5/B2YnyWLbw6Phc6gK+95EhwzyrQKMF6MyefwmV+40JwOq3PeId2CN3p2AdJFdpceKMHC+f3/aQi0ngIz9KSybE4q7e7I1jyrq75B1xNxYRFv19CKwW3f39jaXyL84+Va56vV/TobsR7dfwebfe+7LgTMVNqZ8KExHcRjppiH0WaoDr1n9Cy5bD2l96b0Faho63o3uvSCCS5pr0u9SSwucwcNgsu7sAEMTWfcN4FGymNiul7fmdM1B8xXP0rgPIJLa9VBZCFTAKnZxx6AnulTfOzXwuCKj8IuNWO/lhdXxrFnqbpKdYYY54O8b/Dzu1m4lsHWlLhZYgc9adHvdjXtj6Eg61Luaklva9PSoRNag0cFrJWb7hSEqc7KStzCoi10iRbg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed0293e-94df-46bc-6b1b-08d762cd2434
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 15:22:30.8428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LcH5maa+cOntm2TCIkPKyaQy5Tr3nDjCBMW3FZXaKK8jG1vqYEdCIYOb0rdnoeDzeLdC4IJ9I7IQmHHbWNki8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to redirec=
t
> STP to CPU
>=20
> On Wed, Nov 06, 2019 at 01:47:47PM +0000, Ioana Ciornei wrote:
> > > Subject: Re: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to
> > > redirect STP to CPU
> > >
> > > > The control queues do not form an actual interface in the sense
> > > > that the CPU does not receive unknown unicast, broadcast and
> > > > multicast frames by default.  For each frame that we want to
> > > > direct to the CPU we must add an ACL entry.
> > >
> > > So this appears to be one of the dumbest switches so far :-(
> >
> > To be fair, the actual hardware can do much more.
> > The problem here is that the firmware models the switch in a non-Linux
> style.
>=20
> Well, the whole hardware is not very linux like!

Well, that's a pretty good description of what I am dealing with here.

>=20
> > >
> > > Can you add an ACL which is all L2 broadcast/multicast?  That would
> > > be a good first step.
> >
> > I can add that but it would not be enough.
> > For example, unknown unicast would not be matched thus would not
> reach the CPU.
>=20
> Not ideal, but you could rely on ARP and ND. Any conversation should star=
t
> with a broadcast/multicast ARP or ND. The bridge should add an FDB based
> on what it just learned, and traffic should flow. And when the interface =
is not
> part of a bridge, you don't care about unknown unicast.

If I do this, I would have an L2 switch that relies on IP traffic passing t=
hrough it.
Also, if I use ACLs to model dynamic FDB entries than I will need to "softw=
are age
the ACLs... which is at least not ideal.

>=20
> > > Does the ACL stop further processing of the frame? Ideally you want
> > > the switch to also flood broadcast/multicast out other ports, if
> > > they are in a bridge. If it cannot, you end up with the software brid=
ge
> doing the flooding.
> >
> > Yes, the ACL stops any further processing.
>=20
> O.K, the software bridge can handle that. It is not the best use for hard=
ware,
> but will work.
>=20
> > Your assumption is true, learning, with the current implementation, is =
not
> possible for CPU frames.
> > In .ndo_start_xmit() we inject directly into the switch port's Tx queue=
s,
> thus bypassing the entire learning process.
> >
> > All in all, I do not see a way out just by using the ACL mechanism (bec=
ause
> of unknown unicast frames).
> >
> > I have to talk in detail with the firmware team, but from what I can
> understand if we make the following changes in firmware it would better f=
it
> the Linux framework:
> >  * make the CPU receive unknown unicast, broadcast and multicast
> > frames by default (without any ACLs)
>=20
> Yes, that is the first step. Some switches go further. Link local L2 fram=
es are
> always passed to the CPU. All ARP and ND packets are passed, IGMP, etc.
> Once you have the first step working, you start thinking about the next s=
tep.
> That is blocking some of this traffic hitting the CPU. IGMP snooping is o=
ne
> way. You need to continue receiving the IGMP frames, but not the multicas=
t
> traffic. But they use the same MAC address. So the switch needs to look
> deeper into the packet.
>=20
> > * frames originated on the CPU should not bypass the learning
> >   process (it should have its own Tx queues that go through the
> >   same learning process)
>=20
> Learning is needed. But maybe not its own Tx queue. It depends on the QoS
> architecture. Ideally you want QoS to work on CPU frames, so they get put
> into the correct egress queue for there QoS level.
>=20
> With DSA this is simpler, since you have a physical interface connected t=
o the
> CPU, so you can use that interface number in all your tables. But with a =
pure
> switchdev driver, each port effectively becomes two ports, one to the fro=
nt
> panel and one to the CPU port. And your tables need to differentiate this=
.
>=20
>      Andrew

Andrew, thanks for all the advice given but I feel like I have to see if th=
e firmware
can be changed to better model the CPU traffic before adding a lot of hacks=
 and
pushing something with the current implementation.

Ioana

