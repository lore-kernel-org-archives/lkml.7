Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4122C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8069420644
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="nPecqCrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfHTCGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:06:02 -0400
Received: from mail-eopbgr770080.outbound.protection.outlook.com ([40.107.77.80]:31179
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728615AbfHTCGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:06:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=At3Hihi0MF7NK+BrzZkWeQHUtS3tNxnG+tfBz9WgXXuEUBVsJy4IANQXljVBpfqpdQyYeEkfT8w5OSgQIVEcIA+gewy7G6ukNcGAu36EEDLQOkfqspvJBOU3T3Le7mi7ZOYE06gBmajmvLHGRnqz3w3ijsl3kRm7xYN+7yCbcK6q4rmJrxY95EHfhWFaDPq/zFLvzjo7x2EPqcfoJ0KSPlNgYKTKINq9UY2koIdPrU9Toai/uEUBMPReNy2XWQY++VMKB54m/w3fki/4LSMuR4flKmCe5kL1VcIGe6Qykgz8lmEwaaTGBjnVgLWtBXtiboidLsw5ODVMpsKH9tspSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AK8arP/DcxNR3UkNreRi4ifCIyWHKYCsVbg0nbtEYg=;
 b=gL0F5yCmH1M5DgKeGdtId4kx4R1SldY1aekF/2fxIxyiK2F4jc5Wl1nIzFoXOg6q9vQ/Skim7G2Du01QEsuzV0bZoQHudREwKVOj0yCO2sCIalsClBnES25J2wqdYfFG3DYyDd2SyWqnWCl6cM0SDKi5eKg8SNa4sihzk9d0IFJJYuUdGrvSqqQq8QhEj6jR36W5vDeP4abLxMvrducF2ZJHPqwzhD9LU5kuWZCelsz2CCt9jLr9agBJ67Rr9GSYeaQIG2BpBXQTAURhTElnKED1Cq2C0aI8S6IMNRe6ZL5d8zYXskjAx1bATTX7a9VmipcXbtYzmXvrhHpzQ8LzWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AK8arP/DcxNR3UkNreRi4ifCIyWHKYCsVbg0nbtEYg=;
 b=nPecqCrbAMr/r4GA1PubYYs5foT0KBxIKPwjHrqHLZNtjPAttUJZRmRzsFC6MauuJ+CcWdzAftPZy8rSAzCs9SOPi0cNUJikorr7jHJI5iav16tssQQ9Giw7BYndq8SXr24fRfx5Bj0ZnxMzsM6ZTDfiEsz9WYf+5vE3XboVMRM=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB3688.namprd03.prod.outlook.com (52.135.214.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 02:05:58 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Tue, 20 Aug 2019
 02:05:58 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] kprobes: adjust kprobe addr for KPROBES_ON_FTRACE
Thread-Topic: [PATCH 1/4] kprobes: adjust kprobe addr for KPROBES_ON_FTRACE
Thread-Index: AQHVVoJFk8X59Zi3AUirAcI9pTWKbqcDJ9IAgAAfqgA=
Date:   Tue, 20 Aug 2019 02:05:58 +0000
Message-ID: <20190820095450.3eb3120b@xhacker.debian>
References: <20190819192422.5ed79702@xhacker.debian>
        <20190819192505.483c0bf0@xhacker.debian>
        <20190820090130.844fc064030db67efb05ceb1@kernel.org>
In-Reply-To: <20190820090130.844fc064030db67efb05ceb1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYCPR01CA0108.jpnprd01.prod.outlook.com
 (2603:1096:405:4::24) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 254805cc-3c7e-466e-0515-08d72512f129
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB3688;
x-ms-traffictypediagnostic: BYAPR03MB3688:
x-microsoft-antispam-prvs: <BYAPR03MB3688954779330EC652EE9A64EDAB0@BYAPR03MB3688.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(396003)(39860400002)(189003)(199004)(6916009)(66946007)(26005)(81166006)(8676002)(6512007)(9686003)(81156014)(66446008)(64756008)(66556008)(66476007)(86362001)(52116002)(99286004)(76176011)(11346002)(386003)(6506007)(102836004)(476003)(446003)(316002)(8936002)(186003)(50226002)(54906003)(486006)(71200400001)(229853002)(6246003)(1076003)(478600001)(6486002)(14454004)(25786009)(66066001)(6116002)(3846002)(4326008)(71190400001)(6436002)(2906002)(14444005)(53936002)(256004)(7736002)(5660300002)(7416002)(305945005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3688;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EgP33k2WdBvvZysnxwxCtLMO8rqDDg7XV9iMpx1hpHwrWcZZTsy6ug8HyptNZx9JfL73em5TmY4JC7+anQnwKJBjQbby7CbD+jJC9KRpCj6/f+QXvN5/XSD/M2zL6By0nBZVOWV5QFvo4ayTLHCp00xtrC3q6MnX/gdMojcUI0zRCihExWyq6DO/8OylHl2DtjGnozngtmvOBVekSCrqqGP+Pqua94bpil8uWJI5rviBHpO2v2oMdXBI/P3SfGuH0o/NdlCXlyL+NvD14FmkqoKNtK1q3uLu/UOKh+tn1s997T1Zzsadej+DGhRGaC1NzNQq5tVMAQOlR1xv9UFwzFvQ+VroT19zddqGVcemKBUuBGcAxlnXxioypMHxCGhxUx3IUwGDxB7/8+gFxJgycqUozaAchycjcivX9j9l1LI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9AE6B2C809ED37448D16241D63F81276@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254805cc-3c7e-466e-0515-08d72512f129
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 02:05:58.2720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bORuSH3Kg/33OmRExcGMEiGh74gYYgpZCCh0TyoT4cdEsYz7pJuKw0ix9WpKeNoQssgEHc/+5/VoASV78kMXQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 09:01:30 +0900 Masami Hiramatsu wrote:

>=20
> Hi Jisheng,

Hi,

>=20
> On Mon, 19 Aug 2019 11:36:09 +0000
> Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>=20
> > For KPROBES_ON_FTRACE case, we need to adjust the kprobe's addr
> > correspondingly. =20
>=20
> No, I think you have misunderstood what the ftrace_call_adjust() does.
> Ftrace's rec->ip is already adjusted when initializing it. Kprobes
> checks the list after initialized (adjusted). So you don't need to
> adjust it again.

This is not to adjust the ftarce's rec->ip, but to adjust the struct kprobe
addr member. Because check_kprobe_address_safe()=3D>arch_check_ftrace_locat=
ion
will check the kprobe's addr with ftrace's rec->ip. Since ftrace's rec->ip
is already adjusted, there will be mismatch if we don't adjust kprobe's add=
r
correspondingly.

However, this patch is wrong. I should not update the kprobe's addr
for non-ftrace-entry. Will fix this in next version.

Thanks

>=20
> BTW, this type of hidden adjustment should be avoided by design.
> If you find user specifies wrong address, return error instead of
> adjust it silently.
>=20
> Thank you,
>=20
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  kernel/kprobes.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 9873fc627d61..f8400753a8a9 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1560,6 +1560,9 @@ int register_kprobe(struct kprobe *p)
> >       addr =3D kprobe_addr(p);
> >       if (IS_ERR(addr))
> >               return PTR_ERR(addr);
> > +#ifdef CONFIG_KPROBES_ON_FTRACE
> > +     addr =3D (kprobe_opcode_t *)ftrace_call_adjust((unsigned long)add=
r);
> > +#endif
> >       p->addr =3D addr;
> >
> >       ret =3D check_kprobe_rereg(p);
> > --
> > 2.23.0.rc1
> > =20
>=20
>=20
> --
> Masami Hiramatsu <mhiramat@kernel.org>

