Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF70C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5FD22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Y++f/hyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfHUCC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:02:27 -0400
Received: from mail-eopbgr740070.outbound.protection.outlook.com ([40.107.74.70]:39982
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbfHUCC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:02:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQ9936GfR4Vxh4KuakPfq/JPKrr7o/AbUxo+SdG63eYjDG6o0WNFG7cGdzsZNhfmy4i3d1gVED66neOtZnClolb0igePKHVh/UXJp7knSfoAjM3omNt/6uRq2Wywmbck7uSEB5uHmyLlqGCDs4bZWsDbn3rvQdh/s2qzfMtVL+gbmhqF+v0yFLq6+VYIPe43zNB36q6D9IYYizg+13y5yaQ2H8SOcBo0+UUJx3YOKEf9IYd7C3SO0GHwhq15Sf/pY4U8jJP6cqLRgr2UrCMY+kBpp/++QNCGakNn0o+6xF2YrdkC5UZzbhgX/mluhSWAuGaJTLJbdXbpeRSYxle4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUuMHjoe75rqWTnQaVQatauchNyXq7Z+RK96qIFK5Io=;
 b=FDu+wwZBrjMHH2lISFucuqHo/Iup3IrNrza3Hl3DZwQgpDuxOH9FYMkcpMTKU4xucAUoVAv+NnQu0OjqvZnz82xdbvIjaXjpMgC+Yw4hhf1aT1kqhZ0fjCaV2wxZXJMpAo/mGpC/dwooESDNzgm8iBAFyGFBT0GtdYHpt9CQZnsTnGzIh/QlJqqU084oKCpCNdjBy9/KocrFV8p6yvOhSB046LpPMw4U7f4gx25YyW1pwASNFUZrpbCL/KUeEbw4Dx4cXA1n5/Pr7vaMrS2ii6D1jCSx2jEdi41D+cUbF1cx2ZyjrSvRzJz4D37vL8CrolFJ7QmDPEHEl9WntLLBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUuMHjoe75rqWTnQaVQatauchNyXq7Z+RK96qIFK5Io=;
 b=Y++f/hypMiLNY8Mc3nRnA95quJq6oAOkwhKJ3YCWoatn3RNtUraDJMPKWfQcX7I69g/onfQlqsz+tbZ7qVwuBe8fM05yqiSIKTek6xDUOIrgDrkWNViQmNjPCwXeFtstOlvHOuSEsA84cf9n2tTU/rlqegVwL8CYWt+BVUPqFs4=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4885.namprd03.prod.outlook.com (20.179.94.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 02:02:24 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Wed, 21 Aug 2019
 02:02:23 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
        Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Thread-Topic: [PATCH v2 1/3] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Thread-Index: AQHVVwqiEXrXfYjUc0SG3b0/wT6us6cDu4YAgACFhgD//8UhAIAA0YuA
Date:   Wed, 21 Aug 2019 02:02:23 +0000
Message-ID: <20190821095109.34c8a47f@xhacker.debian>
References: <20190820113928.1971900c@xhacker.debian>
        <20190820114109.4624d56b@xhacker.debian>
        <alpine.DEB.2.21.1908201050370.2223@nanos.tec.linutronix.de>
        <20190820165152.20275268@xhacker.debian>
        <20190820132110.GP2332@hirez.programming.kicks-ass.net>
In-Reply-To: <20190820132110.GP2332@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:404:14::19) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a617a94-17ba-449a-3b57-08d725db9b5a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR03MB4885;
x-ms-traffictypediagnostic: BYAPR03MB4885:
x-microsoft-antispam-prvs: <BYAPR03MB488506EC9DE9722D8A069701EDAA0@BYAPR03MB4885.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39860400002)(189003)(199004)(316002)(76176011)(6916009)(6246003)(8936002)(2906002)(86362001)(26005)(50226002)(81156014)(81166006)(52116002)(99286004)(8676002)(6116002)(9686003)(53936002)(66476007)(229853002)(6512007)(66556008)(64756008)(6486002)(3846002)(66446008)(66946007)(6436002)(14454004)(25786009)(4326008)(54906003)(478600001)(386003)(7416002)(71190400001)(71200400001)(256004)(305945005)(7736002)(66066001)(11346002)(186003)(102836004)(6506007)(446003)(476003)(486006)(4744005)(1076003)(5660300002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4885;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: shHB0z3Lt1+J1Ki7s8ZOpHzcAyXBvr8/NFz/HzIhP5L/GEypbQo8nQvq655e/o4DqQtVdzKqxn/l8VsKQZLSM/cAPcHmr4ORSE7XAvL43Wvp9kA2Ho0zSF7CmTkns8lw6cZppXUpcM/6b5gFSYHjjjw7zOQ5rNA3pNpbgKwlRygKQwUdtHswgzD9G6IKchJab/MtxvVS6/CAIfaaH8cdoAjG5nEpZY90U0NJwj1xdvF4VXXeTB0bCCHAg/ErwBtWGLCG8FDrn8CEUbBmX9MFkKGTfSGSlVb83pBuJa7ql/xiIwztBXLUOrhtJVvThaggThldQitDDGclonePbeHnk7gzkYUkTEy8tUIyvVJQui6a+Ytc0GIXLtj4SQ9ox2bleBKHQ3aTFGmumd5MHyqDinnuYBSA9bbHb10Vw0RZOYY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C07A4FB8806CE458AFD476C7948DA7B@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a617a94-17ba-449a-3b57-08d725db9b5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 02:02:23.2990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DB9R5wdkeldXDg4VeETorIOfE5CXxsTkOiMIMFEBsF+Xrh9e7kQQUNpcehD0zQgNjJPGvShpX3Xm0PF5zf3uaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4885
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, 20 Aug 2019 15:21:10 +0200 Peter Zijlstra wrote:

>=20
>=20
> On Tue, Aug 20, 2019 at 09:02:59AM +0000, Jisheng Zhang wrote:
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
> What's weird; I thought ARM has fixed sized instructions and they are
> all 4 bytes? So how does a single byte offset make sense for ARM?

I believe the "+1" here means + one kprobe_opcode_t.

Thanks
