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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2076EC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA75820823
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E60kwCHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbfFSIS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:18:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39563 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731318AbfFSIS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:18:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so739573wma.4;
        Wed, 19 Jun 2019 01:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PR4gZqLNS6e99SIOZCQ9Ek/eOBSLxvfwfETugMlLZgA=;
        b=E60kwCHyoTvF0Bwsg27nYPSMRPnJZRk+TPmiPAcnUbGlPDVfy30lUi/8xSxf2EIYt1
         twp9P5silzfVUZ3Z++o0RBrDbqOvwSTjLGA2W6QCHjMjc0u9QzOl7fZ8PCTfTatkSenp
         LsnAAouyYB+vmvXO4RBL6yuf441jzdHGwzSPuUHokAo5iI6Odw6FLwaxkpdy7Ec+XWpe
         Ss9CSoOC/4Ckq8LO71oNGmkhFHeFZkVsJvPCI58GimOhg1Ka9wpf/JJxL34NPLmEpYY5
         k9if5OISwryW8n3R2ESVg3wsMoiqSyTTc7FbFr+LbJ/q85V3JfNFhS7nkK1wWobTdCSb
         QyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PR4gZqLNS6e99SIOZCQ9Ek/eOBSLxvfwfETugMlLZgA=;
        b=FNfF0tZskueH2j6NkhygxFhHp4ogMhkedbmHhpykVCAQcoajNOHqIoKmANETP3LfRH
         c08X9KAUAteeqOBQC17dLf/TE189mlteGG2fk45AtkW3Ji30FFhxBRVvc+OmJ2p6JyO4
         hIxIntVPtqaeatFFcUYXffx1Nj/zElU2QAGqgMnSJrH5eJxtIhpEltEsEo56tsV8QDnO
         7PEPGKkYUd9e7haXo9o0e0dNKImn3eom9DX9MFhb2eaxuH8NRAGqLLg31JiErDFwNL3Y
         hfSdKfCFVlZgdJikdVgmM0OFP3tD4b/CvmVPGCBocCK/zmPM2GzMzr8gfHfz0sMv4yfi
         Bu9Q==
X-Gm-Message-State: APjAAAVf1WTeTWT8XcVDI7Epz+DUIGB///lS8VSSVi6ZowzJ6tFFTMjG
        BFIeC/UZZB0PejDAn4R0B8PQJIbJFNk=
X-Google-Smtp-Source: APXvYqwwHGDm+xj+qbWAMSxmuk3G0HXrqW9s9AOusy715Jtl0q9h238qfwnT/vk2eAHDCyFNCiDRTw==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr7571789wmc.151.1560932304308;
        Wed, 19 Jun 2019 01:18:24 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id x6sm19977502wru.0.2019.06.19.01.18.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 01:18:23 -0700 (PDT)
Date:   Wed, 19 Jun 2019 10:18:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] clocksource/drivers/tegra: Set and use timer's
 period
Message-ID: <20190619081822.GD3187@ulmo>
References: <20190618140358.13148-1-digetx@gmail.com>
 <20190618140358.13148-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline
In-Reply-To: <20190618140358.13148-4-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 05:03:53PM +0300, Dmitry Osipenko wrote:
> The of_clk structure has a period field that is set up initially by
> timer_of_clk_init(), that period value need to be adjusted for a case of
> TIMER1-9 that are running at a fixed rate that doesn't match the clock's
> rate. Note that the period value is currently used only by some of the
> clocksource drivers internally and hence this is just a minor cleanup
> change that doesn't fix anything.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0J784ACgkQ3SOs138+
s6G7NA//VwmW7oUtMjv3N3sEQLTm5K8NQhFBB1WgJnGGgqD+PGdyKlmX93j4XAsd
MKaUtSVsFk6DaPnKlDWMoUCkJUqYjgwiLK1fNAXaiFyj1dxzc+sDVdIHNIJ5CnJc
4fqTQU4gkEInf7ac0kxAaYjR5woyzLjizhidK5aNzEtfqtEHwSUJmw9bWx6BDpdS
iP59g0AtACJodakc+5krfJ0ZDesSLL8KpA8szbvgpqVCWjgVJ9UvSJ5CzHniNXC/
YDGX+nY2UjED9h4yS8+xA5WGANmV2lm6T3QwpoUfcYK0vflywSmR488qTm+Fen47
a8518Y4FuLRNrwglQnZhF55BDWonyVsOEmfPOc4eIJ1EMbnKZ+ayUxxcOphWiSu8
tq0X8z8QllYftEcC6V0IqtqeB4CqR3fxVY0L/RK0LF/36Azn1361WFXmT7BcSqFR
HzWld/hlHKag/Ux1ka3kM8PhIz7AizGnvtrmPumEqyDs5Ju/vfUt0q/do1Ykj7vd
TNmousIP+brO1v15ryKsqs70M5Xejo+wVH1V7Wf3aQaFwOxt9syphL9PNGf7dfJ5
Y/FU9+sHtqtNU6Q4Bth7wT6OQhhlESRaH44AaDjBUb9JlQ/xqEOCaURDYFTO+Lsm
srbM1BEiuYkSfas3dZheMOpc/62g//hj9UmePPdeOtBa8cLKOas=
=HaRR
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
