Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAAAC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DAE20872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LpcH017p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfFFSWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:22:14 -0400
Received: from mail-eopbgr810045.outbound.protection.outlook.com ([40.107.81.45]:38592
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727559AbfFFSWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sonYqcdLrVVZs4jxWz2LM04hL11uBXmDup0Q2BRmOQQ=;
 b=LpcH017pBJhBfHTppKchmLvpbJbhyDGDO9Q4PpexaMxtISqrRvdXMCaQVPw1Hrsa22KM4wYDoBfDBTJGa837FNP471u5pO7S5yAUTBQWorRsPJz8SU+EvlwViuqF9R7H7k+U97YAwXj34frhLpzVDBpbcTy5kq5wkLhUU1yw0qk=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.231.93) by
 CH2PR02MB6021.namprd02.prod.outlook.com (10.255.156.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 18:22:08 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::b9dd:11e0:7fca:ba55]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::b9dd:11e0:7fca:ba55%5]) with mapi id 15.20.1943.018; Thu, 6 Jun 2019
 18:22:07 +0000
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
Thread-Index: AQHVEu5GErREaULonk+tvtDvF1CkjaaOsacAgABQ8tA=
Date:   Thu, 6 Jun 2019 18:22:07 +0000
Message-ID: <CH2PR02MB63591C650DB8C7E15D9D3CCDCB170@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <1558784245-108751-1-git-send-email-dragan.cvetic@xilinx.com>
 <1558784245-108751-5-git-send-email-dragan.cvetic@xilinx.com>
 <20190606132842.GC7943@kroah.com>
In-Reply-To: <20190606132842.GC7943@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b334be30-de8b-4607-eec9-08d6eaabe27c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR02MB6021;
x-ms-traffictypediagnostic: CH2PR02MB6021:
x-microsoft-antispam-prvs: <CH2PR02MB60210AAA2FE44B9F6F38A457CB170@CH2PR02MB6021.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(13464003)(199004)(99286004)(26005)(52536014)(6116002)(3846002)(6436002)(66066001)(74316002)(4326008)(7696005)(14454004)(5660300002)(9686003)(55016002)(25786009)(2906002)(76176011)(478600001)(229853002)(53546011)(6506007)(102836004)(107886003)(8936002)(7736002)(6916009)(76116006)(73956011)(66946007)(486006)(14444005)(446003)(33656002)(256004)(81156014)(71190400001)(316002)(53936002)(71200400001)(66446008)(68736007)(54906003)(476003)(86362001)(6246003)(81166006)(8676002)(66556008)(186003)(305945005)(11346002)(64756008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6021;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5MzkTd5FzxfzGWuPlrUp6S3DdKpeFq+Um9/YzIEaYsyB8dE22WKTbbpqyocHyEFQ0sH4kHTlGuQnSA/H+9PymvLd/gHPaeEr2TtpwFaQdb5f+gcIpPviltAdVqNYYYigYQG3RNKDay2xXFj+Oh5XGIOE8fglIcgz7lLCBSbz0/oeluhCjyfa1jHUjLrSVQk46T77jvwVccFUrX0ibm6rRhM3/bvKxpApPd/6PoLyToc0IM38yHhRiuhTvUqQDviav2duH5nK29fIk5RTa/pdsGFNcMU+yJ+YcAWK+2JVzf3vX+32H88vr6IFg8dL/8n0oVItNY2Qp1MM6t3nVCQRBhAI+Aoa0KKaPa5j1JHyoHcq3EOzeBDVC0b+gUoEidS0w02wc1iog6zxAl7ba6zZotFuWr8CU0k9jYe9zbxuJ5I=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b334be30-de8b-4607-eec9-08d6eaabe27c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 18:22:07.7990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: draganc@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday 6 June 2019 14:29
> To: Dragan Cvetic <draganc@xilinx.com>
> Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@li=
sts.infradead.org; robh+dt@kernel.org;
> mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kerne=
l.org; Derek Kiernan <dkiernan@xilinx.com>
> Subject: Re: [PATCH V4 04/12] misc: xilinx_sdfec: Add open, close and ioc=
tl
>=20
> On Sat, May 25, 2019 at 12:37:17PM +0100, Dragan Cvetic wrote:
> > +static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int xsdfec_dev_release(struct inode *iptr, struct file *fptr)
> > +{
> > +	return 0;
> > +}
>=20
> empty open/close functions are never needed, just drop them.

Accepted.
Will remove them.

>=20
> > +
> > +static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
> > +			     unsigned long data)
> > +{
> > +	struct xsdfec_dev *xsdfec;
> > +	void __user *arg =3D NULL;
> > +	int rval =3D -EINVAL;
> > +
> > +	xsdfec =3D container_of(fptr->private_data, struct xsdfec_dev, miscde=
v);
> > +	if (!xsdfec)
> > +		return rval;
>=20
> It is impossible for container_of() to return NULL, unless something
> very magical and rare just happened.  It's just doing pointer math, you
> can never check the return value of it.

Accepted.
Will remove if statement.

>=20
> > +
> > +	if (_IOC_TYPE(cmd) !=3D XSDFEC_MAGIC)
> > +		return -ENOTTY;
>=20
> How can this happen?

Accepted.
Will be removed.

>=20
> > +
> > +	/* check if ioctl argument is present and valid */
> > +	if (_IOC_DIR(cmd) !=3D _IOC_NONE) {
> > +		arg =3D (void __user *)data;
> > +		if (!arg)
> > +			return rval;
> > +	}
> > +
> > +	switch (cmd) {
> > +	default:
> > +		/* Should not get here */
> > +		dev_warn(xsdfec->dev, "Undefined SDFEC IOCTL");
>=20
> Nice that userspace has a way to fill up the kernel log :(
>=20
> Just return the correct error here, don't log it.

Accepted.
Will remove log.

>=20
> thanks,
>=20
> greg k-h
