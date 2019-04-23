Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803A4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F2621738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izQEzvyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfDWLJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:09:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44196 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWLJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:09:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so10808306wrs.11;
        Tue, 23 Apr 2019 04:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6QZMY5ROdo/Gy/xV4SfQ/GodT/ILdhdEoATuAI/JUBM=;
        b=izQEzvyQapGVzbVCsuAWXcwX3+XBMZhBqnxKUWb0MygBJPmzKraWK2RQ2klsXB+oy3
         Lk+GTDjnaLEXrMB0KOXmTk0ivz5ml/9d2NkHt5TQ3maxR2ewyPze+XTbZhcz6KWTDGwA
         K8Ri0Iz1pa6J897/9kxg9GY1eSjmz8liWAZvZPirN/wUlg//iZFYAUk6NWBxjd8pzWLw
         2z6kATVp6hl0KZiXc6TCfn5y/E9RbeVxncJy5h/B4QIOcpUdxG5FUL6Gc1gE/LFAvgZR
         JF3MLEf5vY3DYWQD7z4ekf/bVyghk+4bqspl/IObTOOo5qEQxKcoMpkfyAo01ljUl6SM
         N0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6QZMY5ROdo/Gy/xV4SfQ/GodT/ILdhdEoATuAI/JUBM=;
        b=BXGwUJlmev2Qomrn8XIMuaeehZv1C/q+a4WZSrDGPcWvTEknAWZ1uFToq8o/q9n6FH
         LuWXl1KGXXV31RRP7jMeXFQ+ktlHaAKz+nu5TQ+nWj6z0fzmh6tatW7BotG27Gripl0A
         EVp/2u6PxeOUccQepAv3lSmhzAVEORuRUkhRWmK5QQM38FqwtjYaxNGqu36kFauVT0ct
         56znFEOGuqCobieeOVOOPqRZGL1jIcgLK3qrP02QLkg3OVAWaGUIvkIuWRAZ6Pw+lzGM
         dH6ndrzkELXNwNxsVJoinPCSZRnyF+0Jb3eqj8G7c0J1zAsDTh0jeecf7clYioAW4EEj
         Oszw==
X-Gm-Message-State: APjAAAWxKq/1Dbj14XPQl9+hTfuP5XjC6DIkIx+b5N1unNopfDEsHIdV
        FqTWVFwhMivMRYWvxkMYGsk=
X-Google-Smtp-Source: APXvYqxT3nvnlxV4Yp06y1WbJz+mbbpn0jdsRJ6LFXavgu3mCriz0aRGHiwBwhCjryGMYyB5Vi2/sg==
X-Received: by 2002:adf:eac9:: with SMTP id o9mr16781510wrn.85.1556017747846;
        Tue, 23 Apr 2019 04:09:07 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id u10sm15019380wml.32.2019.04.23.04.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 04:09:06 -0700 (PDT)
Date:   Tue, 23 Apr 2019 13:09:05 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, m.szyprowski@samsung.com, krzk@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>
Subject: Re: [PATCH v4 1/2] dt-bindings: drm: panel: Add Samsung s6e63m0
 panel documentation
Message-ID: <20190423110905.GC23448@ulmo>
References: <20190222175153.20567-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <20190222175153.20567-1-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 06:51:52PM +0100, Pawe=C5=82 Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
>=20
> This commit adds documentation for Samsung s6e63m0 AMOLED LCD panel
> driver.
>=20
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes from v2:
>   - Added Reviewed-by
>=20
> Changes from v1:
>   - Add missing subject prefix
>   - Rename reset-gpio to reset-gpios
>   - Add link to spi properites documentation. They're required
>     for driver to work
>   - Removed delay properties, which are now hardcoded in driver
>   - Removed display timings, which are now hardcoded in driver
> ---
>  .../display/panel/samsung,s6e63m0.txt         | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsu=
ng,s6e63m0.txt

Applied both patches, thanks.

Thierry

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly+8lEACgkQ3SOs138+
s6E22A/+NmgPdR2i/5NmTD2zUY3s/+jsr1LblOwQ+y2Yz1pZmdKfQNBscZgN3YpU
/rlWw0kfOk3rNXW0p50jVUbDpxWJfKd8dmZyElBroJ4/v6BED1U/yRojxE30Hgjt
ACw1i9awfm+vS3vSfdpQ6HYl/vtMjsCW9Y0puQNgQUk8jIrEFWDgOjLP4JlsKmRe
AKWVjE9X37X3M3i+HaygNA0SbZCMQ0RL2MWv58cbkbO3fgZdukPvvyvz32ivFb1t
tE4X3Ws94iJ/M8qY3ndScmE8t7hrG3TDBz+zyngZ8KotvqLkRtNmiV9FXiKM0+Oc
vSRcSyQrvSpjEaG9OO+HrGammzuOxLROR80dRGuG03G3lONQiZaFzbBkPy6EAeUh
jZw3HoPaE6uu/2TuY1esGxCiwu0ky6WLvBObWrLmnQDu15R3h6ugd0gyctCED8uN
/JH8T+bgMs6rAtoPANuPEr8doasGCf4rxHEYBmGJqGsqwD28BvLpj2q2ABgN4+07
eJQCQq9SoM1I0qynUkZejWoifFjcfA3JHDaB24YXUGBP5GdrShf7hZbXOU5q+Cof
PvfewrMOxuijjul8rtVwk0kaA7FZb3NLV4UmFnIThrPGHoO5RzSv6eOZxk6wkcFh
0UKggDY9C4lzlfaigZSXuRwYeqCygo+ukT0KONxxGWHgQljNBZE=
=UaPE
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
