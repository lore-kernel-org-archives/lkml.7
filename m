Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A93C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C2E214AE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QlrQv8w5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfFHTlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 15:41:02 -0400
Received: from mail-eopbgr680084.outbound.protection.outlook.com ([40.107.68.84]:33670
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727215AbfFHTlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 15:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dduBsOtI3AySDNvyRkfFyB0uZnLrh6bMbc/SM/4UcEI=;
 b=QlrQv8w57SOibc3keKogeSe5IO2EBQvtvaJwSr0qNX6P2ahX46KcfKsseui39wYwJfPG2haCk+wEJm0Xp1IAT4FmCSV7jeRGX67itUn3N/S5lmcOqjUJocq7fX3KUtf4SYfALukLW4sXcBPx2k93vqlZYW9w2LaYbiR3GJihjwQ=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.231.93) by
 CH2PR02MB6231.namprd02.prod.outlook.com (52.132.230.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Sat, 8 Jun 2019 19:40:58 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::b9dd:11e0:7fca:ba55]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::b9dd:11e0:7fca:ba55%5]) with mapi id 15.20.1965.017; Sat, 8 Jun 2019
 19:40:57 +0000
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
Thread-Index: AQHVEu5GErREaULonk+tvtDvF1CkjaaOsacAgAFm4tCAAFUHgIABzWHQ
Date:   Sat, 8 Jun 2019 19:40:57 +0000
Message-ID: <CH2PR02MB6359406779BEEC45AAB41A98CB110@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <1558784245-108751-1-git-send-email-dragan.cvetic@xilinx.com>
 <1558784245-108751-5-git-send-email-dragan.cvetic@xilinx.com>
 <20190606132842.GC7943@kroah.com>
 <CH2PR02MB6359747C72220A978CCA807BCB100@CH2PR02MB6359.namprd02.prod.outlook.com>
 <20190607155731.GB8752@kroah.com>
In-Reply-To: <20190607155731.GB8752@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e2369b1-4268-41a8-fa02-08d6ec493a9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR02MB6231;
x-ms-traffictypediagnostic: CH2PR02MB6231:
x-microsoft-antispam-prvs: <CH2PR02MB62315EC2FB84405614DEA5DFCB110@CH2PR02MB6231.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:350;
x-forefront-prvs: 0062BDD52C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(396003)(376002)(39850400004)(199004)(189003)(13464003)(33656002)(52536014)(81156014)(68736007)(229853002)(14454004)(8936002)(81166006)(99286004)(478600001)(7736002)(8676002)(74316002)(73956011)(66556008)(76116006)(64756008)(66946007)(2906002)(66446008)(66476007)(305945005)(55016002)(53936002)(66066001)(6916009)(6436002)(4326008)(6506007)(53546011)(14444005)(256004)(9686003)(476003)(76176011)(186003)(486006)(102836004)(54906003)(7696005)(6116002)(71190400001)(86362001)(26005)(71200400001)(3846002)(5660300002)(6246003)(25786009)(316002)(107886003)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6231;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mDd9gNhw6PgbDZhHoPAel8CyA8tgln6Sku2zPy0/5jbT8SgMZKeblZHYRqC2NL+4+gbMifS+hJyugXyA3mX1CVMa1wodqgjLeACMwWEMm49ODrvuJH+clyUwYFh4lICS8MB7y2t32mt4RH4Rw5Zra0RrZ10DTHpsR/BBQShVTGyRrjl70jO6Zr7Od2gzkhoS5tA+TDOushlaRp58rdm/iqiDXsZ3ui48i+oplmfraLD9bDMfKaz6obDHXTlSyLUyKBry/w+T97w0HHApD+INqiapEnog590xXkNxq4zG+ALmQtv4M9BMxRi2Gf6SMiMIJAv6NU04bWvuP01EFUWAjlP0y8W/DRr3R3pOJrB5gCTJ1D+AsD7lRj8UnPUQIW1zLibBDZ4T155Tw+sdgPFKsYhvkntnnxgqmOny1BlnQzE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2369b1-4268-41a8-fa02-08d6ec493a9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2019 19:40:57.4671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: draganc@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Friday 7 June 2019 16:58
> To: Dragan Cvetic <draganc@xilinx.com>
> Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@li=
sts.infradead.org; robh+dt@kernel.org;
> mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kerne=
l.org; Derek Kiernan <dkiernan@xilinx.com>
> Subject: Re: [PATCH V4 04/12] misc: xilinx_sdfec: Add open, close and ioc=
tl
>=20
> On Fri, Jun 07, 2019 at 10:58:34AM +0000, Dragan Cvetic wrote:
> > > On Sat, May 25, 2019 at 12:37:17PM +0100, Dragan Cvetic wrote:
> > > > +static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int xsdfec_dev_release(struct inode *iptr, struct file *fpt=
r)
> > > > +{
> > > > +	return 0;
> > > > +}
> > >
> > > empty open/close functions are never needed, just drop them.
> > >
> >
> > open() is needed to allocate file descriptor eg.
> > fd =3D open(dev_name, O_RDWR);
>=20
> But you do nothing in those open/release callbacks.  Remove them and see
> that the code works just fine :)
>=20

Accepted.
I will squash this commit with the first next which needs open/close, iocta=
l.

> thanks,
>=20
> greg k-h

Thanks
Dragan

