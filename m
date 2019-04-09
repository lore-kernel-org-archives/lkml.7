Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD03C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE5A20830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="DHNoMD1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDIJrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:47:53 -0400
Received: from mail-eopbgr1400107.outbound.protection.outlook.com ([40.107.140.107]:65024
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfDIJrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OseHzYK+wOuq0fd4DGSoi0wi6fKomx5nIfGuIuB7mlY=;
 b=DHNoMD1LO62RVYpF7mZ+dIIC4wE56RtU//laDNeQWJSap9G2L0KOzpZxeL3PjBMfhv7mxAc8K/IJvM9xZhMRVMXJl1vmN/zxpLmC/HHBGFTxI+xG5sDSbScGWFAkosMacC/lzF9bYV0f39GvRSwPmwA6bxjvQA1Qb/NwS0ShWzI=
Received: from TYAPR01MB4271.jpnprd01.prod.outlook.com (20.178.139.148) by
 TYAPR01MB4221.jpnprd01.prod.outlook.com (20.178.140.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 09:47:49 +0000
Received: from TYAPR01MB4271.jpnprd01.prod.outlook.com
 ([fe80::cda2:4f20:84e4:de70]) by TYAPR01MB4271.jpnprd01.prod.outlook.com
 ([fe80::cda2:4f20:84e4:de70%4]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 09:47:49 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Simon Horman <horms@verge.net.au>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 3/3] phy: renesas: rcar-gen3-usb2: enable/disable
 independent irqs
Thread-Topic: [PATCH 3/3] phy: renesas: rcar-gen3-usb2: enable/disable
 independent irqs
Thread-Index: AQHU6IMtNq0pm/ZwY0KVYOnopE2tzqYqK7OAgAl1TzA=
Date:   Tue, 9 Apr 2019 09:47:49 +0000
Message-ID: <TYAPR01MB4271AF6C14F4A99902FAFA2FD82D0@TYAPR01MB4271.jpnprd01.prod.outlook.com>
References: <1554120083-29990-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1554120083-29990-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190403091939.qguys2dftombenpb@verge.net.au>
In-Reply-To: <20190403091939.qguys2dftombenpb@verge.net.au>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca20d1e0-8fa0-43fb-1954-08d6bcd06d6c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB4221;
x-ms-traffictypediagnostic: TYAPR01MB4221:
x-microsoft-antispam-prvs: <TYAPR01MB422196E7B2DF326EDD4B3DFCD82D0@TYAPR01MB4221.jpnprd01.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(39860400002)(396003)(346002)(51444003)(189003)(199004)(81156014)(4326008)(33656002)(8676002)(2906002)(14454004)(97736004)(478600001)(8936002)(81166006)(486006)(7696005)(68736007)(76176011)(6506007)(5660300002)(66066001)(26005)(102836004)(105586002)(106356001)(99286004)(316002)(74316002)(186003)(256004)(7736002)(6246003)(71200400001)(53936002)(6916009)(71190400001)(305945005)(229853002)(476003)(14444005)(6436002)(55016002)(9686003)(446003)(3846002)(86362001)(6116002)(52536014)(25786009)(54906003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4221;H:TYAPR01MB4271.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1PnhpPlR/eI0XfdVZhfKqflLuUPtM3k/iHILDv4PwOoh9q6KpY7O7Iyqbra1DGHN1TBuSUiZhQ8KN0LKqvjWZU2UEvH2Mv2kYcUwuI8WIevwwZD7y5WyUdGIcS7iOo9v8wVnAPfkAXwUJJzbSXoAC4uQfDY0WTCDk52WvsYkQVOduW2mWuX6FKlLb4SOv+uONHoIp1yD8OokSLUBTbjVFn/lJDCQf7ZffuWt9CxmNrRxlUAFrOLiHARUG4/Xl4JjNN7j0cE4Oc049HDcqJISToEsM3/TZitrYtugIjMtbQM+LpX0C8DQyCaWwrzGJYfMMzUgfyNlKZfQWA7cXC6zetaLls31sG2bTgnZZoQMHbPybEcTSS380Q3ZPAdQRw5jJXQCOWO3zFVupIUtRZ9AYryEs6UMNWY4sYDJognzSkk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca20d1e0-8fa0-43fb-1954-08d6bcd06d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 09:47:49.2702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon-san,

> From: Simon Horman, Sent: Wednesday, April 3, 2019 6:20 PM
>=20
> Hi Shimoda-san,
>=20
> On Mon, Apr 01, 2019 at 09:01:23PM +0900, Yoshihiro Shimoda wrote:
> > Since the previous code enabled/disabled the irqs both OHCI and EHCI,
> > it is possible to cause unexpected interruptions. To avoid this,
> > this patch creates multiple phy instances from phandle and
> > enables/disables independent irqs by the instances.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> I noted a few nits below but overall this looks good to me.
>=20
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thank you for your review!

<snip>
> > +#define NUM_OF_PHYS			4
> > +#define PHY_INDEX_BOTH_HC		0
> > +#define PHY_INDEX_OHCI			1
> > +#define PHY_INDEX_EHCI			2
> > +#define PHY_INDEX_HSUSB			3
>=20
> nit: I think the above #defines would be better expressed as an enum.

I'll modify it.

<snip>
> > +static enum usb_dr_mode rcar_gen3_get_dr_mode(struct device_node *np)
> > +{
> > +	enum usb_dr_mode candidate =3D USB_DR_MODE_UNKNOWN, tmp;
>=20
> nit: I think that there could be a better name for tmp, f.e. mode
> nit: The scope of tmp could be limited to inside the for loop.

I'll modify it.

Best regards,
Yoshihiro Shimoda

