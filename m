Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84820C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5BA2442B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VV+59EBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfE3CRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:17:55 -0400
Received: from mail-eopbgr150041.outbound.protection.outlook.com ([40.107.15.41]:48894
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726311AbfE3CRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LvHwmCVnlAgk4vIdUdJTRhYZl6n7CWhwmMNgwvUmDM=;
 b=VV+59EBm5yHQ6Xa2HvLw4Ly7x40821x+ukhLX4fN2K+bwNbG+6xVcAoxT70uN2OXkaKgWd2ZcKdQ9WcvgFOIiI3mcIg/FuGOdItTGVJYaUOUFsbCUFbFryaOyxhRNp0v6XiS9aGMOrYnFgzfTws68xoZ4lmZwjt6BJwmxzxS4W0=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.44.16) by
 AM5PR0402MB2881.eurprd04.prod.outlook.com (10.175.42.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Thu, 30 May 2019 02:17:51 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::a1bf:17d:a52:3824]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::a1bf:17d:a52:3824%4]) with mapi id 15.20.1943.016; Thu, 30 May 2019
 02:17:50 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: Enable the USB snooping
Thread-Topic: [PATCH] usb: dwc3: Enable the USB snooping
Thread-Index: AQHTXdpMV/QBUrO8J0eNmcCmR0ATg6MVIlkAgAAD6zCAABVWgINueaJwgAAMz4CAAYVcwIAADlOAgAEFSVA=
Date:   Thu, 30 May 2019 02:17:50 +0000
Message-ID: <AM5PR0402MB28650ECE851C840990816C1CF1180@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20171115060459.45375-1-ran.wang_1@nxp.com>
 <87ineb9b5v.fsf@linux.intel.com>
 <VI1PR04MB1504776EF3D4D8C374F0C069F1290@VI1PR04MB1504.eurprd04.prod.outlook.com>
 <87shdfet90.fsf@linux.intel.com>
 <AM5PR0402MB28654EBE2D431CC2F8061CF8F11E0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <87k1eaanjw.fsf@linux.intel.com>
 <AM5PR0402MB2865AB6C2A50851B7EA4E653F11F0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <874l5dr21m.fsf@linux.intel.com>
In-Reply-To: <874l5dr21m.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5c6e834-a328-43d9-3c35-08d6e4a50426
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM5PR0402MB2881;
x-ms-traffictypediagnostic: AM5PR0402MB2881:
x-microsoft-antispam-prvs: <AM5PR0402MB288134B70D4E5954895E5915F1180@AM5PR0402MB2881.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(376002)(39860400002)(189003)(199004)(7736002)(52536014)(81166006)(316002)(66946007)(9686003)(8936002)(64756008)(66556008)(229853002)(71200400001)(66066001)(4326008)(76116006)(446003)(66476007)(11346002)(71190400001)(305945005)(486006)(476003)(14444005)(68736007)(256004)(81156014)(74316002)(86362001)(6246003)(102836004)(2906002)(26005)(73956011)(5660300002)(8676002)(6506007)(7696005)(53546011)(6436002)(66446008)(53936002)(33656002)(25786009)(6916009)(55016002)(6116002)(3846002)(54906003)(14454004)(186003)(478600001)(99286004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2881;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oNI7vJm8GJgd/dEva3fPZYPX3F9AVbgo9cU4GZL3ntgeZCKqR6Yg+gHSgHKfj4JGhCp30Hau981pfscQgGrQms0krJxlR7N+gsVWY2QMd3e2T+HpmQ4Mei8ZLS23yk66IbdAEApIj8a3hGcImd0IP/lEySxxZcZYyGaXh4q+bhNkaMoY4k2B1MtStNub8qzK3rdymuRHu6ko5WUmcmQHCQ+4MFheBe43/C0uvRmoAAGXvXIb8qP/3ahvtN5NP3KUbV8RkODiEkNXUL+Co1PD8bw3CjP2H4b/RKqKoedK3vBw8UfiSHarNNcaYPegDNqNxeBYRMUF66zGlgbwXsKxXxqPOe/JzjbEFjwS7kuPZXdcP5iEWHWrqSRoqEoBwdxCIh3Ja0/O8ScLo1+rTMLrvh6Gp1Unaab6OuYoC/mZTPM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c6e834-a328-43d9-3c35-08d6e4a50426
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 02:17:50.8684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ran.wang_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2881
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On Wednesday, May 29, 2019 18:25, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Ran Wang <ran.wang_1@nxp.com> writes:
> >> >> >> c) WHAT does this mean for PCI devices?
> >
> > According to DWC3 data book, I think this (PCI) mean to the case of 'ma=
ster
> bus type =3D Native'
> > The data book describes this feature as 'system bus DMA option for the
> > master bus, which may be configured as AHB, AXI, or Native.' On Table
> > 6-5, it says when MBUS_TYPE is Native, the definition of 4 transfer typ=
es
> control bits [3-0] is 'Same as AXI'.
> >
> > However, as to the code implementation to be generic to both PCI and
> > AXI, I admit I don't have a perfect solution so far, only 2 proposals w=
ith
> concerns:
> >
> > a. Create another module driver like dwc3-exynos.c
> (arch/arm/boot/dts/wxynos54xx.dtsi)
> >     to contain above programming code. However, it will touch the same =
reg
> range of DWC3
> >     I think this is not good.
>=20
> I'd prefer avoiding another glue :-)

Got it.
=20
> > b. Add #ifdef CONFIG_ARCH_LAYERSCAPE in drivers/usb/dwc3/core.c to
> constrain hacking code
> >    can only take effect for Layerscape (AXI case). I know it look ugly.
> >
> > Do you have any better advice on this (besides changed power on default
> value from HW perspective)?
>=20
> Maybe we don't need to care, actually. Since this property will only be n=
eeded
> for RTL instantiation that didn't configure these defaults properly durin=
g
> coreConsultant.

Ok, I think I could add information in bindings to highlight this setting m=
ight
be RTL instantiation (SoC) relevant to prevent misusing.

> >> >> >> Another question is: Why wasn't this setup properly during
> >> >> >> coreConsultant instantiation of the RTL? Do you have devices on
> >> >> >> the market already that need this or is this some early FPGA
> >> >> >> model or test-only
> >> >> ASIC?
> >
> > Several Layerscape platforms like LS1043ARDB, LS1046ARDB, etc. are
> > already on the market and have this issue. So I have to work out a SW p=
atch to
> fix them.
>=20
> Thank you, now I'm certain that this is not some temporary solution :-)
>=20
> Thanks for going through this again. Please refresh the patch so we can t=
ry to
> get it merged.

Sure, as I know all LS1043A and LS1046A relevant platforms have added 'dma-=
coherent'
to DTS node of 'soc' in mainline, which means without this fix USB function=
 will down
definitely, I will go through all update requirement we've discussed and wo=
rk out
next version patch. Thank you.

Regards,
Ran=20
