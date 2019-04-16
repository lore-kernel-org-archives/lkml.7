Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860E0C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4096A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W84UnVha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfDPO1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:27:14 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:58820 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDPO1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:27:13 -0400
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 9777A24E2089;
        Tue, 16 Apr 2019 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555424833; bh=JmRiW5JBu+eYi+srMENzofB3YaSoM6LZD/RtNHIrrwE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=W84UnVhaGx/9FoQdQiItpilHPS6aikha8isKNWjnotzytX8K+4BDIn8uGNW8P28o5
         68sYOoOrT7O1FmKTQKxzMyDkAoecPOqx/RVuLoBZJQwFz8tAd4vSPWxzMJIp/RimWL
         tG/4tjipDywpk3Ca+mTyBTfCtlG2JDP0KWsbXKsg1Nqy5AtSDjSGbSygAYJAg2kpAA
         YszPIgwB7EfhDsGoq0Q0C4oKr+HymaKontJY0yYKMm3dSGtfkknM/2N450+PRaKB+c
         cTY2okYB2lXtNVyePjS86aSbXO+8Ec0WRo6zvYiAAc0eWvB8vOWS23Asb+T1l0LLQR
         3DyeFOYwKSEmg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 88CAEA008B;
        Tue, 16 Apr 2019 14:27:13 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 16 Apr 2019 07:27:13 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 16 Apr 2019 16:27:11 +0200
From:   Vitor Soares <vitor.soares@synopsys.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Vitor Soares <vitor.soares@synopsys.com>
CC:     "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] i3c: add mixed limited bus mode
Thread-Topic: [PATCH 2/3] i3c: add mixed limited bus mode
Thread-Index: AQHU87sNC3bExezwqEuwlsXYEL/C9KY+Kn2AgACunBA=
Date:   Tue, 16 Apr 2019 14:27:10 +0000
Message-ID: <13D59CF9CEBAF94592A12E8AE55501350A615980@DE02WEMBXB.internal.synopsys.com>
References: <cover.1555350118.git.vitor.soares@synopsys.com>
        <a3bf32dadd9b0135442526cc77fec5726e6e617d.1555350118.git.vitor.soares@synopsys.com>
 <20190416080049.5a6053b0@collabora.com>
In-Reply-To: <20190416080049.5a6053b0@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctYjVmZDJlZjktNjA1My0xMWU5LTgyM2EtZDQ4MWQ3?=
 =?us-ascii?Q?ODUxODBmXGFtZS10ZXN0XGI1ZmQyZWZiLTYwNTMtMTFlOS04MjNhLWQ0ODFk?=
 =?us-ascii?Q?Nzg1MTgwZmJvZHkudHh0IiBzej0iMzUzNSIgdD0iMTMxOTk4OTg0MjczNTUy?=
 =?us-ascii?Q?MDEwIiBoPSJTYnhIdlBrM3EvT3Z4YnlqL21td0l6MUlVdVU9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUNL?=
 =?us-ascii?Q?WWxaNFlQVFVBVXk2M2FrYW1QOWFUTHJkcVJxWS8xb09BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDa0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQVZ6ZGhHZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
 =?us-ascii?Q?aEFHNEFZd0JsQUY4QWNBQnNBR0VBYmdCdUFHa0FiZ0JuQUY4QWR3QmhBSFFB?=
 =?us-ascii?Q?WlFCeUFHMEFZUUJ5QUdzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FYd0J3?=
 =?us-ascii?Q?QUdFQWNnQjBBRzRBWlFCeUFITUFYd0JuQUdZQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJnQmxB?=
 =?us-ascii?Q?SElBY3dCZkFITUFZUUJ0QUhNQWRRQnVBR2NBWHdCakFHOEFiZ0JtQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFHOEFk?=
 =?us-ascii?Q?UUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBY3dCaEFH?=
 =?us-ascii?Q?MEFjd0IxQUc0QVp3QmZBSElBWlFCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QnpBRzBBYVFCakFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhNQWRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFkQUJ6?=
 =?us-ascii?Q?QUcwQVl3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtB?=
 =?us-ascii?Q?WHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCMUFHMEFZd0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWndCMEFITUFYd0J3QUhJQWJ3QmtBSFVBWXdCMEFGOEFk?=
 =?us-ascii?Q?QUJ5QUdFQWFRQnVBR2tBYmdCbkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpB?=
 =?us-ascii?Q?R0VBYkFCbEFITUFYd0JoQUdNQVl3QnZBSFVBYmdCMEFGOEFjQUJzQUdFQWJn?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhNQVlRQnNBR1VBY3dCZkFI?=
 =?us-ascii?Q?RUFkUUJ2QUhRQVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFjd0J1QUhBQWN3QmZBR3dBYVFCakFHVUFiZ0J6QUdV?=
 =?us-ascii?Q?QVh3QjBBR1VBY2dCdEFGOEFNUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHNEFjQUJ6QUY4QWJBQnBBR01BWlFCdUFITUFaUUJmQUhRQVpRQnlBRzBB?=
 =?us-ascii?Q?WHdCekFIUUFkUUJrQUdVQWJnQjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSFlBWndCZkFHc0FaUUI1?=
 =?us-ascii?Q?QUhjQWJ3QnlBR1FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
x-originating-ip: [10.107.25.87]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, Apr 16, 2019 at 07:00:49

> Hi Vitor,
>=20
> On Mon, 15 Apr 2019 20:46:42 +0200
> Vitor Soares <vitor.soares@synopsys.com> wrote:
>=20
> > The i3c bus spec define a bus configuration where the i2c devices
>=20
> 		   ^defines			    I2C devices...
>=20
> > doesn't have the 50ns filter yet they allow the SDR max speed.
>=20
>   ^don't	^ a 50ns filter but support SCL running at SDR max
> rate (12MHz).
>=20
> >=20
> > This patch introduce the limited bus mode so the users can use
>=20
> 	     ^introduces		    ^ so that users
>=20
> > a higher speed on presence of i2c devices index 1.
>=20
> 		 ^in
>=20
> >=20
> > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > Cc: Boris Brezillon <bbrezillon@kernel.org>
> > Cc: <linux-kernel@vger.kernel.org>
> > ---
> >  drivers/i3c/master.c       | 5 +++++
> >  include/linux/i3c/master.h | 5 +++++
> >  2 files changed, 10 insertions(+)
> >=20
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > index 1c4a86a..46d3774 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -463,6 +463,7 @@ static int i3c_bus_init(struct i3c_bus *i3cbus)
> >  static const char * const i3c_bus_mode_strings[] =3D {
> >  	[I3C_BUS_MODE_PURE] =3D "pure",
> >  	[I3C_BUS_MODE_MIXED_FAST] =3D "mixed-fast",
> > +	[I3C_BUS_MODE_MIXED_LIMITED] =3D "mixed-limited",
> >  	[I3C_BUS_MODE_MIXED_SLOW] =3D "mixed-slow",
> >  };
> > =20
> > @@ -575,6 +576,7 @@ int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i=
3c_bus_mode mode,
> >  			i3cbus->scl_rate.i3c =3D I3C_BUS_TYP_I3C_SCL_RATE;
> >  		break;
> >  	case I3C_BUS_MODE_MIXED_FAST:
> > +	case I3C_BUS_MODE_MIXED_LIMITED:
> >  		if (!i3cbus->scl_rate.i3c)
> >  			i3cbus->scl_rate.i3c =3D I3C_BUS_TYP_I3C_SCL_RATE;
> >  		if (!i3cbus->scl_rate.i2c)
> > @@ -2481,6 +2483,9 @@ int i3c_master_register(struct i3c_master_control=
ler *master,
> >  				mode =3D I3C_BUS_MODE_MIXED_FAST;
> >  			break;
> >  		case I3C_LVR_I2C_INDEX(1):
> > +			if (mode < I3C_BUS_MODE_MIXED_LIMITED)
> > +				mode =3D I3C_BUS_MODE_MIXED_LIMITED;
> > +			break;
> >  		case I3C_LVR_I2C_INDEX(2):
> >  			if (mode < I3C_BUS_MODE_MIXED_SLOW)
> >  				mode =3D I3C_BUS_MODE_MIXED_SLOW;
> > diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> > index 44fb3cf..740235e 100644
> > --- a/include/linux/i3c/master.h
> > +++ b/include/linux/i3c/master.h
> > @@ -250,12 +250,17 @@ struct i3c_device {
> >   *			     the bus. The only impact in this mode is that the
> >   *			     high SCL pulse has to stay below 50ns to trick I2C
> >   *			     devices when transmitting I3C frames
> > + * @I3C_BUS_MODE_MIXED_LIMITED: I2C devices without 50ns spike filter =
are
> > + *				present on the bus. However they allows
> > + *				compliance up to the maximum SDR SCL clock
> > + *				frequency.
>=20
> 						    However they support
> 				SCL clock running at maximum SDR rate
> 				(12.5MHz).
>=20
> >   * @I3C_BUS_MODE_MIXED_SLOW: I2C devices without 50ns spike filter are=
 present
> >   *			     on the bus
> >   */
> >  enum i3c_bus_mode {
> >  	I3C_BUS_MODE_PURE,
> >  	I3C_BUS_MODE_MIXED_FAST,
> > +	I3C_BUS_MODE_MIXED_LIMITED,
> >  	I3C_BUS_MODE_MIXED_SLOW,
> >  };
> > =20
>=20
> The code itself looks good.
>=20
> Thanks,
>=20
> Boris

Thanks for your feedback I will address the fixes next version.


Best regards,
Vitor Soares


