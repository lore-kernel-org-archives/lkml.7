Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3637C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84080216F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="aI2em27o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfEQNPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 09:15:49 -0400
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:53479
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726556AbfEQNPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 09:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdevltd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Bq7kxBYjSuOHBzHUWiVirE24zmLr+g86XteVOR1cZo=;
 b=aI2em27oo6vCRHywUqDi76TC+/kf1026UtdBSoo59M7LUtBnP9yzG6tmICAWqYXRtPMqhAuVyQjRmUlBthrP/PbNdoxU7mfydnNUTfL/33ZF2qu++fA6lNtIc/27LE1bz1pSTTnVtHCeQDGQeM3A/RJbCJG2MZB7HNdhXJBuMsE=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB3264.eurprd08.prod.outlook.com (52.134.30.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 17 May 2019 13:15:43 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::8e9:9487:4f0a:fdaf]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::8e9:9487:4f0a:fdaf%3]) with mapi id 15.20.1878.028; Fri, 17 May 2019
 13:15:43 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Forest Bond <forest@alittletooquiet.net>,
        Ojaswin Mujoo <ojaswin25111998@gmail.com>
Subject: Re: [PATCH v3] staging: vt6656: returns error code on
 vnt_int_start_interrupt fail
Thread-Topic: [PATCH v3] staging: vt6656: returns error code on
 vnt_int_start_interrupt fail
Thread-Index: AQHVDIWpJheiltxkuEGGqxIJz+Vw2aZvCaCAgABClAA=
Date:   Fri, 17 May 2019 13:15:43 +0000
Message-ID: <20190517131539.GA9842@qd-ubuntu>
References: <20190516093046.1400-1-quentin.deslandes@itdev.co.uk>
 <20190517075331.3658-1-quentin.deslandes@itdev.co.uk>
 <20190517091723.GA4602@kroah.com>
In-Reply-To: <20190517091723.GA4602@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR0202CA0030.eurprd02.prod.outlook.com
 (2603:10a6:4:a5::16) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.21.227.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 542f9ec4-977b-41d7-f205-08d6dac9c3d1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR08MB3264;
x-ms-traffictypediagnostic: VI1PR08MB3264:
x-microsoft-antispam-prvs: <VI1PR08MB3264C7CE129C5C2D37FD720AB30B0@VI1PR08MB3264.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(396003)(366004)(376002)(136003)(39830400003)(189003)(199004)(40764003)(8936002)(68736007)(7736002)(6512007)(66446008)(66556008)(66946007)(44832011)(486006)(9686003)(66476007)(54906003)(316002)(3846002)(6116002)(52116002)(26005)(33656002)(1076003)(476003)(386003)(8676002)(81156014)(81166006)(33716001)(186003)(76176011)(73956011)(64756008)(11346002)(6506007)(229853002)(305945005)(6486002)(6916009)(2906002)(6436002)(99286004)(102836004)(66066001)(25786009)(446003)(14444005)(53936002)(6246003)(5660300002)(4326008)(71190400001)(86362001)(256004)(508600001)(71200400001)(74482002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3264;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +MXDBJHJ5GC9kAO9OqBPs2U6gKdHeN97GtEl+BnzdEW921VcicCH2ze4EsaEEgulcvgqsZrwPG3tzPIve2QRhmjL9UtTOE/QhzkFHVpekSJ1x2iFO4l2wKVsA3PdbsEAb0UClzo/doK+amnH8qWP2vtkq4ghteQnrs+CkJGf7HAhXJqCQ0p/jZlBAQtjMtShl2ykJK9JXWyUK79/xtvf0WQA0p8xkpPM/7GgSYFlFbnCguCgWn3k5SoqDQ0JTQlSPCq1+3/RahGQopO78atA1cldJ48LKY0AhfSHCPZc5RQnYwbs3perGgvs9gBqFS81uFj7zfKGidA/g3cWoI78J5nYBYTnMmto2MI0WSBT2T/oi7J/t9DsoE8sI1KzQ8Onz+vw25YPU3WjkPTajZklRgvcZtyGcRgO4WNIQV2ojRg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C5DE0311380A844B362DFE6208B51BA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 542f9ec4-977b-41d7-f205-08d6dac9c3d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 13:15:43.3505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 11:17:23AM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 17, 2019 at 07:53:49AM +0000, Quentin Deslandes wrote:
> > Returns error code from 'vnt_int_start_interrupt()' so the device's pri=
vate
> > buffers will be correctly freed and 'struct ieee80211_hw' start functio=
n
> > will return an error code.
> >=20
> > Signed-off-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> > ---
> > v2: returns 'status' value to caller instead of removing it.
> > v3: add patch version details. Thanks to Greg K-H for his help.
>=20
> Looking better!
>=20
> But a few minor things below:
>=20
> >=20
> >  drivers/staging/vt6656/int.c      |  4 +++-
> >  drivers/staging/vt6656/int.h      |  2 +-
> >  drivers/staging/vt6656/main_usb.c | 12 +++++++++---
> >  3 files changed, 13 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/staging/vt6656/int.c b/drivers/staging/vt6656/int.=
c
> > index 504424b19fcf..f3ee2198e1b3 100644
> > --- a/drivers/staging/vt6656/int.c
> > +++ b/drivers/staging/vt6656/int.c
> > @@ -39,7 +39,7 @@ static const u8 fallback_rate1[5][5] =3D {
> >  	{RATE_54M, RATE_54M, RATE_36M, RATE_18M, RATE_18M}
> >  };
> > =20
> > -void vnt_int_start_interrupt(struct vnt_private *priv)
> > +int vnt_int_start_interrupt(struct vnt_private *priv)
> >  {
> >  	unsigned long flags;
> >  	int status;
> > @@ -51,6 +51,8 @@ void vnt_int_start_interrupt(struct vnt_private *priv=
)
> >  	status =3D vnt_start_interrupt_urb(priv);
> > =20
> >  	spin_unlock_irqrestore(&priv->lock, flags);
> > +
> > +	return status;
> >  }
> > =20
> >  static int vnt_int_report_rate(struct vnt_private *priv, u8 pkt_no, u8=
 tsr)
> > diff --git a/drivers/staging/vt6656/int.h b/drivers/staging/vt6656/int.=
h
> > index 987c454e99e9..8a6d60569ceb 100644
> > --- a/drivers/staging/vt6656/int.h
> > +++ b/drivers/staging/vt6656/int.h
> > @@ -41,7 +41,7 @@ struct vnt_interrupt_data {
> >  	u8 sw[2];
> >  } __packed;
> > =20
> > -void vnt_int_start_interrupt(struct vnt_private *priv);
> > +int vnt_int_start_interrupt(struct vnt_private *priv);
> >  void vnt_int_process_data(struct vnt_private *priv);
> > =20
> >  #endif /* __INT_H__ */
> > diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656=
/main_usb.c
> > index ccafcc2c87ac..71e10b9ae253 100644
> > --- a/drivers/staging/vt6656/main_usb.c
> > +++ b/drivers/staging/vt6656/main_usb.c
> > @@ -483,6 +483,7 @@ static void vnt_tx_80211(struct ieee80211_hw *hw,
> > =20
> >  static int vnt_start(struct ieee80211_hw *hw)
> >  {
> > +	int err =3D 0;
> >  	struct vnt_private *priv =3D hw->priv;
> > =20
> >  	priv->rx_buf_sz =3D MAX_TOTAL_SIZE_WITH_ALL_HEADERS;
> > @@ -496,15 +497,20 @@ static int vnt_start(struct ieee80211_hw *hw)
> > =20
> >  	if (vnt_init_registers(priv) =3D=3D false) {
> >  		dev_dbg(&priv->usb->dev, " init register fail\n");
> > +		err =3D -ENOMEM;
>=20
> Why ENOMEM?  vnt_init_registers() should return a proper error code,
> based on what went wrong, not true/false.  So fix that up first, and
> then you can do this patch.
>=20
> See, your one tiny coding style fix is turning into real cleanups, nice!
>=20
> >  		goto free_all;
> >  	}
> > =20
> > -	if (vnt_key_init_table(priv))
> > +	if (vnt_key_init_table(priv)) {
> > +		err =3D -ENOMEM;
>=20
> Same here, vnt_key_init_table() should return a real error value, and
> then just return that here.
>=20
> >  		goto free_all;
> > +	}
> > =20
> >  	priv->int_interval =3D 1;  /* bInterval is set to 1 */
> > =20
> > -	vnt_int_start_interrupt(priv);
> > +	err =3D vnt_int_start_interrupt(priv);
> > +	if (err)
> > +		goto free_all;
>=20
> Like this, that is the correct thing.
>=20
> So, this is now going to be a patch series, fixing up those two
> functions (and any functions they call possibly), and then this can be
> the last patch of the series.
>=20
> thanks,
>=20
> greg k-h

Thank you for your help, this is getting really exciting! However, I had
a look at these function (vnt_init_registers() and vnt_key_init_table())
and some questions popped in my mind.

If I understand correctly, your request is to fix these function so they
can return an error code instead of just failing, as I did with
vnt_int_start_interrupt() in the third patch, which is also the most
logical behaviour.

So, vnt_init_registers() is a big function (~240 lines), which should
return a proper error code. For this, all the function called in
vnt_init_registers() should also return a proper error code, right?

What about functions called that does not return any value, but their only
action is to call a function that return a status code? As I learn with thi=
s
patch, discarding error values is not a acceptable behaviour. Why would we =
write
functions returning an error code solely to discard it? So such function sh=
ould
be changed too?

I listed up to 22 function that need to be updated in order to correctly
propagate errors up to vnt_start() so it could "nicely" fail and here is
the last problem: regarding this fair amount of changes, how to ensure
the device will work as well as before? I don't have this device at home
or at work and it doesn't seems easy to find.

Thank you,
Quentin
