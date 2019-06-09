Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF507C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 18:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8F420665
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 18:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NK5y+jYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbfFIStR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 14:49:17 -0400
Received: from mail-eopbgr800084.outbound.protection.outlook.com ([40.107.80.84]:19563
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729082AbfFIStR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 14:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skKOfJuohvJiRQK1q1GVO1UjuZcV+2PQZv2YVOpjbLA=;
 b=NK5y+jYj1hTAVbC0aeezBs+3i3Xk8jCo1JO4GYEEn+6gS9oIRWZTZndT9Fel6Dz5kmAzu8p7UcvYkAyXAPTGnH7rI46jMNtAMlWWSQyypVlIIdigpKyohRWn94euU9Wcoar55QTAyV5bPVbdumlDjOVgjcQg+rY4VsoUtwdxC0s=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.231.93) by
 CH2PR02MB6328.namprd02.prod.outlook.com (52.132.231.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Sun, 9 Jun 2019 18:48:32 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::b9dd:11e0:7fca:ba55]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::b9dd:11e0:7fca:ba55%5]) with mapi id 15.20.1965.017; Sun, 9 Jun 2019
 18:48:31 +0000
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
Subject: RE: [PATCH V5 02/11] misc: xilinx-sdfec: add core driver
Thread-Topic: [PATCH V5 02/11] misc: xilinx-sdfec: add core driver
Thread-Index: AQHVHlbrpEJ1Sg1DIU6G1r6HwZ+3LaaTLpiAgAB7DEA=
Date:   Sun, 9 Jun 2019 18:48:31 +0000
Message-ID: <CH2PR02MB6359778016A4BDCBD29EA275CB120@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <1560038656-380620-1-git-send-email-dragan.cvetic@xilinx.com>
 <1560038656-380620-3-git-send-email-dragan.cvetic@xilinx.com>
 <20190609112235.GA16574@kroah.com>
In-Reply-To: <20190609112235.GA16574@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c6acf9f-f461-46ac-3bc9-08d6ed0b11dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR02MB6328;
x-ms-traffictypediagnostic: CH2PR02MB6328:
x-microsoft-antispam-prvs: <CH2PR02MB6328BB35D73EEFBF7DBE93FDCB120@CH2PR02MB6328.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 006339698F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(136003)(366004)(39850400004)(396003)(346002)(199004)(189003)(13464003)(4326008)(8936002)(446003)(6246003)(478600001)(25786009)(8676002)(86362001)(52536014)(14454004)(7736002)(305945005)(81166006)(81156014)(107886003)(5660300002)(71200400001)(71190400001)(53936002)(33656002)(2906002)(9686003)(6116002)(476003)(486006)(3846002)(11346002)(66556008)(229853002)(66066001)(55016002)(64756008)(76116006)(76176011)(7696005)(6506007)(66476007)(68736007)(53546011)(6436002)(66946007)(66446008)(73956011)(316002)(54906003)(6916009)(99286004)(256004)(26005)(186003)(74316002)(14444005)(102836004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6328;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A/01PPhdJ8cPz4lanm+byAwNwhm/jJrbPqTg7l+IRYjPX6Bpiw/+i81X5umgG9I09q4rSluqEXwz68ghsI38fFSVKr+mqjxKWcqHBdboiWq22BHpuB+WPSVq4DcyW/ffYa4XMpv/eNZcdbxZ2M7/WT71f0gbcA4+lImtJyBE46l6X+Bpw2mITgV849+mbMG4PyxJ/col/1hKzWQmsf+NAyIbhQEd+UDLJERNufWdhj63S90P+Z6vUJeXTzHBXVhs+XkCwhoGotNOxrcCg5YYSzSM/MldkcSqzpV9AE71G65UjagZ0HpM7KK8uw17l+SRQLFFe70jaj9qQupdbftCollergfJyw5uLv9nh3l2Mq9SMSN0o+hsB3CYuDFP3jpIIew9eihBQvPWFK06tHUl5FmEX8JHhqpXkcEYSH1V1bY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6acf9f-f461-46ac-3bc9-08d6ed0b11dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2019 18:48:31.8039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: draganc@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Sunday 9 June 2019 12:23
> To: Dragan Cvetic <draganc@xilinx.com>
> Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@li=
sts.infradead.org; robh+dt@kernel.org;
> mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kerne=
l.org; Derek Kiernan <dkiernan@xilinx.com>
> Subject: Re: [PATCH V5 02/11] misc: xilinx-sdfec: add core driver
>=20
> On Sun, Jun 09, 2019 at 01:04:07AM +0100, Dragan Cvetic wrote:
> > Implement a platform driver that matches with xlnx,
> > sd-fec-1.1 device tree node and registers as a character
> > device, including:
> > - SD-FEC driver binds to sdfec DT node.
> > - creates and initialise an initial driver dev structure.
> > - add the driver in Linux build and Kconfig.
> >
> > Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> > Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
> > Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> > ---
> >  drivers/misc/Kconfig        |  12 +++++
> >  drivers/misc/Makefile       |   1 +
> >  drivers/misc/xilinx_sdfec.c | 118 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 131 insertions(+)
> >  create mode 100644 drivers/misc/xilinx_sdfec.c
> >
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 6b0417b..319a6bf 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -471,6 +471,18 @@ config PCI_ENDPOINT_TEST
> >             Enable this configuration option to enable the host side te=
st driver
> >             for PCI Endpoint.
> >
> > +config XILINX_SDFEC
> > +	tristate "Xilinx SDFEC 16"
> > +	help
> > +	  This option enables support for the Xilinx SDFEC (Soft Decision
> > +	  Forward Error Correction) driver. This enables a char driver
> > +	  for the SDFEC.
> > +
> > +	  You may select this driver if your design instantiates the
> > +	  SDFEC(16nm) hardened block. To compile this as a module choose M.
> > +
> > +	  If unsure, say N.
> > +
> >  config MISC_RTSX
> >  	tristate
> >  	default MISC_RTSX_PCI || MISC_RTSX_USB
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index b9affcd..0cb3546 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -59,3 +59,4 @@ obj-$(CONFIG_OCXL)		+=3D ocxl/
> >  obj-y				+=3D cardreader/
> >  obj-$(CONFIG_PVPANIC)   	+=3D pvpanic.o
> >  obj-$(CONFIG_HABANA_AI)		+=3D habanalabs/
> > +obj-$(CONFIG_XILINX_SDFEC)	+=3D xilinx_sdfec.o
> > diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> > new file mode 100644
> > index 0000000..75cc980
> > --- /dev/null
> > +++ b/drivers/misc/xilinx_sdfec.c
> > @@ -0,0 +1,118 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx SDFEC
> > + *
> > + * Copyright (C) 2019 Xilinx, Inc.
> > + *
> > + * Description:
> > + * This driver is developed for SDFEC16 (Soft Decision FEC 16nm)
> > + * IP. It exposes a char device which supports file operations
> > + * like  open(), close() and ioctl().
> > + */
> > +
> > +#include <linux/miscdevice.h>
> > +#include <linux/io.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/poll.h>
> > +#include <linux/slab.h>
> > +#include <linux/clk.h>
> > +
> > +static int xsdfec_ndevs;
>=20
> You should use an idr for this, not just a number you bump up and down.
> This will not work properly at all.
>=20
> Think about this situation:
> 	probe device 0
> 	xsdfec_ndevs =3D 1
> 	probe device 1
> 	xsdfec_ndevs =3D 2
> 	remove device 0
> 	xsdfec_ndevs =3D 0
> 	probe another device
> 	misc device fails due to duplicate name.
>

My bad.
I can use idr, but couldn't be better optimized code if use simple mutex to=
 protect the variable.

> thanks,
>=20
> greg k-h
