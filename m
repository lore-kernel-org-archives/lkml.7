Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18559C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78B620830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="BVs9hw09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfDIJtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:49:46 -0400
Received: from mail-eopbgr1400124.outbound.protection.outlook.com ([40.107.140.124]:19792
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726079AbfDIJtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZJJIhGjLfGsFunJd1udP0GiK/8wm5CJPeinnX28ngw=;
 b=BVs9hw096LNYI4JUMqp0azMroZWamnWVD266lv0qZDwJM6Pgqmxl4fayw3Lll6jwpfnDSSQyNTIo/gQbEHT3Y1xJe36I2KFatLgb8ZIplV82p9LwaVljVA5aCiilvH7CGGKJyMkotaOAUbfbeumRpp2TdWFLrPcf+tlJjWT6hTY=
Received: from TYAPR01MB4271.jpnprd01.prod.outlook.com (20.178.139.148) by
 TYAPR01MB4221.jpnprd01.prod.outlook.com (20.178.140.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 09:49:43 +0000
Received: from TYAPR01MB4271.jpnprd01.prod.outlook.com
 ([fe80::cda2:4f20:84e4:de70]) by TYAPR01MB4271.jpnprd01.prod.outlook.com
 ([fe80::cda2:4f20:84e4:de70%4]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 09:49:42 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: RE: [PATCH 3/3] phy: renesas: rcar-gen3-usb2: enable/disable
 independent irqs
Thread-Topic: [PATCH 3/3] phy: renesas: rcar-gen3-usb2: enable/disable
 independent irqs
Thread-Index: AQHU6IMtNq0pm/ZwY0KVYOnopE2tzqYqRMIAgAlc0+A=
Date:   Tue, 9 Apr 2019 09:49:42 +0000
Message-ID: <TYAPR01MB4271AFFCCC0B2D1215227746D82D0@TYAPR01MB4271.jpnprd01.prod.outlook.com>
References: <1554120083-29990-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1554120083-29990-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <TY1PR01MB17706362E3C2AB67C3ABD1E7C0570@TY1PR01MB1770.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB17706362E3C2AB67C3ABD1E7C0570@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 905d9d14-8dc1-4805-906f-08d6bcd0b118
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB4221;
x-ms-traffictypediagnostic: TYAPR01MB4221:
x-microsoft-antispam-prvs: <TYAPR01MB422170E8D303374EC04411E2D82D0@TYAPR01MB4221.jpnprd01.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(39860400002)(396003)(346002)(189003)(199004)(81156014)(4326008)(33656002)(8676002)(2906002)(14454004)(97736004)(478600001)(8936002)(81166006)(486006)(7696005)(53546011)(68736007)(76176011)(6506007)(5660300002)(66066001)(26005)(102836004)(105586002)(106356001)(99286004)(316002)(74316002)(186003)(256004)(7736002)(6246003)(71200400001)(6862004)(53936002)(71190400001)(305945005)(229853002)(476003)(14444005)(6436002)(55016002)(9686003)(446003)(3846002)(86362001)(6116002)(52536014)(25786009)(54906003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4221;H:TYAPR01MB4271.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Llo38HQgcR63AtBc9gc0LmtYZisAmpfbsekpLnBj8Qg00xWFt3C2VU63PnnQxqtXoFyn9Ay0aNJ1zI+rMXly3hvNwwhu2i36PBvoiFnzRD6U0eZXcFqMeYXjobGdm28L1mALPi2CuT4MmLJpNtlss8rFiDlcPvbgqK1YlfpW/dva4D7xYMuAxdjs6fS/ZoGu7bhpAlYyjixBodHjYk3cAL8+sg1E7NNM5hoJGH4LjG54GWgbb8o/uMVRk9YiyicGEdxcctDgZwnXxNKQ2+syjHyO4Yy8AqOj2XXaeUvmPY/n4O3IB2TpS16WEbO6JjLIZTBxtmyyWRT5WMVNetIHXDfrc08W+YTBcT7Zu4DhdwkWVGXr4DfxuyVKU1R6F39gEEbYpXDsB0e0G6ZJ+NsE1CaTuXYNwH2uxfj3pRpsTzA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905d9d14-8dc1-4805-906f-08d6bcd0b118
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 09:49:42.7738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fabrizio-san,

> From: Fabrizio Castro, Sent: Wednesday, April 3, 2019 7:49 PM
>=20
> Hello Yoshihiro-san,
>=20
> Thank you for your partch!
>=20
> > From: devicetree-owner@vger.kernel.org <devicetree-owner@vger.kernel.or=
g> On Behalf Of Yoshihiro Shimoda
> > Sent: 01 April 2019 13:01
> > Subject: [PATCH 3/3] phy: renesas: rcar-gen3-usb2: enable/disable indep=
endent irqs
> >
> > Since the previous code enabled/disabled the irqs both OHCI and EHCI,
> > it is possible to cause unexpected interruptions. To avoid this,
> > this patch creates multiple phy instances from phandle and
> > enables/disables independent irqs by the instances.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Tested-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Thank you for your review and test!

<snip>
> > +static enum usb_dr_mode rcar_gen3_get_dr_mode(struct device_node *np)
> > +{
> > +	enum usb_dr_mode candidate =3D USB_DR_MODE_UNKNOWN, tmp;
> > +	int i;
> > +
> > +	/*
> > +	 * If one of device nodes has other dr_mode except UNKNOWN,
> > +	 * this function returns UNKNOWN.
> > +	 */
> > +	for (i =3D 0; i < NUM_OF_PHYS; i++) {
> > +		tmp =3D of_usb_get_dr_mode_by_phy(np, i);
>=20
> We are calling of_usb_get_dr_mode_by_phy with i =3D=3D 0, but we don't do=
cument it
> in the dt-bindings document?

This (i =3D=3D 0) is for backward compatibility. So, I'll add such a commen=
t on the driver.

Best regards,
Yoshihiro Shimoda

