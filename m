Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA96DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED4120811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 11:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfCHL3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 06:29:24 -0500
Received: from sauhun.de ([88.99.104.3]:60650 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfCHL3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 06:29:23 -0500
Received: from localhost (p54B3343A.dip0.t-ipconnect.de [84.179.52.58])
        by pokefinder.org (Postfix) with ESMTPSA id 522972C3F83;
        Fri,  8 Mar 2019 12:29:20 +0100 (CET)
Date:   Fri, 8 Mar 2019 12:29:19 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jun Gao <jun.gao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-i2c@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        qii.wang@mediatek.com
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to
 i2c_get_dma_safe_msg_buf()
Message-ID: <20190308112919.GA1674@kunai>
References: <20190215090202.157100-1-hsinyi@chromium.org>
 <20190215090959.soxkf3ho3or2geme@ninjato>
 <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
 <20190215092500.6q3hqnoufyowiqaz@ninjato>
 <20190215163657.fs6t7p3vqez53su3@ninjato>
 <CAJMQK-jzvMBD_AaB7XMJtMqNWiEin25bem4Zo9T5W86Z-U=Tww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <CAJMQK-jzvMBD_AaB7XMJtMqNWiEin25bem4Zo9T5W86Z-U=Tww@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 02:04:11PM +0800, Hsin-Yi Wang wrote:
> Thanks for the solution.
> Previously we were testing if the driver can handle zero-length
> transfer, but it turns out it will timeout. (Also checked this from
> mtk's datasheet)
> Adding original owner qii.wang to verify that. We'll apply this after
> verification.

I just checked this issue again and concluded that both are reasonable,
the suggestion from me below with the adapter quirk AND your original
patch setting the threshold to 1. With my suggestion the core will
prevent 0-length messages. But still, we should set the threshold to 1
because 0 is a value the HW is not capable of.

>=20
> On Sat, Feb 16, 2019 at 12:36 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> >
> > >> > Ok, I can add a check in another patch. Should we return NULL poin=
ter
> > >> > if msg->len is 0 or print out some warnings? Thanks.
> > >>
> > >> No warning, msg->len =3D=3D 0 is a valid setting. But interesting qu=
estion:
> > >> I was about to say NULL, but your driver would assume ENOMEM there a=
nd
> > >> discard the message which is also not correct since msg->len =3D=3D =
0 is a
> > >> valid setting. So, should we just return msg->buf then? Will this wo=
rk
> > >> with your driver? Can it handle zero-length transfers?
> > >
> > > dma_map_single(i2c->dev, msg->buf , msgs->len, DMA_TO_DEVICE); breaks
> > > kernel if msgs->len is 0, so I think it doesn't handle zero-length tr=
ansfer.
> >
> > Please don't drop the lists.
> >
> > Then, the correct solution is to forbid those transfer with this
> > controller. Check I2C_AQ_NO_ZERO_LEN. Also, update the functionality
> > like this .. (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK).
> >

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyCUgsACgkQFA3kzBSg
Kba9Yg/+M7cbMDhNMb4QMvsx2CXavB/39rfypl8ZMb3+9ie+XUgHO69Eni+lZyyn
z8TcGgTAoQaYepbdDLMgQdrppkIf+JdZPBLoeFQ+Gom9c6qGME0ib8bc+ZltG9BV
INl6N9P3ZtRSjccRcGGcicjQGi32ctmYYqwr82tXD9xDuaOYM1Mch9Boet7bnsj8
vaO/CmVHhg7dUjx/TZAVbvHmhcG6GudqvYEbBZM5kwinZzy7O78usan9imr2saYC
c71Tij0lTgoEVhEqZac+166BZccT8qXaJPYs8t9Vclu5PmKkeuU+lSzMsBAdiQcJ
U1YbFIH6xPa1up1o53AcSsHeaZmKI/X6ph9g7MuqqLFvej8MbfXIz9Swix3kjiOd
yzYyqPdqOyl0bQ5k8DJI9XT2phnOMixHHlhwn2n9TGDFQpfOh5kUqJ0bn9Qc/ydt
eR0c0Sj3CQDQQk6RyJOvv+svdsknVBHgL8md7rsu3PRnPXJrnNAEvf4L+QFLNhpj
Y6WshPVyqbhUt3V/sXOUVyhBMX5j+I8KPvlSmtYQZxpx0b58EzUduk5spdjy/x/o
KVvwXFuGCNSWB9Hhb/nKPNcwyVd7w+EhqOgdKK+Uz8dsar14UBTy7NDrdxvQ4WBj
rE/ZTfbfK/lFppbEx1nIDGtlse1TJW92mHYfM+2SzkDaHtw6lqM=
=Q2xm
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
