Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF51C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A6722CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="R+FHqRRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfHTJDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:03:02 -0400
Received: from mail-eopbgr760054.outbound.protection.outlook.com ([40.107.76.54]:34389
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729291AbfHTJDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:03:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bizSn/devj0O0fmZwTN2I+TdCUywqvQ2x6lNVadwNOMJIflLQm1VFOZ7CiVU+CxYJVvx4owH6sCF8587n0oOxcUAQ5sJmSpQi9p8unH4PCR7fAzc3omAM/M/JUQGjFK12ep+7xT/SBol5yDFXMLDCSqUVSQCWNjDQmGQJbzTb96qYzIUSNhhEaMjDc4AviiIe/72tGi8QX99uPtLzZ6a0gF/lQB+6t1/YdzTGjkoFzXXt/rv4qjHzwm6HEgNwskTq6KTgvVn9fhEsq3QAkBxLlUc/aZFSI7B6854njBnrXLsru1nGqOBzzRWJ60Yt/5lw8bPEHiot8VDpXozRC5dRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+D7ZhHnjuXRLwjkMuWC2NGMD1CqSLlncAZyzAx47J8=;
 b=QkQOiMmfx/O8bRHRmzk6bhG6IT2gQRpEc9By10bfjRXj9Lp62hPQRzJpdKYzYRp7U2NUnvRpINPQhBRz+He484csbQioygURXF/I6wkzGbpWLmUqP5vjpCFqKlZuyfiMvyTxbwEHldqies8fbz6mKpbGvJx9qZ+yO2VUDVu6obftmEPy6gf7ZcP1iXTkAbHD6+jxDrhungboBROBWYFUfvqUFZIKmpB6MZiaiX+QbL361CrO+RTsnikMH7MLfLA8yNi8y3SLyhE86Eu0bUSmRYM2t3WR7u+xNNK+np9ZCSA2SfwfvSOI7WPZgCQZ8h8b1rdLL8KavjAGptFo8KjpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+D7ZhHnjuXRLwjkMuWC2NGMD1CqSLlncAZyzAx47J8=;
 b=R+FHqRRhQe5wHvuiPMXO+Cz6Nud7DTYo3qCfG3JhoXJzCa19KkMJHYxykUsx+T678iM0Ub14r7SVkapZiBj1qNsLw3eXB2lVlT14MKKcexJc4fGroGKux7/7XW+GV6nze+uNBs7B12t/3H8q4I4UQP8OwC1/3IexVbkvxTm6q9E=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3413.namprd03.prod.outlook.com (52.135.212.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 09:02:59 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Tue, 20 Aug 2019
 09:02:59 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
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
Thread-Index: AQHVVwqiEXrXfYjUc0SG3b0/wT6us6cDu4YA////agA=
Date:   Tue, 20 Aug 2019 09:02:59 +0000
Message-ID: <20190820165152.20275268@xhacker.debian>
References: <20190820113928.1971900c@xhacker.debian>
        <20190820114109.4624d56b@xhacker.debian>
        <alpine.DEB.2.21.1908201050370.2223@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908201050370.2223@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR01CA0057.jpnprd01.prod.outlook.com
 (2603:1096:404:10a::21) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53ce8562-1499-42e5-80a0-08d7254d32ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3413;
x-ms-traffictypediagnostic: BYAPR03MB3413:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR03MB3413BE64A06642A7AD4A0283EDAB0@BYAPR03MB3413.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(39850400004)(396003)(54534003)(199004)(189003)(1076003)(6116002)(8676002)(70486001)(53936002)(229853002)(64756008)(7736002)(66446008)(66556008)(117636001)(386003)(6506007)(66476007)(7416002)(5660300002)(71200400001)(71190400001)(476003)(256004)(11346002)(446003)(81156014)(81166006)(6916009)(486006)(86362001)(6486002)(6436002)(102836004)(99286004)(2906002)(4326008)(52116002)(8936002)(66946007)(305945005)(966005)(54906003)(76176011)(4744005)(26005)(6246003)(316002)(478600001)(6306002)(8266002)(6512007)(9686003)(97876018)(3846002)(50226002)(25786009)(186003)(66066001)(14454004)(533714002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3413;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B8/IttSITC+KXhssqD10UctryDtyeEc+imaG3LSBPFYtHdQLk4S5q56+ZqkQ5fVSNmpfcpBTa/PVynH8bjkwP+t1A9LHWs9hmyFX1UbSGkFOGe+8wpiOFdC+jtydamNQduIqkB+4wk4ImWtQa1YYEA+kUADufNkCa06TrG2sPVVFzsUpq8ZeEGRjxKcy6CHOsPQWwNIA9n+MwqpouIO3OkKr9W0VZ1/1ZCHtXfk8w2VZpp+lVbrZJShteCYnOxC2RLSJRrTlCZz6Scy/QbBnSeC1aB+3cEvDs2h3KpNWMCVCln2Rg/QDzfg6yXxNxCz376N23jxhv08yMYFMjL9k6eQAPjoDUAvhJhNGCa//ENBACvBNhu+kL3QjxcIRLtqyxuJgFiqrbyLD4838s6TO1+eMhIPp2ZN00Ga+i/Bv5Ec=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A7F59BFB2BC2E43A06AAF5B7145A9FA@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ce8562-1499-42e5-80a0-08d7254d32ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 09:02:59.3213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLOlSxjPh+/htCwtY1doK/9+D+mBtLeY0wBc3tnW0Zqi6UoNd7l6L07iX+RGGPbD8PaAVCV/yZsKo49uSD2rUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3413
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, 20 Aug 2019 10:53:58 +0200 (CEST) Thomas Gleixner wrote:

>=20
>=20
> On Tue, 20 Aug 2019, Jisheng Zhang wrote:
>=20
> > This is to make the x86 kprobe_ftrace_handler() more common so that
> > the code could be reused in future. =20
>=20
> While I agree with the change in general, I can't find anything which
> reuses that code. So the change log is pretty useless and I have no idea
> how this is related to the rest of the series.

In v1, this code is moved from x86 to common kprobes.c [1]
But I agree with Masami, consolidation could be done when arm64 kprobes
on ftrace is stable.

In v2, actually, the arm64 version's kprobe_ftrace_handler() is the same
as x86's, the only difference is comment, e.g

/* Kprobe handler expects regs->ip =3D ip + 1 as breakpoint hit */

while in arm64

/* Kprobe handler expects regs->pc =3D ip + 1 as breakpoint hit */


W/ above, any suggestion about the suitable change log?

Thanks

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-August/67441=
7.html
