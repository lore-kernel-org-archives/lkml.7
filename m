Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E377C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DACB208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bPZhVJUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbfFFSSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:18:21 -0400
Received: from mail-eopbgr800041.outbound.protection.outlook.com ([40.107.80.41]:32559
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727559AbfFFSSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxU+Y6sPuN5ogKfRaNb78JHNEqdY2yNol8PMQilUZ14=;
 b=bPZhVJUG/zrBM3M8YVuHN1tMxKiP+kXYjIt/QMOALaFthu+E+73q9ajBb3VxD2wfu1OUTp/sjxsUhXX/fQz1NL+qVkKEu+lSEEYh1AmQVrGTuEFbcaUsU1uZNWL3m1QoJvzL88HxwmyKoHSDk8q3DpUUiJx9Gcdi/4l8y0EiGEI=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.231.93) by
 CH2PR02MB6183.namprd02.prod.outlook.com (52.132.229.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Thu, 6 Jun 2019 18:18:17 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::b9dd:11e0:7fca:ba55]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::b9dd:11e0:7fca:ba55%5]) with mapi id 15.20.1943.018; Thu, 6 Jun 2019
 18:18:17 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: RE: [PATCH V4 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Thread-Topic: [PATCH V4 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Thread-Index: AQHVEu5GErREaULonk+tvtDvF1CkjaaOsQmAgABRNPA=
Date:   Thu, 6 Jun 2019 18:18:16 +0000
Message-ID: <CH2PR02MB6359A547C69E6E674CB3C7D0CB170@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <1558784245-108751-1-git-send-email-dragan.cvetic@xilinx.com>
 <1558784245-108751-5-git-send-email-dragan.cvetic@xilinx.com>
 <20190606132629.GB7943@kroah.com>
In-Reply-To: <20190606132629.GB7943@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b49cb14e-6617-4b87-0658-08d6eaab5903
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR02MB6183;
x-ms-traffictypediagnostic: CH2PR02MB6183:
x-microsoft-antispam-prvs: <CH2PR02MB618315AE620C37C67A8751ECCB170@CH2PR02MB6183.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(13464003)(199004)(66476007)(66556008)(6116002)(64756008)(74316002)(3846002)(66946007)(68736007)(186003)(66066001)(73956011)(478600001)(8936002)(6246003)(76176011)(81156014)(52536014)(66446008)(7696005)(53546011)(76116006)(102836004)(25786009)(6506007)(81166006)(99286004)(4326008)(26005)(5660300002)(107886003)(8676002)(53936002)(316002)(11346002)(55016002)(9686003)(6916009)(71200400001)(2906002)(71190400001)(14454004)(86362001)(14444005)(256004)(486006)(33656002)(54906003)(305945005)(476003)(7736002)(446003)(6436002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6183;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /vNvoFU03VmoX8tDDivfb70QZK4OxiLYRcGcu2G+3dO0ql3+WPCx3cUveF2y50f2XBYdlJ3uDTdquOvY1I69L/edDjIWxs1vEryzBe21mIRA9azg69kouxdFf/WBIGsZSFd7/HkefeoTh7RRYgApnZ2/sNsP6JWS3FM1ingjsGMB1xPhsVNA5VtgSRjJr68YyCittKIyBXsj4Awu6FM0u3YVknuXIQPXieOtG5hwdsQXs9W6g9CByC1S+iR4fSnYpINvkFOqbneP6m0iBuC9PlfqhH4LiIYM5Y6GMWldWmpo0uHz2Gn8aP9uLcDibqMjiRg/1Egwbr/1s9yn2ae5NoVheME85C/BBw9tuZBH5EFsVdVXbL6MMgqSJGQRFPPgABEloLHP3dn91FAiF5Id8wEFhb2PsMx9/3B8mkRucKc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49cb14e-6617-4b87-0658-08d6eaab5903
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 18:18:17.1392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: draganc@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday 6 June 2019 14:26
> To: Dragan Cvetic <draganc@xilinx.com>
> Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@li=
sts.infradead.org; robh+dt@kernel.org;
> mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kerne=
l.org; Derek Kiernan <dkiernan@xilinx.com>
> Subject: Re: [PATCH V4 04/12] misc: xilinx_sdfec: Add open, close and ioc=
tl
>=20
> On Sat, May 25, 2019 at 12:37:17PM +0100, Dragan Cvetic wrote:
> > Add char device interface per DT node present and support
> > file operations:
> > - open(),
> > - close(),
> > - unlocked_ioctl(),
> > - compat_ioctl().
> >
> > Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> > Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
> > Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> > ---
> >  drivers/misc/xilinx_sdfec.c      | 57 ++++++++++++++++++++++++++++++++=
+++++---
> >  include/uapi/misc/xilinx_sdfec.h |  4 +++
> >  2 files changed, 58 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> > index ff32d29..740b487 100644
> > --- a/drivers/misc/xilinx_sdfec.c
> > +++ b/drivers/misc/xilinx_sdfec.c
> > @@ -51,7 +51,6 @@ struct xsdfec_clks {
> >   * @regs: device physical base address
> >   * @dev: pointer to device struct
> >   * @config: Configuration of the SDFEC device
> > - * @open_count: Count of char device being opened
>=20
> Why is this removed here?  You don't add something in one patch and then
> remove it in a later one if it's never needed :)

Accepted.
Will be removed from previous patches.

>=20
> thanks,
>=20
> greg k-h
