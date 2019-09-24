Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9245C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 03:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A044D20872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 03:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lKFosT6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437496AbfIXDdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 23:33:21 -0400
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:2817
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729308AbfIXDdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 23:33:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RN6wSONGqOZK+YzSRSIjCt+6J6UFQx920NzRdoiKNtrRzmLYT+1PK0d2r+wxT8cdAYIouBUZ2tPUBQ3gVtAZfNSTbfPzITEDgP1tklFgHq4MV9MEN85rN3WmxAHADI+7SODGK4lI2yo88xr/q9dVrqrdzs5d0rp5ogTt1quJ/8EYCwCJq/jU2U1uoVoJEGh9dQesj+4bZcr+uNhwomL2+ipWV+oYzradORQEaEw1AC4nMpNaPpxaF1bz5XTGFD00M5KH7Sl96w3hpV4D30FC/Al8LlIef8BLBGlKAtHBi3CeG+cTzrf8t4+VlC2tvE3Fw1A7o8Gn8PPib2XM8nCftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDxfBsK+MlvOSFJD9kB7m/i2bWuMSHm8dIfbmAgijA4=;
 b=DREC2MIPL0Ue1jbu1MFZwuV4fahmiSAQHn3m/wIz8hizR/irG1MWxkcKbSN8Sy4KcXV/02UgZRRvZFCUJx/JRjk7QxyqhkIUdzRv74aPLZRBGWMUpQxM0rGQFHVfeM/xfTm6k8HaLCA5JDsJDPptZ6xqWaT8AoQu7djggxCh/B7psQa6IIuiBPHF1r/wAbz90Ls9BjwkpJpuJPtQ+600sXfyW215qg2v6Q8bpI/EAQIXhvOoyXN3Ar+2qVFykwe8I7yUpKENP7uRx1H2r/Fmjz3M1mXvbQefGF6W+u/Gb4JR0z3de+mMm52aVpw/QKwACcEnFFN7U4KpRWNXUapoTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDxfBsK+MlvOSFJD9kB7m/i2bWuMSHm8dIfbmAgijA4=;
 b=lKFosT6ymow8//TSHSAWfpOYZ5TpyK1SqGB9+jj3CryJS1FPxaDScllFnBYNzQ+wPxXos8OA4gzgLwiQ+KN2I/eEBF12wmGXtnO5nsN7+fuSBJYP2W3CuZKxnBVLPduAPjHQsrwEpmPH5VAkSaDmKCWSJ/CUG+kQ9dgiQA+ZOSo=
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com (52.133.240.82) by
 DB8PR04MB5897.eurprd04.prod.outlook.com (20.179.11.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Tue, 24 Sep 2019 03:32:37 +0000
Received: from DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::906f:1414:8cb:f7ee]) by DB8PR04MB6826.eurprd04.prod.outlook.com
 ([fe80::906f:1414:8cb:f7ee%2]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 03:32:37 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: hub add filter for device with specific VID&PID
Thread-Topic: [PATCH] usb: hub add filter for device with specific VID&PID
Thread-Index: AQHVcfycJPrHn/IcK0qf/xic1GWPZ6c5W4SAgADPjkA=
Date:   Tue, 24 Sep 2019 03:32:37 +0000
Message-ID: <DB8PR04MB6826516958DA6083192250CFF1840@DB8PR04MB6826.eurprd04.prod.outlook.com>
References: <20190923105102.37413-1-ran.wang_1@nxp.com>
 <Pine.LNX.4.44L0.1909231059260.24712-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909231059260.24712-100000@netrider.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3b1e3a7-c3cc-429b-9239-08d7409fd8cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR04MB5897;
x-ms-traffictypediagnostic: DB8PR04MB5897:
x-microsoft-antispam-prvs: <DB8PR04MB5897A5582EC5999EA29F88F7F1840@DB8PR04MB5897.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(199004)(189003)(476003)(6246003)(7736002)(6116002)(9686003)(55016002)(6506007)(71200400001)(5660300002)(86362001)(2906002)(14444005)(256004)(6916009)(53546011)(6436002)(3846002)(102836004)(305945005)(74316002)(33656002)(66446008)(64756008)(66946007)(446003)(11346002)(71190400001)(81166006)(186003)(7696005)(8676002)(4326008)(54906003)(229853002)(81156014)(52536014)(66476007)(316002)(486006)(76116006)(478600001)(8936002)(66556008)(66066001)(14454004)(76176011)(99286004)(2171002)(25786009)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5897;H:DB8PR04MB6826.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: thy7CaXDRUI0cpGw09e5XN/y6hZ5pssGMuCD+x/V0SDid6srS+jaHtPA8BRuSbuVeJrFRRSaA37nSJeubdOqGNI9j0ftGfCgxLhuQxZ9mkXEIoOYROsaLfn9F37XijtzSirJD1dejPNkHQ7F1GzelFadgn3Lw9eAM99qN+YRRXXCcwbXmgrduL1ro/YO5MGpffrjSC1PMkIFKTO76mTG8JqR14fYD7jphlF10tFOo20BW7i3YFyPrs2ZeDmr11wjO3jc2qUN2aVTeaz66OQmbg5XuCzKXeY60UZHsnEQosSaWbiorgBqUKSjTPln8gI0FVR95G/NhS/fpNk2I3G+K/pNAlw/MT80egf7UaEREbkQLj3EBm5lmHk7YLYx0rpRG4tfWlTpWFaUmbWrxFJ/WGWcuapeoLv/33tE3dqrvT0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b1e3a7-c3cc-429b-9239-08d7409fd8cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 03:32:37.6623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2D5CbC74VG5nmaNiaVGlu60scwG17T9vxwjIcQ3lTyCZ4BzlFZSueiLET5A3fy+GumsLHOuyajpr6Ka1uTNguw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5897
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Monday, September 23, 2019 23:01, Alan Stern wrote:
>=20
> On Mon, 23 Sep 2019, Ran Wang wrote:
>=20
> > USB 2.0 Embedded Host PET Automated Test (CH6) 6.7.23 A-UUT
> > "Unsupported Device" Message require to stop enumerating device with
> > VID=3D0x1a0a PID=3D0x0201 and pop message to declare this device is not
> supported.
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  drivers/usb/core/hub.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c index
> > bbcfa63..3cda0da 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -4982,6 +4982,18 @@ static void hub_port_connect(struct usb_hub *hub=
,
> int port1, u16 portstatus,
> >  		if (status < 0)
> >  			goto loop;
> >
> > +		 /* USB 2.0 Embedded Host PET Automated Test (CH6)
> > +		 * 6.7.23 A-UUT "Unsupported Device" Message
> > +		 * require to filter out below device when enumeration
> > +		 */
> > +		if ((udev->descriptor.idVendor =3D=3D 0x1a0a)
> > +		 && (udev->descriptor.idProduct =3D=3D 0x0201)) {
> > +			dev_err(&udev->dev, "This device is not supported:
> idVendor=3D0x%x idProduct=3D0x%x\n",
> > +				udev->descriptor.idVendor,
> > +				udev->descriptor.idProduct);
>=20
> There's no need to write out the Vendor and Product IDs.  They already ap=
pear
> in the "New device" message.

OK

> > +			goto done;
> > +		}
> > +
> >  		if (udev->quirks & USB_QUIRK_DELAY_INIT)
> >  			msleep(2000);
>=20
> Shouldn't this be implemented as a device quirk?

Yes, I was also looking for the way in quirk but not quite sure currently.
So we can stop initializing a device (with specific VID&PID) in quirk, righ=
t?

Actually in drivers/usb/core/hub.c function usb_enumerate_device(), it will
call is_targeted(udev) which has below implementation:

54         /* OTG PET device is always targeted (see OTG 2.0 ECN 6.4.2) */ =
        =20
55         if ((le16_to_cpu(dev->descriptor.idVendor) =3D=3D 0x1a0a &&     =
             =20
56              le16_to_cpu(dev->descriptor.idProduct) =3D=3D 0x0200))     =
            =20
57                 return 1;   =20

The ID is very close to what I need to response. So, do I need to add code =
here?

Thanks.
Ran

