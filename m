Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04AFC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18B02083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njgUJ1u0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfFTJj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:39:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34508 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfFTJj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:39:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so2329832wrl.1;
        Thu, 20 Jun 2019 02:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=60NPO1jNpQvd7Ez31xiYkmEeG4s8Fwi9JQHXOHTFnZA=;
        b=njgUJ1u0/jmMLVeZBWWtKW7im7ll2M30pi/UEoCUfv+8k3TLoatQ6FHqEkQxegnJ21
         1r2KX3041H+yUrnyJeuiDfd8LbqmQCqNWWZKiSPVYSG1Yjx6ktW7GWz0/9CEcgQYb1oC
         AOHSi/o1FdpyozWhGHoLFrZ6Jrir9fCfK/toc/uDICoZ9GU1miakz/srxVuDTQMJr3Wt
         WmT/F967pUnui+TbY7Gib8bxJXmNfr7f2wsSwLIW1F4jNKijEssowlJ+5YaJiu34asf3
         hpFf3s/ZUUstJItyDx7eQZrBF0TFUoMtoCiAc9GsUmKv46XY6++dsp+C4a3F6G0ddjCi
         SusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=60NPO1jNpQvd7Ez31xiYkmEeG4s8Fwi9JQHXOHTFnZA=;
        b=rEq0Ncj+BAacgxwXLikMJAlURzTLsCGhaskxRzkOp5nPhog2gs1ayXYafT1d/Hn49o
         ZKES8lq7bKgdvpPPo1rfkhg1G0R3ELvIQZ/pP4gniAzJOXnJqBN4e1A+g/Iu6aYTC7fP
         pZEKClWQiLrkeMS+SGPEvVDk1jB6flEk4enyhuSnOxHK9Nla8yVWxp80rLv97LPIsISG
         72TE/416F7EAxzVphvvKhjr8vpjUaRmKYHT24exks3lthei80HYaV/r0W72ewQ8HL04d
         70mTLYrk/MQE3Bc7RKX5vJQlB72sTOSTXe3FL4yjjFmYZcwEYOhgjuj7eFBdYrs0PleE
         noJw==
X-Gm-Message-State: APjAAAWIahq6vTkXDlN6WdGJfXsQtUiq4WrfRwIr5bJhfxD9A9XH+aBA
        mrZ0/WSmVpFvfx+r6F5G6mI=
X-Google-Smtp-Source: APXvYqz/QiChR4nRct216cdjVr+StmgHBQwnJMAfrEgDwXvUONAdLPrqVpnqJrkLbPN5J5tTlJIPlA==
X-Received: by 2002:adf:f246:: with SMTP id b6mr31407645wrp.92.1561023596478;
        Thu, 20 Jun 2019 02:39:56 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id v65sm6011756wme.31.2019.06.20.02.39.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 02:39:55 -0700 (PDT)
Date:   Thu, 20 Jun 2019 11:39:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     jonathanh@nvidia.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mkumard@nvidia.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] arm64: tegra: enable ACONNECT, ADMA and AGIC
Message-ID: <20190620093954.GJ26689@ulmo>
References: <1560945082-24554-1-git-send-email-spujar@nvidia.com>
 <1560945082-24554-2-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AXxEqdD4tcVTjWte"
Content-Disposition: inline
In-Reply-To: <1560945082-24554-2-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AXxEqdD4tcVTjWte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2019 at 05:21:22PM +0530, Sameer Pujar wrote:
> Enable ACONNECT, ADMA and AGIC devices for following platforms
>   * Jetson TX2
>   * Jetson Xavier
>=20
> Verified driver probe path and devices get registered fine.
>=20
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  changes in current revision
>    * renamed agic, interrupt-controller, name
>=20
>  arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 12 ++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 12 ++++++++++++
>  2 files changed, 24 insertions(+)

Applied to for-5.3/arm64/dt, thanks.

Thierry

--AXxEqdD4tcVTjWte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0LVGoACgkQ3SOs138+
s6HmwxAAuz3s2lsYuNspLRTR7ZEw+HSokk6+25gsH3D8xjf6/9CeYFTfEFwu9fRV
svrVsN2wkVUvThaNn5UpajTzJJ+AUg5isdIcNUJ5zwlAbFmhCzwxGFgMit6aMxnz
if2/SLmiNZ6QnzU1r7RUkqMGC69hHhrV7daAEcYTWklLYYmIeU6wX3cLrVCsvnQ7
QF/087CR/T66/ECHcKodVtsE86BrLsiyVaiQq2AeAOscFWhIzv/M98aQb9OiceRm
2OB7nf+qhsdjU1M1G73rpcNuRHdppTOxm2ZFP22mk4VLLLmrL1nHA6XbGUQTNedW
h5TrwlsEVDtUyqLj6OThRByxv0+lvatK9Wor2su8h2v4KZubxL+FjcfbwWN8kgxP
r6QE9Swo2EZzqav5PFaY3nXbG+F1oFaPZpw6MkG70Swv26cwh3DEAvw4a9iPvzhh
W9gaqXYIc01SZkX2Nub5Zx0AKptK/4NI21aE+uO8HnYS43Qydvs+6JVqGA9oRSmT
ZF9Kd+585Upebth/fZHspW0YgxWNlO0WtqWjBt8wFeyMkYamHft1d8kSXGyiccsv
9ZDZncC7trCxQyF4NUc8xibtAO2P2bsc9Sq6qgYfOQxct/4Ve/2queKa3xwIruxB
aCw4MrbJQ7EKFkph8e6gZ8cIUfA29VqxIN/ZmcRP3uI5FkbylCU=
=CBE0
-----END PGP SIGNATURE-----

--AXxEqdD4tcVTjWte--
