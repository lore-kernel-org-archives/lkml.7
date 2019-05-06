Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FED2C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0773E20675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TCfO0CD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfEFMYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:24:00 -0400
Received: from mail-eopbgr780079.outbound.protection.outlook.com ([40.107.78.79]:54621
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725827AbfEFMX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X0+P5Sm5WOvr4dReZrS3AWGzBErsCauRkQSEH/ITCw=;
 b=TCfO0CD3ahliVPvjlIo22BUxL0DqZgBqS7q6fSOhHIQz+2lVWNdDoseoKsdC5TshbulNdc6HpIKAx5hS1EQXnDQDOw7NpdoMMtotnQ8br7XZGh6M3GuVW9U6dyofzmksVrMYPNa/t48Voi/osSvVXhuzD4JLCWY+JDXs5c5AdCM=
Received: from BL0PR02MB5681.namprd02.prod.outlook.com (20.177.241.92) by
 BL0PR02MB3843.namprd02.prod.outlook.com (52.132.9.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Mon, 6 May 2019 12:23:56 +0000
Received: from BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::6cde:f726:b36e:752d]) by BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::6cde:f726:b36e:752d%5]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 12:23:56 +0000
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
Thread-Index: AQHU/UVOyBvhwX5Hf0mi9G9IHzQgRKZYHAiAgAGBAECAAQXIAIADZtRg
Date:   Mon, 6 May 2019 12:23:56 +0000
Message-ID: <BL0PR02MB56814D6EACC16938A0575D16CB300@BL0PR02MB5681.namprd02.prod.outlook.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-3-git-send-email-dragan.cvetic@xilinx.com>
 <20190502172007.GA1874@kroah.com>
 <BL0PR02MB5681B0F2BC0D74D8604D4289CB350@BL0PR02MB5681.namprd02.prod.outlook.com>
 <20190504075502.GA11133@kroah.com>
In-Reply-To: <20190504075502.GA11133@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2849d9ec-7af0-46d7-d4b2-08d6d21db5cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BL0PR02MB3843;
x-ms-traffictypediagnostic: BL0PR02MB3843:
x-microsoft-antispam-prvs: <BL0PR02MB3843E236856AF89C9C8621A7CB300@BL0PR02MB3843.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(396003)(39860400002)(199004)(189003)(13464003)(478600001)(6246003)(54906003)(52536014)(3846002)(476003)(486006)(14454004)(2906002)(81156014)(81166006)(66446008)(4326008)(316002)(186003)(305945005)(7736002)(107886003)(6116002)(53936002)(8676002)(446003)(11346002)(74316002)(26005)(86362001)(76116006)(68736007)(99286004)(9686003)(66066001)(66556008)(6436002)(53546011)(256004)(66946007)(73956011)(64756008)(66476007)(229853002)(102836004)(14444005)(71190400001)(5660300002)(71200400001)(8936002)(25786009)(33656002)(6916009)(6506007)(76176011)(7696005)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3843;H:BL0PR02MB5681.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mmy24UGHwddgcDOPqMLT1uzi8N0o23Pxe2cgRIxSDsjubSRmpZ/qpNNdEYbPzZOWqPv1zAEq/OkpnDMx9r8w7f3Nnf21y1aLCd3leQ4qGYS79q+RHBgrsmaIG+Jw4HwKeiXF2hfiTTpPy5e6twBQSLLQx4q6Z27ePNzMyK8iSffW/LYtqKLm+V+T0km2MZf9X/8cRxGB+8epynkz+oqxjCma6uspjDjowEWnHJP+LrhW/vD6lwW9YAhUMUagvcI+82Ztc7B1mIWJ6wPqQbBu6AO9LX8ISWzAMmIrEdhsdBXenrt6wEA+GaxsTUldBz64oJQrSIjvH18Hv6/yVC//FQLAOqbqN5BqfgAZyOZ4VrCKjbT7Hpod0PfHMG0rifBE2qp+F/7ZalruEu20fwEPR0oERrLC3KRAFlRIViPE4dE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2849d9ec-7af0-46d7-d4b2-08d6d21db5cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 12:23:56.4363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3843
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Saturday 4 May 2019 08:55
> To: Dragan Cvetic <draganc@xilinx.com>
> Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@li=
sts.infradead.org; robh+dt@kernel.org;
> mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kerne=
l.org; Derek Kiernan <dkiernan@xilinx.com>
> Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
>=20
> On Fri, May 03, 2019 at 04:41:21PM +0000, Dragan Cvetic wrote:
> > Hi Greg,
> >
> > Please find my inline comments below,
> >
> > Regards
> > Dragan
> >
> > > -----Original Message-----
> > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > Sent: Thursday 2 May 2019 18:20
> > > To: Dragan Cvetic <draganc@xilinx.com>
> > > Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kerne=
l@lists.infradead.org; robh+dt@kernel.org;
> > > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.k=
ernel.org; Derek Kiernan <dkiernan@xilinx.com>
> > > Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
> > >
> > > On Sat, Apr 27, 2019 at 11:04:56PM +0100, Dragan Cvetic wrote:
> > > > +#define DRIVER_NAME "xilinx_sdfec"
> > > > +#define DRIVER_VERSION "0.3"
> > >
> > > Version means nothing with the driver in the kernel tree, please remo=
ve
> > > it.
> >
> > Will be removed. Thank you.
> >
> > >
> > > > +#define DRIVER_MAX_DEV BIT(MINORBITS)
> > >
> > > Why this number?  Why limit yourself to any number?
> > >
> >
> > There can be max 8 devices for this driver. I'll change to 8.
> >
> > > > +
> > > > +static struct class *xsdfec_class;
> > >
> > > Do you really need your own class?
> >
> > When writing a character device driver, my goal is to create and regist=
er an instance
> > of that structure associated with a struct file_operations, exposing a =
set of operations
> > to the user-space. One of the steps to make this goal is Create a class=
 for a devices,
> > visible in /sys/class/.
>=20
> Why do you need a class?  Again, why not just use the misc_device api,
> that seems much more relevant here and will make the code a lot simpler.
>=20

The driver can have 8 devices in SoC plus more in Programming Logic. It loo=
ked logical to group them under the same MAJOR, although they are independe=
nt of each other.
Is this argument strong enough to use class?

> thanks,
>=20
> greg k-h
