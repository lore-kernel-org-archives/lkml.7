Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC6DC04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32395205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="U54jBjVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfEGNQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:16:07 -0400
Received: from mail-eopbgr790078.outbound.protection.outlook.com ([40.107.79.78]:44902
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726321AbfEGNQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh91UyZ5CG3oKqllnpLHPUVnPM/iwog42gkqfmdoJAY=;
 b=U54jBjVDOwo5ETdeOJyp91vnOe16hy09MOrUsqoocSMHvZwyCwfCGH5vhfKOK6Rde/i81Vq2GvIZKeTkVztuUS6k3fYEODYHOT67TbDQK2+KE9ajsNynG66+TGp2jppuoUKyYdlblnSuW5HBMO+DYEimaojg2PR4B0sWxs68auY=
Received: from BL0PR02MB5681.namprd02.prod.outlook.com (20.177.241.92) by
 BL0PR02MB4449.namprd02.prod.outlook.com (10.167.179.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.15; Tue, 7 May 2019 13:15:58 +0000
Received: from BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::6cde:f726:b36e:752d]) by BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::6cde:f726:b36e:752d%5]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 13:15:58 +0000
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
Thread-Index: AQHU/UVOyBvhwX5Hf0mi9G9IHzQgRKZYHAiAgAGBAECAAQXIAIADZtRggAAL5YCAATcywIAAKlGAgAAWmLCAABaBAIAABssg
Date:   Tue, 7 May 2019 13:15:58 +0000
Message-ID: <BL0PR02MB5681A7C4F93F33F1C1E05114CB310@BL0PR02MB5681.namprd02.prod.outlook.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-3-git-send-email-dragan.cvetic@xilinx.com>
 <20190502172007.GA1874@kroah.com>
 <BL0PR02MB5681B0F2BC0D74D8604D4289CB350@BL0PR02MB5681.namprd02.prod.outlook.com>
 <20190504075502.GA11133@kroah.com>
 <BL0PR02MB56814D6EACC16938A0575D16CB300@BL0PR02MB5681.namprd02.prod.outlook.com>
 <20190506123425.GA26360@kroah.com>
 <BL0PR02MB568169E26DCD12498EBDFC3ACB310@BL0PR02MB5681.namprd02.prod.outlook.com>
 <20190507093941.GC20355@kroah.com>
 <BL0PR02MB568148AD27F3FE86D168BDF9CB310@BL0PR02MB5681.namprd02.prod.outlook.com>
 <20190507122106.GA7873@kroah.com>
In-Reply-To: <20190507122106.GA7873@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a44ea838-bc48-48ab-8bc9-08d6d2ee24fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BL0PR02MB4449;
x-ms-traffictypediagnostic: BL0PR02MB4449:
x-microsoft-antispam-prvs: <BL0PR02MB4449368B670A883EFF8B7E4DCB310@BL0PR02MB4449.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(13464003)(189003)(199004)(68736007)(6916009)(81156014)(8676002)(8936002)(6246003)(6436002)(486006)(52536014)(229853002)(86362001)(76116006)(305945005)(7736002)(14444005)(256004)(74316002)(476003)(446003)(55016002)(73956011)(66946007)(11346002)(66476007)(66556008)(64756008)(66446008)(66066001)(316002)(26005)(53546011)(25786009)(6506007)(5660300002)(186003)(81166006)(33656002)(4326008)(102836004)(71200400001)(71190400001)(107886003)(9686003)(53936002)(3846002)(2906002)(54906003)(76176011)(14454004)(99286004)(7696005)(478600001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:BL0PR02MB5681.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WvjX/UzY63sYA97KvWt0dRXKA4FeKYLw2bwV6ZfUOGbbqe1qMdGY2pd3x0CLIsqi8foN9xeFviaAhEqHr0l6HHNbUmmaeLjr7sCPjlSXTjKLToOoqjzQIUu8xpKSyZepucheydDin44l1/svNCJfCH1R6xpCVmOPqgbR3k/+6ytp5+bR4LP4jMXHVi4NDoH3Qdy500WYaP7bUkX6r9wm0s9VON76d3kvta4ViDuUYVo+0KjCnXARsyM8Hevkg41K1Qs4xVRk83GKHCREvgTs8oBTacq4RdAmnEYOoXnTqs5pHTWX0FBdDHC8jySDurnaGzB9vdELBZ2laIHwhTZDaniVP8RG13mHM16mCAeV/v38nK1KoUFrDvpSsLy+IyoYtUfgsp0o5L9nh9NQ65cnBe5etZ3nI6L8VOM3qI4rkbs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44ea838-bc48-48ab-8bc9-08d6d2ee24fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 13:15:58.1684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Tuesday 7 May 2019 13:21
> To: Dragan Cvetic <draganc@xilinx.com>
> Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@li=
sts.infradead.org; robh+dt@kernel.org;
> mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kerne=
l.org; Derek Kiernan <dkiernan@xilinx.com>
> Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
>=20
> On Tue, May 07, 2019 at 11:55:42AM +0000, Dragan Cvetic wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > Sent: Tuesday 7 May 2019 10:40
> > > To: Dragan Cvetic <draganc@xilinx.com>
> > > Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kerne=
l@lists.infradead.org; robh+dt@kernel.org;
> > > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.k=
ernel.org; Derek Kiernan <dkiernan@xilinx.com>
> > > Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
> > >
> > > On Tue, May 07, 2019 at 08:48:41AM +0000, Dragan Cvetic wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > > > Sent: Monday 6 May 2019 13:34
> > > > > To: Dragan Cvetic <draganc@xilinx.com>
> > > > > Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-k=
ernel@lists.infradead.org; robh+dt@kernel.org;
> > > > > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vg=
er.kernel.org; Derek Kiernan <dkiernan@xilinx.com>
> > > > > Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
> > > > >
> > > > > On Mon, May 06, 2019 at 12:23:56PM +0000, Dragan Cvetic wrote:
> > > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > > > > > Sent: Saturday 4 May 2019 08:55
> > > > > > > To: Dragan Cvetic <draganc@xilinx.com>
> > > > > > > Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-a=
rm-kernel@lists.infradead.org; robh+dt@kernel.org;
> > > > > > > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kerne=
l@vger.kernel.org; Derek Kiernan <dkiernan@xilinx.com>
> > > > > > > Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core dr=
iver
> > > > > > >
> > > > > > > On Fri, May 03, 2019 at 04:41:21PM +0000, Dragan Cvetic wrote=
:
> > > > > > > > Hi Greg,
> > > > > > > >
> > > > > > > > Please find my inline comments below,
> > > > > > > >
> > > > > > > > Regards
> > > > > > > > Dragan
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > > > > > > > Sent: Thursday 2 May 2019 18:20
> > > > > > > > > To: Dragan Cvetic <draganc@xilinx.com>
> > > > > > > > > Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; lin=
ux-arm-kernel@lists.infradead.org; robh+dt@kernel.org;
> > > > > > > > > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-k=
ernel@vger.kernel.org; Derek Kiernan
> <dkiernan@xilinx.com>
> > > > > > > > > Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add cor=
e driver
> > > > > > > > >
> > > > > > > > > On Sat, Apr 27, 2019 at 11:04:56PM +0100, Dragan Cvetic w=
rote:
> > > > > > > > > > +#define DRIVER_NAME "xilinx_sdfec"
> > > > > > > > > > +#define DRIVER_VERSION "0.3"
> > > > > > > > >
> > > > > > > > > Version means nothing with the driver in the kernel tree,=
 please remove
> > > > > > > > > it.
> > > > > > > >
> > > > > > > > Will be removed. Thank you.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > +#define DRIVER_MAX_DEV BIT(MINORBITS)
> > > > > > > > >
> > > > > > > > > Why this number?  Why limit yourself to any number?
> > > > > > > > >
> > > > > > > >
> > > > > > > > There can be max 8 devices for this driver. I'll change to =
8.
> > > > > > > >
> > > > > > > > > > +
> > > > > > > > > > +static struct class *xsdfec_class;
> > > > > > > > >
> > > > > > > > > Do you really need your own class?
> > > > > > > >
> > > > > > > > When writing a character device driver, my goal is to creat=
e and register an instance
> > > > > > > > of that structure associated with a struct file_operations,=
 exposing a set of operations
> > > > > > > > to the user-space. One of the steps to make this goal is Cr=
eate a class for a devices,
> > > > > > > > visible in /sys/class/.
> > > > > > >
> > > > > > > Why do you need a class?  Again, why not just use the misc_de=
vice api,
> > > > > > > that seems much more relevant here and will make the code a l=
ot simpler.
> > > > > > >
> > > > > >
> > > > > > The driver can have 8 devices in SoC plus more in Programming L=
ogic.
> > > > > > It looked logical to group them under the same MAJOR, although =
they
> > > > > > are independent of each other.  Is this argument strong enough =
to use
> > > > > > class?
> > > > >
> > > > > Not really :)
> > > > >
> > > > > 8 devices is pretty small.  What tool will be trying to talk to a=
ll of
> > > > > these devices and how was it going to find out what devices were =
in the
> > > > > system?
> > > > >
> > > >
> > > > These devices are Forward Error Correction encoder/decoder
> > > > and will be part of the RF communication chain. They will be includ=
ed
> > > > in the system through DT. Also, described in DT.
> > >
> > > Userspace doesn't mess with DT.
> > >
> > > I am asking what userspace tool/program is going to be interacting wi=
th
> > > these devices through your now-custom api you are creating.  Do you h=
ave
> > > a link to that software, and how is that code doing the "determine wh=
at
> > > device nodes are associated with what devices" logic?
> > >
> >
> > Example code is not public yet, sorry.
>=20
> Ok, then I think we need to wait for that to get this merged at the
> minimum, don't you agree?  Otherwise how do we even know that any of
> these codepaths are tested?
>=20
> > The index number in the device name
> > is a link to device, see snippet from the example code:
> >
> > #define FEC_DEC  "/dev/xsdfec0"
> > dec_fd =3D open_xsdfec(FEC_DEC);
> >
> > The index number corresponds to the device order in DT.
>=20
> So that implies you don't need a class at all, right?
>=20

Greg, you won:(
Thanks for patience, I appreciate it very much.
Dragan

> thanks,
>=20
> greg k-h
