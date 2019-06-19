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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FE0C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6F82080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSFF7IMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfFSISK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:18:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45003 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbfFSISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:18:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16so2272091wrl.11;
        Wed, 19 Jun 2019 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hKafA83HR129xflG51gsGBZsgT6NNwg0oJBoOQ5ihug=;
        b=VSFF7IMjDDUPWcM3CYnrOGK9B6Y2Db3uN6Lvjdxoq/4j4wlZM+4qLibJPrg/2edYf1
         70sOThT1/d95glhgIK48gXZM5z3kjuGZPc5N2/ETSeXVfRzLD70FaddIwcmIy683K3cp
         ti5K8QpbO+wXErkeq0jnWNtyahx6JQrvIYoAiNWeamuL7ihk1Yn3B6lJH/FTWtURxqVV
         UszcI/z33m7hmEjZJqzUc1TH+NLleV9kRuATroZQF0/Abi7sutST/zxSmhGB3LYn1xyo
         5pfZLKZizPCngMCYGkT/xLbQXtdX/LDjZeLtrU4rlS08o8fHsGXxne9YXv4PzoMYoLN8
         CnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hKafA83HR129xflG51gsGBZsgT6NNwg0oJBoOQ5ihug=;
        b=W5D79VneRafprnSHnTMhTt1ggHmIEz50idaTPe2bC8eVsgGcQWCbkVO+QbM4rGeaSQ
         R0Md2Xq/y0smFtXT6R6WBTzAtgcWQuxIwiFUp3WyjBmo3kMt1y45n/NSFDk/OcyXJh3U
         wFXvWDf/oFEArzSZehTfJXjIeOrjEcBm3h0XrPhWl3PoB89+hSSeokK5zPnmQbDDNHBI
         RwURU4s1keC0f50sX2VuZ8H66gTHsLdg5i+aF9Gm7KnZztCKY2PjyNxqX6Zc3WszcJZH
         2Nm3r48T1QTyDD4IQHr2FSAmmCB8hjlpO9BjXdRIAq3R3yi11aOMHVdj2qS5vCzNdDzP
         FEFA==
X-Gm-Message-State: APjAAAUrcR8p2ZbJBQL92FPuS1k7muqlz5cSkRf6sJGp8tlWWXytjvIj
        hzJ9/GIhwwP2F4A7BjZ0TuU=
X-Google-Smtp-Source: APXvYqzN5SJLO2Ow11TxeJTr2cRJ6TAlMsUEmQ4WDuFhunKulIJOHKj96/WqqKw66moNe54vJJW1dA==
X-Received: by 2002:a5d:56cb:: with SMTP id m11mr17083297wrw.255.1560932287129;
        Wed, 19 Jun 2019 01:18:07 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id t63sm575665wmt.6.2019.06.19.01.18.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 01:18:06 -0700 (PDT)
Date:   Wed, 19 Jun 2019 10:18:05 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] clocksource/drivers/tegra: Remove duplicated use
 of per_cpu_ptr
Message-ID: <20190619081805.GC3187@ulmo>
References: <20190618140358.13148-1-digetx@gmail.com>
 <20190618140358.13148-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
In-Reply-To: <20190618140358.13148-3-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 05:03:52PM +0300, Dmitry Osipenko wrote:
> It was left unnoticed by accident, which means that the code could be
> cleaned up a tad more.
>=20
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 42 ++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 17 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0J770ACgkQ3SOs138+
s6FwAg//dVTkrpxaLZ41QK0AvOfQ8qOR5oXFHUc8FPLDhaBrAYlCEqPxgKk5e3JJ
bR4EAdKMcfCdd54lrE0DS9k0aqdi6wmpwVi8WkwlUbg5Wzk5lWCCbTCsX1qBfL2H
k6twuyg6Y93OKDLpv9PBx+bW79QJGjvoVFmTI8cqm2fhWN7fv3tFg3gW1I5on7Qm
0np0BRZRok8r+CsvjBxWk6hDuyN3l9lC1OfAH6P61ODOTnEGa+8A60t6GoKozB8C
UNhUHzjIdqxoBr+0fAWX5MBuXfdLB81y4cOPtSPDUTF/x4pQpufweUvySsGhcaQ2
oON36mnFTboXLSJc3OEB1aZM6LXFeAokcjhUzJtMuBkUpUX7cj0TahYKUWfylvCT
08ta/F+2jvJ917CLwg1x8uWZaYRMfPwNhmBvyLzl4q7KJA7uGSxSk+6XP27Mfma9
YH78IRdwTN1Z6cyDJcgJGWfyoJZnKi4FLXSuTWZ/3cu9jnGx//OkuAG2ebu4iRu7
8EfbZ6ElDkNK50eANp8tUiQvGQ929wpT/Z6HA9vxmAULO24t4UOa1jkHvQ2DgN3k
HH9gfiXYDDpSPkIx6wGMCnc0+5J9sxBEEMDyEq/vS+fvI1xEEM/0SMydLD047JJL
2GxPRZCzx5tpJEZQgKGDsauFjAnhiDxUQRJRaOP3JuRYTEVFoyY=
=9tvU
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
