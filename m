Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35207C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A29C22C7D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNmUOLL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfE2Nqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:46:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36857 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfE2Nq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:46:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id s17so1855587wru.3;
        Wed, 29 May 2019 06:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zA1ZbrjHanDMuERyrJxkqEcLI/WGuk9rXVkOoOWshjU=;
        b=VNmUOLL0fE8kIppYw/blCmqwLCixw9nqxg96YcAZtWz8YlQ1zsDg2EEGdzpSMiKWiw
         75/U2myJGZdLzOBDHXsYowRTo0KZFt6RswEIjlGdUQ3Yps6BsG7wbRa8xohWcVTRUBQd
         xoHu4754hkdq6vaVkOrihGwdpxFX40aPZAlTkY4rribl8o/VboEFEnmdtp+nGCIEJadf
         LBBq0hpxrIdQslgAa+1LK96v8Eoyt5GR3sfHlCIFaFYiui+bklFCAe8868qmeC7LvsbE
         sMG7jpg1UuwBZys1pNcVNKe5KoXzJH5p7VK0i5EgND959svenTndwx9t5p9k454M0dTG
         punQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zA1ZbrjHanDMuERyrJxkqEcLI/WGuk9rXVkOoOWshjU=;
        b=gpN8nUFogn4eBWoFNji5tZrs63RD9tQv3l4SYhms/hKxuXOivio0hFzn8EYd/DUnS9
         KeBGDAk6jRb074DiFMaJghjgYU7wZmyMJuPzmmVedi99rSFz+Sbw47zqG4UJpwNwjFq0
         X55B6QYt1FC5lguyKtFG2aGlB8WyeCX1z7D3TIaD2SwNqBnWbVokdTDiYMEUbXloJBbx
         BRrXXRe3LNzy8PGOFIDf8aHcNWuHTTs8B23FJzepIBirLFSC6bf3G+Sl3jrN6tvi4ESj
         zRFE9QxtVMQlTu7zKvCsuhhlNQfUjiwpPuA10YetN0I9PeEdeyV8JBdX0RQGEPevHovE
         1pFg==
X-Gm-Message-State: APjAAAVWeN2gH3aAjD11Tpkq/MJNDrS377kIdILHIuO6ly8FS1ZJtqf5
        L+qtExoDYQpzle391LdikZk=
X-Google-Smtp-Source: APXvYqxsooOprXPdPQ5zlSWgan6UOpPtRJkHPupbP7w6C7kptTdp5VeuHqj9JLzmc0TMjNmB49l3XA==
X-Received: by 2002:a5d:6190:: with SMTP id j16mr3108705wru.49.1559137587741;
        Wed, 29 May 2019 06:46:27 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id 6sm34132977wrd.51.2019.05.29.06.46.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 06:46:26 -0700 (PDT)
Date:   Wed, 29 May 2019 15:46:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH] clk: tegra210: Fix default rates for HDA clocks
Message-ID: <20190529134625.GD17223@ulmo>
References: <1559121501-8566-1-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
In-Reply-To: <1559121501-8566-1-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2019 at 10:18:21AM +0100, Jon Hunter wrote:
> Currently the default clock rates for the HDA and HDA2CODEC_2X clocks
> are both 19.2MHz. However, the default rates for these clocks should
> actually be 51MHz and 48MHz, respectively. Correct the default clock
> rates for these clocks by specifying them in the clock init table for
> Tegra210.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/clk/tegra/clk-tegra210.c | 2 ++
>  1 file changed, 2 insertions(+)

Does this fix anything? Should this be backported to stable releases?

Acked-by: Thierry Reding <treding@nvidia.com>

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzujTEACgkQ3SOs138+
s6Gtwg//ahUkusGdGV9/e18/FFhmcqOEMi+6PyOAh6dfSA2zRMIRKtCr3ZpgLvlC
WHp272SeeDP46I+NVREKSwQ99uwadiWBCDYc3xYyktl7md091y6GIIF6Dc+1ANMG
7Umm65k4mgbpPcMJtaldiXzgKuQClEM6fPikEduCEIjSIhfeODpA8T6sIsML3OuS
q7IM9U6BE9BIjI8+e3mYk51Zw8bol+OxOfT67Iuj4jrugWTz3P8QlzmHRoslEO57
kYx2chG5eslDbE3biqb4x6vCceQIzQL8uXYIfua9hIvq7Vh1f/IzFloICH/3calk
e4+fLed8Ot3gtQVVSyUsMpexVHX5/glIK+YeWVqSdyYE39U1bhaZSjEfylDpY5qR
Wh9YXpQo/p/myv0PLviK2vvaIv/UKrRKwC+4lzNuQej95K3nkEylRJgbOGruj1Iz
69wA9kLe1bHoukNETyMpEHPozJKsdknqzLKsPuZJMW7oZPM+omwCb5mU9plYlF2h
sMxq2Z1/oUWDptGAYHzrP7XQ3ZJQEAOtYz8f4LwEHcPSyFIqtXsOomFfckVEIBDW
Lh3QifHXjlaFjjmL/h5hI2mapMFiTH5shELGaDmyn634mdFbygk8ZaaYzQXlF72O
XR/5Uc2RviTrsJUztyhMN0qWF3SH/uAklsOgkCvRacgoS13hQEs=
=Udg9
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
