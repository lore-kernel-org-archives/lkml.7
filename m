Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FDAC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AF72072B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a/J9G08e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfKOG7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:59:09 -0500
Received: from mail-eopbgr140079.outbound.protection.outlook.com ([40.107.14.79]:6661
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727189AbfKOG7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:59:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0t8gUR8fhxR86p4i9CP3NFJtvDSUYYwP6RLePyQrZ02/nPDOxGY/P2GrKiVS4UpsKKNK4V8wUUp+R+ujE17TERoTBv/mT/Bm+2z+O0mu7GIqmlw6AY6r5Tf7mrElxcz5Ow1EeivcI1FFy2Iex3gelSxq9vyfCFXMYUJG6nYbR8+UkeBJhBrs0nN2wFrSaqRKO3JuR7KP1k447+NyZK4nrNb6yiobIVEpuDw8EYQ3OCi8riX+la9/M+bK0AHvBDg6eBxa67fCG77BULUgoj780ze+eOTgrxpf0N58VGQdAFzEIDYbcn3D43HWpyXwWA7RIK61XV0o6R341wxrDl0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkcVLIRzZitmeP0mutorBTnD6mFZFeYsbR/pOKTKEUQ=;
 b=Q60xn+WL5DT6Eq+NYB+twPMNfQJebhRo8bPmpidKv5mxNsVEprwa1Xa1VJbLgccBqkAdvEDK78+H2kQLGUZrGtbACisOm75MoJWjYSIDoO3MBLCVpeKInuJUO6pkwPGqs07FBXKkSLwAEpo0PtNH73j839QIzInBqrQm3H2Ik00rw70jijD+yYT9Gp8xxh+4iZEyIa2YXj5rQdGInnzoJvUebtPOEwfLF0KED1C5+ooaTJcsBismT/HgA14iLoWTtCA+FbSOSXtdin5Rpul/mX+p7R02RoTe1KyKLKo26Ta3pWMMGbwpIkq6FA8b4mvqJI2j5BJR5FyPlWMxoLCVAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkcVLIRzZitmeP0mutorBTnD6mFZFeYsbR/pOKTKEUQ=;
 b=a/J9G08e2/fBfNR/r1NdtwPqEvwcD+3IystAQQZnYswx+HPaJUzh+cNj2TASjg8sWGrGDXYLayjliLq8KloAfqFiYK2Lb1dhVQxN+ihvAqXkhBavP3HAtmt8RFwmqyD8COXfXpUyLhrVgHTdgSh2zCz6CibeP/f/UeF46gCOxdU=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5519.eurprd04.prod.outlook.com (20.178.121.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Fri, 15 Nov 2019 06:59:02 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::cd33:501f:b25:51a9%7]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 06:59:02 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Olbrich <m.olbrich@pengutronix.de>
Subject: Re: [PATCH] usb: gadget: composite: split spinlock to avoid recursion
Thread-Topic: [PATCH] usb: gadget: composite: split spinlock to avoid
 recursion
Thread-Index: AQHVmTxEIjD1nt2RjUO3vLFSiYOzzqeIpkIAgACXfICAAW0yAIABJ5EA
Date:   Fri, 15 Nov 2019 06:59:02 +0000
Message-ID: <20191115070122.GF30608@b29397-desktop>
References: <20191113063414.GA30608@b29397-desktop>
 <Pine.LNX.4.44L0.1911131021460.1558-100000@iolanthe.rowland.org>
 <20191114132330.iw4ucbfaxofi6cfy@pengutronix.de>
In-Reply-To: <20191114132330.iw4ucbfaxofi6cfy@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f857095-a373-41e3-8f7a-08d769994c4c
x-ms-traffictypediagnostic: VI1PR04MB5519:
x-microsoft-antispam-prvs: <VI1PR04MB5519DF24B0991C9C70D963EF8B700@VI1PR04MB5519.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(9686003)(71200400001)(86362001)(305945005)(2906002)(110136005)(71190400001)(6116002)(3846002)(7736002)(11346002)(33656002)(6486002)(99286004)(446003)(229853002)(8936002)(476003)(6436002)(66476007)(66556008)(64756008)(45080400002)(66446008)(66946007)(478600001)(6512007)(66066001)(76176011)(33716001)(316002)(44832011)(14454004)(2501003)(5660300002)(486006)(256004)(14444005)(53546011)(26005)(6246003)(25786009)(102836004)(6506007)(8676002)(81166006)(2171002)(91956017)(81156014)(1076003)(186003)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5519;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q9MqmMVmu/tv+yqbfF8RcHAtWh8HEi4yvZWVRouPx91/3LK7MyFRfME+tY4p9VRhpwYWkGT8ppJqcxS07QfvcUs2NTezHXAAgUOTgQomi+E9m4VCcerhL/U/Skhf/8AV1BgdsZm91ZUW1iA7kME8F/ImgFOOXDoYGofgNmE/PxAsmF1Y+MViwJPApg/x5hljDLf+qdfir3g3iwHwS3VogV811gPR/ApknzIloMjS9C5qCZzHyrVfvoaliMEgdcRPAGwyanuzATTAgvy0mNr5rO48zFYO3c/1dfm6AaRb46nh3UNQ40RGy7Cci77rAVTn6NopWnGGXUFloRgyayVkThWA2kUcZij5ZaQ9g5JTJCAfFknO0nm6SfXv0XskY7kbJb9W1ZqKf5UCikF+qq/Ki2MCSgI1QYa0PQPoChITNAL0eX9qarzbCI1mqDyONCnk
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A50DCA1B20CB2C4B8E5BD598BD7B32FC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f857095-a373-41e3-8f7a-08d769994c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 06:59:02.5514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUYQiWCRADZ5D1Tmpurd+Cx6ntsmYGHzMaQ6Gwr9Tyo5k+w3a1iYp0kKVtVIRccPGpyRBmJE4YzCvttrGz8KaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5519
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-14 14:23:30, Michael Olbrich wrote:
> On Wed, Nov 13, 2019 at 10:36:25AM -0500, Alan Stern wrote:
> > On Wed, 13 Nov 2019, Peter Chen wrote:
> > > On 19-11-12 10:33:18, Michael Olbrich wrote:
> > > > 'delayed_status' and 'deactivations' are used completely independen=
t but
> > > > they share the same spinlock. This can result in spinlock recursion=
:
> > > >=20
> > > > BUG: spinlock recursion on CPU#1, uvc-gadget/322
> > > >  lock: 0xffffffc0570364e0, .magic: dead4ead, .owner: uvc-gadget/322=
, .owner_cpu: 1
> > > > CPU: 1 PID: 322 Comm: uvc-gadget Tainted: G         C O      5.3.0-=
20190916-1+ #55
> > > > Hardware name: XXXXX (DT)
> > > > Call trace:
> > > >  dump_backtrace+0x0/0x178
> > > >  show_stack+0x24/0x30
> > > >  dump_stack+0xc0/0x104
> > > >  spin_dump+0x90/0xa0
> > > >  do_raw_spin_lock+0xd8/0x108
> > > >  _raw_spin_lock_irqsave+0x40/0x50
> > > >  composite_disconnect+0x2c/0x80
> > > >  usb_gadget_disconnect+0x84/0x150
> > > >  usb_gadget_deactivate+0x64/0x120
> > > >  usb_function_deactivate+0x70/0x80
> > > >  uvc_function_disconnect+0x20/0x58
> > > >  uvc_v4l2_release+0x34/0x90
> > > >  v4l2_release+0xbc/0xf0
> > > >  __fput+0xb0/0x218
> > > >  ____fput+0x20/0x30
> > > >  task_work_run+0xa0/0xd0
> > > >  do_notify_resume+0x2f4/0x340
> > > >  work_pending+0x8/0x14
> > > >=20
> > > > Fix this by using separate spinlocks.
> > >=20
> > > This issue may be introduced by 0a55187a1ec8c ("USB: gadget core: Iss=
ue
> > > ->disconnect() callback from usb_gadget_disconnect()"), which adds
> > > gadget's disconnect at usb_gadget_disconnect. Add Alan, if he is Ok
> > > with your patch, you may cc to stable tree.
> >=20
> > I wasn't aware of the dual usage of that lock in the composite core=20
> > (and 0a55187a1ec8c touches only the gadget core, not composite.c).
> >=20
> > In any case, I don't have a good feel for how the locking is supposed=20
> > to work in the composite core.  This is really something Felipe should=
=20
> > look at.
> >=20
> > Would a better fix be to change usb_function_deactivate() so that it
> > doesn't hold the lock while calling usb_gadget_deactivate()?  Maybe
> > increment cdev->deactivations unconditionally before dropping the lock
> > (for mutual exclusion) and then decrement it again if the call fails?
>=20
> Hmm, I think, that would mean that usb_gadget_activate() may be called
> while usb_gadget_deactivate() is still running right? That's not
> acceptable, is it?
>=20

I agree with Alan. Return error for usb_function_activate if
usb_function_deactive is running could be accepted, it seems there is
no other good way to fix this lock recursion and your below atomic
issue, let's see what Felipe will say.

Peter

> Anyways. Something else is needed because executing usb_gadget_deactivate=
()
> under the spinlock has another problem. It's hard to reproduce, but we've
> seen this one:
>=20
> BUG: scheduling while atomic: pipewire/260/0x00000002
> Modules linked in: allegro(C) regmap_mmio v4l2_mem2mem xlnx_vcu st1232 ui=
o_pdrv_genirq
> Preemption disabled at: [<ffffff801061dc40>] usb_function_deactivate+0x30=
/0x80
> CPU: 1 PID: 260 Comm: pipewire Tainted: G         C O 5.3.0-20191112-1 #2
> Hardware name: Wolfvision ZynqMP PF4 (DT)
> Call trace:
>  dump_backtrace+0x0/0x178
>  show_stack+0x24/0x30
>  dump_stack+0xc0/0x104
>  __schedule_bug+0xb0/0xc0
>  __schedule+0x354/0x4d8
>  schedule+0x44/0xd8
>  schedule_timeout+0x1b4/0x380
>  wait_for_common+0xc0/0x188
>  wait_for_completion_timeout+0x2c/0x38
>  dwc3_gadget_pullup+0x90/0xb0
>  usb_gadget_disconnect+0x38/0x150
>  usb_gadget_deactivate+0x64/0x120
>  usb_function_deactivate+0x70/0x80
>  uvc_function_disconnect+0x20/0x58
>  uvc_v4l2_release+0x34/0x90
>  v4l2_release+0xbc/0xf0
>  __fput+0x90/0x208
>  ____fput+0x20/0x30
>  task_work_run+0x98/0xb8
>  do_notify_resume+0x2f4/0x340
>  work_pending+0x8/0x14
> dwc3 fe200000.usb: timed out waiting for SETUP phase
>=20

Hi Michael,
  =20

--=20

Thanks,
Peter Chen=
