Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCD2C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 02:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B693F2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 02:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="O1Y84+iZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfJKCIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 22:08:55 -0400
Received: from mail-eopbgr750137.outbound.protection.outlook.com ([40.107.75.137]:24902
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727369AbfJKCIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 22:08:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHouel33XLD/253E+RRq9qXmiBq5oCwak8C0jdNJiBLSN2F86rwmga1QDbsZZL3w5y8gJtzP2CvcN8VK966ehYsDzmT/fFwPxINnPb2OYdzY+A6CD/lNgsgp7a+M4sOb/8kCfeM3Gb7HsoHi4/LNHGv4vZaQuZ/Oou+hs3BulphReo6kVbV/J7OVH23VFnCJHA6/I39qA7SW2ZJT4pdH8whzJbE0eVBGnBTVmejMrIgFjnromSTswDMXFAIUx4XiWmuMOPdtDv3vNOl5YESAYzkJP7VKxdQMxhfPO9xLpanjjAIho3NKB4/h0f7O+Xv2J8b0LY+Y4wz+Y6JFsgO3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkWLf+lwpa3bNkDStcFz/F4MOFOX2bq/N3ayqRSYRPs=;
 b=B277/Oy/3iOig9doSJsrkR7EtZaTGYLRmBYl4F7xlevIvewAcI2yzn9ZXHaVqoBKxBDB80CiGHWFqD8FH0C768brWk2NQb4t/GyW7LcmYmN3kFoB+yPRoZfU4O5TfIrFyYPz4ktclpR8ZZBWmHdb7Ho/2QibliKF7rkbnStNCSW3Kow1ZUuPQQy1mfFWMuoQ6yK2cF2/7zzeZ2J/3SHbsn/11ZdAzvQGjGLQAB6NQQvTAhrvFv443/7FvkNUfFVhowljFAavF6tdc0oQHSof8K/E8aq4dIUTnDP2EWtwN9Mi4JgeNzYAq6bNJKiezCvKYlNA3Qsw8v+sugccJiLCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkWLf+lwpa3bNkDStcFz/F4MOFOX2bq/N3ayqRSYRPs=;
 b=O1Y84+iZXk9pFKFmzv0LBXXjaw5psV7qvRtUBi56UgRl1/U2WVsklDU6AMiFIVNssw5nwcMmXsb2WomUG43gAxldYUH4PMNjJblq9kM/4S/fgWzSLcvtx3dE3d1SZdYn5xckE4CLshNy6MqKvh/YpzU6KUUnAVWOUF8Vi46u7bU=
Received: from BL0PR04MB4532.namprd04.prod.outlook.com (10.167.181.144) by
 BL0PR04MB4516.namprd04.prod.outlook.com (10.167.172.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 02:08:51 +0000
Received: from BL0PR04MB4532.namprd04.prod.outlook.com
 ([fe80::c184:37a4:7e6e:aa42]) by BL0PR04MB4532.namprd04.prod.outlook.com
 ([fe80::c184:37a4:7e6e:aa42%7]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 02:08:51 +0000
From:   Xin Ji <xji@analogixsemi.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to
 DP bridge driver
Thread-Topic: [PATCH v2 2/2] drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to
 DP bridge driver
Thread-Index: AQHVf00oAsK7Lki4wU2Sq6LUBIfyh6dToneAgAAA2YCAAQ+sAA==
Date:   Fri, 11 Oct 2019 02:08:50 +0000
Message-ID: <20191011020838.GA24665@xin-VirtualBox>
References: <cover.1570699576.git.xji@analogixsemi.com>
 <43f48a7036e5a2991bd6bd8a7361107b27e48c54.1570699576.git.xji@analogixsemi.com>
 <20191010095315.GK13286@kadam> <20191010095617.GL13286@kadam>
In-Reply-To: <20191010095617.GL13286@kadam>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:203:2e::36) To BL0PR04MB4532.namprd04.prod.outlook.com
 (2603:10b6:208:4f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [114.247.245.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71e79915-43f9-455f-ef12-08d74deff547
x-ms-traffictypediagnostic: BL0PR04MB4516:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB451612E1E6A2646508F9E663C7970@BL0PR04MB4516.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(136003)(366004)(396003)(39850400004)(376002)(199004)(189003)(33716001)(33656002)(7736002)(14454004)(6116002)(71190400001)(478600001)(7416002)(6512007)(9686003)(305945005)(1076003)(4326008)(3846002)(256004)(71200400001)(8676002)(8936002)(54906003)(2906002)(316002)(81156014)(81166006)(6916009)(26005)(76176011)(6506007)(386003)(186003)(102836004)(66066001)(6486002)(25786009)(86362001)(486006)(52116002)(99286004)(476003)(6436002)(66446008)(66946007)(66556008)(66476007)(64756008)(229853002)(5660300002)(6246003)(107886003)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR04MB4516;H:BL0PR04MB4532.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: usKS3wylebWlSSkYQwC9iMZVGVwMnI012B776Vij0BVDqfOxn0a0FvRxSuJO8ImmKg9nZz7u0x71qaV062uqiVJNZBH4JDTd8LJR3q4U8C0zsPlYmFlJkz87G7lisXuxHgXcJLNk+alDnuhRS96MKnElCH09SXySr5GJ8SKIvd4VTjHUePB+uC/YElie1r0sWKXNEKInE3WQHY633U0uaY81+wm8HwCa+8MiWtkPYSrn45yKsW5RDJeoPD/65Jn2PBBm+Fik2D+obp+SeG1gFgWdJOIl6NS7bETWAa7hZRex3Tf3J53KzjcBmGumgdOoeWibMtp2wGiUtREFKlCPFFkW4v4s/Fl+qG5xvh7GGYvstMbVPxXyES3KvX8WEWOpRyvuJ2pUxCKXSSJXA27gj1fp9GZxK24+HfsCZ/zH+HU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <74774DB8CEF834469574AC2BF8907A4B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e79915-43f9-455f-ef12-08d74deff547
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 02:08:50.9675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZYKiGDEgQL4ZvGLttVYYMI25yzDrRuHuXYsq4+zpzheDHegNEpbpKN5eqw4uPG1uYAnMYOzaLB3lbokuf8hww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4516
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan Carpenter,

This is a bug, I'll fix it right now.

The coding is much nicer than before, thanks for your comments,
it is very helpful for me.

Thanks,
Xin


On Thu, Oct 10, 2019 at 12:56:17PM +0300, Dan Carpenter wrote:
> On Thu, Oct 10, 2019 at 12:53:15PM +0300, Dan Carpenter wrote:
> > This code is *so* much nicer than before.  I hope you feel good about
> > the changes.  It makes me happy to look at this code now.
> >=20
> > On Thu, Oct 10, 2019 at 09:34:19AM +0000, Xin Ji wrote:
> > > +static int edid_read(struct anx7625_data *ctx,
> > > +		     u8 offset, u8 *pblock_buf)
> > > +{
> > > +	int ret, cnt;
> > > +	struct device *dev =3D &ctx->client->dev;
> > > +
> > > +	for (cnt =3D 0; cnt < EDID_TRY_CNT; cnt++) {
>                                           ^^^^^
>=20
> > > +		sp_tx_aux_wr(ctx, offset);
> > > +		/* set I2C read com 0x01 mot =3D 0 and read 16 bytes */
> > > +		ret =3D sp_tx_aux_rd(ctx, 0xf1);
> > > +
> > > +		if (ret) {
> > > +			sp_tx_rst_aux(ctx);
> > > +			DRM_DEV_DEBUG_DRIVER(dev, "edid read failed, reset!\n");
> > > +			cnt++;
>                         ^^^^^
>=20
> I mean that it's incremented twice, yeah?
>=20
> regards,
> dan carpenter
