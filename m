Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A78C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E3E229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="McxbtvD2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Tml0Y6JK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfGXKsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:48:01 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:44896 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726087AbfGXKsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:48:00 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A7DE1C0177;
        Wed, 24 Jul 2019 10:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563965280; bh=8SCncZ9d0yiM5NxICKBEFxskB53j5pekm3OWkUQP4mY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=McxbtvD29OSnEo3zx9zYdppC5MzXDRbWdCboPO09tXjN7QBRRl/1zyHc/tQOXNYiv
         6c39NKkRl9JcUgBgYo5m0fDh5OM9h1I4gUb1Qzw3AzDmutDV7ah8phWZnsnjB5v8gU
         LT7WIJqX5otLF8OnXoXgcd+f/6wriX23uqKHTAOeCz2F6ecE3u5SpOIXVNmWGUpMYR
         FI8w0nPzvkxHg4iQjB6bgZhkRRxgFGSfsTYCrDaLKPNBxL8bvjOuBmwrbQ9ieKQ04z
         3aX0D7joecOCzcKhyqVsIA34Tv7aGeLcAC/E7ne1dnnapS4N5ZyqiKwlVhxoIGrpXR
         ibOw9pXfsMf2g==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E57FCA0093;
        Wed, 24 Jul 2019 10:47:50 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 24 Jul 2019 03:47:34 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 24 Jul 2019 03:47:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N49R/gClEBq8JBOhkgcIeQ15PNwOhZlAqNw6RNTGRw8DzWzAGU2LXRQ2HBaAwVhfVUgj4+vWyCt/jBU/8Lsg0tBGOliy4gy3S5MeOp0IIv4A42LubddoEr/wgFtR25KO40yt66Kr1BbSHtQx/d1RUGg3A6ZBHAwAXKEqbzoWXx7SmBKdnCiwj0e4o08lZVA7Wdv2mdB2zcDUD4BZrepsk0SGg9mM5UluWn4F+RTfzqTDZBJIkQRKQcslzaWcVF325ov3rfayKxpcsGdtP+L5pWn3eUX6M4nbjI3k3TLjox1Ro/MiSMBII3ShCLn2VDtlllEvi6qXFF74aUocNZuSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbO3+YOLwp+tDFcvoIHmi4IhGiqpgnG+7rXrGB9yos8=;
 b=TOA8Nk0ui2RgMdG2Ajxh05vaC9WPIPvNCPSRPCD4yDHRynDvaxzg6i00j15a1bgX+nNzZ3eAZYq9UNWaUmOlcX+xfuxMhmwR2lTX0PigRDhNpUK4b1rAOXb23I8UsesBvIjTR4OAoqLT+AF/qODljyRsH8mCU/tTQ8or+zf0zUR2MFxCa8SiO0+4npHJP5AE+N2A6f90bj4ICoqxFhm3AdkAuJjXDWVBff5W4IadZmPcYNaXJeny6OfKGH+6tl9v2dyRQ3XryYbdgJnzBg8xIsXToUSKG2sbOGdBCTWd+OulczJi3q65HfY55kAsFt3hWN9pkQdOvVEi4UTxxprubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synopsys.com;dmarc=pass action=none
 header.from=synopsys.com;dkim=pass header.d=synopsys.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbO3+YOLwp+tDFcvoIHmi4IhGiqpgnG+7rXrGB9yos8=;
 b=Tml0Y6JKvYeiCHDJ3hsNLHZEkfklcOMdmVKTfCYQGjquIZ8SvmTMYc0bHud9CLJrVxxkszjDyuy/2L3V38ZxRC8sbwIJ0NnHH4390uayZKqK2H+d/x6fBfGdrGszBUiIobtGHSbBC3SP0rVyDFeuWFOwX1KKgwHKG5/RReV0KpY=
Received: from CY4PR1201MB0120.namprd12.prod.outlook.com (10.172.78.14) by
 CY4PR1201MB2501.namprd12.prod.outlook.com (10.172.117.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Wed, 24 Jul 2019 10:47:31 +0000
Received: from CY4PR1201MB0120.namprd12.prod.outlook.com
 ([fe80::1c8d:9b3c:7538:477b]) by CY4PR1201MB0120.namprd12.prod.outlook.com
 ([fe80::1c8d:9b3c:7538:477b%4]) with mapi id 15.20.2094.017; Wed, 24 Jul 2019
 10:47:31 +0000
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Mischa Jonker <Mischa.Jonker@synopsys.com>
CC:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] ARCv2: IDU-intc: Add support for edge-triggered
 interrupts
Thread-Topic: [PATCH 1/2] ARCv2: IDU-intc: Add support for edge-triggered
 interrupts
Thread-Index: AQHVQUE0HZQCxaDVMkWPRiR2w9FjAabZlNWA
Date:   Wed, 24 Jul 2019 10:47:31 +0000
Message-ID: <CY4PR1201MB0120EDD4173511912A9FC99EA1C60@CY4PR1201MB0120.namprd12.prod.outlook.com>
References: <20190723102606.309089-1-mischa.jonker@synopsys.com>
In-Reply-To: <20190723102606.309089-1-mischa.jonker@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abrodkin@synopsys.com; 
x-originating-ip: [91.237.150.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2b40524-c757-4e1e-dd6d-08d71024547d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR1201MB2501;
x-ms-traffictypediagnostic: CY4PR1201MB2501:
x-microsoft-antispam-prvs: <CY4PR1201MB250163EB51C8B7210AE94F4CA1C60@CY4PR1201MB2501.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(136003)(396003)(39860400002)(346002)(376002)(366004)(199004)(189003)(13464003)(66476007)(74316002)(53936002)(6246003)(76176011)(25786009)(478600001)(305945005)(4326008)(14454004)(33656002)(68736007)(229853002)(186003)(7736002)(6506007)(102836004)(2906002)(26005)(256004)(486006)(55016002)(6862004)(53546011)(446003)(7696005)(14444005)(11346002)(9686003)(476003)(81156014)(3846002)(66066001)(6116002)(52536014)(76116006)(6436002)(71190400001)(6636002)(8936002)(316002)(86362001)(54906003)(99286004)(66946007)(66446008)(8676002)(66556008)(64756008)(5660300002)(71200400001)(81166006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1201MB2501;H:CY4PR1201MB0120.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wn+2RXjXVsmx1Ee4AIl+t6GTrEcy0D5OlqsebUzY4Odolv4E2N5vTql7rjhUeQdaneiveTQe9gRxVkGrsaeQRxb1fJgEH6c1lfk/BJBjPXBEV3PBT7STkmMwjUO6b5qG+U087NSUZbdQGQF4dvyeAEWb/kJr9X3T4zdG9l0xWF42RdKbyVSJqhjDTDz9VBhVCu4KCLWil+RTkoAmyKwm8AqP1g/nZ7E8FwR5403ERec0O3s2YO4HsG27DUy3n5X8xW+mWU/lGM7NXbgRxqutSFAm3zqn1jyAnjC3CSkswcTtQuJ/gucd9ncnwCVRUCLAp2sFBc5EHbWIhQvZiWPYZUcSMKLy/bseoXmkXkdceMrGAKy9G4s0yjDKeKiDPXUAXBjTAdpko+3cmKMzRndF14Y3yucWAtUbT1LP1HAMiNc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b40524-c757-4e1e-dd6d-08d71024547d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 10:47:31.6227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abrodkin@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2501
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mischa,

> -----Original Message-----
> From: Mischa Jonker <mischa.jonker@synopsys.com>
> Sent: Tuesday, July 23, 2019 1:26 PM
> To: Vineet Gupta <vgupta@synopsys.com>; Alexey Brodkin <abrodkin@synopsys=
.com>;
> kstewart@linuxfoundation.org; tglx@linutronix.de; robh+dt@kernel.org; lin=
ux-snps-
> arc@lists.infradead.org; linux-kernel@vger.kernel.org; devicetree@vger.ke=
rnel.org
> Cc: Mischa Jonker <mischa.jonker@synopsys.com>
> Subject: [PATCH 1/2] ARCv2: IDU-intc: Add support for edge-triggered inte=
rrupts
>=20
> This adds support for an optional extra interrupt cell to specify edge
> vs level triggered. It is backward compatible with dts files with only
> one cell, and will default to level-triggered in such a case.

In general LGTM. Still a couple of comments.

It might be useful to explain changes
made to idu_irq_set_affinity() as it's not immediately clear what affinity
has to do with IRQ modes (in theory it should be orthogonal).

But what happens we're actually fixing previously implemented short-cut
when instead of a separately set IRQ mode we were doing it together with
setup of distribution since it's done with the same one command
(anyways we relied on the one and only IRQ type being supported).

And now we have a proper implementation with separated setup of IRQ mode an=
d
affinity.

>  static int
>  idu_irq_set_affinity(struct irq_data *data, const struct cpumask *cpumas=
k,
>  		     bool force)
> @@ -263,13 +285,32 @@ idu_irq_set_affinity(struct irq_data *data, const s=
truct cpumask *cpumask,
>  	else
>  		distribution_mode =3D IDU_M_DISTRI_RR;
>=20
> -	idu_set_mode(data->hwirq, IDU_M_TRIG_LEVEL, distribution_mode);
> +	idu_set_mode(data->hwirq, false, 0, true, distribution_mode);
>=20
>  	raw_spin_unlock_irqrestore(&mcip_lock, flags);
>=20
>  	return IRQ_SET_MASK_OK;
>  }
>=20
> +static int idu_irq_set_type(struct irq_data *data, u32 type)
> +{
> +	unsigned long flags;
> +
> +	if (type & ~(IRQ_TYPE_EDGE_RISING | IRQ_TYPE_LEVEL_HIGH))
> +		return -EINVAL;

Maybe add an explanation why only these types are supported?

-Alexey
