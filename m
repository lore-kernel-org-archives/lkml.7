Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8FDC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8A72080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfr+9nhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbfFSITL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:19:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35112 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbfFSITL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:19:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so2338558wrv.2;
        Wed, 19 Jun 2019 01:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U3gkqf62duv2S4qSk1BsXgc5+0V3FIYM46LS2IA6yQs=;
        b=jfr+9nhjeEd4uQ9NwNDroJQh5/RYgb0XNyMXQsp4ztuyl+Z+Yoi4pCbzdfY2HGQ0Xi
         ZkXNtdojFufisTBaOUG7c8uuf2/0xkx+8TGAPVB1AHW5Kz30SEfREp1n6vYIZ8fweLxE
         E1eLxF+1Vr4RV4aeQ0Ac8MLZjdjMCJ7sO0iD6dREW4VeO9WXg4K9Q/w5Hxh6NHcaORWD
         4b4RHenPrd82g67BPLaRyV6GpaLorQyfP25u6KVlTkZU43IWARVyioyo6+aSaEN23yU8
         u6v/bD9tlFec4bSltYGa9Qf/f7zN6G8+teirSHKNvnyJCLN/64z2MCbSP0Po561dzBD2
         QNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U3gkqf62duv2S4qSk1BsXgc5+0V3FIYM46LS2IA6yQs=;
        b=uLDR5h9dqp0zDhNVlzzWhWFQgAwEPS1dx2wkWWwmi82j6CqADvD41zcTbj3ET3YzLe
         bENiW5x/kc84lfxBKfSLlhV3FrMOVQ0/8Xowbs8nb7fRIID2PVWaBdFdBEhagEgzsv+V
         7CsJfrqg5maRwEaYLlGpuYBFoeuTAlLkC3TSRr9EsFNWIU4GiLkC3OyjXwjf05klwdzz
         5krA+pWJeuJLIqwvHUeDBOC7rpI5ZmzrUb6X56fxGqTA7imzpuwGZZZw8K8vDwFpPL3W
         h4NvJlNnt5VC2nws8zSCjWR16mpvXv9QzLJFfAxMMyz2yPQXn4H3T9EFjVf/IqIkcVQ8
         bxvQ==
X-Gm-Message-State: APjAAAU78A59ObNrp39r8niARITRKZMU14EzSCNzzSTdJjDV/4Hk1XSl
        gvBHdQn1YuZQdgDQEHsR/CI=
X-Google-Smtp-Source: APXvYqzUB4hndteZjD5N5cStYXk9IfEV5ewFnpa/8N2dKEIGetCAYwLz5iXHlyhH/oyc43iekMhKKw==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr7692444wrq.143.1560932348782;
        Wed, 19 Jun 2019 01:19:08 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id y2sm14930708wrl.4.2019.06.19.01.19.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 01:19:08 -0700 (PDT)
Date:   Wed, 19 Jun 2019 10:19:07 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] clocksource/drivers/tegra: Cycles can't be 0
Message-ID: <20190619081907.GH3187@ulmo>
References: <20190618140358.13148-1-digetx@gmail.com>
 <20190618140358.13148-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dMyqICaxQaaUjrCL"
Content-Disposition: inline
In-Reply-To: <20190618140358.13148-8-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dMyqICaxQaaUjrCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 05:03:57PM +0300, Dmitry Osipenko wrote:
> Tegra's timer uses n+1 scheme for the counter, i.e. timer will fire after
> one tick if 0 is loaded. The minimum and maximum numbers of oneshot ticks
> are defined by clockevents_config_and_register(min, max) invocation and
> the min value is set to 1 tick. Hence "cycles" value can't ever be 0,
> unless it's a bug in clocksource core.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--dMyqICaxQaaUjrCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0J7/sACgkQ3SOs138+
s6G7MA/9G+CmXx9PZo3EMnR8P9HXMQopYOOzkDGXiZBqCTuZDW4Q+6YD5TXMXi0d
qcwWbqbB4vMcTqGZcIiBGKWMqybDx/KwmiZMugif+8em3lF5zcwsCQE/KUv6Imk9
LgKNB7lkMT12luQLydhUx5VwWFRLGtX7do43iR0MVxzqQlsArsstsBlU7YZYoOr/
QgCnJ+/MeqggTBv/DyURec7wDHcWBBWyrojNE07zPOVE2mMk661ayT8otdD8O4Il
vIore5FVcks3m5zrdTNgx5kb93/KYrlqF6XYED9HIY2a5cHRt3Fo46ykiiBrVgY5
rF9PoHd9KNRSZ5pDg2PbSZZLlOA53BLIneK6rEazlsHkOKUhMaX80Fse7HHUC4sO
7sdiHgn3FJIJiypxDyGK1dDQdPCsgboi4whEMU5ROemnDSgxKh2uCDEExa+Z6Fab
wxJMTNvQoxk6YJXg7sBRbhUCwCrBIx89RJY6pElZk5Ki/zSJyM502KZxxXCUeUG6
G/oHwQt53tkwwsW/6SdSrCuFCUGbY0T1g/GvoUulU3tCEt/gaExPoKGY0h2oLlY4
1j9Fsa3AG8yya+ZkQlVXtxofrV6S4P5C0sUuJ9+L6jaXvc+nHKoyav5j42O/YfAy
PsmucZmlDcK+6w67YJKd1cOYTkTpkWKb7cctNHIIcv4Ruq5US9M=
=vn0b
-----END PGP SIGNATURE-----

--dMyqICaxQaaUjrCL--
