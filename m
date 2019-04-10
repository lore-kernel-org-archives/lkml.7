Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D37EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431C1206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="QfhuVAE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388021AbfDJQqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:46:37 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:30310
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732780AbfDJQqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf28rCKWqLc8TGs6FIkZDUX0suqUniy6/AYU9MIDYn0=;
 b=QfhuVAE3xhUTuNb9Bko6n7rqIEk3yxNXg1QdzBxhM0OkShY6kKMJLgoxAPuYGWXRaHstT3hzDeXthobYg7v5ASjDcFjHKdC0WvtwKmkw7TUoGjyEPIR0R1wL31Z6kCnqyOzbp9o4QZS4E0w0rUMHmTb3sIcIxL0OmeMwhmbQwwA=
Received: from VI1PR0801MB1935.eurprd08.prod.outlook.com (10.173.73.149) by
 VI1PR0801MB1902.eurprd08.prod.outlook.com (10.173.73.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 16:46:32 +0000
Received: from VI1PR0801MB1935.eurprd08.prod.outlook.com
 ([fe80::4a6:561d:54b7:5011]) by VI1PR0801MB1935.eurprd08.prod.outlook.com
 ([fe80::4a6:561d:54b7:5011%9]) with mapi id 15.20.1771.014; Wed, 10 Apr 2019
 16:46:32 +0000
From:   Ben Davis <Ben.Davis@arm.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm: Add writeback_w,h properties
Thread-Topic: [PATCH 1/2] drm: Add writeback_w,h properties
Thread-Index: AQHU74amwIxOwSjfOU+AYdTKY4TuV6Y1R62AgABTK4A=
Date:   Wed, 10 Apr 2019 16:46:32 +0000
Message-ID: <20190410164631.GB5105@arm.com>
References: <cover.1554891327.git.ben.davis@arm.com>
 <4509c625676508caf2b3f5035d901d8fe862fa76.1554891327.git.ben.davis@arm.com>
 <209a6f72-32b6-e546-4fd3-4c27d087d13c@linux.intel.com>
In-Reply-To: <209a6f72-32b6-e546-4fd3-4c27d087d13c@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.24 (2015-08-30)
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::26) To VI1PR0801MB1935.eurprd08.prod.outlook.com
 (2603:10a6:800:89::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Davis@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40c0a435-bea0-4494-ae68-08d6bdd41647
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0801MB1902;
x-ms-traffictypediagnostic: VI1PR0801MB1902:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0801MB19028B9A2DE18007A085DBADE52E0@VI1PR0801MB1902.eurprd08.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(346002)(136003)(189003)(199004)(71190400001)(6436002)(105586002)(386003)(8676002)(71200400001)(102836004)(72206003)(6486002)(86362001)(14454004)(446003)(6916009)(44832011)(68736007)(97736004)(229853002)(4326008)(66066001)(476003)(6512007)(486006)(8936002)(5660300002)(36756003)(2616005)(99286004)(106356001)(6246003)(26005)(186003)(6116002)(3846002)(33656002)(25786009)(316002)(6506007)(11346002)(7736002)(53936002)(76176011)(256004)(52116002)(58126008)(2906002)(305945005)(54906003)(81166006)(81156014)(1076003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1902;H:VI1PR0801MB1935.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /5atSuj+OhwfAp1qaKGHuHwctL6GuB0XrHaqnkCTSfruhCV2zZZe/JjZqN3PD3jQyaZNB/F+JyDRfNVl3Vf0CKKk1aRfi8cCgqwx9vjN9oup2+f4YtyuV99kaRgk/VtHnF22LFc+caSA1sU55xEnJUXtBLrBjxvFpt4HBxrNtnFBSCY+4y0xt6EG0MVOIs6Lt76SzlkbnBJE9qnwvmj6K75Oht8IyCXYqwpdF4SRE3Q3XUH0TvR4bNmNGM9WM+zyGZ+UpdiapBRusAlX5NR+LaMsJ6LJ5PNLzN94Vm7HVlUC45+bO8jGEtOC0aUdZrJ2RGSt2ZiWMyPvWSyN7JFRhZpMK2w6sUVEoXmYUw+xXWCG8KZzQ9QIzwBnJFU2/ibLZHcS9ebhBBaN8qhtKHs9lJ57NOHTdFT2os9josrCA4I=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <260EFEFFDD4E8642948B51C0B4BA3DD4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c0a435-bea0-4494-ae68-08d6bdd41647
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 16:46:32.7269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1902
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 01:48:51PM +0200, Maarten Lankhorst wrote:
> Op 10-04-2019 om 13:11 schreef Ben Davis:
> > Add new properties to specify width and height for writeback.
> >
> > Signed-off-by: Ben Davis <ben.davis@arm.com>
> > ---
> >  drivers/gpu/drm/drm_atomic_uapi.c |  8 ++++++++
> >  drivers/gpu/drm/drm_writeback.c   | 28 ++++++++++++++++++++++++++++
> >  include/drm/drm_connector.h       |  4 ++++
> >  include/drm/drm_mode_config.h     | 10 ++++++++++
> >  4 files changed, 50 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_at=
omic_uapi.c
> > index d520a04..1f68dce 100644
> > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > @@ -765,6 +765,10 @@ static int drm_atomic_connector_set_property(struc=
t drm_connector *connector,
> >  			return -EINVAL;
> >  		}
> >  		state->content_protection =3D val;
> > +	} else if (property =3D=3D config->prop_writeback_w) {
> > +		state->writeback_w =3D val;
> > +	} else if (property =3D=3D config->prop_writeback_h) {
> > +		state->writeback_h =3D val;
> >  	} else if (property =3D=3D config->writeback_fb_id_property) {
> >  		struct drm_framebuffer *fb =3D drm_framebuffer_lookup(dev, NULL, val=
);
> >  		int ret =3D drm_atomic_set_writeback_fb_for_connector(state, fb);
> > @@ -837,6 +841,10 @@ drm_atomic_connector_get_property(struct drm_conne=
ctor *connector,
> >  		*val =3D state->scaling_mode;
> >  	} else if (property =3D=3D connector->content_protection_property) {
> >  		*val =3D state->content_protection;
> > +	} else if (property =3D=3D config->prop_writeback_w) {
> > +		*val =3D state->writeback_w;
> > +	} else if (property =3D=3D config->prop_writeback_h) {
> > +		*val =3D state->writeback_h;
> >  	} else if (property =3D=3D config->writeback_fb_id_property) {
> >  		/* Writeback framebuffer is one-shot, write and forget */
> >  		*val =3D 0;
> > diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writ=
eback.c
> > index c20e6fe..be42073 100644
> > --- a/drivers/gpu/drm/drm_writeback.c
> > +++ b/drivers/gpu/drm/drm_writeback.c
> > @@ -74,6 +74,12 @@
> >   *	applications making use of writeback connectors *always* retrieve a=
n
> >   *	out-fence for the commit and use it appropriately.
> >   *	From userspace, this property will always read as zero.
> > + *
> > + *  "WRITEBACK_W":
> > + *	The width of the writeback buffer to write back.
> > + *
> > + *  "WRITEBACK_H":
> > + *	The height of the writeback buffer to write back.
>=20
> What happens when they are not set, and left to default 0?
>=20
> ~Maarten

Hi Maarten,

If they're not set they should be ignored and if writeback is enabled
it should not be scaled. However you probably shouldn't be able to set
them as 0, I can add a restriction on that.

Thanks, Ben
