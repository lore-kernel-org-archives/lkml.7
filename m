Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57892C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260FE2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOVK5LW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfDLPhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:37:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39725 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfDLPhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:37:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so11554007wmk.4;
        Fri, 12 Apr 2019 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vNStv2a1Zhwm7TEz+PTCA4TZ7hONU8Mj3fdHdsl9aCw=;
        b=kOVK5LW9l5jmelTX6bcRJmbhT8B1pLCy+AGNRKbawan0kIaRBItZpGzuZn7T3ashOK
         R4HRxXFrZZlWDW8epKGxQ3DgnzSsA0BFUmS1P5G9Egc5y5kgG5vs+qA0ifgbKHWYEuY5
         rR95KnX5eJBnGVlHg8yEhK9grywP4T+qeUyRwEtm7RY0sC0R5mo4qmdWJw2OkYtXh1S/
         uqiFXxfgbVOxnqLmDvByTaAF+/Xl0Tt1803Vf87KBZYEfpyteDvtHu2lfIOYi2bDKa3v
         6gTh8e74d3zGdIlI0gq+TmPU5jGypz4R3EgOtExRGEQCxbHIH5y4YzpYGvk+bGqZlrpw
         yX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vNStv2a1Zhwm7TEz+PTCA4TZ7hONU8Mj3fdHdsl9aCw=;
        b=ssrW7Fo7dMKiujYcVnQX41Vusaz12e+eguy5PjNeXZdx1X85OzXHYN4y4knu7nVZsk
         xOe2XRIfsG0JGaBTCDdBtVu9kUkXSKWG9IfeCwPGcKi7LEUYKbm+CKteR2fTdmPqVkjf
         i8/pjJynRtbtv5qvuiHByYAvTPJfcWIPaJFe9JdTmhnl1JmIOg67ha2tX19X8/7ooHBk
         4YrPmnyaE3Kg2HWbL2P3PxFN0XTxaRiZujWBWJZkiOrr978oz2Lyd/oCrHyJZOEqHAFS
         LvpEHCq5jDlaHZNsg5ScZZN1WaGFfvMzFeBZdA4VxkhARhitYALWTGPB0kcOK9v4er+C
         li/g==
X-Gm-Message-State: APjAAAV7lAI803Gnxw/xP6NcK7M/Vi6N/FVXF2MSr993j9/cOk9cRANl
        JuaPb6AN1SIR0nlNGwELyJ8=
X-Google-Smtp-Source: APXvYqwN+PkF0tie9lIYJHVixy8J0ZmXAi5N2ohjpylab4I3d6u1KRNQW03lN6RsCJX0wmh2az3lPA==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr11284217wmc.137.1555083442480;
        Fri, 12 Apr 2019 08:37:22 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id o10sm64169010wru.54.2019.04.12.08.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 08:37:21 -0700 (PDT)
Date:   Fri, 12 Apr 2019 17:37:21 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, riteshh@codeaurora.org, jonathanh@nvidia.com,
        anrao@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V1 2/2] arm64: tegra: enable command queue for tegra186
 sdmmc4
Message-ID: <20190412153721.GB21159@ulmo>
References: <1555011474-20107-1-git-send-email-skomatineni@nvidia.com>
 <1555011474-20107-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <1555011474-20107-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 12:37:54PM -0700, Sowjanya Komatineni wrote:
> This patch enables command queue support for Tegra186 SDMMC4.
>=20
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlywsLAACgkQ3SOs138+
s6Ez6w/9G4OglGZXk/Rwe6TE1G1g92cvW4k1u/TwGWo/UyM5xrs9deo04ZSns8dJ
svV/yRsNRMIh3yyDAxj/nBmsybtMDzhtUTK6YmZMrPkZtbgrzOINaYltP8Yjd9Lj
+Fj3sDyak3pD9CJo9r3fni24rIbdqMhCYx3ozspf72NOdRG3IF0OecbqI3o+oxKZ
HiNs3e10cvSSWurK3oyIxLVvk0RO+PqL4TKGn2GXlXJbP7Zp5JL0c5nSohTzqfrQ
mC/qPXR4z8UBIwdHysffk/CoJYOQmQ0G6PGqoDC2yCjy8r+6pyx1K8ZTSFY1KamD
xCZ339xQyRYERDPxLZWv7tRDYf00sY8YRetbZKUP0+87yxwwVJtjUN6sHzE/5iua
qGklQU+uUBI3FxDUZulv8MHsRFUc2gW9HMU5XnUP0BwW/7H9cr89JoIwla0t2d1P
jFqYZLjUXtXaMlbNAoX5vh+Jblj9TSYplJ17olPdLZ/kvju8wnIi4atLhNI9P7LC
6NK+8b0IQGmPfibNXzAumlC9EJB/gEoo2BA6Wuj++AxAPJXUqXBDMnjqb+CJ+IQj
McazrlPUA6HD8D3hN2rVDf+ThGROADQnOrgjaUm9ZbkwB0/VD9l85SejOrpQ922w
sdXzrZxS7KQlYkCR950cgb7HhJv13C1SqA9LAzBsgWP4mN0g4nA=
=0Tdg
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
