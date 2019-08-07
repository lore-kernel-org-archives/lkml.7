Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ECCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B1D22297
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZO4Uohw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbfHGRG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:06:28 -0400
Received: from mail-eopbgr140088.outbound.protection.outlook.com ([40.107.14.88]:7041
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729278AbfHGRG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:06:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+4RWqS9mWQuYvxoKFrA8TwRtuaMNbIqdlzDENJyiykRsHSlWH2Z9EpOF7qxyCDW2kdANhAiwLlpOmVnX6S5ANdIwbMeKV5RQ/G5MkZzUFrjkavVpF1pTP4Qu36ZGurpy31pvICfDg4meUezibi3Hc0nN8S1KSX4nKZI8rqK5WuHhbVjB8Iwn7GXY0dhYdaTHk2WAeanTS5453Y4ukUvMM5ub89YWMgWf9ByJ6gPXcncJXJsAU5uUuZsYNzyue0gJI1G3/xLkuxiQCa3167y1UIMmFYPxfhmw/q5qYIUDit9uLOBgXd+HdTe14bxmPYF5l9JAcUNq6XuJkyhTUzBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXgom3m4usbskkXUBX4HQzilg0P2eehK84yCaDE9nHg=;
 b=MuECgnTNj61UdBvbejGDeufRc1XU012VqVjxvP54Vkb7QtVNz3OkX+no+aYjxE7RAtmZkui+d9xpp0fKo7/MR+WPZxvRc69vPNR2qxWSkO8CFvCQSkBFGQbeTdlTblgxL72YasyL8Qq8vfsFtMnzKigTuk+hJr7WcfdrtzEXZAWjQdcGPETNLjjPPpucVBdf3Fc+XYMQURSUIlf3k46krqAbB3abkKiyTfqT5QMuQibCnchADXwo5dy+SWIqpsTCGAIokUVXha9oeIDS2MD7HEhB+XMIvfxcK40PTKYUC4Tvzw3JChsavNCLTktsFq6EkyzrAwHM8H2qtma3m8TWSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXgom3m4usbskkXUBX4HQzilg0P2eehK84yCaDE9nHg=;
 b=ZO4Uohw+YqIxJAbreLNtk5Bf02nHXO8/ScodvSMyZXjihi1p0/ABCNZNZmNSk/EM6x+90cgArtxO4BYsX0fU/ZZPcFz/VgHIT29rc7xP/OrZVSj4VCMWdAUWT5tEjy8ckqvcLsi/5iCBe+QM7nmF3DaMDvrs+VZLMJa3VwU7/to=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3774.eurprd04.prod.outlook.com (52.134.15.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Wed, 7 Aug 2019 17:05:44 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 17:05:44 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Thread-Topic: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Thread-Index: AQHVTUJZuWgkceiY7EG3+fZ0PXp0Og==
Date:   Wed, 7 Aug 2019 17:05:43 +0000
Message-ID: <VI1PR0402MB2863C28FAB5DA6356280432BDFD40@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190805153114.GA16836@kroah.com>
 <HE1PR0402MB28579034C09EB49A76A4F8E7DFD50@HE1PR0402MB2857.eurprd04.prod.outlook.com>
 <20190806184042.GA26041@kroah.com>
 <VI1PR0402MB2863C4406C06B0BDA3581822DFD40@VI1PR0402MB2863.eurprd04.prod.outlook.com>
 <20190807165646.GA6584@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c91bf569-509d-400c-82ed-08d71b597bde
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3774;
x-ms-traffictypediagnostic: VI1PR0402MB3774:
x-microsoft-antispam-prvs: <VI1PR0402MB3774540372699E7CBE161B28DFD40@VI1PR0402MB3774.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(199004)(189003)(51744003)(71200400001)(66556008)(66946007)(64756008)(446003)(102836004)(53546011)(66476007)(6506007)(229853002)(186003)(66446008)(6916009)(5640700003)(53936002)(68736007)(2501003)(55016002)(4326008)(99286004)(71190400001)(3846002)(86362001)(74316002)(6116002)(66066001)(1730700003)(8676002)(8936002)(76116006)(9686003)(25786009)(91956017)(7736002)(7416002)(476003)(5660300002)(7696005)(478600001)(316002)(76176011)(26005)(6246003)(54906003)(81166006)(52536014)(2906002)(305945005)(33656002)(6436002)(14454004)(81156014)(2351001)(486006)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3774;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CZi9f2mPsDSmKGfJ1WOPqmo3/Yf5Pk4oWs0Zcr1+djpEJdn2QHUSOPHqSQTp/5Em33c7RJe2zW+564r8lxy+8LN2qkFXi1sJ1/OCDG4mFYFVSoyH/dIaFnQqF/a3tyL/kJvuQf6+1Tx6sp/YMSW5qze7W3fsP9J3MohHwwHOgzUGQqIfRZ4akY5SgM9rMU6HSHPo8z8q3Igi6VAFWYc54scfGVcR8FTrGmN4lNDhMaWn9TktMXE+OBIZgDr3ehCInQJDExn3MDoIZalRL51DH8w92c4iRFw97dH28829MGw+oKrOaghVjxx5Mc+IWf7o6/ti69dJGUx+0Di3IIR6UQrapRfDqUcE5XIrn9VHfs/rhjy5uAWzYf+5urNY7OyUMFS0McvOZrDDik54OyQNrn1kJdSOzYz5Ry5xXD4gMAg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91bf569-509d-400c-82ed-08d71b597bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 17:05:43.8454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EqXslEB28TsGX4osT9gFlsJoBtjvEcCRemOuKUHSQ9QXrBzCt6xmpvC+RTXp/5G19p09hUCJWM6cYT0+fNt0HwV6xRx0B3wLp3uJc8ilLK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/2019 7:56 PM, gregkh@linuxfoundation.org wrote:=0A=
> On Wed, Aug 07, 2019 at 04:42:17PM +0000, Stefan-gabriel Mirea wrote:=0A=
>> On 8/6/2019 9:40 PM, gregkh@linuxfoundation.org wrote:=0A=
>>> On Tue, Aug 06, 2019 at 05:11:17PM +0000, Stefan-gabriel Mirea wrote:=
=0A=
=0A=
<snip>=0A=
=0A=
>>>> Other than that, I do not see anything wrong with the addition of a=0A=
>>>> define in serial_core.h for this purpose (which is also what most of t=
he=0A=
>>>> serial drivers do, including amba-pl011.c, mentioned in=0A=
>>>> Documentation/driver-api/serial/driver.rst as providing the reference=
=0A=
>>>> implementation), so please be more specific.=0A=
>>>=0A=
>>> I am getting tired of dealing with merge issues with that list, and no=
=0A=
>>> one seems to be able to find where they are really needed for userspace=
,=0A=
>>> especially for new devices.  What happens if you do not have use it?=0A=
>>=0A=
>> I see. If I drop its usage completely and leave 'type' from the=0A=
>> uart_port as 0, uart_port_startup() will fail when finding that=0A=
>> uport->type =3D=3D PORT_UNKNOWN at [1] (there may be other effects as we=
ll,=0A=
>> e.g. due to the check in uart_configure_port[2]).=0A=
>>=0A=
>> So I suppose that I need to define some nonzero 'PORT_KNOWN' macro in=0A=
>> the driver and use that one internally for 'type'. Is my understanding=
=0A=
>> correct? Will there be any problems if I define it to a positive integer=
=0A=
>> which is already assigned to another driver, according to serial_core.h?=
=0A=
> =0A=
> Ugh, ok, that's messy, nevermind.  Keep the #define in there, I will try=
=0A=
> to figure out how to move all of these at once sometime in the future...=
=0A=
> =0A=
> sorry for the noise.=0A=
=0A=
No problem, thank you for your time.=0A=
=0A=
Regards,=0A=
Stefan=0A=
