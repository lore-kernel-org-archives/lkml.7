Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DC1C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2A22075B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ahHovQee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfG2IUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:20:12 -0400
Received: from ozlabs.org ([203.11.71.1]:51569 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfG2IUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:20:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45xt0T0bbFz9sMQ;
        Mon, 29 Jul 2019 18:20:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564388409;
        bh=lfCsp2hyEGbThOuKiVn2hk/tp0U4RSwPC4uVbmrp4+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ahHovQeeaULp+5VAO21mDQCeuM+kRFe+h3BeWyrmggs8jiv5t04aCiasQeP5Kqf6q
         KTUfvAmCd46PRvFHrfiUJkaVCFzPU+8UqfQ9NfUTmc0H6HcQ+1yARdQN0sARCdBkyo
         hghBGxpVWXri8x3Y+Ru1uL57r0dmP61ghGSjOP5AxpLLnQf+7Ho9ps/WGNrlpnsaB3
         rd3muM9d4Zy+ubff6Rftnq8+blYMnc4gjgd975i6Ib/AWGFEohQXkPo8O+KWBuyk0t
         Hp49Tsi0Tnt+8YJ4DZKJkbOPiLjfxBuSYoN0uPW29WpnXZ5bZYpGHQEpH8HCmnBjp0
         rPRnipA5Xhdiw==
Date:   Mon, 29 Jul 2019 18:20:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of Linus' tree
Message-ID: <20190729182008.14e75363@canb.auug.org.au>
In-Reply-To: <s5h5znlpbdt.wl-tiwai@suse.de>
References: <20190729140404.37bac29e@canb.auug.org.au>
        <s5h8sshpbt3.wl-tiwai@suse.de>
        <e96cf8a57c4633e807cfe82762397ad15ba19ed8.camel@sipsolutions.net>
        <s5h5znlpbdt.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xLdHkpy2Q+DQ.V63y1ZCW0m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xLdHkpy2Q+DQ.V63y1ZCW0m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 29 Jul 2019 09:07:10 +0200 Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 29 Jul 2019 09:03:14 +0200,
> Johannes Berg wrote:
> >=20
> > On Mon, 2019-07-29 at 08:58 +0200, Takashi Iwai wrote: =20
> > > > This warning has been around for a long time.  It could possibly be
> > > > suppressed by checking for errors returned by onyx_read_register().=
 =20
> > >=20
> > > Yes, or simply zero-ing the variable in onyx_read_register().  The
> > > current code ignores the read error and it's been OK over a decade :)=
 =20
> >=20
> > Yeah, it's pretty weird that it never showed up before. I was wondering
> > for a minute why I was CC'ed on a sound merge issue :-) =20
>=20
> Maybe switched to a new gcc version?

Or the number of warnings in a powerpc allyesconfig build got low
enough for me to finally take notice :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/xLdHkpy2Q+DQ.V63y1ZCW0m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0+rDgACgkQAVBC80lX
0GxVAgf8D0EY4Nfw7dKIsnd3Y7YDBwfuf6QepZ0jE9uI0NnRS2ZZPL9Qg4XCFgKz
+3ulymA+/foqRjmboDtrPUJMyLPiFJfiFOT6Ik/ZXHzcnbnfV8sl6NcHRD8TvLvk
n6bKL+3+PSpujYrI5251SjM8RrN55N3/prTrrzswRdsqT1AwLItq1n/dKoCeD/pF
RQDf4IRgsGFWNjxyW82FIFsZiiPNJSLJkAFNlzgcOV0TZGtO/QwI/YMMiVJo+bXk
ZG9PcCBf+dr8ilpabis7TCBSloEu1nwK4qHjrAjRgaMft3gdJ2bhiohbBU9s16ID
bg33l1Xhy0cGDF1/5MNg9te5Bn2xPQ==
=52Id
-----END PGP SIGNATURE-----

--Sig_/xLdHkpy2Q+DQ.V63y1ZCW0m--
