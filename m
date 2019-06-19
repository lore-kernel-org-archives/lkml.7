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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEC8C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD822080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG/cdeQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbfFSISB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:18:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47016 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbfFSISB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:18:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so2254486wrw.13;
        Wed, 19 Jun 2019 01:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DXAWQaSJ1ixW7PhDzILHIAsJdU837VBRtLs/tC+aJeI=;
        b=AG/cdeQ7sGSui1N8sJ6Ze9HRZrvDAnhpwS4hoG5ZkkFcFKruwSdCoxT0DbKTtateKt
         WUXugu6fteePxe6bfVv+EKBzC+hs6cbG9hH2bOK0CP2QchBH7SbezN1gdSp/OmizioaQ
         oXSyaorTuP0MlheD75Rd+ChoJsjSP45T/qTNcqcW1aaBiI07g9XUdR5TapIoRHcvkGFr
         qCaDerNYa5mFbfg0BrJnE9An2bkNLLlF16ccoMC/k9FNE5FWwK0AEsJAlhHjXIyiu/71
         3XGsrPD6LDe9WjZpA5/70TY7SicJrhUS9NJZ2WzZ20EynOOC/pZB53MJ1EEU6SY07qFQ
         fHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DXAWQaSJ1ixW7PhDzILHIAsJdU837VBRtLs/tC+aJeI=;
        b=bbxtdvhUVMcdoMTGFBy3PFqQ3+4NSu1BJcI0DJN3D+oN+m07zkJoe0h1j0Yp2pAh71
         iuuEpHD2DdWoiYZeuW54c1bHvZJ1V3+tRj2XoQxKaHPmlXcSP/hrrkMO5e9IUtdK706S
         69DMN2Z8cAFq5vWlDLbWd6Gu1PuyDdWa4VEcaRnfe7VoAh/dzk70RfZ2efSpcjXdVG9v
         /tRTrxjw2TZMOTrGBJFS4zeMBSQtoVn5U75oKSLj/1+diap8M56UyS01fJJUiSQf7Iwb
         w5Kt/ffi8jEjevQlV/iTj+IYXX6UDIIR9x0Ebu3bKGfs9vKr0FzAjbLpoB3xgomA/yp5
         Xixg==
X-Gm-Message-State: APjAAAWTo3NL2oGsPyTLeVgkyt67N13bfBuw9AtU913fGUsR9roCbAyk
        neVOTGMM0Km3noLAPMtJX+U=
X-Google-Smtp-Source: APXvYqzoAXGXpeaigOQWBru7R2bMdlb3/nMIS0pEThTImdXKU2Im4yIUREdfmqAKgRb+S+JfAUsKpA==
X-Received: by 2002:a5d:6742:: with SMTP id l2mr22935026wrw.323.1560932278664;
        Wed, 19 Jun 2019 01:17:58 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id d4sm10828441wra.38.2019.06.19.01.17.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 01:17:57 -0700 (PDT)
Date:   Wed, 19 Jun 2019 10:17:56 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] clocksource/drivers/tegra: Restore timer rate on
 Tegra210
Message-ID: <20190619081756.GB3187@ulmo>
References: <20190618140358.13148-1-digetx@gmail.com>
 <20190618140358.13148-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20190618140358.13148-2-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 05:03:51PM +0300, Dmitry Osipenko wrote:
> The clocksource rate is initialized only for the first per-CPU clocksource
> and then that rate shall be replicated for the rest of clocksource's
> because they are initialized manually in the code.
>=20
> Fixes: 3be2a85a0b61 ("clocksource/drivers/tegra: Support per-CPU timers o=
n all Tegra's")
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0J77QACgkQ3SOs138+
s6HKVhAAuoQ7z7ZRf/w81QpPE0Mf9qG1XtWwgG6PU35inY2dU2m9a/e/wOLskJuc
rMBaK6kTTdVGtq1r0l96KxATZ3B8YDrsGgXJUyzAdy1Q72Vn/AUdbuqjIlanYx4P
XN64XA7FqbqzAn+IF3s2ZoUcZ9zrvpWs2KGYGBd2BmJyMwy7z3FMRNj3XbO10GiH
LkN0fHSgm85qb7kudxyPirCmUfdcG1qHGb54P/5m5jRHnBckeotQat4BTFZ+sO+z
HRQFxbvhmfyqwvrtSo6UqnmDtVuW9+R1Qgff/u4jLQj35KfMnqfTHRQJNwwTUnOF
bcRDx0zB4Hesrtk9mllDh4iJqOxiIHJ+Wtu780kKZgBIa7P4qOxRdnkaNwgsLJyO
5pkVAx8ETwrx6+Q6lXM5Gw8NTB84zEDfJifV84tYimn/qeBrkN16i2qOpRToRcnl
/UW8I6CtINNUDTX+cLloHWt10ztX/J/OphEP74gqG9/tELeVLddYoh2PgmynNdUu
93bu6h8q42qOHTPbz2mlVKii2e6mfpyklGqXVCQV68TchEeNccsXvzy/YEnPuLgI
srAI6Mj8nshjXQCLoHpjSHKuv1TibwrLf0LLPtraCt5shg6wwEqPtiJsFzgxUBbe
pdmqNGR6Qf8pHWXrv5Kqhib/+VyqWQ96m0Q5Bv/AN5bmf8kJQ2c=
=evgu
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
