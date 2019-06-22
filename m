Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF8EC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FA520665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hmrKop4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfFVRyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 13:54:09 -0400
Received: from mail-eopbgr770055.outbound.protection.outlook.com ([40.107.77.55]:60159
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbfFVRyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 13:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYzbyHoAuBmjV95TFYTDwtofOHutYXa+ylQ7C5vfp0E=;
 b=hmrKop4CF+Pn0uVGeYdG3xoGwiuRjwkeKhfVMqZBUhPtVZ1jUDSfQGYZEZftsPK7e5rOUpXorwuCeOgZDHq9h5t0GPTN1vEfrIK1hX3TV/cwIbkIBUTBvR4kj53ipG3U98o5t3XsB+E7mmtcvCItdrSTr8RIgxgRQLUj0xkz0jo=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.231.93) by
 CH2PR02MB6055.namprd02.prod.outlook.com (10.255.156.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Sat, 22 Jun 2019 17:54:04 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::b9dd:11e0:7fca:ba55]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::b9dd:11e0:7fca:ba55%5]) with mapi id 15.20.2008.014; Sat, 22 Jun 2019
 17:54:04 +0000
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
Subject: RE: [PATCH V7 00/11] misc: xilinx sd-fec drive
Thread-Topic: [PATCH V7 00/11] misc: xilinx sd-fec drive
Thread-Index: AQHVIHtLLdGbOE767U2XbDHU36aibaamNrSAgAA5XPCAAM7egIAAuPAA
Date:   Sat, 22 Jun 2019 17:54:04 +0000
Message-ID: <CH2PR02MB6359A32E03E920AE5EEB7324CBE60@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <1560274185-264438-1-git-send-email-dragan.cvetic@xilinx.com>
 <20190621141553.GA16650@kroah.com>
 <CH2PR02MB635999D7374378CEA096FE72CBE70@CH2PR02MB6359.namprd02.prod.outlook.com>
 <20190622060135.GB26200@kroah.com>
In-Reply-To: <20190622060135.GB26200@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c60bf531-5d8b-4bc6-4493-08d6f73a9dbc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CH2PR02MB6055;
x-ms-traffictypediagnostic: CH2PR02MB6055:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CH2PR02MB6055133DBC84AA7C5F1EDFD7CBE60@CH2PR02MB6055.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0076F48C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(366004)(396003)(346002)(13464003)(189003)(199004)(86362001)(486006)(66946007)(73956011)(66066001)(256004)(14444005)(66476007)(66556008)(64756008)(66446008)(33656002)(476003)(71200400001)(53546011)(11346002)(52536014)(71190400001)(966005)(53936002)(8676002)(102836004)(6306002)(9686003)(316002)(229853002)(99286004)(81156014)(81166006)(8936002)(54906003)(7696005)(446003)(6506007)(76176011)(14454004)(305945005)(186003)(26005)(55016002)(7736002)(478600001)(25786009)(6436002)(4326008)(6246003)(107886003)(2906002)(3846002)(6116002)(74316002)(5660300002)(76116006)(68736007)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6055;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O5g8DQHuPOnDN4jEYSxiM1V71kzm0L/kAj2AAP5FPH9V9Gcd8h2APrC8J/LeKXpfVEUFK2Dmcr//0i4rlGMGhQWWX4jopRDwttB1+ughbIygC4NHjTmOd3oC9cl/V4Qvn7dIC3D9r4/lli2Y+g11ya4g8xToq2xmf2utLt/FcJ30v9HwxKpVceWFX3U5nUfvptFrVmiqrbx4/KYH3zX6K82ArFyFAdkoeNtTAUbDbAdSPTG4th/FrSqFzorWY9neWmkDsH0aN0C2e4kv/vf5XL293bWO+b0td0n0SEmWtVPyFmyacwBOIg8n1RzmEAzcEL63htBFayWwP8S5x5hiZJIkNVUGBmhzWPoKTSpjWUqIkc74nnDmemJcXnMz72FXmPb8ZPgfGm8N6fbc4yaeEm9o3QGL0rWe5v4zCYQT5Bg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60bf531-5d8b-4bc6-4493-08d6f73a9dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2019 17:54:04.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: draganc@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Saturday 22 June 2019 07:02
> To: Dragan Cvetic <draganc@xilinx.com>
> Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@li=
sts.infradead.org; robh+dt@kernel.org;
> mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kerne=
l.org; Derek Kiernan <dkiernan@xilinx.com>
> Subject: Re: [PATCH V7 00/11] misc: xilinx sd-fec drive
>=20
> On Fri, Jun 21, 2019 at 05:49:45PM +0000, Dragan Cvetic wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > Sent: Friday 21 June 2019 15:16
> > > To: Dragan Cvetic <draganc@xilinx.com>
> > > Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kerne=
l@lists.infradead.org; robh+dt@kernel.org;
> > > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.k=
ernel.org; Derek Kiernan <dkiernan@xilinx.com>
> > > Subject: Re: [PATCH V7 00/11] misc: xilinx sd-fec drive
> > >
> > > On Tue, Jun 11, 2019 at 06:29:34PM +0100, Dragan Cvetic wrote:
> > > > This patchset is adding the full Soft Decision Forward Error
> > > > Correction (SD-FEC) driver implementation, driver DT binding and
> > > > driver documentation.
> > > >
> > > > Forward Error Correction (FEC) codes such as Low Density Parity
> > > > Check (LDPC) and turbo codes provide a means to control errors in
> > > > data transmissions over unreliable or noisy communication
> > > > channels. The SD-FEC Integrated Block is an optimized block for
> > > > soft-decision decoding of these codes. Fixed turbo codes are
> > > > supported directly, whereas custom and standardized LDPC codes
> > > > are supported through the ability to specify the parity check
> > > > matrix through an AXI4-Lite bus or using the optional programmable
> > > > (PL)-based support logic. For the further information see
> > > > https://www.xilinx.com/support/documentation/ip_documentation/
> > > > sd_fec/v1_1/pg256-sdfec-integrated-block.pdf
> > > >
> > > > This driver is a platform device driver which supports SDFEC16
> > > > (16nm) IP. SD-FEC driver supports LDPC decoding and encoding and
> > > > Turbo code decoding. LDPC codes can be specified on
> > > > a codeword-by-codeword basis, also a custom LDPC code can be used.
> > > >
> > > > The SD-FEC driver exposes a char device interface and supports
> > > > file operations: open(), close(), poll() and ioctl(). The driver
> > > > allows only one usage of the device, open() limits the number of
> > > > driver instances. The driver also utilize Common Clock Framework
> > > > (CCF).
> > > >
> > > > The control and monitoring is supported over ioctl system call.
> > > > The features supported by ioctl():
> > > > - enable or disable data pipes to/from device
> > > > - configure the FEC algorithm parameters
> > > > - set the order of data
> > > > - provide a control of a SDFEC bypass option
> > > > - activates/deactivates SD-FEC
> > > > - collect and provide statistical data
> > > > - enable/disable interrupt mode
> > >
> > > Is there any userspace tool that talks to this device using these cus=
tom
> > > ioctls yet?
> > >
> > Tools no, but could be the customer who is using the driver.
>=20
> I don't understand this.  Who has written code to talk to these
> special ioctls from userspace?  Is there a pointer to that code
> anywhere?
>=20

The code which use this driver are written by the driver maintainers they a=
re examples APP and test code which are not public.


> > > Doing a one-off ioctl api is always a risky thing, you are pretty muc=
h
> > > just creating brand new system calls for one piece of hardware.
> > >
> >
> > Why is that wrong and what is the risk?
>=20
> You now have custom syscalls for one specfic piece of hardware that you
> now have to maintain working properly for the next 40+ years.  You have
> to make sure those calls are correct and that this is the correct api to
> talk to this hardware.

This is very specific HW, it's high speed Forward Error Correction HW.
I'll be happy if I maintain this for the next 40+ years.

Actually, forgive me asking, what architecture would make me not maintain t=
his driver next 40+ years?
=20

>=20
> > What would you propose?
> > Definitely, I have to read about this.
>=20
> What is this hardware and what is it used for?  Who will be talking to

The Soft-Decision Forward Error Correction (SD-FEC) integrated block suppor=
ts Low Density Parity Check (LDPC) decoding and encoding and Turbo code dec=
oding.
SD-FEC use case is in high data rate applications such as 4G, 5G and DOCSIS=
3.1 Cable Access.
A high performance SD-FEC (i.e. >1Gbps), is a block used to enable these sy=
stems to function under non-ideal environments.

> it from userspace?  What userspace workload uses it?  What tools need to

There will be APP which configures the HW for the use cases listed above.

Thanks

Dragan

> talk to it?  Where is the code that uses these new apis?
>=20
> thanks,
>=20
> greg k-h
