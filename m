Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0C1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A9C20840
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oyIiRAYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbfCAMWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:22:32 -0500
Received: from mail-eopbgr30080.outbound.protection.outlook.com ([40.107.3.80]:49543
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728149AbfCAMWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt3XGWCkAvk8xyzjHn+dfI9Ufitf73f50bPQh7P+YeM=;
 b=oyIiRAYlR/8N/9xy1YP3DGaC40TJJDQNRNOrhxCZv1AbdyWguGAuToV+Nh0UpTuB/i0xXw9l7iQP9iwB1q8NSpSo9elbiAyEv9uPYSr0I1GuStDaVN6ow3ygXSQyqSF+FTqTyOU3zoIpxdCdzqQ2Ije8Hk7ZWL/McVRoW6koaYk=
Received: from DB5PR0801MB1590.eurprd08.prod.outlook.com (10.167.230.14) by
 DB5PR0801MB1543.eurprd08.prod.outlook.com (10.167.229.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 12:22:13 +0000
Received: from DB5PR0801MB1590.eurprd08.prod.outlook.com
 ([fe80::ac52:cef2:374a:afbd]) by DB5PR0801MB1590.eurprd08.prod.outlook.com
 ([fe80::ac52:cef2:374a:afbd%2]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 12:22:13 +0000
From:   Dave P Martin <Dave.Martin@arm.com>
To:     Amit Kachhap <Amit.Kachhap@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Kristina Martsenko <Kristina.Martsenko@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/6] arm64/kvm: add a userspace option to enable
 pointer authentication
Thread-Topic: [PATCH v6 4/6] arm64/kvm: add a userspace option to enable
 pointer authentication
Thread-Index: AQHUyDUHomsoycWuT0aO9zX8kUcTe6X2lXv/gAAs5YA=
Date:   Fri, 1 Mar 2019 12:22:13 +0000
Message-ID: <20190301122211.GT16031@e103592.cambridge.arm.com>
References: <1550568271-5319-1-git-send-email-amit.kachhap@arm.com>
 <1550568271-5319-5-git-send-email-amit.kachhap@arm.com>
 <20190221155350.GY3567@e103592.cambridge.arm.com>
 <56edb86f-7205-4714-823a-d26005d175ab@arm.com>
In-Reply-To: <56edb86f-7205-4714-823a-d26005d175ab@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.23 (2014-03-12)
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LNXP265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::25) To DB5PR0801MB1590.eurprd08.prod.outlook.com
 (2603:10a6:0:3b::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dave.Martin@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 608fd9d8-ca4f-40dc-72eb-08d69e408915
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR0801MB1543;
x-ms-traffictypediagnostic: DB5PR0801MB1543:
x-microsoft-exchange-diagnostics: 1;DB5PR0801MB1543;20:w9uE29gx1TZC+UD1pHkdlFN7CI94hBNxG+vUEF+Ve90gc792GYPkMiGpEMTrKDj9widBEGl6CcLIEEPq4XahADaHsZ65ENMfMFTEssaw4fzdNsERCrRygOGSGSNbRa+jlG9Z8TY+/sum4TzxfDApLo3AumySnJD1Un7aEnZ6GbU=
x-microsoft-antispam-prvs: <DB5PR0801MB1543E5DC64969D6A556059A9FE760@DB5PR0801MB1543.eurprd08.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(40434004)(446003)(6862004)(71190400001)(53936002)(8676002)(71200400001)(68736007)(6246003)(386003)(53546011)(6506007)(66066001)(476003)(5660300002)(11346002)(72206003)(97736004)(478600001)(14444005)(5024004)(256004)(229853002)(6436002)(81166006)(6116002)(81156014)(3846002)(6486002)(486006)(25786009)(6512007)(305945005)(86362001)(93886005)(14454004)(8936002)(76176011)(6636002)(316002)(105586002)(33656002)(106356001)(58126008)(186003)(54906003)(99286004)(4326008)(26005)(102836004)(52116002)(7736002)(1076003)(2906002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR0801MB1543;H:DB5PR0801MB1590.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MATtJzummZy2aylwttEqvu7TLB16jbX/hpaTL1b2LpWItgXpLAsJFBBuAtjwjUTZ4NqaqqFaEKfZIUaHGiIQgX62BQmmcNjJxMLHbTErBkyqq0lNLsQDN6DW/cPlqb3vYBJrrTZytevNeaRpEYfJy14Z6/C3FPeYBqgh7yws//F8Jzdno3PDi6Sa7Q3WOJajzfUOCkl10+c1e2ySZ58N/bGN7vHtfOJJJAc2wvs3o0Lrrn2R2XBcUjk9kUaIkEmpAUINUwf8KbSuXCAWy+1g9f4dYLouTr9fxkntUORbxOKHAKWXLGve8bBm0hugRhXZEurzm1y/I22w8thNRUO6igAbJVdDKpmV+EeM1TNX1ybx2ZGpuRlTDw1G/VFYvLUooHapgQ28kuiaEhF27naS3+igwF57uT9k1q5rr3aX4PU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54399122237D6D478067621271C8CF64@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608fd9d8-ca4f-40dc-72eb-08d69e408915
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 12:22:13.2892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR0801MB1543
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 09:41:20AM +0000, Amit Daniel Kachhap wrote:
> Hi,
>
> On 2/21/19 9:23 PM, Dave Martin wrote:
> > On Tue, Feb 19, 2019 at 02:54:29PM +0530, Amit Daniel Kachhap wrote:
> >> This feature will allow the KVM guest to allow the handling of
> >> pointer authentication instructions or to treat them as undefined
> >> if not set. It uses the existing vcpu API KVM_ARM_VCPU_INIT to
> >> supply this parameter instead of creating a new API.
> >>
> >> A new register is not created to pass this parameter via
> >> SET/GET_ONE_REG interface as just a flag (KVM_ARM_VCPU_PTRAUTH)
> >> supplied is enough to enable this feature.
> >>
> >> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Marc Zyngier <marc.zyngier@arm.com>
> >> Cc: Christoffer Dall <christoffer.dall@arm.com>
> >> Cc: kvmarm@lists.cs.columbia.edu

[...]

> >> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> >> index 12529df..f7bcc60 100644
> >> --- a/arch/arm64/kvm/sys_regs.c
> >> +++ b/arch/arm64/kvm/sys_regs.c
> >> @@ -1055,7 +1055,7 @@ static bool access_cntp_cval(struct kvm_vcpu *vc=
pu,
> >>   }
> >>
> >>   /* Read a sanitised cpufeature ID register by sys_reg_desc */
> >> -static u64 read_id_reg(struct sys_reg_desc const *r, bool raz)
> >> +static u64 read_id_reg(struct kvm_vcpu *vcpu, struct sys_reg_desc con=
st *r, bool raz)
> >>   {
> >>   u32 id =3D sys_reg((u32)r->Op0, (u32)r->Op1,
> >>    (u32)r->CRn, (u32)r->CRm, (u32)r->Op2);
> >> @@ -1071,7 +1071,7 @@ static u64 read_id_reg(struct sys_reg_desc const=
 *r, bool raz)
> >>    (0xfUL << ID_AA64ISAR1_API_SHIFT) |
> >>    (0xfUL << ID_AA64ISAR1_GPA_SHIFT) |
> >>    (0xfUL << ID_AA64ISAR1_GPI_SHIFT);
> >> -if (!kvm_supports_ptrauth()) {
> >> +if (!kvm_arm_vcpu_ptrauth_allowed(vcpu)) {
> >>   kvm_debug("ptrauth unsupported for guests, suppressing\n");
> >>   val &=3D ~ptrauth_mask;
> >>   }
> >> @@ -1095,7 +1095,7 @@ static bool __access_id_reg(struct kvm_vcpu *vcp=
u,
> >>   if (p->is_write)
> >>   return write_to_read_only(vcpu, p, r);
> >>
> >> -p->regval =3D read_id_reg(r, raz);
> >> +p->regval =3D read_id_reg(vcpu, r, raz);
> >>   return true;
> >>   }
> >
> > The SVE KVM series makes various overlapping changes to propagate vcpuo
> > into the relevant places, but hopefully the rebase is not too painful.
> > Many of the changes are probably virtually identical between the two
> > series.
> >
> > See for example [1].  Maybe you could cherry-pick and drop the
> > equivalent changes here (though if your series is picked up first, I
> > will live with it ;)
> Yes no issue. I will cherry-pick your specific patch and rebase mine on i=
t.

OK, thanks.

Unfortunately it is likely to churn a bit due to review-- my v6 series
will rename some stuff.  Hopefully it will be stable from then on.

Cheers
---Dave
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
