Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724D3C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C22122CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Z5seiPqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfHTJUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:20:54 -0400
Received: from mail-eopbgr740089.outbound.protection.outlook.com ([40.107.74.89]:54395
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728414AbfHTJUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:20:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTciSLAJyUSlCBEIEixvZsWTQPeC/pl5606PMY8x+1J4FWfhGh8yAEZipnFjqb8RXYjshOMMj21pcTMwyC/qQmVB8DD0jYj2IKa5mXRRUkFCG/a2GA/bhE1qrAEFOn1cwn9BanNmHTjbdndsOFPSjmjO7Q+7LGo7V6UePEBjQm5Q2ixZUjTjg9xFfXsWiYI+R9PtApTlVKYU0nRykbK0/+PhpmZAd8yRDUiigmHBKQpWag0GdxoDK6YIPfP+mBkm3MtDBxT2tM6njpsIyhkwuJqQugyaOuMPerNz4cg+SdQ1Sei7Kx2skG5quyzXOKPgxs/I8jkDEVF5tDghAr9qMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE9aCefP/va/yJurMVlXvrGF3XEew4r8rv+GoqYRI4A=;
 b=lmG4rc1My72vaGR48g6y8xkrSrv/s8XSidr82cnt6WVgr1xZdC0hSWjcI8kN7MWXOyCh4RvhIZFchlinhX0Y+dVDwAimQ4aFT0FOYfbLP1BSzkIRpN8WQAY2d4vME9vzwZqpNUkndvh9PnYDaYODw3hwyPAJYIVwO8BYnd6h3aMNmP0qI5Sc/kLZIzO+TDBHpH9Px0mHmFBDSqovc4mLc2+F2cwOUCcBVtGRHzgkPyKppsRWJBGx8YZ+NujWQ6e1YIlQfwh1aPYhBA6UYP7/pijS3ivnnt4QB2d5G8S3/hUHsHpCpczIhMnJjjiXoD97iyepjtCK3VfcVq+9vKmVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE9aCefP/va/yJurMVlXvrGF3XEew4r8rv+GoqYRI4A=;
 b=Z5seiPqIRpVC9iwJjy8dFlnr6DGGDuQua+SdsHKeXP18Qm8cag9NRiZFBsqzIu2uaEIHUxP2Jnn4Jy1xa9EJHzOfI77FlWTQQ70HuXPFNWIGrWe5+rvIEPvvTVk8vCkZSKR6HAQCI3HxeDzH0DmyaMpfmvKacHKyyLhz9GS9IVg=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3703.namprd03.prod.outlook.com (52.135.214.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 09:20:50 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Tue, 20 Aug 2019
 09:20:50 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Thread-Topic: [PATCH v2 1/3] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Thread-Index: AQHVVwqiEXrXfYjUc0SG3b0/wT6us6cDu4YAgACFhgD//37iAA==
Date:   Tue, 20 Aug 2019 09:20:50 +0000
Message-ID: <20190820170944.1bc81867@xhacker.debian>
References: <20190820113928.1971900c@xhacker.debian>
        <20190820114109.4624d56b@xhacker.debian>
        <alpine.DEB.2.21.1908201050370.2223@nanos.tec.linutronix.de>
        <20190820165152.20275268@xhacker.debian>
In-Reply-To: <20190820165152.20275268@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0054.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::18) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db09ce68-9660-4ce1-d8d6-08d7254fb0ea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3703;
x-ms-traffictypediagnostic: BYAPR03MB3703:
x-microsoft-antispam-prvs: <BYAPR03MB370365228B2A95BC8096B845EDAB0@BYAPR03MB3703.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(136003)(376002)(54534003)(189003)(199004)(4326008)(446003)(476003)(11346002)(316002)(229853002)(6916009)(7736002)(486006)(50226002)(6512007)(99286004)(71200400001)(9686003)(102836004)(6116002)(71190400001)(256004)(76176011)(52116002)(6486002)(54906003)(26005)(2906002)(81166006)(81156014)(8676002)(6436002)(186003)(6246003)(25786009)(386003)(6506007)(8936002)(14454004)(66066001)(14444005)(3846002)(53936002)(478600001)(66946007)(5660300002)(64756008)(7416002)(66476007)(305945005)(1076003)(86362001)(66446008)(66556008)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3703;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8NPCFX82jBzLKRYAZZBLOiscGimWp9j37F2sR7tlQPbfnWXS2TVbPU+FBhDvV4+NIOLEg6/PUNfv/XQwD4cIGzIUVvxgIbjBts4kScaJ3U+sMehxYR3djg6RxZEtFneQEA/pk/6odbHZOZowA0SDg2R6rjiXndbVKLU0YcSSS+drEUdlxd+5WnBGqL7WYZYhBAdrubjVHSYUl8blFTaN7r4mnkYYsDwKz/yRuh+zGGLyULO72cqgZ4v1494OaaJgki2Uev1wEvKJR7iuBE2JIxhz0lDr8fy8bx8LePd0Mi3DaAoXTpL+nKn9a9Mmvrv8onDsykJbKoKcP7RwaZwU5AYMlWCsPav9XLCQfaMZt8AMA6wUkqLmU/8b/2py8Z5aXUuLtAJ/PWnGWqDkqESmQV04CyLsqgcyu/CfwcAoJvY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B8F4A08209FFD4F866D61C201BA4987@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db09ce68-9660-4ce1-d8d6-08d7254fb0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 09:20:50.0327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0SnHW3fDU6frXTcfrvCrR/yAVN8wsNrhPe+3vnxyxr/9oGyHHKDKu2xsWSC+ef0qTjWd1teVPAO+qEgnuW/5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3703
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 09:02:59 +0000 Jisheng Zhang wrote:


>=20
>=20
> Hi Thomas,
>=20
> On Tue, 20 Aug 2019 10:53:58 +0200 (CEST) Thomas Gleixner wrote:
>=20
> >
> >
> > On Tue, 20 Aug 2019, Jisheng Zhang wrote:
> > =20
> > > This is to make the x86 kprobe_ftrace_handler() more common so that
> > > the code could be reused in future. =20
> >
> > While I agree with the change in general, I can't find anything which
> > reuses that code. So the change log is pretty useless and I have no ide=
a
> > how this is related to the rest of the series. =20

Indeed, this isn't related to the rest of the series. So will update the
change log and resend it alone.

>=20
> In v1, this code is moved from x86 to common kprobes.c [1]
> But I agree with Masami, consolidation could be done when arm64 kprobes
> on ftrace is stable.
>=20
> In v2, actually, the arm64 version's kprobe_ftrace_handler() is the same
> as x86's, the only difference is comment, e.g
>=20
> /* Kprobe handler expects regs->ip =3D ip + 1 as breakpoint hit */
>=20
> while in arm64
>=20
> /* Kprobe handler expects regs->pc =3D ip + 1 as breakpoint hit */
>=20
>=20
> W/ above, any suggestion about the suitable change log?
>=20
> Thanks
>=20

