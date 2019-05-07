Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7091DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C8120C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 08:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cMAOQ3XS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfEGItY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 04:49:24 -0400
Received: from mail-eopbgr690060.outbound.protection.outlook.com ([40.107.69.60]:18915
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbfEGItY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 04:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jnm+5DPm82QOz4O3NbmD5dDeuBvD7b6i0dcmQbscHM=;
 b=cMAOQ3XSLutsXK02w2zxS21YnFVWBnsQxlHITSiyfYB+/cb7/SfiIWvqC9H3ZIIHm16NiCrWJZ59xbm42jQnQsi5gIxiulrgYt9i7smfpZJKAa87ZBcQL9S1U/X5RBl4KXt7b/RVQfFnVVOQvPmeq7ehPCR19eIpj6W4+KXiTg0=
Received: from BL0PR02MB5681.namprd02.prod.outlook.com (20.177.241.92) by
 BL0PR02MB4898.namprd02.prod.outlook.com (52.132.14.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Tue, 7 May 2019 08:48:41 +0000
Received: from BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::6cde:f726:b36e:752d]) by BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::6cde:f726:b36e:752d%5]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 08:48:41 +0000
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
Subject: RE: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
Thread-Topic: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
Thread-Index: AQHU/UVOyBvhwX5Hf0mi9G9IHzQgRKZYHAiAgAGBAECAAQXIAIADZtRggAAL5YCAATcywA==
Date:   Tue, 7 May 2019 08:48:41 +0000
Message-ID: <BL0PR02MB568169E26DCD12498EBDFC3ACB310@BL0PR02MB5681.namprd02.prod.outlook.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-3-git-send-email-dragan.cvetic@xilinx.com>
 <20190502172007.GA1874@kroah.com>
 <BL0PR02MB5681B0F2BC0D74D8604D4289CB350@BL0PR02MB5681.namprd02.prod.outlook.com>
 <20190504075502.GA11133@kroah.com>
 <BL0PR02MB56814D6EACC16938A0575D16CB300@BL0PR02MB5681.namprd02.prod.outlook.com>
 <20190506123425.GA26360@kroah.com>
In-Reply-To: <20190506123425.GA26360@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b1bdd10-0ce8-4b6a-226a-08d6d2c8ce24
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BL0PR02MB4898;
x-ms-traffictypediagnostic: BL0PR02MB4898:
x-microsoft-antispam-prvs: <BL0PR02MB4898157F4314057627F7FABFCB310@BL0PR02MB4898.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(346002)(366004)(396003)(136003)(376002)(13464003)(189003)(199004)(305945005)(55016002)(26005)(66946007)(66476007)(52536014)(73956011)(2906002)(316002)(7736002)(54906003)(64756008)(7696005)(4326008)(66556008)(33656002)(6116002)(68736007)(186003)(9686003)(14444005)(256004)(99286004)(6436002)(3846002)(5660300002)(81166006)(66446008)(66066001)(81156014)(8936002)(8676002)(6916009)(107886003)(76116006)(6246003)(14454004)(446003)(25786009)(74316002)(486006)(53936002)(76176011)(86362001)(11346002)(71200400001)(71190400001)(102836004)(476003)(229853002)(478600001)(53546011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4898;H:BL0PR02MB5681.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rCs73paD0sLPXdMctWKr9oYG76bXIrbpsm3a4CJUKfdJIz8V6twAJg8A3kQRIR3AXTN/et/RCG/ctlMiVILWLYNWcdJR+PGjbLK37U+qoveglkGPN7qQaBzGIpj6VY7WKpdCTnpoV/S/w+OEjetgKxJbGQUusF+9ldzqwV0RmYolgypG46iqgWx3Hxr7QGqqrMBUROsuuOdLIldtwAourAivp5sNUG2LLxofeXbUwgZQOJRdCQR5E0D4S6c2yeWuROWlAqXg+O8wAdk5E16AeoqtzudWm6hfldMZxNfW3Qgf0AAcDjOrECwST2+eXZ2Vhz9ZYsnvIiiTrWjuRs/qJ0tLwHpKsCuk/odRqeF7bbATYt1qIWHeoQN2thxI19GYXZN8evEmjRdO9Y8+3E0tjk6tclDd4JhfcCt4p+5oWvs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1bdd10-0ce8-4b6a-226a-08d6d2c8ce24
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 08:48:41.1791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Monday 6 May 2019 13:34
> To: Dragan Cvetic <draganc@xilinx.com>
> Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@li=
sts.infradead.org; robh+dt@kernel.org;
> mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kerne=
l.org; Derek Kiernan <dkiernan@xilinx.com>
> Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
>=20
> On Mon, May 06, 2019 at 12:23:56PM +0000, Dragan Cvetic wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > Sent: Saturday 4 May 2019 08:55
> > > To: Dragan Cvetic <draganc@xilinx.com>
> > > Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kerne=
l@lists.infradead.org; robh+dt@kernel.org;
> > > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.k=
ernel.org; Derek Kiernan <dkiernan@xilinx.com>
> > > Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
> > >
> > > On Fri, May 03, 2019 at 04:41:21PM +0000, Dragan Cvetic wrote:
> > > > Hi Greg,
> > > >
> > > > Please find my inline comments below,
> > > >
> > > > Regards
> > > > Dragan
> > > >
> > > > > -----Original Message-----
> > > > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > > > Sent: Thursday 2 May 2019 18:20
> > > > > To: Dragan Cvetic <draganc@xilinx.com>
> > > > > Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-k=
ernel@lists.infradead.org; robh+dt@kernel.org;
> > > > > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vg=
er.kernel.org; Derek Kiernan <dkiernan@xilinx.com>
> > > > > Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
> > > > >
> > > > > On Sat, Apr 27, 2019 at 11:04:56PM +0100, Dragan Cvetic wrote:
> > > > > > +#define DRIVER_NAME "xilinx_sdfec"
> > > > > > +#define DRIVER_VERSION "0.3"
> > > > >
> > > > > Version means nothing with the driver in the kernel tree, please =
remove
> > > > > it.
> > > >
> > > > Will be removed. Thank you.
> > > >
> > > > >
> > > > > > +#define DRIVER_MAX_DEV BIT(MINORBITS)
> > > > >
> > > > > Why this number?  Why limit yourself to any number?
> > > > >
> > > >
> > > > There can be max 8 devices for this driver. I'll change to 8.
> > > >
> > > > > > +
> > > > > > +static struct class *xsdfec_class;
> > > > >
> > > > > Do you really need your own class?
> > > >
> > > > When writing a character device driver, my goal is to create and re=
gister an instance
> > > > of that structure associated with a struct file_operations, exposin=
g a set of operations
> > > > to the user-space. One of the steps to make this goal is Create a c=
lass for a devices,
> > > > visible in /sys/class/.
> > >
> > > Why do you need a class?  Again, why not just use the misc_device api=
,
> > > that seems much more relevant here and will make the code a lot simpl=
er.
> > >
> >
> > The driver can have 8 devices in SoC plus more in Programming Logic.
> > It looked logical to group them under the same MAJOR, although they
> > are independent of each other.  Is this argument strong enough to use
> > class?
>=20
> Not really :)
>=20
> 8 devices is pretty small.  What tool will be trying to talk to all of
> these devices and how was it going to find out what devices were in the
> system?
>

These devices are Forward Error Correction encoder/decoder
and will be part of the RF communication chain. They will be included
in the system through DT. Also, described in DT.
  =20

> thanks,
>=20
> greg k-h
