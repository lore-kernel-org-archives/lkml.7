Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90190C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4915520652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RtUhSSRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfDPPAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:00:45 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:38558 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbfDPPAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:00:41 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id AA7D310C1726;
        Tue, 16 Apr 2019 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555426840; bh=1ht5PP89NkpyCoY8M/wOtAMkEv/dFC1aR+srnh9L+xg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RtUhSSRrw5ae3YHIhuHWpEH1mTL6xASFn+UHKzinQOtC7IAiLHxGvFrTL08LF159c
         4ILdo/KiBj8xBxGjI6R6j8BweplnafEcUsKbyB+jW3vVW3rji03f2eaHDiGwwytLop
         eyyNGEB6nteScZ9KZcVTYDdkd7bVWFAJUOFf1OvLg0VBH2uz3cGT1Mafs+v/gA8JdK
         IbZalvUiGBxk8bKq3RqJZ66v7eE5fCqwz7u/6jzXPBqzZgNLSPgnJS/9lN6DIJVXcQ
         Rgog55Gk5bGrU28N9gb0NpnWx1F+JY3b5vw1dWfFSKN5xoeQ2m3iMnhM8Zz42O3C0s
         Musap/Pqd2WnA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 51171A00AF;
        Tue, 16 Apr 2019 15:00:38 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 16 Apr 2019 08:00:38 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 16 Apr 2019 17:00:35 +0200
From:   Vitor Soares <vitor.soares@synopsys.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
CC:     Vitor Soares <vitor.soares@synopsys.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>
Subject: RE: [PATCH 3/3] iio: imu: st_lsm6dsx: Add i3c basic support
Thread-Topic: [PATCH 3/3] iio: imu: st_lsm6dsx: Add i3c basic support
Thread-Index: AQHU88BDdPWsnuXu6UGzgTXZFjsXn6Y+MWOAgAAZ9YCAAAH9AIAAky9g
Date:   Tue, 16 Apr 2019 15:00:35 +0000
Message-ID: <13D59CF9CEBAF94592A12E8AE55501350A6159D0@DE02WEMBXB.internal.synopsys.com>
References: <cover.1555354268.git.vitor.soares@synopsys.com>
        <302f8296299d6cd25b3689f5eca1c510a3290db3.1555354268.git.vitor.soares@synopsys.com>
        <20190416082539.2f12b38f@collabora.com>
        <CAA2SeNJ1cTxAp6+5Q4Z5L4VFBfA3U4e11_Obpk8muD1Vh3v52A@mail.gmail.com>
 <20190416100540.7adf1fe5@collabora.com>
In-Reply-To: <20190416100540.7adf1fe5@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctNjA2ZGZkMTQtNjA1OC0xMWU5LTgyM2EtZDQ4MWQ3?=
 =?us-ascii?Q?ODUxODBmXGFtZS10ZXN0XDYwNmRmZDE1LTYwNTgtMTFlOS04MjNhLWQ0ODFk?=
 =?us-ascii?Q?Nzg1MTgwZmJvZHkudHh0IiBzej0iNjcwOCIgdD0iMTMxOTk5MDA0MzM0NDI4?=
 =?us-ascii?Q?Mzg0IiBoPSJIbVBxK21SMUY2RFNUbVVpUWhiY2x2ZGVVakE9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQURn?=
 =?us-ascii?Q?RUE4a1pmVFVBY3IweW1oUjZ6ZG95dlRLYUZIck4yZ09BQUFBQUFBQUFBQUFB?=
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

Hi Boris  and Lorenzo,

From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, Apr 16, 2019 at 09:05:40

> On Tue, 16 Apr 2019 09:58:33 +0200
> Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
>=20
> > >
> > > On Mon, 15 Apr 2019 21:19:41 +0200
> > > Vitor Soares <vitor.soares@synopsys.com> wrote:
> > > =20
> > > > For today the st_lsm6dsx driver support lsm6dso sensor only in
> > > > spi and i2c mode.
> > > >
> > > > The lsm6dso is also i3c capable so lets give i3c support to it.
> > > >
> > > > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > > > ---
> > > >  drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
> > > >  drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 67 +++++++++++++++++=
++++++++++++
> > > >  3 files changed, 75 insertions(+), 1 deletion(-)
> > > >  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > > >
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/s=
t_lsm6dsx/Kconfig
> > > > index 094fd00..1ab9bbf 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> > > > @@ -1,11 +1,12 @@
> > > >
> > > >  config IIO_ST_LSM6DSX
> > > >       tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors"
> > > > -     depends on (I2C || SPI)
> > > > +     depends on (I2C || SPI || I3C)
> > > >       select IIO_BUFFER
> > > >       select IIO_KFIFO_BUF
> > > >       select IIO_ST_LSM6DSX_I2C if (I2C)
> > > >       select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
> > > > +     select IIO_ST_LSM6DSX_I3C if (I3C)
> > > >       help
> > > >         Say yes here to build support for STMicroelectronics LSM6DS=
x imu
> > > >         sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6=
dsm,
> > > > @@ -23,3 +24,8 @@ config IIO_ST_LSM6DSX_SPI
> > > >       tristate
> > > >       depends on IIO_ST_LSM6DSX
> > > >       select REGMAP_SPI
> > > > +
> > > > +config IIO_ST_LSM6DSX_I3C
> > > > +     tristate
> > > > +     depends on IIO_ST_LSM6DSX
> > > > +     select REGMAP_I3C
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/Makefile b/drivers/iio/imu/=
st_lsm6dsx/Makefile
> > > > index e5f733c..c676965 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/Makefile
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/Makefile
> > > > @@ -4,3 +4,4 @@ st_lsm6dsx-y :=3D st_lsm6dsx_core.o st_lsm6dsx_buff=
er.o \
> > > >  obj-$(CONFIG_IIO_ST_LSM6DSX) +=3D st_lsm6dsx.o
> > > >  obj-$(CONFIG_IIO_ST_LSM6DSX_I2C) +=3D st_lsm6dsx_i2c.o
> > > >  obj-$(CONFIG_IIO_ST_LSM6DSX_SPI) +=3D st_lsm6dsx_spi.o
> > > > +obj-$(CONFIG_IIO_ST_LSM6DSX_I3C) +=3D st_lsm6dsx_i3c.o
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/=
iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > > > new file mode 100644
> > > > index 0000000..2df5e70
> > > > --- /dev/null
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > > > @@ -0,0 +1,67 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
> > > > + *
> > > > + * Author: Vitor Soares <vitor.soares@synopsys.com>
> > > > + */
> > > > +
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/i3c/device.h>
> > > > +#include <linux/i3c/master.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/regmap.h>
> > > > +
> > > > +#include "st_lsm6dsx.h"
> > > > +
> > > > +#define NAME_SIZE    32
> > > > +
> > > > +struct st_lsm6dsx_i3c_data {
> > > > +     char name[NAME_SIZE]; =20
> > >
> > >         const char *name;

I will fix this next patch.

> > > =20
> > > > +     enum st_lsm6dsx_hw_id id;
> > > > +};
> > > > +
> > > > +static const struct st_lsm6dsx_i3c_data hw_data[] =3D { =20
> > >
> > > No need to make it an array, and it should probably be named
> > > st_lsm6dso_data not hw_data. =20
> >=20
> > I guess it will be used even for future devices so I would prefer to
> > make it an array with a 'general' name

The idea is that one. Are you ok with hw_data name?
Should I add the lsm6dsr support here or send in a different patch?

>=20
> I find it more error-prone to reference an array with an opaque index
> number than reference an instance with a name that clearly reflects
> what HW it describes (see the I3C_DEVICE() entry at the end of the
> driver), but okay.

I will address this next version.

>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > > =20
> > > > +     { ST_LSM6DSO_DEV_NAME, ST_LSM6DSO_ID },
> > > > +};
> > > > +
> > > > +static const struct regmap_config st_lsm6dsx_i3c_regmap_config =3D=
 {
> > > > +     .reg_bits =3D 8,
> > > > +     .val_bits =3D 8,
> > > > +};
> > > > +
> > > > +static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
> > > > +{
> > > > +     const struct i3c_device_id *id =3D i3c_get_device_id(i3cdev);=
 =20
> > >
> > >                                          i3c_device_match_id(i3cdev,
> > >                                                              st_lsm6d=
sx_i3c_ids);
> > > =20
> > > > +     const struct st_lsm6dsx_i3c_data *hw_data =3D id->data;
> > > > +     struct regmap *regmap;
> > > > +
> > > > +     regmap =3D devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regma=
p_config);
> > > > +     if (IS_ERR(regmap)) {
> > > > +             dev_err(&i3cdev->dev, "Failed to register i3c regmap =
%d\n",
> > > > +                     (int)PTR_ERR(regmap));
> > > > +             return PTR_ERR(regmap);
> > > > +     }
> > > > +
> > > > +     return st_lsm6dsx_probe(&i3cdev->dev, 0, hw_data->id,
> > > > +                             hw_data->name, regmap);
> > > > +}
> > > > +
> > > > +
> > > > +static const struct i3c_device_id st_lsm6dsx_i3c_ids[] =3D {
> > > > +     I3C_DEVICE(0x0104, 0x006C, &hw_data[0]),
> > > > +     { /* sentinel */ },
> > > > +};
> > > > +MODULE_DEVICE_TABLE(i3c, st_lsm6dsx_i3c_ids);
> > > > +
> > > > +static struct i3c_driver st_lsm6dsx_driver =3D {
> > > > +     .driver.name =3D "st_lsm6dsx_i3c",
> > > > +     .probe =3D st_lsm6dsx_i3c_probe,
> > > > +     .id_table =3D st_lsm6dsx_i3c_ids, =20
> > >
> > > You should probably set the pm_ops here (st_lsm6dsx_pm_ops).
> > > =20
> > > > +};
> > > > +module_i3c_driver(st_lsm6dsx_driver);
> > > > +
> > > > +MODULE_AUTHOR("Vitor Soares <vitor.soares@synopsys.com>");
> > > > +MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i3c driver");
> > > > +MODULE_LICENSE("GPL v2");
> > > > + =20
> > >
> > > You can remove this blank line.
> > > =20
> >=20
> >=20

Best regards,
Vitor Soares
