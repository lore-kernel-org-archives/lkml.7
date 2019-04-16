Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467EDC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B7C20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Sb8+vnXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfDPOZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:25:03 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:58738 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPOZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:25:02 -0400
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 0B4F924E2089;
        Tue, 16 Apr 2019 07:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555424702; bh=nJmcFf7PEGn9HaOpWYwHhSjGkUI9ebBap0Or7wsdSHM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Sb8+vnXPtBV3xWVqifflPsS0evAGtWo7SyM3TVQW6eFmPqDIudjeNvFG2H7kaA40b
         E28ICddwOKEfRCFVSknhHk5Olg4cJRO4W0n/tB1a0o/Et04mdYP9xS8u1gZYqeNWgW
         +MsmPVErWF3athv2MYudygu43EMIFMMeag61sJ1cFdfZdSzd8nrZRzBRiFJzad6SyE
         sO5r9yt8KUUO5KJt+bqHcsEtxG2Y6ktF8qo+vuBZf86RX0SPTIIZ9CyRZlEn//BDrB
         x1T3ojCriPQyYaGFpiaW+o3ig4xzJ3gAUnKatJW3G7sTrHB5+M14KK5dfQwq5yfk+z
         cobObvWiGspBw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id DF6F7A0070;
        Tue, 16 Apr 2019 14:24:59 +0000 (UTC)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 16 Apr 2019 07:24:59 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 16 Apr 2019 16:24:57 +0200
From:   Vitor Soares <vitor.soares@synopsys.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Vitor Soares <vitor.soares@synopsys.com>
CC:     "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] i3c: fix i2c and i3c scl rate by bus mode
Thread-Topic: [PATCH 1/3] i3c: fix i2c and i3c scl rate by bus mode
Thread-Index: AQHU87sLhgtQ1+d000+4YAeSeMHzMaY+J6iAgACom0A=
Date:   Tue, 16 Apr 2019 14:24:57 +0000
Message-ID: <13D59CF9CEBAF94592A12E8AE55501350A61596D@DE02WEMBXB.internal.synopsys.com>
References: <cover.1555350118.git.vitor.soares@synopsys.com>
        <05fdeea79db83970e9ecb0d7045b4dd98f206f06.1555350118.git.vitor.soares@synopsys.com>
 <20190416075041.22f8e849@collabora.com>
In-Reply-To: <20190416075041.22f8e849@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctNjY5M2U4ZDMtNjA1My0xMWU5LTgyM2EtZDQ4MWQ3?=
 =?us-ascii?Q?ODUxODBmXGFtZS10ZXN0XDY2OTNlOGQ0LTYwNTMtMTFlOS04MjNhLWQ0ODFk?=
 =?us-ascii?Q?Nzg1MTgwZmJvZHkudHh0IiBzej0iNTE5MCIgdD0iMTMxOTk4OTgyOTU4MjMw?=
 =?us-ascii?Q?NzA5IiBoPSJaSjNUdHgyQVhTaWZYakltTWpCYzF1U1J1bWs9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUMx?=
 =?us-ascii?Q?TFBBcFlQVFVBVUJrWE9oL1J1Z3BRR1JjNkg5RzZDa09BQUFBQUFBQUFBQUFB?=
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
Date: Tue, Apr 16, 2019 at 06:50:41

> On Mon, 15 Apr 2019 20:46:41 +0200
> Vitor Soares <vitor.soares@synopsys.com> wrote:
>=20
> > Currently in case of mixed slow bus topologie and all i2c devices
> > support FM+ speed, the i3c subsystem limite the SCL to FM speed.
>=20

I will it replace with your message below.

> "
> Currently the I3C framework limits SCL frequency to FM speed when
> dealing with a mixed slow bus, even if all I2C devices are FM+ capable.
> "
>=20
> > Also in case on mixed slow bus mode the max speed for both
> > i2c or i3c transfers is FM or FM+.
>=20
> Looks like you're basically repeating what you said above.

What I meant was that I3C framework isn't limiting the I3C speed in case=20
of mixed slow bus.

>=20
> >=20
> > This patch fix the definition of i2c and i3c scl rate based on bus
>=20
> 	     ^fixes					      on the bus
>=20
> > topologie and LVR[4] if no user input.
>=20
>   ^topology		^if the rate is not already specified by the user.
>=20
> > In case of mixed slow mode the i3c scl rate is overridden.
>=20
> 							   ^ with the max
> I2C rate.
>=20
> >=20
> > Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > Cc: Boris Brezillon <bbrezillon@kernel.org>
> > Cc: <stable@vger.kernel.org>
> > Cc: <linux-kernel@vger.kernel.org>
> > ---
> >  drivers/i3c/master.c | 39 +++++++++++++++++++++++++--------------
> >  1 file changed, 25 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > index 909c2ad..1c4a86a 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -564,20 +564,30 @@ static const struct device_type i3c_masterdev_typ=
e =3D {
> >  	.groups	=3D i3c_masterdev_groups,
> >  };
> > =20
> > -int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode)
> > +int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
> > +		     unsigned long i2c_scl_rate)
>=20
>=20
> Can we rename the last arg into max_i2c_scl_rate?

The i2c_scl_rate is base on LVR[4] bit and the user can set a higher scl=20
rate, this is reason I didn't named it to max_i2c_scl_rate.
But if you think that make more sense I'm ok with that.

>=20
> >  {
> >  	i3cbus->mode =3D mode;
> > =20
> > -	if (!i3cbus->scl_rate.i3c)
> > -		i3cbus->scl_rate.i3c =3D I3C_BUS_TYP_I3C_SCL_RATE;
> > -
> > -	if (!i3cbus->scl_rate.i2c) {
> > -		if (i3cbus->mode =3D=3D I3C_BUS_MODE_MIXED_SLOW)
> > -			i3cbus->scl_rate.i2c =3D I3C_BUS_I2C_FM_SCL_RATE;
> > -		else
> > -			i3cbus->scl_rate.i2c =3D I3C_BUS_I2C_FM_PLUS_SCL_RATE;
> > +	switch (i3cbus->mode) {
> > +	case I3C_BUS_MODE_PURE:
> > +		if (!i3cbus->scl_rate.i3c)
> > +			i3cbus->scl_rate.i3c =3D I3C_BUS_TYP_I3C_SCL_RATE;
> > +		break;
> > +	case I3C_BUS_MODE_MIXED_FAST:
> > +		if (!i3cbus->scl_rate.i3c)
> > +			i3cbus->scl_rate.i3c =3D I3C_BUS_TYP_I3C_SCL_RATE;
> > +		if (!i3cbus->scl_rate.i2c)
> > +			i3cbus->scl_rate.i2c =3D i2c_scl_rate;
> > +		break;
> > +	case I3C_BUS_MODE_MIXED_SLOW:
> > +		if (!i3cbus->scl_rate.i2c)
> > +			i3cbus->scl_rate.i2c =3D i2c_scl_rate;
> > +		i3cbus->scl_rate.i3c =3D i3cbus->scl_rate.i2c;
>=20
> Maybe we should do
>=20
> 		if (!i3cbus->scl_rate.i3c ||
> 		    i3cbus->scl_rate.i3c > i3cbus->scl_rate.i2c)
> 			i3cbus->scl_rate.i3c =3D i3cbus->scl_rate.i2c;
> 					  =20
> Just in case the I3C rate forced by the user is lower than the max I2C
> rate.

That was something that I considered but TBH it isn't a real use case.

>=20
> The patch looks good otherwise.

Thanks.

>=20
> > +		break;
> > +	default:
> > +		return -EINVAL;
> >  	}
> > -
> >  	/*
> >  	 * I3C/I2C frequency may have been overridden, check that user-provid=
ed
> >  	 * values are not exceeding max possible frequency.
> > @@ -1980,9 +1990,6 @@ of_i3c_master_add_i2c_boardinfo(struct i3c_master=
_controller *master,
> >  	/* LVR is encoded in reg[2]. */
> >  	boardinfo->lvr =3D reg[2];
> > =20
> > -	if (boardinfo->lvr & I3C_LVR_I2C_FM_MODE)
> > -		master->bus.scl_rate.i2c =3D I3C_BUS_I2C_FM_SCL_RATE;
> > -
> >  	list_add_tail(&boardinfo->node, &master->boardinfo.i2c);
> >  	of_node_get(node);
> > =20
> > @@ -2432,6 +2439,7 @@ int i3c_master_register(struct i3c_master_control=
ler *master,
> >  			const struct i3c_master_controller_ops *ops,
> >  			bool secondary)
> >  {
> > +	unsigned long i2c_scl_rate =3D I3C_BUS_I2C_FM_PLUS_SCL_RATE;
> >  	struct i3c_bus *i3cbus =3D i3c_master_get_bus(master);
> >  	enum i3c_bus_mode mode =3D I3C_BUS_MODE_PURE;
> >  	struct i2c_dev_boardinfo *i2cbi;
> > @@ -2481,9 +2489,12 @@ int i3c_master_register(struct i3c_master_contro=
ller *master,
> >  			ret =3D -EINVAL;
> >  			goto err_put_dev;
> >  		}
> > +
> > +		if (i2cbi->lvr & I3C_LVR_I2C_FM_MODE)
> > +			i2c_scl_rate =3D I3C_BUS_I2C_FM_SCL_RATE;
> >  	}
> > =20
> > -	ret =3D i3c_bus_set_mode(i3cbus, mode);
> > +	ret =3D i3c_bus_set_mode(i3cbus, mode, i2c_scl_rate);
> >  	if (ret)
> >  		goto err_put_dev;
> > =20

Best regards,
Vitor Soares
