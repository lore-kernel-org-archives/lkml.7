Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9E0C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E9320850
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 02:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JUehoy37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfH0Chu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 22:37:50 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:36231
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbfH0Chu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 22:37:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJPNALwBCoQ4dpi5Mwj3TGN77HLztEI/s+WVF8GMfllpoAqojsOw9DOVfdBF8CNBDDXqNpOmTL+zwGBhxvNpweZ1fLjNzpPk3SbWxHhaGQBTWI/BICfUuNnvo9hfwMyNByN65NQhWqzpG+cTWLVvBuvUEHcxDm2G7z85gwgv5/q0FfyjftrJkDGN6wb09hamaj1EgzoTlpokGgoXZUQpCtXecy2DblMX/nDn0BgfNo4AeOI0Yq1WHoFlmiq1ENyIv+ac4ztprhwHv1y1PzOq3zg/sf4rCmRR62a6/jOFsakKmgZZnkj5H2CDojSe5tIv1IuO/llU1fLxSaShR+t0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh6PQN3MhLX50M52oXu5hwSSeeJrutsHabA55Ls2OCo=;
 b=YHgUAkDGCrwq719ebyDGl9F6RmXg47qD4EKjMDMeWeczWHUB/Wqnq6dq0JKC1JjQdQBG3n8ccDd+1UyUSGer2NWeTnac25HjMP5jNoGEy2NM1rbpesWMhpakWXY4aVw1HiUI8bPC/WDoDIdtvqcxlQMWb113TtqVHMPpeuMoa6ENp1lAMNkr5rgVKh1ygZIH/OB6qfLCYFAb4zcn9gripxKotQ2qzwUSPfn0asWosLfKGpcO1NgCpf1aKdUikmUyq671POahchAAL3hoe3z+lX8eUOY46M81DFOwU5JRHaGPkwVizbzrQb+qL+qQcyghEVQebU2Z1OBLJZoVJGiJ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh6PQN3MhLX50M52oXu5hwSSeeJrutsHabA55Ls2OCo=;
 b=JUehoy37S4O9QRS8ng+El1Wyn3A919POFlvj7CaSDMiSIrtQiVxN17HugEhz/O7szMRJWKFRpF5829M7P3qG/HljvZ8lAoar+ZI/5Yn47Pu/B0p0AJ2xT5P08jQMIUbL/6cwb0V3gfdNYvJEF1ZL8J4LKrfBoxd4DKju8cY97ak=
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com (52.133.240.82) by
 DB8PR04MB5691.eurprd04.prod.outlook.com (20.179.9.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 02:37:46 +0000
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::ad63:e8df:f0c2:7246]) by DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::ad63:e8df:f0c2:7246%2]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 02:37:46 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>, Yinbo Zhu <yinbo.zhu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Xiaobo Xie <xiaobo.xie@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [EXT] Re: [PATCH v1] usb: dwc3: remove the call trace of
 USBx_GFLADJ
Thread-Topic: [EXT] Re: [PATCH v1] usb: dwc3: remove the call trace of
 USBx_GFLADJ
Thread-Index: AQHVRdjlAL5PjFT4bkqsQBug9WvpnabwwpYAgAYomICAACZOgIAEo6yAgAAcWACAEp/msA==
Date:   Tue, 27 Aug 2019 02:37:45 +0000
Message-ID: <DB8PR04MB682695EEB3E358BDB3E2D5D0F1A00@DB8PR04MB6826.eurprd04.prod.outlook.com>
References: <20190729064607.8131-1-yinbo.zhu@nxp.com>
 <875zn8nt31.fsf@gmail.com>
 <VI1PR04MB41580DBF1A0C2DC143EE9CE3E9D30@VI1PR04MB4158.eurprd04.prod.outlook.com>
 <87h86nvtqo.fsf@gmail.com>
 <VI1PR04MB4158B49129BE9E3C00997555E9AC0@VI1PR04MB4158.eurprd04.prod.outlook.com>
 <87v9uzt1dr.fsf@gmail.com>
In-Reply-To: <87v9uzt1dr.fsf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d1f106d-fd46-493f-4b97-08d72a978b33
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB5691;
x-ms-traffictypediagnostic: DB8PR04MB5691:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB56914FB3CA9BBA0662F30CB6F1A00@DB8PR04MB5691.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(189003)(199004)(66066001)(305945005)(66556008)(66476007)(66946007)(76116006)(2501003)(446003)(256004)(14444005)(66446008)(476003)(486006)(11346002)(99286004)(76176011)(26005)(64756008)(186003)(102836004)(6506007)(53546011)(7696005)(71200400001)(71190400001)(33656002)(316002)(74316002)(3846002)(25786009)(9686003)(8676002)(8936002)(5660300002)(110136005)(54906003)(229853002)(86362001)(2906002)(7736002)(4326008)(53936002)(81156014)(6246003)(55016002)(6116002)(6436002)(478600001)(14454004)(81166006)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5691;H:DB8PR04MB6826.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B329vy0RpKpH4NGIMDRKUmkKa/BtKLDlhPAtMA0HrW0ltoNgsdsq1sSFtQlF0cY5W+PGXqUVlRybubtqprMeE0KznYXHvH3IrBdrrtxrqX+rlV7Xnuf/IA/ZBYLK0r+mLeVi/JmseMK7g3hPf5Kg2m0c6dlT/gO2W5owMlsBK1OdlwCpnOWpFfygmNhR6I4gWw8zqzLDN7dfkQan3hO++dARVou5CnxJK+PETqtrmfkwOuWDO0x/GegUTVwfHrNhauHTPrwNLe6VPP6jfbLRq6yn7ee40sAd4gbwCYPJA4SGYCAtrjysdxia0ekRX0NF8Fkg/0byoi4BvSWahaLhsvl1c2nTKq65dUX9M8/hS37fQAtxzsuxPCkdY0uaOfAS4UHK5aGoUPUoU6s3rOSW+xoFVUE/BI9pjJq0m2Pv0a8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1f106d-fd46-493f-4b97-08d72a978b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 02:37:45.8316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRk8nN4KP1p3H/0pWbhWqI894eKm9Eq3jqjpbB4PEOJExV8maEqZoALP2FB7NEYaOc638QQhC73vKRiyjQM9zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5691
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On Thursday, August 15, 2019 13:59, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Yinbo Zhu <yinbo.zhu@nxp.com> writes:
> >> Yinbo Zhu <yinbo.zhu@nxp.com> writes:
> >> >> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> >> >> > index
> >> >> > 98bce85c29d0..a133d8490322 100644
> >> >> > --- a/drivers/usb/dwc3/core.c
> >> >> > +++ b/drivers/usb/dwc3/core.c
> >> >> > @@ -300,8 +300,7 @@ static void
> >> >> > dwc3_frame_length_adjustment(struct
> >> >> > dwc3 *dwc)
> >> >> >
> >> >> >       reg =3D dwc3_readl(dwc->regs, DWC3_GFLADJ);
> >> >> >       dft =3D reg & DWC3_GFLADJ_30MHZ_MASK;
> >> >> > -     if (!dev_WARN_ONCE(dwc->dev, dft =3D=3D dwc->fladj,
> >> >> > -         "request value same as default, ignoring\n")) {
> >> >> > +     if (dft !=3D dwc->fladj) {
> >> >>
> >> >> if the value isn't different, why do you want to change it?
> >> >>
> >> >> --
> >> >> Balbi
> >> > Hi Balbi,
> >> >
> >> > I don't change any value. I was remove that call trace.
> >>
> >> Sure you do. The splat only shows when you request a FLADJ value
> >> that's the same as the one already in the register. The reason you
> >> see the splat is because your requested value is what's already in the=
 HW.
> >>
> >> So, again, why are you adding this device tree property if the value
> >> is already the correct one?
> >>
> >> > In addition that GFLADJ_30MHZ value intial value is 0, and it's
> >> > value must be 0x20, if not, usb will not work.
> >>
> >> it's not zero, otherwise the splat wouldn't trigger. You're
> >> requesting the value that's already in your register by default.
> >>
> >> --
> >> Balbi
> >
> > Hi Balbi,
> >
> > According that rm doc that GFLADJ_30MHZ has a default value is 0x20,
> > when GFLADJ_30MHZ_REG_SEL is 0, this 0x20 is a hard-coded value.
> >
> > But in fact, that default value is 0, please you note!
> >
> > Then according that xhci spec 5.2.4, that register the sixth bit if is
> > 0, then that can support Frame Lenth Timing value.
> >
> > So set GFLADJ_30MHZ_REG_SEL to 1 for use FLADJ, then I find that it
> > must use 0x20 usb will work well, even thoug xhci can permit
> > GFLADJ_30MHZ use other value
>=20
> You only get the splat because you try to sent GFLADJ to 0x20 and it's AL=
READY
> 0x20. This means that you don't need the property in DTS.
>=20
> > In addition about what you said is about dts patch, and that patch had
> > merged by upstream, patch owner isn't me,
>=20
> Well, then remove the setting from DTS, since clearly it's not needed.

Please considering below scenarios on the same board which needs GFLADJ pro=
perty on kernel DTS:

1. Board boot to U-Boot first, then load kernel. In this case, we need kern=
el DTS
    help to get GFLADJ setting right, everything is as expected.

2. Board boot to U-Boot console, then execute 'usb start' under U-Boot cons=
ole to init
    DWC3 controller, then load kernel. In this case, actually GFLADJ is cor=
rectly
    configured already, and the GFLADJ config double-checking is fine (beca=
use kernel
    cannot know if U-Boot has initialized it or not), but warning looks not=
 necessary.

3. Board boot to kernel, GFLADJ get set from DTS, then system suspend & res=
ume. In this case
    when resuming, GFLADJ setting has been restored correctly, so here we m=
ight not need
    send out the warning message (double-checking might be fine).

So, what's your suggestion to remove this looks non-necessary warning messa=
ge?

Thanks & Regards,
Ran

> > My patch is only for remove the call-trace, about why remove it commit
> > information has detail introduce please check!
>=20
> --
> balbi
