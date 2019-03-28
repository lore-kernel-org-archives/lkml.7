Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04581C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12DB2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqkKG3A8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfC1Qcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:32:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38304 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfC1Qcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:32:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so4814389wmc.3;
        Thu, 28 Mar 2019 09:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RqY0LIujZoVeOlc9UL+a2GaKesMZz4LTrbvFEFVa7hw=;
        b=PqkKG3A8fLda0/z03EinbVEekUKQ9UpeeBZciwv5e+dVcKyMqNViGK6kJ4yWHbmwAn
         CBeFhSCWclyUYjET47p3fvQ6e34RT1ccRvOiEwmVFWjGL3vBqBl+lTd9lwgEodYLCQYT
         p7Mfa7VVLP/4T2//KE2YBN2Uwx28VbBpTob/vavVhLmtQJA0bIrWGE5YTFe81KdkDsGs
         e5N0Z/yMGQzTMNPIhrr6FzJ8FDbuiv1mYTMfZfF1zY4uLKOyHW9D+R7x+hoi0cHhv5Dl
         cuCHZfhYQAiVW95ZZHYjil3PlMwujqKdZYom7LNWyHGCRce4KR9S9fvSntvBgpF9dEkt
         Sy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RqY0LIujZoVeOlc9UL+a2GaKesMZz4LTrbvFEFVa7hw=;
        b=pKg0OJF2wY+tyY14hldXfy1T0rJwZjL6Efl1qh3WZBZfDI9oP5uap0fTxoT1ZsOzl0
         +4BPp31aAkz83BlulKNFPXqkIO04F1Lgrj7RnHGcVyO01WJqK+hCdOWvAcBWQpUw/eXc
         16xFylvrtpOzFwP/49d/ocfLvVt1zFxVxaOCSksdsEE9ybKSEfqmbInuuw7TVmjA+uFu
         2ZdPeyTwdkdkfterwamYHUmMIQ/+EVnYDxyf/uOp30FJRUQpy5lAiAw/4rZAzBm9m/8G
         4X0K5/0n2VyVZmdXLPBobzhpwa5rpI03HQzqoPSPGswttYF+B60tPLPIPdJsD8eV8Hmy
         VctQ==
X-Gm-Message-State: APjAAAW63Qpm7T9F25C6cSXv27l5Wo+3CIXuJLMU3tCnZydBplX2L7YH
        qH79fpDZK4W2aznMlctCEwM=
X-Google-Smtp-Source: APXvYqwAL/8NOmwlpwF37KnJSvusPW210n1O1Gk14hYxN2dhItdmRc4lOKd+SqXsA4IfTQWZQj8fHQ==
X-Received: by 2002:a1c:9cd1:: with SMTP id f200mr547093wme.91.1553790769650;
        Thu, 28 Mar 2019 09:32:49 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id e1sm37413957wrw.66.2019.03.28.09.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 09:32:49 -0700 (PDT)
Date:   Thu, 28 Mar 2019 17:32:48 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     treding@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] bus: tegra-aconnect: use devm_clk_*() helpers
Message-ID: <20190328163248.GB31367@ulmo>
References: <1552452119-6574-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <1552452119-6574-1-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2019 at 10:11:58AM +0530, Sameer Pujar wrote:
> aconnect bus driver is using pm_clk_*() interface for managing clocks.
> With this, clocks seem to be always ON. This happens on Tegra devices
> which use BPMP co-processor to manage clock resources, where clocks
> are enabled during prepare phase. This is necessary because calls to
> BPMP are always blocking. When pm_clk_*() interface is used on such
> Tegra devices, clock prepare count is not balanced till driver remove()
> gets executed and hence clocks are seen ON always. Thus this patch
> replaces pm_clk_*() with devm_clk_*() framework.
>=20
> Suggested-by: Mohan Kumar D <mkumard@nvidia.com>
> Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  drivers/bus/tegra-aconnect.c | 64 ++++++++++++++++++++++++++++++--------=
------
>  1 file changed, 44 insertions(+), 20 deletions(-)

Both patches applied to for-5.2/bus, thanks.

Thierry

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyc9y8ACgkQ3SOs138+
s6ERBg//U8ylvk0qzMcb6sgjNdaXLC1+tH5hvx9MldWTobCNl/kySlSfiPM9Evaq
sJruCUQIrGrqK/5bApPB/tmxhD7Rjm51xJL9ETRnAauZKEVNomVsYdbSTi7wFjRh
clZ6vEaobWwSEl5IPTv0WN7Gg22LMDVXrPu4CRFavvTCOCalp7xbvqGEHGP2zipc
dzTESdlx5RO0azzreorgYcQWEfEnqiXr9V6PJm9DnTx9LtrObu+iU92l+ysgaaGe
xBQbmL5Kv2avdmUvm9FXX2HNB1F9igAAa4gJfTcdkC2XpHXPhCeVEhIKRucKAvJQ
tQonbJc8yGU7ywCncS79QyM7zxMWY6k5XJAxVKaRHk3amQajFVC3+781eEVgwi3d
76OOfBbCnSXw015lHf29sWanzEZ6yUuK2Hsqwg02hMTNYG0jy7HKDrNoja2ynjfg
3g2KSulWC/ZYX0Yp6B4VReAVA9xS+Hsp8C02PzhxKWHRe7q9tsX6pzeMimFCt7qz
MK4jWFjrazSN5dkKtNOmbj53oxPInv91J0z2+6nD2nEy1RI/Jfe6o6OJememzFoj
YuEW3xVvZEUYz94EodVg4V9F82TE54m+vyF0bZI6iOgJq9GGQUOKVPTp2vj6i3JI
JKTUNl8A/VBOYoS6uMabtGNj0Qy90sdP2dWZrhzXO2ftwUTEGPk=
=Jrro
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
