Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868F1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56658206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWRFX++Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbfDRJn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:43:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55175 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRJn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:43:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so2002592wml.4;
        Thu, 18 Apr 2019 02:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K0FLtOfXpWaZbif33VOkSsJZBPCbQPbqlBeJZqp/xKk=;
        b=PWRFX++Q9zE64Jqj/C/tGA5OgR5YHdJqlJ+NE3o2D2u21wGazt9ZKzg+4kLKvJEZU6
         LtHJWwq8ZZpHxL8k4/woLCThaz9j6/cWvxC9JRfl48+pVTxYbIlaQVgERf8CwvXN70VF
         sttKtVZF9YnLrTr1vuQJ4AGG1uPseZdFATuZvFhNk8S5MOgEqgeqyjlt/HHBHrM8eHHF
         eJ+m1gb5DVw2ZpeMAEAlqwtNLjv/OskSF0WSWiXhJVqFtij6eknCY5DVQmxdjhDM/NkX
         iHX2SUa2sn3d8eoIl5CvWKiOu59hZuxZL8dpykDiJ57QXdFAHMwe19H7+CZlqnOAzSMK
         n9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K0FLtOfXpWaZbif33VOkSsJZBPCbQPbqlBeJZqp/xKk=;
        b=QRXj55U/mEFJ3d+hhq+/IgxdMKUIKo82y9I5d9RtLLQfI04mtZdCZxpyve8WizZZhs
         u31IKci2xwsoxvkDIheRIVdgdGfUEVu4w3Jz3X9lAac3SmR5S37tHizpYgSmHNmITMAE
         lxh5CsdZYroyDolCQVLF/G92q/KQJrQMhoqgmqoacFsSsZsYZAaS7D7mq/Jtt7IXIKfi
         aoU4KLvx7qUVK+v24yvANX6rftv+7RP531ibXsFi8aOcGCPatGl4qzlM1bJnmLfMmEdb
         5UdYUU4N78zUzpfMxCnrgqu3Nq2sd5dUgGZvwZRYNOHn3diA4pT64MkcFMRSPcO16D+f
         lctw==
X-Gm-Message-State: APjAAAVoG0wwVw2ssqhypor576a9ZatomuKPUHhIk6BmvvW+p/9So1uu
        7rRn1Hk1lmzP4vS7ckEkHIU=
X-Google-Smtp-Source: APXvYqxykLV5XNFfmKoVR1ImnqYTe4ZWpzgVdQno2HnBJnn4EjMneGx37F2/2Tq1ChpwTuvBKW535g==
X-Received: by 2002:a1c:4056:: with SMTP id n83mr2333683wma.146.1555580635784;
        Thu, 18 Apr 2019 02:43:55 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id r18sm2654755wme.18.2019.04.18.02.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 02:43:55 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:43:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] ARM: dts: tegra30: Add ACTMON node
Message-ID: <20190418094354.GC26909@ulmo>
References: <20190411223042.25809-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <20190411223042.25809-1-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2019 at 01:30:42AM +0300, Dmitry Osipenko wrote:
> Add ACTMON node to the Tegra30's device-tree.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra30.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied to for-5.2/arm/dt, thanks.

Thierry

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly4RtkACgkQ3SOs138+
s6HXnw//cy1isrQsfetZ391dyHewlkERIHxtGrQde2E5DdQyyqezUpwnQ440u1A/
z69vskHEOfsL4xqxRcRkaWg6jVA6yQa6WrTd3B1ZuIVm766B/OpDXDPPmInGLJXh
cvXjNquWZCbt/QF3y9M4tne/T7Ix48w9m4mYAzCIvzg0myvzi/ijZEx6HlPcUqfI
OzgAKQeVcFl6Rc38VebMR0AZo4H4pwpdW2FCjPwUWojOMqP3R9jxcgF2TrxYk0S9
NNL7v8YPcb1SKI57zeC6hwmbrlPU/YRlc+K7LrMxk7aMSmQ0j9A5cCjEQr0KHnpK
gNjgLrnv1pk3+1fSuDsph0t/1d5n9qNt4fKe5tkjoSSVv7wSxyA+Zar5exOT13/s
db2MKFGLZC2QfLSF/1uRLQo8wnlhMPcatiTDZoptPeJXOjFPpaO1ACl7Joc78COH
SgDqCFBy2razhvIHtZ9M4MpIDPKOByyu+U1EW3R90dOjDBms6LHF3R4WXHiDjV4b
mF2n8Xy0xkW82yUKJb2/BprV2j59isszkd9kg296f86mmRcTnVAPsZrm119zIo6w
oFV3KRN8Ur0P1XOwQ3J7of1629yV7k+tY5xYrjtJ+q9R+/1WtJusszfq30h8syuT
fTwARTFlHCpybtPANPaE8ma2hZ2zXAIYIpTGm3tzAErwi4Mk1jI=
=9pCI
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
