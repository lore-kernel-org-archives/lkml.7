Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF90FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F09121928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFfug13x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391360AbfJPQDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:03:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41353 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbfJPQDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:03:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id p4so12837887wrm.8;
        Wed, 16 Oct 2019 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8tAzClyAvZpUSFyKG/Pk8kSHQbTC3odRRyjL8/E0mfM=;
        b=jFfug13xCcYliAOTf69yFMA+Mvkx2HeD406hyp5ifiYivCZzu8FiEQT3ZOpIA84Chh
         0FY/HX9TwYPGyTEeUFsmmggPMZkAeFiG7Mt4J+SLrc/qAi1T4SS424uou1WjRSTZ7EQQ
         Gbyp1NXVXQuh79XtuibNDc5/Ou8lTJw6yK2JcU1D8HG63Vqji3b5xuuZuL/Rq88D6CFR
         Wd3wCrt2IC68NbIpkNs9YfOTh5J1lfRbz/gPmizn3QI2zP5n4DcmmA+xp0UIxaw//Y0A
         +GGLOSekVHF5TjrTBJUknP9lKJsE2DHQyId85UBAjdqcEB0Z5M28/30pAlLX8aw3/OWp
         ZBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8tAzClyAvZpUSFyKG/Pk8kSHQbTC3odRRyjL8/E0mfM=;
        b=gPksQ13wo9CFmRQuNgEXyQxLyc7E//fi+XmXZn5QXz0mp1tU82aAPugbHjoIMpBpGi
         9hc1BNyEdttIW6wOnF5PeBAz1JuMW/sehGuIUvWKF15FH1hKz7qrl/0eQabNF6ExYcpq
         Uk3iB0XmMQ2JE7am1y2uJGoJp6JICGUd1gXT6ch/heX+7NyE7N6sDIRuTpOBazKXT0Gz
         tiy62tPNbATny/OR54cmaAP/4gR+oioOEvDC2JR6GuJO5FyDryhnnpPgdolo1lFMwcZP
         qOBb+m2j8pFdG0PhnKQcwqCtf1xR52v+uJXF5EP9PdUiwHGcUepiT+bVT4nrP542w52C
         rx8w==
X-Gm-Message-State: APjAAAX4YcHlTtgOzG2P0mLKJu+Kx+LlyWv3FHbVM2Fl1NfwiS6qnByX
        lu1XB8o9TZbU7p+Z0k/dxik=
X-Google-Smtp-Source: APXvYqx2fq3WUjV1DN0JFZChxKVkSK4kwdX+hTuiRYccS4yHQC2WgV0minWbd47ga5S1YMqawMGn6g==
X-Received: by 2002:adf:c641:: with SMTP id u1mr3427669wrg.361.1571241832723;
        Wed, 16 Oct 2019 09:03:52 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id p7sm2684570wma.34.2019.10.16.09.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 09:03:51 -0700 (PDT)
Date:   Wed, 16 Oct 2019 18:03:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20191016160349.pwghlg566hh2o7id@pali>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
 <184209.1567120696@turing-police>
 <20190829233506.GT5281@sasha-vm>
 <20190830075647.wvhrx4asnkrfkkwk@pali>
 <20191016140353.4hrncxa5wkx47oau@pali>
 <20191016143113.GS31224@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xtpjukghalsmqwao"
Content-Disposition: inline
In-Reply-To: <20191016143113.GS31224@sasha-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xtpjukghalsmqwao
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 16 October 2019 10:31:13 Sasha Levin wrote:
> On Wed, Oct 16, 2019 at 04:03:53PM +0200, Pali Roh=C3=A1r wrote:
> > On Friday 30 August 2019 09:56:47 Pali Roh=C3=A1r wrote:
> > > On Thursday 29 August 2019 19:35:06 Sasha Levin wrote:
> > > > With regards to missing specs/docs/whatever - our main concern with=
 this
> > > > release was that we want full interoperability, which is why the sp=
ec
> > > > was made public as-is without modifications from what was used
> > > > internally. There's no "secret sauce" that Microsoft is hiding here.
> > >=20
> > > Ok, if it was just drop of "current version" of documentation then it
> > > makes sense.
> > >=20
> > > > How about we give this spec/code time to get soaked and reviewed fo=
r a
> > > > bit, and if folks still feel (in a month or so?) that there are mis=
sing
> > > > bits of information related to exfat, I'll be happy to go back and =
try
> > > > to get them out as well.
> >=20
> > Hello Sasha!
> >=20
> > Now one month passed, so do you have some information when missing parts
> > of documentation like TexFAT would be released to public?
>=20
> Sure, I'll see if I can get an approval to open it up.

Ok!

> Can I assume you will be implementing TexFAT support once the spec is
> available?

I cannot promise that I would implement something which I do not know
how is working... It depends on how complicated TexFAT is and also how
future exfat support in kernel would look like.

But I'm interesting in implementing it.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--xtpjukghalsmqwao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXac/ZAAKCRCL8Mk9A+RD
Up63AJ9RWDz74lfxmFMyPt68AQrr18x87wCfW3K+Im689OPplqjLk3mnz6YAHp0=
=8o6F
-----END PGP SIGNATURE-----

--xtpjukghalsmqwao--
