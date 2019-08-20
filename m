Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5719C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83632082F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="OmLW5u4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfHTKlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 06:41:20 -0400
Received: from mail-eopbgr720088.outbound.protection.outlook.com ([40.107.72.88]:35936
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728842AbfHTKlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:41:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDz0jHFoSzRzxT9J6T/yVh7Z//SQrRbX2QMKSqWKMBxX9w73UYR+f6AnDV+G1agZY9l1IwuaqR6XdKHkygI/JePTJFWVIAC32zOMUGus/nM20ibCU9nAijv+trTaUdFBgp7YnOg6jSZq3QhLo+ahCC8u4NsISSAEZgSYaJlYdbwWTSERbS2r84xsWXaPeuv4lS2bkb73my6EnP4tH3nGwUiip2MQLn+OdSnABnaBXFYXhqqj4eiNw2+xbS9feO/mSQFSkvVyJaMX4oGsAtZUlytHdQNXeGt4zLLRav8txDTViQLj3sZ+tOY53yz6vu7I3optpXLPSyaSD7jLOPVXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1B0ttXKBUVnx709ARvmQLu2Rz1k/Y6tXYiVQl/mg8Y=;
 b=CSfcRT1Gz0c7xDLTa/WNAj+cbBODWtPtpt6mIoq+bVuRwYZVhqwXv7e1gA5CrSbRieaim7jwOYua98FOMwhaZIzxzbsmb1FFHsFjZj4wkDr3RXv9ZQ+vNhAGb0CHWAFmHYUOi+eDjGmU5Rfr+uTYHzkZ+NBe3TjsmlpyYWwgWFI6Y2ftTVPw6yTL/PKSFD0ax/U3nMotxSeb+OHPkwGWo+WsBMMcNkax3zgWiS9cXgC9PYg82NW4YjlS2UgGq7Q6obaF3VOS/x4Nt/AE5mfE3rNCNyFVj612vCRM61uluGmIj7jougDjJs8wXJb+TXeX/7y9xcceTINV/yUp5dXksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1B0ttXKBUVnx709ARvmQLu2Rz1k/Y6tXYiVQl/mg8Y=;
 b=OmLW5u4GQrQVWtPWMNbsK9m3VzAJO/c59M1mtFtMTwyFgxzK46u4OYYQFunmiaF7oDRJVW3dHm8+Y2i5hPKv6lLfO1J35hHn4yr8Q1Op3dSxqZ+D4wUrvLOb4gIuANqA4dbmgO6sacKHy8hWd9RnG3xXmnKQ5J5rpJIvCaqi2xA=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3575.namprd03.prod.outlook.com (52.135.213.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 10:41:16 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Tue, 20 Aug 2019
 10:41:15 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
CC:     Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] kprobes: adjust kprobe addr for KPROBES_ON_FTRACE
Thread-Topic: [PATCH v2 2/3] kprobes: adjust kprobe addr for KPROBES_ON_FTRACE
Thread-Index: AQHVVwrOlWp5wQEBs0CTmAwXsgLkUqcD0kYAgAAEH4A=
Date:   Tue, 20 Aug 2019 10:41:15 +0000
Message-ID: <20190820183009.1ef539cf@xhacker.debian>
References: <20190820113928.1971900c@xhacker.debian>
        <20190820114224.0c8963c4@xhacker.debian>
        <1566295437.yqnot2qd2e.naveen@linux.ibm.com>
In-Reply-To: <1566295437.yqnot2qd2e.naveen@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY1PR01CA0199.jpnprd01.prod.outlook.com (2603:1096:403::29)
 To BYAPR03MB4773.namprd03.prod.outlook.com (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f866b5f0-b77f-4903-288a-08d7255aed5a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR03MB3575;
x-ms-traffictypediagnostic: BYAPR03MB3575:
x-microsoft-antispam-prvs: <BYAPR03MB35756448ADC24DC97CDD6242EDAB0@BYAPR03MB3575.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(25786009)(5660300002)(64756008)(86362001)(486006)(26005)(71190400001)(66446008)(71200400001)(66556008)(6436002)(66066001)(66476007)(66946007)(476003)(386003)(6506007)(256004)(8676002)(102836004)(6486002)(186003)(53936002)(9686003)(6512007)(14454004)(6916009)(50226002)(81156014)(76176011)(4326008)(8936002)(1076003)(81166006)(229853002)(14444005)(7416002)(446003)(11346002)(6246003)(478600001)(305945005)(316002)(2906002)(6116002)(3846002)(54906003)(7736002)(52116002)(99286004)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3575;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yNsIplS3g5erwKNDe9Aggwv3WmPANboGhCnndv/Qe1uyDEssCCzsMEcKkryrH39KnzPVoUhAV67xYtqKNGTNM7br4bJMOhsPXeNa2xfUIO+qRZHBKr6l/gTyAG4IO0k3D+K71MRf4lsvw5MO+ng5/Gwc93bIXm5J11b5C0KsQwPIkHA0MdgsHki2zsevh2HeqVTZHtt02i67bPURSGfMQ2UfGSSs7itrsisnhaTTtjvlQXWLJP7hiWhB+89En/abmhFLjvkYio/ENgHVHwq2qR4Hcz7msOYHmvUuZdmyCrvj7tMeRDki+bgOQoUMSFxC9C2Fx32848dvo3C47e3eLP7me26KVB+TNrEk4CYNIIXShGFhkaZ9oy2W+a0DwIwNB4xxJgKvBKOjOAZtxDdb9/2ux+5/jYlNU2rp3LoG7tU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1998460293D9114B826D762A1BF42427@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f866b5f0-b77f-4903-288a-08d7255aed5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 10:41:15.8066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBnrU2yGql1LAGQ+PPp8P6UPzymYEoUTgjy44oIfuK57af7izoPhLaG/eBQi3Sm0kfGjm1X+S+QGdFI4tZ+mWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 15:45:24 +0530 "Naveen N. Rao" wrote:

>=20
>=20
> Jisheng Zhang wrote:
> > For KPROBES_ON_FTRACE case, we need to adjust the kprobe's addr
> > correspondingly.
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  kernel/kprobes.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 9873fc627d61..3fd2f68644da 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1484,15 +1484,19 @@ static inline int check_kprobe_rereg(struct kpr=
obe *p)
> >
> >  int __weak arch_check_ftrace_location(struct kprobe *p)
> >  {
> > -     unsigned long ftrace_addr;
> > +     unsigned long ftrace_addr, addr =3D (unsigned long)p->addr;
> >
> > -     ftrace_addr =3D ftrace_location((unsigned long)p->addr);
> > +#ifdef CONFIG_KPROBES_ON_FTRACE
> > +     addr =3D ftrace_call_adjust(addr);
> > +#endif =20
>=20
> Looking at the commit message for patch 3/3, it looks like you want the
> probe to be placed on ftrace entry by default, and this patch seems to
> be aimed at that.

Yeah.

>=20
> If so, this is not the right approach. As I mentioned previously, you
> would want to over-ride kprobe_lookup_name(). This ensures that the
> address is changed only if the user provided a symbol, and not if the
> user wanted to probe at a very specific address. See commit

Great! Now I understand the reason.

> 24bd909e94776 ("powerpc/kprobes: Prefer ftrace when probing function
> entry").

Now, I got your meaning. You are right. I will update the patch in newer
version.

Thanks a lot!

>=20
> If this patch is for some other purpose, then it isn't clear from the
> commit log. Please provide a better explanation.
>=20
>=20
> - Naveen
>=20

