Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE92C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A6922DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="euKxpOo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfHUCJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:09:19 -0400
Received: from mail-eopbgr750089.outbound.protection.outlook.com ([40.107.75.89]:18670
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbfHUCJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:09:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkJf9SJjTeFdjKCd8yRtxLX/lUBs63l5SYrDfkQZG4cDcFKpq8aillHgPxVyxfjtTrTuJEFmeYwbizG2hOYOyatCZ7TByI3xntt7jzIpYVyqlHtnandfw3JAqozB7RQk9Z7rh+BWQAV2GDhRWc4WbbUallQiTy7HnyX4Quh+48+KNtJVmQX/SA004wIdSQEvcd2ArceCYeejMDk1uVEH26ksHugN88rr7ocj2GR++9NTKDKnBhfCQlQANfhzGGuqPqzygcvwSQeNUAM8JDjYhVZrYjcBGrRM+K/ZVNmBOIppriGNK+X4SnC+ngEFnYio3AhrCSOQbPxdYYgXklW4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg5V4KIiFC4h1rp2jN9bS9pv2shUGDwX3sNbL4AKjTI=;
 b=fQhn+7BJBTO0zTn4zQVvHVfPyFgGnLs0robF1w6xQGXR72zaokXuIF4NJKhlqxo6IWIvbZqdcimcivyw5arNqmkddbU1616VTZcmSqzwb90/mA5CZlwdPYY+RqxpEEyQ6jztmEuXb4vnUd9aXy3CA2UPSBaS/AYVfAJLqXbUsUtczRXVuaijfU10KwfY69cktexG80yLHkShuP6tuzvpV7mpZa2nyOp5z3xuSiN6HIs9GXp3tvM0n7unXIdhtvIPcPvnGl0LceBlMKlOB9IWd68bYMOG5wnZbZQf73EGsCaQDMKM8d1YJpxOnEK4uKomIMOEa1evQ7cHfA+WsLpehA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg5V4KIiFC4h1rp2jN9bS9pv2shUGDwX3sNbL4AKjTI=;
 b=euKxpOo8JV3NKIFZJwokdEIuCg7qrVQMY9Rka9B6eaqFaxrDxLizH2NIuKs3x3QFI3GdkAPmMlGw/HkYlB7/BGI3fGTgGIuRiMod/mBUZta+rlOxOLJGu0fUEJ5K+fEVoP7yL0fTFJLPXaF57JtxzaJVskB0fJSO3NHcxfviPJA=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3574.namprd03.prod.outlook.com (52.135.213.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 02:09:11 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Wed, 21 Aug 2019
 02:09:10 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Thread-Topic: [PATCH v2 1/3] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Thread-Index: AQHVVwqiEXrXfYjUc0SG3b0/wT6us6cDu4YAgACFhgCAAJchgIAAAL+A
Date:   Wed, 21 Aug 2019 02:09:10 +0000
Message-ID: <20190821095527.729b2b0d@xhacker.debian>
References: <20190820113928.1971900c@xhacker.debian>
        <20190820114109.4624d56b@xhacker.debian>
        <alpine.DEB.2.21.1908201050370.2223@nanos.tec.linutronix.de>
        <20190820165152.20275268@xhacker.debian>
        <20190821105247.f0236d2c04b2c0c4d4e1847e@kernel.org>
In-Reply-To: <20190821105247.f0236d2c04b2c0c4d4e1847e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0210.jpnprd01.prod.outlook.com
 (2603:1096:404:29::30) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67fd10f7-a471-4cc1-3f3c-08d725dc8e3d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR03MB3574;
x-ms-traffictypediagnostic: BYAPR03MB3574:
x-microsoft-antispam-prvs: <BYAPR03MB3574972D034A5BEBA292D3CEEDAA0@BYAPR03MB3574.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39860400002)(54534003)(189003)(199004)(478600001)(76176011)(102836004)(14454004)(53936002)(316002)(7736002)(7416002)(1076003)(25786009)(446003)(11346002)(2906002)(476003)(4326008)(486006)(26005)(54906003)(52116002)(6246003)(99286004)(86362001)(386003)(6506007)(305945005)(186003)(6916009)(66946007)(8936002)(8676002)(66446008)(5660300002)(64756008)(71200400001)(256004)(14444005)(66556008)(66476007)(71190400001)(6116002)(66066001)(3846002)(6486002)(229853002)(50226002)(6512007)(9686003)(6436002)(81156014)(81166006)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3574;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iETVAJMaw8V7kKA66OhWKk8NhTg4JHz/JgWRLQP10VQnzgDquJ17BaZjXmfS6XQg45n98dh2nz2W6cg3X/qCJXzqxJx3dqDJsGtqwwis58NtFRh3pjFhCKXDwHqLJF4tfGvVWsuNn8sltyTLH7OKmk/9zMw4Aj10CyT0/7JEQq2Rm6nMIYqDq4izlvv0fqMoFPeCdcDEZnv+MgcGoYXpr51D4eb/+kFm71UUfuDGMa7c9EslyOYZVDhO+qTZNDzYcnLs5j1CoyKgLguQkTo7jH8tvRNBZI0ffZBUC6qipiEAVRH8c7bwlvWRQB2RiVFXVTMerO2ueEvPLWCegwWHr70ybGGOy1UvLm+T3MFW4L/rKDwcgISJU/FLS3K78VHLb5d/V12Rc9tAALTC+WMmsPVucc/oo9nyPdOrBbkeY/I=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0201144BB45AB64793AC6F3ED43EFCDF@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fd10f7-a471-4cc1-3f3c-08d725dc8e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 02:09:10.6615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJPNmnEX7RMFUaDOm9sVUWc+KcP7rYY1TYtLSvq9K18I1NviyHWMfGhH5OIWoqvro026lLNg60bKKVkafc1nng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 21 Aug 2019 10:52:47 +0900 Masami Hiramatsu wrote:
>=20
>=20
> Hi Jisheng,
>=20
> On Tue, 20 Aug 2019 09:02:59 +0000
> Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>=20
> > Hi Thomas,
> >
> > On Tue, 20 Aug 2019 10:53:58 +0200 (CEST) Thomas Gleixner wrote:
> > =20
> > >
> > >
> > > On Tue, 20 Aug 2019, Jisheng Zhang wrote:
> > > =20
> > > > This is to make the x86 kprobe_ftrace_handler() more common so that
> > > > the code could be reused in future. =20
> > >
> > > While I agree with the change in general, I can't find anything which
> > > reuses that code. So the change log is pretty useless and I have no i=
dea
> > > how this is related to the rest of the series. =20
> >
> > In v1, this code is moved from x86 to common kprobes.c [1]
> > But I agree with Masami, consolidation could be done when arm64 kprobes
> > on ftrace is stable. =20
>=20
> We'll revisit to consolidate the code after we got 3rd or 4th clones.
>=20
> >
> > In v2, actually, the arm64 version's kprobe_ftrace_handler() is the sam=
e
> > as x86's, the only difference is comment, e.g
> >
> > /* Kprobe handler expects regs->ip =3D ip + 1 as breakpoint hit */
> >
> > while in arm64
> >
> > /* Kprobe handler expects regs->pc =3D ip + 1 as breakpoint hit */ =20
>=20
> As Peter pointed, on arm64, is that really 1 or 4 bytes?
> This part is heavily depends on the processor software-breakpoint
> implementation.

Per my understanding, the "+1" here means "+ one kprobe_opcode_t".

>=20
> >
> >
> > W/ above, any suggestion about the suitable change log? =20
>=20
> I think you just need to keep the first half of the description.
> Since this patch itself is not related to the series, could you update
> the description and resend it as a single cleanup patch out of the series=
?
>=20

Got it. Will do today.

Thanks a lot
