Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B3DC32753
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA15208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565607690;
	bh=9/oTI13CIV7MKyQ7xvdb2YbU6DDZNRNgpBJ0zvV0NWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gCKz4e3Z5nV/YGQC3vJQo36rPdy+pe6+NlJ2+IurimKxLxg5SOgIuIOubTfPSV1c/
	 jqgZgQGfKmt3quSPmNKuwURqb8wZUMsoWAbZkJkpmPfafslv47Hn0Lcgjc8fUb2F8+
	 Nzsb6L1ux/0wzNST0dX4V8rZe4MVupXUw7RtWMdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfHLLB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:01:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49444 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfHLLB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jvTQU0/ncqqXZDApf5L3Jww+4/vfyT4p+hACaV7a4bM=; b=kkqMmOPduW+sLbd1PSVVdomcK
        Zkfy5Q6CbT3E9jxZYRj6CawNRtzGVSoW+0Z4abnGmutl7WeeYJFlKlRbNxR0meLNSCeIb378NCWxR
        d3Ms2GYtWOqD6r6VMQWwgNViFFJVaKVhyt8BwRuycxEk8oEo8InmjCfvzIsFF8h8BMOFQ=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hx84W-0000yA-VK; Mon, 12 Aug 2019 11:01:05 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B6FE127430B7; Mon, 12 Aug 2019 12:01:03 +0100 (BST)
Date:   Mon, 12 Aug 2019 12:01:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v4 0/7] Allwinner H6 SPDIF support
Message-ID: <20190812110103.GD4592@sirena.co.uk>
References: <20190527200627.8635-1-peron.clem@gmail.com>
 <CAJiuCcfUhBxEr=o7VVpPROQZadQh7z1QC0SkWSYt-53Sj3H2qw@mail.gmail.com>
 <CAJiuCcc3_1jZWV7G3+fFQYRZ8b6qcAbnH+K6pkRvww6_D=OMAw@mail.gmail.com>
 <20190715193842.GC4503@sirena.org.uk>
 <CAJiuCceYDnyxRLLLLy6Dn6DLTZ+NmSaUnoX1Vmzvgiy0XvF_Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline
In-Reply-To: <CAJiuCceYDnyxRLLLLy6Dn6DLTZ+NmSaUnoX1Vmzvgiy0XvF_Fw@mail.gmail.com>
X-Cookie: Decaffeinated coffee?  Just Say No.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 10, 2019 at 10:45:23AM +0200, Cl=E9ment P=E9ron wrote:

> Hi,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> Sorry, I just discovered that the ASoC patches have been merged into
> the broonie and linus tree in 5.3.

> I'm still quite new in the sending of patches to the Kernel but
> souldn't be a ack or a mail sent to warn the sender when the series
> are accepted?

Not every maintainer will send those, I do but you might find they've
gone into your spam folder if you're using gmail.

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1RRu4ACgkQJNaLcl1U
h9BDaAf+JGgo/qiKbJdNE79u2FwpthOgmKAEpcOVw6Z0Lrx2YvRMtW86kCYYDdmh
La5nF6FUWArR10NnVlhJNeSshE4iSF8iGIBtN/lNJGzb3mprdBrCReGkJzcGoHdI
LnpzXGf+ixSv5om2cqAGZ9a6Wh0l4uNdigwEmH3fNv+K+HT4jdO67g78VFHuaB96
mNlhbXTJ36FtGR6ZNiXjpbzCsRiRwT4r0WtGIoEYO5uPzL3zXV467CbGKmMBpjbD
XlUl7rNzdCRu4eqmnQNVFUcToCt4ZVZYGUZmBrIFS1FW7LVaGQRAjf46gC4WEq/R
Ui9Pyp92dWkr76RNhU29bXkdhz8tcA==
=uNoD
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
