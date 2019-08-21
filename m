Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6EFC3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E1E2332B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="E3pI+Ezm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfHUCu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:50:56 -0400
Received: from mail-eopbgr690064.outbound.protection.outlook.com ([40.107.69.64]:51266
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbfHUCuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:50:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/3qvSrGTjkEgWeY4df7hRfinClfkVuToQkua4IGFh6COyf6peXRzgCdAQ0yJ02d291O9ATfEFyTQi0tgrgyawDi7z3Ptl+4HvXZRh9Y7oCt56NlQSc9WYXnb/ucLnuttUftecYu5ygmNK90Iqt3rSVwmqqD1smdrnF6Tz1RxKUKW5PoDYogmJUqCpKIHYBaGvs8anWbX6W3TBrxCLsdrwYEIUN0UCXLZO+G8ESGG4Yptvn+23dJ4XNSPyATLH8dAR5ShHwoBm/cpHD7VABBqzhsMr065DaPhJnBDI1WuC95PofEMPwZY4Y7hewC7K6Yv8XDlztuPooBm0E5RZ3F9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSEe01lJKSGwrdqp+XWy/X703fpPJkGSOShx94rrULo=;
 b=cZQpBTy448RrFc8jL7KI8VQqJ1cfuKGHshl57vg2YVwqwnu1UsgcTaN6VUqHvO8PJBKjYpkhh8gmzDTFS3G9jH/JtjmDOUFK38peXY+Ee9cotl3xmE0hdphKVmRaUrY4YAayqnymF/kyQA75psbdz47xUbEHqieV8MuGQbEBC317mcajaPrMgAMbCXbqSSiJ9egYJM8TVtTGTeiKCOt9IyJnRrSWqOL3SWasRXauX17A6hp3ibx03P92A6T2sqI3IkrJ/+3Pa7KllCTfpbzVP/JWn5atsNSsl/y5er0ozrPznTK2HP4KgnmzpAH3kX489wFQHG0DXj2BDiFuPAamPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSEe01lJKSGwrdqp+XWy/X703fpPJkGSOShx94rrULo=;
 b=E3pI+EzmD7LGsZi8OCm6dfQlNTwQM/RbtaEnVomYQmzrzrTHIH1uRJMLDq6Lm+ApycT/s3Exe6/j2EiXoWVLSgGCF/gon1VBVBpky/5Fs+L9yKkdKFWZnmiyTLy3dOkbwSLJrhkFbyEfwo3+Z8u8R7dcYcRxQ0wklefa9DqQRpg=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4134.namprd03.prod.outlook.com (20.177.184.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 02:50:12 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::a517:3578:67bf:6c88%7]) with mapi id 15.20.2157.022; Wed, 21 Aug 2019
 02:50:12 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] kprobes: adjust kprobe addr for KPROBES_ON_FTRACE
Thread-Topic: [PATCH v2 2/3] kprobes: adjust kprobe addr for KPROBES_ON_FTRACE
Thread-Index: AQHVVwrOlWp5wQEBs0CTmAwXsgLkUqcE3FSAgAAIv4A=
Date:   Wed, 21 Aug 2019 02:50:12 +0000
Message-ID: <20190821103857.14d2a40d@xhacker.debian>
References: <20190820113928.1971900c@xhacker.debian>
        <20190820114224.0c8963c4@xhacker.debian>
        <20190821110739.fb3ab6b69423dff64a3b4a29@kernel.org>
In-Reply-To: <20190821110739.fb3ab6b69423dff64a3b4a29@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY1PR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:402:1::34) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcb2cc99-586c-4500-c248-08d725e24999
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR03MB4134;
x-ms-traffictypediagnostic: BYAPR03MB4134:
x-microsoft-antispam-prvs: <BYAPR03MB4134C73B72F146E76CE139C5EDAA0@BYAPR03MB4134.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(52116002)(71200400001)(14454004)(71190400001)(99286004)(2906002)(66946007)(66556008)(64756008)(66446008)(6486002)(66476007)(386003)(6506007)(229853002)(476003)(6116002)(3846002)(54906003)(256004)(1076003)(11346002)(86362001)(478600001)(446003)(486006)(6436002)(9686003)(6512007)(53936002)(6246003)(186003)(7736002)(26005)(25786009)(5660300002)(305945005)(4326008)(316002)(8936002)(7416002)(8676002)(81156014)(81166006)(102836004)(50226002)(6916009)(76176011)(66066001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4134;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IpoFs2USXlJnGXGqJrA1oHlY9W17zu9bpgDB1oiFlwWSFJsFTmfko29+Nsf38IyEVI9+K9D+DIpl1cdLm1MmrZJZ0hW+etsS1RhtIXr/Hd9yVzTaPgUSlxxRrMQS2gcKG8zyf99G1pi3YoMTivrmRFd/TprPL1gvBKJiOFDcUB6GiPQK0/Nd4JBpie20KOqi359RfgQie3qPrAt3/tP3xrh2sGD30VtOlhAeajFD6XPZL4LntoObBPKB5273kdm7AcJvaMqe4h4JhqclJVOnNVsy/Zfg5J4Aj1oJNzDZvueTxXur+10DZXb9qt9PCmgoGFHIzl/OAE4M0XPwl4+06VpZ/ZO8M72TdNIDJjqBgq1Qg7cMkUDGbUtmTaSiBsgg80HnVXv/gF091lQQiEVNUYLARTc2W3P6NmEL+tL3IGw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <729B9B6589E3D843922E38EC366DDC75@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb2cc99-586c-4500-c248-08d725e24999
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 02:50:12.6193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7dkFLErusU4mcytO2IQxK6HafDLamLdzY0ZclNC7U4pBRcjhpcVk6UM0jWWZuTpaCDItfs2BJkNMM7EFdwIow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 21 Aug 2019 11:07:39 +0900 Masami Hiramatsu wrote:

>=20
>=20
> Hi Jisheng,
>=20
> On Tue, 20 Aug 2019 03:53:31 +0000
> Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>=20
> > For KPROBES_ON_FTRACE case, we need to adjust the kprobe's addr
> > correspondingly. =20
>=20
> Either KPROBES_ON_FTRACE=3Dy or not, ftrace_location() check must be
> done correctly. If it failed, kprobes can modify the instruction
> which can be modified by ftrace.
>=20
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
> > +#endif
> > +     ftrace_addr =3D ftrace_location(addr); =20
>=20
> No, this is not right way to do. If we always need to adjust address
> before calling ftrace_location(), something wrong with ftrace_location()
> interface.
> ftrace_location(addr) must check the address is within the range which
> can be changed by ftrace. (dyn->ip <=3D addr <=3D dyn->ip+MCOUNT_INSN_SIZ=
E)

yeah! I will try Naveen's suggestion, I.E patch kprobe_lookup_name() instea=
d.

Thanks

>=20
>=20
> >       if (ftrace_addr) {
> >  #ifdef CONFIG_KPROBES_ON_FTRACE
> >               /* Given address is not on the instruction boundary */
> > -             if ((unsigned long)p->addr !=3D ftrace_addr)
> > +             if (addr !=3D ftrace_addr)
> >                       return -EILSEQ;
> >               p->flags |=3D KPROBE_FLAG_FTRACE;
> > +             p->addr =3D (kprobe_opcode_t *)addr; =20
>=20
> And again, please don't change the p->addr silently.
>=20
> Thank you,
>=20
> >  #else        /* !CONFIG_KPROBES_ON_FTRACE */
> >               return -EINVAL;
> >  #endif
> > --
> > 2.23.0.rc1
> > =20
>=20
>=20
> --
> Masami Hiramatsu <mhiramat@kernel.org>

