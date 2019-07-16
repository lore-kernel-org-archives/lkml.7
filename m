Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD82C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B335F21721
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZCLmPdS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbfGPIgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 04:36:13 -0400
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:46506
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727042AbfGPIgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:36:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiJbUWXTYk5R04nFDM2D0x/DRZYBgXcgZ0lLPtfu6NokheEga6jMsQ6JRfhm7yZTje6DWcy0JaPJmgCMtEbEKtDq/Si6ytJtwkNJSjRGa4Yn8mwD7NfMc96zxG9DgHBYEXjJXo+CJwIwyDf/2F7oU4QtifsGz+iMrAXRKK/zidk8MQF+GAXjF8YAMj8O984nF3bekSeJMZ8fY1McLdm7+qYELjAWLwqlhIPBFFgYyylqfT1BSNbeG4eTW47a8uLjLizl+T39uuCy6HYfEOvdQSdXm3spnJdtAfpKqaqMQb4gUPTh9cBo/EhzAeMeCGex257RLXqM3XkzfsGpEXReGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w83cFNKV+uozj3pi29g89oBPXrMbtsS5du5297YNKy8=;
 b=cCKkfnb85vDNFN5cMX0/P0FjbRpIkC94pMkIZIhWeYz7iFJamdIJkKvOqpJsoLsXZaxGWdpYm+6TO2RqiUAtB21n8tIU4UcZOxErskcYpJGa3JBHYEkOKGtUyIUEZ3O9BRCW7uauArlRUZYP8rjcmOUHiJOpXyDNpoanC0uClqwLh2THdO7DhZX6TGrDSZ49hDsxWo5senxl1PTUDZS+v/jsH1yF0qiPJA5LNU0niM8qQTByeDXFNo5TfdecFM8e1M/00QNk4ZIFn3tiL9sI2nlWgn3wR0p0kT57gDu+lzLNzUENQ+vbFeNbdSVUObBQ1Ta/8dPJCLf8BpixERlb0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w83cFNKV+uozj3pi29g89oBPXrMbtsS5du5297YNKy8=;
 b=ZCLmPdS+FeTD0CcqkvP3jGi9DVmRqfgFdtuAPMaWrX6GBhoYlxlnhlMMcO0X6Y4xADq7jVpZ+1lVCen0tLaq/nt77nzQXK//16SVxPYsGf6+7nfp6hMzLqdhjSirFZZ10/25OXZsVhtCP5MNkvy67TGvIpsvfbgMhAbna8Gpw5s=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.175.24.138) by
 VI1PR0402MB3824.eurprd04.prod.outlook.com (52.134.16.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 16 Jul 2019 08:36:09 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::a186:c119:606e:bdc4]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::a186:c119:606e:bdc4%4]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 08:36:09 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Subject: RE: [PATCH v2 5/6] staging: fsl-dpaa2/ethsw: Add switch driver
 documentation
Thread-Topic: [PATCH v2 5/6] staging: fsl-dpaa2/ethsw: Add switch driver
 documentation
Thread-Index: AQHVMz3BTGBjH61q0EuXmPZPH88RYabMIiqAgADaFWA=
Date:   Tue, 16 Jul 2019 08:36:08 +0000
Message-ID: <VI1PR0402MB28008341F0B606DFEBE03713E0CE0@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1562336836-17119-1-git-send-email-ioana.ciornei@nxp.com>
 <1562336836-17119-6-git-send-email-ioana.ciornei@nxp.com>
 <20190715193431.GA15581@kroah.com>
In-Reply-To: <20190715193431.GA15581@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99350ce0-6691-4a6a-00ec-08d709c8a6b4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3824;
x-ms-traffictypediagnostic: VI1PR0402MB3824:
x-microsoft-antispam-prvs: <VI1PR0402MB3824329824E2B9C658C5D6FDE0CE0@VI1PR0402MB3824.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(44832011)(186003)(102836004)(68736007)(256004)(81166006)(446003)(11346002)(476003)(81156014)(26005)(486006)(6116002)(3846002)(6916009)(74316002)(305945005)(7736002)(8936002)(2906002)(33656002)(86362001)(66066001)(71190400001)(14454004)(8676002)(478600001)(99286004)(9686003)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(55016002)(316002)(25786009)(54906003)(229853002)(52536014)(71200400001)(4326008)(7696005)(76176011)(6506007)(53936002)(5660300002)(6436002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3824;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5YmS2b5EJl7p+obrDD7dNcN0fbEgiUhq4sai57/uRL+aSgUmfYDdL93LR619gdTvWocd73VXW58PWcJX8MsSdAsKawl4r3q3gEcMH7pdBcWvbn+kFawDDMbHLSLyoZ/hUiEqGundYNKDhEt2hVik8UdIT+eJdjRa2AOziL89Atq8ZV0nH0J5Cn13iZZE1FCHF01Wmyv87I1eiM5bo4TU3YzQlr8kZonrWMAyQKAzeJJslKLlGcsyrW6LY/TF+gRTo+VDVYCg17b/xwukv9KcaNSsTFojGR23aMxLg0PYo+3pBltCtjPUGxU7tSgx3orQ/vGi66j6NlREK0BYtqxSjekeFmY6R1w6CPBIyeoXGHuDkZDm1fJiZ0THtYEYex7r93cSJHt99TTAWjStcCIufWi5fB/qDKAkbgG4j6sJ8Lw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99350ce0-6691-4a6a-00ec-08d709c8a6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 08:36:08.9406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ioana.ciornei@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v2 5/6] staging: fsl-dpaa2/ethsw: Add switch driver
> documentation
>=20
> On Fri, Jul 05, 2019 at 05:27:15PM +0300, Ioana Ciornei wrote:
> > From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
> >
> > Add a switch driver entry in the dpaa2 overview documentation.
> >
> > Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> > Changes in v2:
> >  - none
> >
> >  .../networking/device_drivers/freescale/dpaa2/overview.rst          | =
6 ++++++
> >  MAINTAINERS                                                         | =
1 +
> >  2 files changed, 7 insertions(+)
> >
> > diff --git
> > a/Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
> > b/Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
> > index d638b5a8aadd..7b7f35908890 100644
> > ---
> > a/Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
> > +++ b/Documentation/networking/device_drivers/freescale/dpaa2/overview
> > +++ .rst
> > @@ -393,6 +393,12 @@ interfaces needed to connect the DPAA2 network
> > interface to  the network stack.
> >  Each DPNI corresponds to a Linux network interface.
> >
> > +Ethernet L2 Switch driver
> > +-------------------------
> > +The Ethernet L2 Switch driver is bound to a DPSW and makes use of the
> > +switchdev support in kernel.
> > +Each switch port has a corresponding Linux network interface.
> > +
> >  MAC driver
> >  ----------
> >  An Ethernet PHY is an off-chip, board specific component and is
> > managed diff --git a/MAINTAINERS b/MAINTAINERS index
> > c0a02dccc869..5c51be8e281c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4938,6 +4938,7 @@ M:	Ioana Ciornei <ioana.ciornei@nxp.com>
> >  L:	linux-kernel@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/staging/fsl-dpaa2/ethsw
> > +F:
> 	Documentation/networking/device_drivers/freescale/dpaa2/overview.r
> st
> >
> >  DPAA2 PTP CLOCK DRIVER
> >  M:	Yangbo Lu <yangbo.lu@nxp.com>
> > --
> > 1.9.1
> >
>=20
> This patch did not apply :(

Sorry for this. I'll take this chance to also add more information and send=
 it properly.

--
Ioana
