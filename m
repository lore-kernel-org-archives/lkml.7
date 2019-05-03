Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2654EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10B52075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4oGpEXFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfECQl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:41:26 -0400
Received: from mail-eopbgr730048.outbound.protection.outlook.com ([40.107.73.48]:59104
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726719AbfECQl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FFXXP1GaK1ON9h27xOe8RrwNYt8sjfSvo1Mwn/29ME=;
 b=4oGpEXFef2G8MaR36iL4WPPuM3Q3AudgFfsfCkfL7cx+rP8Pm02AKAtwJg4EWvWDExv3K1/ZXNiHLdGSmG4FHImR215EgQvd2tRRnduPdP6vo4VdI1XFBvC+CExJ07mq+CQplTb2XTH5Kjs9tniNXAsW1FS47XKN8ixbZdb+xIQ=
Received: from BL0PR02MB5681.namprd02.prod.outlook.com (20.177.241.92) by
 BL0PR02MB3764.namprd02.prod.outlook.com (52.132.8.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Fri, 3 May 2019 16:41:22 +0000
Received: from BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::6cde:f726:b36e:752d]) by BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::6cde:f726:b36e:752d%5]) with mapi id 15.20.1856.012; Fri, 3 May 2019
 16:41:22 +0000
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
Thread-Index: AQHU/UVOyBvhwX5Hf0mi9G9IHzQgRKZYHAiAgAGBAEA=
Date:   Fri, 3 May 2019 16:41:21 +0000
Message-ID: <BL0PR02MB5681B0F2BC0D74D8604D4289CB350@BL0PR02MB5681.namprd02.prod.outlook.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-3-git-send-email-dragan.cvetic@xilinx.com>
 <20190502172007.GA1874@kroah.com>
In-Reply-To: <20190502172007.GA1874@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20ecc15a-232a-480b-d330-08d6cfe62cc5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BL0PR02MB3764;
x-ms-traffictypediagnostic: BL0PR02MB3764:
x-microsoft-antispam-prvs: <BL0PR02MB376404865825B146C29A02E5CB350@BL0PR02MB3764.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(366004)(346002)(199004)(189003)(13464003)(54906003)(107886003)(4326008)(25786009)(66556008)(66446008)(316002)(7736002)(52536014)(76116006)(73956011)(6246003)(66946007)(186003)(6436002)(9686003)(71200400001)(71190400001)(26005)(3846002)(6116002)(55016002)(53936002)(14454004)(68736007)(478600001)(14444005)(256004)(229853002)(5660300002)(11346002)(2906002)(305945005)(66476007)(86362001)(6506007)(53546011)(64756008)(446003)(486006)(99286004)(74316002)(102836004)(6916009)(8936002)(8676002)(476003)(33656002)(7696005)(76176011)(81166006)(81156014)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3764;H:BL0PR02MB5681.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V4esCaVumuYM+hZPb1IuVRCBY7Ao+W9KKk+9xuXJnw4KnbNgaBYLF3IzdthqP0VOTgjtaY0LKQsxZihVasBlbn3oOSVhnXUVAY1rlZONgskikrlhgMdr5cucfJ042g0T/8rGSfFLCFgv7bl163T7gpMArgAP23YILwCjc6WuOUYGATXXfUdRXK9xZuZu3tZ1jSAqwmvcOowxXk62LJfyW0pWXfn7whihitZgYkhMrCah/OJ9GcjVz6qQ991w4JsfDISW2K/30dd03k/Q9kwkum37M/sd2xuY7vXmoGoWUYOXBjt8HQqNz7ezGu6jQlIY4EAWyJNYM1l+MpGeb77QXFhhhfV6JCpQA1tKMRCfy/KqsM5Dow3JLZTPuG6FM/jgnAm7fcNUYgL1DDubjXVrfbQ3w1427ffKestg055HitU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ecc15a-232a-480b-d330-08d6cfe62cc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 16:41:21.8774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3764
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find my inline comments below,

Regards
Dragan

> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday 2 May 2019 18:20
> To: Dragan Cvetic <draganc@xilinx.com>
> Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@li=
sts.infradead.org; robh+dt@kernel.org;
> mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kerne=
l.org; Derek Kiernan <dkiernan@xilinx.com>
> Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
>=20
> On Sat, Apr 27, 2019 at 11:04:56PM +0100, Dragan Cvetic wrote:
> > +#define DRIVER_NAME "xilinx_sdfec"
> > +#define DRIVER_VERSION "0.3"
>=20
> Version means nothing with the driver in the kernel tree, please remove
> it.

Will be removed. Thank you.

>=20
> > +#define DRIVER_MAX_DEV BIT(MINORBITS)
>=20
> Why this number?  Why limit yourself to any number?
>=20

There can be max 8 devices for this driver. I'll change to 8.

> > +
> > +static struct class *xsdfec_class;
>=20
> Do you really need your own class?

When writing a character device driver, my goal is to create and register a=
n instance
of that structure associated with a struct file_operations, exposing a set =
of operations
to the user-space. One of the steps to make this goal is Create a class for=
 a devices,
visible in /sys/class/.

>=20
> > +static atomic_t xsdfec_ndevs =3D ATOMIC_INIT(0);
>=20
> Why?

At the end this become a minor number.=20
It is not needed, will be removed. Thanks.

>=20
> > +static dev_t xsdfec_devt;
>=20
> Why?
>=20
> Why not use misc_device for this?  Why do you need your own major with a
> bunch of minor devices reserved ahead of time?  Why not just create a
> new misc device for every individual device that happens to be found in
> the system?  That will make the code a lot simpler and smaller and
> easier.
>
>=20
>=20
> > +
> > +/**
> > + * struct xsdfec_dev - Driver data for SDFEC
> > + * @regs: device physical base address
> > + * @dev: pointer to device struct
> > + * @config: Configuration of the SDFEC device
> > + * @open_count: Count of char device being opened
> > + * @xsdfec_cdev: Character device handle
> > + * @irq_lock: Driver spinlock
> > + *
> > + * This structure contains necessary state for SDFEC driver to operate
> > + */
> > +struct xsdfec_dev {
> > +	void __iomem *regs;
> > +	struct device *dev;
> > +	struct xsdfec_config config;
> > +	atomic_t open_count;
> > +	struct cdev xsdfec_cdev;
> > +	/* Spinlock to protect state_updated and stats_updated */
> > +	spinlock_t irq_lock;
> > +};
> > +
> > +static const struct file_operations xsdfec_fops =3D {
> > +	.owner =3D THIS_MODULE,
> > +};
>=20
> No operations at all?  That's an easy driver :)


The operations are implemented in the later patches.


>=20
> thanks,
>=20
> greg k-h
