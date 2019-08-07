Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C32C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEE32229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sfzje78j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388552AbfHGQmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:42:35 -0400
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:6812
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729944AbfHGQme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:42:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfAljpL4mDeHv1c01nX+b263TsuhBnaCPk6bau3xOig870qeMTo8G6tIQxcgRonMcKdSnOBpYWF5yQF4+a73QAV9TTpsAfjdHZzb1yQQTcJKdtbszpLPMytIojmNkU7nYHA19v4QFV8FvpbKVtgV9+UW8T3woBysHKfWSKZjWyr76XRU8twIJgvY/NNUKBkuZim19IdmpsjaArfxQdLaYHWTRdvfVp2OItGXTCbOlcI6YjUfkuPnA+1MGpumDj3gUm5miDBASF2YcoZffY3V9jmWW4T5QxZKF5mPNp/C1FjIQEDADzszVq0xuYt0UHFV3FGL/lbiiP3g6xT4Hqd7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jJTcLgr82saZwMm28KzgPFSz4hKbfPLg6K4ApOKkpc=;
 b=amdC7UKWon0p0k3wQNfde3iaieSHJyUOGKdl6dXr+EBXoaVIyxfPRPaHEIh+Or2SI6TrL178L/jYzpE5BOfvbtGJ5vMTOn6Tm8oZ941lLadTyHi0av8yiHHkRv6id7XK4nnVgTw7bdqk9IeDGcgEXGBuNaa1LL7xn4IYSgAh1653fdXZfqxSGrjpoh222hsYqbbMNpI5jyatA/GmiUjCFQpvX9+xAHEbx6L/s8tDzZV5UZ42EkPiMVVwKOc3btrXYn7IllL8zeLZF4LaD3prXPPBGL5+yiTPKkfWcCmnjm/Hv4CTzR2aCHmJ3vB3qDQXNOj4h5MImlYFO+PKLjSHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jJTcLgr82saZwMm28KzgPFSz4hKbfPLg6K4ApOKkpc=;
 b=sfzje78jJjGyjs1WyPTn1B8FUohKh6C4m3hPMkH6NmMoL+cUpcz2wMqSkH0rX7MHiCxdHmBuSw+gG1ZLlL0SkdN5M17L+gw9Cywp7ALuwBFPU6LRnc+XvsxJGjKKbhYkzzRbV/3hc/laYOxgip2ivfznWqJsJqAPp+lkzsdwYaE=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3360.eurprd04.prod.outlook.com (52.134.1.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Wed, 7 Aug 2019 16:42:17 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 16:42:17 +0000
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
Thread-Index: AQHVTT8SPpHUwU0eqkG6Gc3hvK3zpw==
Date:   Wed, 7 Aug 2019 16:42:17 +0000
Message-ID: <VI1PR0402MB2863C4406C06B0BDA3581822DFD40@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190805153114.GA16836@kroah.com>
 <HE1PR0402MB28579034C09EB49A76A4F8E7DFD50@HE1PR0402MB2857.eurprd04.prod.outlook.com>
 <20190806184042.GA26041@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8145bb2a-2585-4321-0549-08d71b563581
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3360;
x-ms-traffictypediagnostic: VI1PR0402MB3360:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR0402MB33602720EF1857360F9CB3CADFD40@VI1PR0402MB3360.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(199004)(189003)(8936002)(66476007)(66556008)(64756008)(81166006)(66446008)(81156014)(86362001)(305945005)(2351001)(14454004)(5660300002)(25786009)(446003)(4326008)(26005)(229853002)(8676002)(1730700003)(6916009)(476003)(66946007)(486006)(53936002)(74316002)(186003)(99286004)(316002)(33656002)(76116006)(55016002)(256004)(66066001)(6116002)(6246003)(6506007)(53546011)(54906003)(6306002)(3846002)(7696005)(52536014)(6436002)(2501003)(7416002)(966005)(7736002)(478600001)(68736007)(9686003)(71190400001)(5640700003)(91956017)(102836004)(14444005)(2906002)(76176011)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3360;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h1B8WoIjgsnF79fvyEQ1n4NmqEch+dB3lEqkI2xGzlxWPQPNupewKqV+Xhp5WcSP2v118qP4R9e/LuQmomJQ3HOmXFWHnNkemlBiRJePKVBmnTcQR5S2g8DVrop5+6/o7UKCTA/imi9JATIqhB5LC2xnNHTkjHulZu6QeLGvUtOGw3+eaAIF3yBJvjf8nJsnCuwj/wogAU4MV6LPbnWM9X2jrM+PoOknNleyuUXk5ucJJGtzhviGwJsRjGOLPu6JqZXNfakls0ahaHd4NjJ6Af/T9/M9OWg3MAsxymFhYZoXYKdcaDiISsiNTddERv1IDoHRfjDtxmY6pnl1jRqELVWZeCz22tl4EGN4b8JFqCXAoLzX9ttJ4RQvAfuZPmAs35UTySdJUgGM3q1KSA5rRnL9W3vC4krbNMF5mcZpG4c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8145bb2a-2585-4321-0549-08d71b563581
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 16:42:17.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6GzYRrtpcRqs+n1j0gsN24F+HBDXkxk3cxeQva7VvvCf4QNQf3wpU8xEGYbqVSp+7SejmBo4s+DrUpWW999wMM5vLWPLiyWpr6+/+ZCqA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3360
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/2019 9:40 PM, gregkh@linuxfoundation.org wrote:=0A=
> On Tue, Aug 06, 2019 at 05:11:17PM +0000, Stefan-gabriel Mirea wrote:=0A=
>> On 8/5/2019 6:31 PM, gregkh@linuxfoundation.org wrote:=0A=
>>> On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:=
=0A=
>>>>=0A=
>>>> +/* Freescale Linflex UART */=0A=
>>>> +#define PORT_LINFLEXUART     121=0A=
>>>=0A=
>>> Do you really need this modified?=0A=
>>=0A=
>> Hello Greg,=0A=
>>=0A=
>> This macro is meant to be assigned to port->type in the config_port=0A=
>> method from uart_ops, in order for verify_port to know if the received=
=0A=
>> serial_struct structure was really targeted for a LINFlex port. It=0A=
>> needs to be defined outside, to avoid "collisions" with other drivers.=
=0A=
> =0A=
> Yes, I know what it goes to, but does anyone in userspace actually use=0A=
> it?=0A=
=0A=
No, we do not use it from userspace, but kept the pattern only for=0A=
conformance.=0A=
=0A=
>> Other than that, I do not see anything wrong with the addition of a=0A=
>> define in serial_core.h for this purpose (which is also what most of the=
=0A=
>> serial drivers do, including amba-pl011.c, mentioned in=0A=
>> Documentation/driver-api/serial/driver.rst as providing the reference=0A=
>> implementation), so please be more specific.=0A=
> =0A=
> I am getting tired of dealing with merge issues with that list, and no=0A=
> one seems to be able to find where they are really needed for userspace,=
=0A=
> especially for new devices.  What happens if you do not have use it?=0A=
=0A=
I see. If I drop its usage completely and leave 'type' from the=0A=
uart_port as 0, uart_port_startup() will fail when finding that=0A=
uport->type =3D=3D PORT_UNKNOWN at [1] (there may be other effects as well,=
=0A=
e.g. due to the check in uart_configure_port[2]).=0A=
=0A=
So I suppose that I need to define some nonzero 'PORT_KNOWN' macro in=0A=
the driver and use that one internally for 'type'. Is my understanding=0A=
correct? Will there be any problems if I define it to a positive integer=0A=
which is already assigned to another driver, according to serial_core.h?=0A=
=0A=
Regards,=0A=
Stefan=0A=
=0A=
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/tty/serial/serial_core.c?h=3Dv5.3-rc1#n188=0A=
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/tty/serial/serial_core.c?h=3Dv5.3-rc1#n2348=0A=
