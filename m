Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA1EC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A244E20830
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fflNlJ8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbfIPNt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:49:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36744 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733128AbfIPNt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:49:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so38982486wrd.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/NPsPj1awstwEtbeOu7moJJbL2ezBiFpC0Ki5LS8P+s=;
        b=fflNlJ8lJ60ejk7+T13Q78OrBQh1gYWQCS1F1lOJyhIrSjMemFYFV/ePr4IHxww7wk
         GhGHLlsvszDJUdF8tkGPxYeNV1nYtYterQLQRrX5GtXtj89lV/AN9tK9zEc7c60d9lk6
         xFvUJUXfTr+2Nw37eN1If1tRc/YltPfobrS4jEk+DtUTOy/Eu33Lhinp1Ddk1IH72Lpl
         L7TC3pUX81PSjp3Sunm+C4/uIW/6K/+GNGk772oY9lDwM5hM3+xlBIrTs6FJmeW0P5dy
         q+//hbUpc+bZwI1N0P/Fn9cJ7uukjkHlRT28FQlNKIq+ZIPiw4DeE0t+6XPP6IuPNZw3
         zP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/NPsPj1awstwEtbeOu7moJJbL2ezBiFpC0Ki5LS8P+s=;
        b=JCxzrE2G+UnnHLQ4M8X2OOfdoSAplsnvvoXmMvhAw9nGym9nAMX5FbW1uNcwHXvhu3
         VE/h+WLa4tlVS0JvBkqxEhbkTfHNisxkFEikUBT/vhihXF2X1AZK0giU+d8eeElFtuTM
         7aFaGIOZ6JRKVr3lXY37eDTENuXdHrHhmDYKRSChhdZenKEXdk1IRroQkhXCN8lsy6L6
         23qRNuz8ZG3OT/ZA/yA7CDWQ+s/4GfHxfQNEHCupyC03zFGRsb/YOtcWO2m7BFb4h/Hd
         nJZxjTqqWSRSNiKcVv/FIcT8e5knHp6Jv0snq65geudS1+66w9sLFQIPKnTeFEZOl0U1
         gB4w==
X-Gm-Message-State: APjAAAVqU8C57zPuCFWvUU+YgukcbXVpJfloECCHg6Aj37rooGB+MueW
        TYrAP6Ssvx4/VEw2OeshaAQ=
X-Google-Smtp-Source: APXvYqwYGuFHyOnyPqHGJsh88x9YZDphC9WMSwz9ljoOj11Il80UrjNM46ouviozaiWNYy7L1RgGAg==
X-Received: by 2002:adf:e603:: with SMTP id p3mr28941971wrm.102.1568641764073;
        Mon, 16 Sep 2019 06:49:24 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id g201sm15984235wmg.34.2019.09.16.06.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 06:49:21 -0700 (PDT)
Date:   Mon, 16 Sep 2019 15:49:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/6] ARM, arm64: Remove arm_pm_restart()
Message-ID: <20190916134920.GA18267@ulmo>
References: <20170130110512.6943-1-thierry.reding@gmail.com>
 <20190914152544.GA17499@roeck-us.net>
 <CAK8P3a3G_9EeK-Xp7ZeA0EN7WNzrL7AxoQcNZ8z-oe5NsTYW6g@mail.gmail.com>
 <056ccf5c-6c6c-090b-6ca1-ab666021db48@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <056ccf5c-6c6c-090b-6ca1-ab666021db48@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2019 at 06:17:01AM -0700, Guenter Roeck wrote:
> On 9/16/19 12:49 AM, Arnd Bergmann wrote:
> > On Sat, Sep 14, 2019 at 5:26 PM Guenter Roeck <linux@roeck-us.net> wrot=
e:
> > > On Mon, Jan 30, 2017 at 12:05:06PM +0100, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >=20
> > > > Hi everyone,
> > > >=20
> > > > This small series is preparatory work for a series that I'm working=
 on
> > > > which attempts to establish a formal framework for system restart a=
nd
> > > > power off.
> > > >=20
> > > > Guenter has done a lot of good work in this area, but it never got
> > > > merged. I think this set is a valuable addition to the kernel becau=
se
> > > > it converts all odd providers to the established mechanism for rest=
art.
> > > >=20
> > > > Since this is stretched across both 32-bit and 64-bit ARM, as well =
as
> > > > PSCI, and given the SoC/board level of functionality, I think it mi=
ght
> > > > make sense to take this through the ARM SoC tree in order to simpli=
fy
> > > > the interdependencies. But it should also be possible to take patch=
es
> > > > 1-4 via their respective trees this cycle and patches 5-6 through t=
he
> > > > ARM and arm64 trees for the next cycle, if that's preferred.
> > > >=20
> > >=20
> > > We tried this twice now, and it seems to go nowhere. What does it take
> > > to get it applied ?
> >=20
> > Can you send a pull request to soc@kernel.org after the merge window,
> > with everyone else on Cc? If nobody objects, I'll merge it through
> > the soc tree.
> >=20
>=20
> Sure, I'll rebase and do that.

I've uploaded a rebased tree here:

	https://github.com/thierryreding/linux/tree/for-5.5/system-power-reset

The first 6 patches in that tree correspond to this series. There were a
couple of conflicts I had to resolve and I haven't fully tested the
series yet, but if you haven't done any of the rebasing, the above may
be useful to you.

Thierry

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1/kt0ACgkQ3SOs138+
s6Gyww/+K/pGweyEoA46/dAVNxy5Vcu6G8+VGLroSopzGQ4AagO4eAZk4SvXqWTM
A/Ig7+ORbGubvEVJWItR409xxLu6/eWNeZMgGaeeC7B3+X6dwG94uDPPP2JYVpKk
pDZ1VZLdP7GO3vGnehlH0V+o53iJ00HAebTNpYI4aUKDxrECapbL3idAPBny/ext
q1j+9nJxKkSw5SUQw3IF/PNBWJ7lF84r0wkwuZemObJDtdPllANlxmqS61uFXUVE
hZYr3rDzEZ/l4usVRJmwa/QMw8pWpt+eRTGxWedz8wmBw6K9Dmzz3EmvtI7a28Xc
fe1ARSsnh5d5tPN+uTy9GsjXzuX57hsXliWzkvcy10zWucGIvr7WtXyJdak8AuJ7
WxmKplq8Xt0I1qO5zQxwxkYRY5snwu0P82VE4mNuWSPtnb9vSb95q10k1C5elRpA
zOcSDHgiBmk8hOSX+DYP19kCzUduQHBDZhZyqbFGSkafGvw0/PQpBrYqy1nKu6rA
kivAJtIRc9t8QyTcBQ9nHccsMPkoNIa6sseXVPaFiQTQshBDvPpJ6HMSdYcfbohC
v9pGjGrjhMkXlK9Qur+R9NLDXkxoYWwA4D6BetGFo5OvD1uDXbUqyJBrDRf4xWmY
MHK8npnj+TyQD86KVEm0e5Zc/QwvRWTokAfsZM2f4QTRTUCp/WA=
=6fyR
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
