Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0667CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EBF20679
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YQcBZDf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390337AbfJWI2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:28:13 -0400
Received: from mail-eopbgr50078.outbound.protection.outlook.com ([40.107.5.78]:62475
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390034AbfJWI2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:28:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+iAsvAvWL/yGg/5qR1lOO+4INOqC2yD16Q+zWSl+hX1JIPh4J1GPP9vIvvoHmALj9LJXYnZTlyr2V23ibgR+IHMzVtZLK2USu8U7GIy/s4vToB29qn0jFa6AJA7rmSnOBWKNfGe/9nhmRxsuPcLUq+Ay51NAy1BT7yF9hs9RqVAZgqodqLJGTD7UX/UwAkfhbRZvhvwpsNyE6THmD2h0Vm7xi3ktdS8T6f65gHWSo6y42KxG/QCqRbPE0gVUpurAa8qVQ4l+fyM2cNQpIswlnlg7RtFjfx2Blf7bQeeU1qMcg7ROI0jJD2jiJhMNPawesKo79aZVu0Dcry9uGBy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBI8+VpEjy81yxpmbh7MGyAEolNlJ+Yxnl07v6jag3k=;
 b=WA5cXOm9+ZbkgX2Os8pqJf2ZC453OtR4oNsGYSkiV6I7dCYxuzTxUc1CD23LGgiNKFQTbB5SGr7Lfjt0+HSmTmucaASg37him2LJOlu107/G0/wpvKhQejIG3gqAa7BAc2r2xKok5vTTMBE9ORIBcenr9/rMTa3k9iYfPeC1WiQJzKxUrIzX9PA5iRRVwpDrm40RvPRKsJ8AGeuDJW3z62g4/sWszQh7Ynw1Gj2clqPpMRI3NFqEvi+PdlQO+zaHPI8PHbp0g6yKlDw1olhKsN98XQ7NKiMYq+56etmBoUTyoSI4eRDA1JSh8b1yGaxso5vJJrpJXABSg4Y2MK/KVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBI8+VpEjy81yxpmbh7MGyAEolNlJ+Yxnl07v6jag3k=;
 b=YQcBZDf4R0zm7k8ZaETidwdnIX0a4OK7TgybkPeimyhieBfow1qVFhmG/FX85dg91sfRNjADyuSmdOpdMycY1IR0CFK6doMh0316WZAww3DKGmqbHpogVmXT+m0iaSgpAW7ZII+yCmNsXWM0JsKX0BEEEnFScJ3MW7/wPzLwIjo=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB6237.eurprd04.prod.outlook.com (20.179.24.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 23 Oct 2019 08:28:07 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::68e3:e1a6:78fd:7133%3]) with mapi id 15.20.2387.021; Wed, 23 Oct 2019
 08:28:07 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] usb: chipidea: use of extcon framework to work for
 non OTG case
Thread-Topic: [PATCH v1 1/2] usb: chipidea: use of extcon framework to work
 for non OTG case
Thread-Index: AQHViCsAqaE2F5BkzEikzWHSfo+rUadl6qoAgADFcwCAATcWgA==
Date:   Wed, 23 Oct 2019 08:28:07 +0000
Message-ID: <20191023082755.GA8578@b29397-desktop>
References: <20191021161654.14353-1-igor.opaniuk@gmail.com>
 <20191022020748.GA26973@b29397-desktop>
 <CAByghJbAnAN8dVAa0taPfLiMx2r4evcZhoryfZYyxjYiaFpTsw@mail.gmail.com>
In-Reply-To: <CAByghJbAnAN8dVAa0taPfLiMx2r4evcZhoryfZYyxjYiaFpTsw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9cc61e58-47ce-4f6f-e93a-08d75792ee79
x-ms-traffictypediagnostic: VI1PR04MB6237:|VI1PR04MB6237:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR04MB62378EC0BE0C343636CD29168B6B0@VI1PR04MB6237.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(189003)(199004)(54906003)(316002)(71190400001)(86362001)(66946007)(66476007)(64756008)(76116006)(66446008)(66556008)(71200400001)(66066001)(25786009)(305945005)(3846002)(6116002)(91956017)(33716001)(7736002)(256004)(4326008)(14444005)(2906002)(229853002)(6246003)(6916009)(44832011)(11346002)(446003)(6436002)(14454004)(6486002)(76176011)(478600001)(1076003)(99286004)(7416002)(102836004)(6506007)(26005)(53546011)(33656002)(476003)(9686003)(8936002)(81166006)(81156014)(6512007)(8676002)(486006)(186003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6237;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zh5LH72q/kc751CNMU73zv6xWZgPWyvCKJR6sxxhoD0C/7nyfAkkOozByGAcgFsXyUGeggJ9sO+eCWvxaXu46f0mno44WjyubCbNjTx3dTCZbrH7WJGWwvpcJWqsC7hz/lMl0LLKGlMK2JHJP003xzhyfcVWOOULyt9GOM+n6YlceiQbm6GjisIWiG72JqAVpYvgttKykB8ruDtC2tv4DAcbpqLnAquXN9kNnIngW0EiP+9ZeRp0fMpX/k73VpGTos9fDzMwtCj6E3g5V7AhCUUDy6zPjSMrbX+/hOOGmipZ0tzB+RuEnUj++ZIHx2Mz3fmg2leWH2ngUGji9KYUnvP7arOPUjo6vO0hNJa7dzJ+0zN2reoSvQsGrzxVV++T9KzzHULod/ui/uxs+fOkW/F5WTFm+xRPjRCQ/JyhKpgEBx7nhvlbBThjPz5fjaeE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06F95D668D4926478A4E443058C4F085@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc61e58-47ce-4f6f-e93a-08d75792ee79
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 08:28:07.2833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vazHGy8wCgUfIC1Bh94aA9Ebvo3Z4QblygpPzTsk2hOj1U+v/npcD7d/6xmeN8EgQE2CQFG4aJnL8Pqoy61xsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-22 16:54:30, Igor Opaniuk wrote:
> Hi Peter,
>=20
> On Tue, Oct 22, 2019 at 5:11 AM Peter Chen <peter.chen@nxp.com> wrote:
> >
> > On 19-10-21 19:16:53, Igor Opaniuk wrote:
> > > From: Stefan Agner <stefan.agner@toradex.com>
> > >
> > > The existing usage of extcon in chipidea driver freezes the kernel
> > > presumably due to OTGSC register access.
> > >
> > > Prevent accessing any OTG registers for SoC with dual role devices
> > > but no true OTG support. Use the flag CI_HDRC_DUAL_ROLE_NOT_OTG for
> > > those devices and in case extcon is present, do the role switch
> > > using extcon only.
> >
> > Hi Igor & Stefan,
> >
> > I have several questions about the problem you met:
> > - Which vendor's controller you have used?
> > - What do you mean "no true OTG"? Does it mean no "OTGSC" register?
>=20
> Probably the commit message adds a bit of confusion here
> (I've kept the original one from the patch in our downstream kernel,
> but will probably reword it).
>=20
> The actual problem is that USB_OTG1_ID pin isn't wired, so we can't rely
> on the value of ID pin state in OTGSC for the role detection.
> In our SoM (Colibri iMX6ULL) ID pin from USB connector is wired
> to SNVS_TAMPER2 which is pinmuxed as GPIO pin (GPIO5_02),
> [1] (this is schematic for the Carrier Board, not SoM (isn't publicly
> available),
> but there is a pretty good explanation + schematic
> in the section "2.3.2.2 USB 2.0 OTG Schematic Example ").

Ok, I clear now. Then, you may not use CI_HDRC_DUAL_ROLE_NOT_OTG which
is for the controller without OTGSC. For imx6ull, access OTGSC will not
hang the system if USB is NOT at suspend mode.

Current upstream design has already considered the user case for switch
role through GPIO, but there is an issue that the external cable
wakeup doesn't work, I will submit it later (see ci_extcon_wakeup_int
implementation at downstream kernel).

You could try to disable runtime-pm to see if the behaviour is expected
or not, if it is NOT expected, please report what's that?

>=20
> >
> > >       if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MOD=
E_HOST) {
> > >               ret =3D ci_hdrc_host_init(ci);
> > > @@ -1145,8 +1208,18 @@ static int ci_hdrc_probe(struct platform_devic=
e *pdev)
> > >
> > >       if (!ci_otg_is_fsm_mode(ci)) {
> > >               /* only update vbus status for peripheral */
> > > -             if (ci->role =3D=3D CI_ROLE_GADGET)
> > > -                     ci_handle_vbus_change(ci);
> > > +             if (dr_mode =3D=3D USB_DR_MODE_PERIPHERAL) {
> > > +                     usb_gadget_vbus_connect(&ci->gadget);
> >
> > We only use ci->role at runtime, since it has already considered the
> > dts setting, kernel configuration and hardware setting.
> >
> > If your controller doesn't otgsc register, but do need to support
> > role switch, you may enhance the function ci_get_role
>=20
> Btw, ci_get_role() implementation still resides in the NXP dowstream kern=
el
> and I've never seen anything posted to the ML (if it was, could you
> please point me to
> the patch?). I can introduce the new one, which wraps both OTGSC handling
> + extcon for CI_HDRC_DUAL_ROLE_NOT_OTG controllers.

Sorry about that, I just read code for the upstream kernel with some
downstream patches on it.

>=20
> Frankly speaking, I don't know the reason why additional workqueue (ci->w=
ork_dr)
> was introduced (will try to reach Stefan regarding this).
> As I see it's valid to call extcon_get_state() from the atomic
> context, so probably
> using something like ci_get_role()(or ci_detect_role(), whatever)
> instead of explicitly
> retrieving bits from OTGSC in every ID pin check is a good choice.
>=20

There are VBUS and ID events handling which are not non-atomic.

--=20

Thanks,
Peter Chen=
