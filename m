Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A14C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FF32087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfCHOwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:52:06 -0500
Received: from sauhun.de ([88.99.104.3]:33842 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfCHOwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:52:06 -0500
Received: from localhost (p54B3343A.dip0.t-ipconnect.de [84.179.52.58])
        by pokefinder.org (Postfix) with ESMTPSA id D16B02C3F83;
        Fri,  8 Mar 2019 15:52:03 +0100 (CET)
Date:   Fri, 8 Mar 2019 15:52:03 +0100
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
Message-ID: <20190308145203.GA4743@kunai>
References: <20190215090202.157100-1-hsinyi@chromium.org>
 <20190215090959.soxkf3ho3or2geme@ninjato>
 <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
 <20190215092500.6q3hqnoufyowiqaz@ninjato>
 <20190215163657.fs6t7p3vqez53su3@ninjato>
 <CAJMQK-jzvMBD_AaB7XMJtMqNWiEin25bem4Zo9T5W86Z-U=Tww@mail.gmail.com>
 <20190308112919.GA1674@kunai>
 <CAJMQK-j9b3o+KQfN8nLXGiP+TXi8i77=yTTQsEARa6cotPhxzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <CAJMQK-j9b3o+KQfN8nLXGiP+TXi8i77=yTTQsEARa6cotPhxzw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > I just checked this issue again and concluded that both are reasonable,
> > the suggestion from me below with the adapter quirk AND your original
> > patch setting the threshold to 1. With my suggestion the core will
> > prevent 0-length messages. But still, we should set the threshold to 1
> > because 0 is a value the HW is not capable of.
> >
> I think quirk might be better, since mediatek said they might have some ICs
> that can handle zero-length transfer in the future, so flags might be
> more clear if they want to restore functionality.

But I guess you don't want to do the zero-length transfer with DMA then?
With that in mind, raising the threshold still makes sense to me.


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyCgY8ACgkQFA3kzBSg
KbZ2Qg/9GaOmyLxHs9ayEmGtGSYNxgpXmj+fMfBqvL2OlsSPG8EDNtIs5n7+p7Lq
gPz2Tm0EnnCkIWmpp4EFhON17ZkuIVthAO7lMTacqk6lAxMqP2d5qtbtTllHerdZ
2whXvhfxEOobWGDQoxstTv/mgSLckRaltjteITi17UqFdRAQsIJOerJ+MY9QOFrt
xi+bDnwiV8YEsgRX9iWSUx3kKPel+n36oiAY+5/ONHE1+R5KOmdGHpRPHTzhB99Q
sn8XZe2hGPKNbF/j3RdDOmO6Qbd5jlWEg7IlHnqJx1Bbi2rJfEqPG/Z6kcI+lE8l
gUPlYlS2VMLZ7D6td11AVgBAThDjlguVzzVr0vf/kKBXRojRf3rNd6AQDg46TSE4
5k73pVpD2G1mnlbryQKG2tQOw1XB8CCIfgRQA1AquCoUdwrPZAdTYD9V7qdqkW7y
9OWwM/bmkEZHpnpUZNxxGBKuGoTIOOmhAIgjMpKw1/z2iIm3cZM/T/J9wRCH70Jr
1cRwRSUgz2SgrqZ2SjGC/arXgyhUCv6Xtn1XXRRr+dnhOVQGynfls0ooNcLO6O9V
TlrASHvc5wmXTtYr3QIeytDqwmbZmj7H8LtItRlTAz2XH7zTkfDHEijW9HAMJ0zu
3k4PWLCIwV93n3127uNNwXGpUTHlhgxWlIwVR1WsLOsreLblXZY=
=7FL8
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
