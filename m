Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9C6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5AF2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b80li0mO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfDCQYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:24:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33652 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCQYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:24:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so22251568wrp.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 09:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=utFnmc7dvfDDktsHT1dhVoyIdmVH+4sr6FbCLDmGPBM=;
        b=b80li0mOLtwINKu4dmuzBOMqVxR6hBVMwm596hUDSCtRtA0rrU5XZ18Vxeeyv8D5jF
         +KTM/8//MSQn0t7WPQ32Sa4X1YblvxyS86xhkEjyI5u5xHC8pGBI2TJXtdr8NZ3pbprF
         3LMgvvqdOzW6C6ugia17mr5uuIdrkG8W21GL48+VIdG4h0i/10lTCRR6iHooY+qkQarO
         cpJGfYt3AjquVcYRj44dNAlqVuAgH5Ux3kEvNBQ/vV7kSmpDdizCe6wcolBeB9K5zBSM
         HNxa6gJ78I4eb4bc57SbFrc7A1s7K2X0t18a8g7ZHRDTSw7YUpiMdZ02f5WbQLd++E8j
         c+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=utFnmc7dvfDDktsHT1dhVoyIdmVH+4sr6FbCLDmGPBM=;
        b=PARZI3yhFwK9aVnsc/YR/mDSfPq4qMpqdOVOfxkrC8hTEeK3q7SBE1Af3e88po3zdD
         aFadjN5HrX/28uHPlontHNMEb4XKIBqi79/eF9pGC+wgR4Ls+rkGNaefvxROCSX53MRW
         fitf5jgsH4Zqf+HJxpGVkXjWu4GNSkf/Wp46KI7LSrLn5EF/2zMsaTqOWAU0zeeIIlsO
         uln2RUiSkSVIoymPMHongFgIzN/Z5rLLdqFzS9UnxXpsefpBFQoIBNvwWCwzheSNUUNc
         yaLiZit9356zm0o+p01pbAjHcl0HKZKuu7Z2+v13Or320QqBrgCaEP8ZuO/gNDt+TyFy
         mIWQ==
X-Gm-Message-State: APjAAAURN6qxbcSQ6lo+zwxYjXfVmmkwOvDwr3Nu/Xmg3qFFYYFYqPvf
        mFRIXbPHGfGOTD0nt4fz+ew=
X-Google-Smtp-Source: APXvYqyxUm8LcBMcs8cjU8hTWvZ7HsZIYBqsRcFQT4hrq7jYcBiBQ+HFraansWrygp9CmWkF8FFL1w==
X-Received: by 2002:adf:fd86:: with SMTP id d6mr317379wrr.15.1554308690752;
        Wed, 03 Apr 2019 09:24:50 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id c20sm28582050wre.28.2019.04.03.09.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:24:50 -0700 (PDT)
Date:   Wed, 3 Apr 2019 18:24:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yannick =?utf-8?Q?Fertr=C3=A9?= <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] drm/panel: rm68200: no error msg if probe deferred
Message-ID: <20190403162449.GQ5238@ulmo>
References: <1553155535-13555-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9+VnUxDxRuy97YQ+"
Content-Disposition: inline
In-Reply-To: <1553155535-13555-1-git-send-email-yannick.fertre@st.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9+VnUxDxRuy97YQ+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2019 at 09:05:35AM +0100, Yannick Fertr=C3=A9 wrote:
> Do not print an error message if the regulator framework
> returns EPROBE_DEFER.
>=20
> Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> ---
>  drivers/gpu/drm/panel/panel-raydium-rm68200.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--9+VnUxDxRuy97YQ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyk3lEACgkQ3SOs138+
s6FEYw//STmVwecNFJk1hQ25t2jNZMlnkZ93NEODkMq2FMnBag71R4Xo3Q/QlVlL
JiU2uyL/nbAtA2/eQMVfLivZtjtweou44YzWvuwuluyiwcdSAUbALroPQYfmy9Oa
1x4uD8TEWrEUm96QQW3wtbjkJC3WL0y+fAq9aN1h/SkzhpkhfCmG+iRZtwElFsyc
6VATPI2fX0GeWynnTUGV1DgKsqGlrpR6hFXBnFEm2X5UxAM2ut0kwtt11O7CrO7a
UREkqcRP41Su2U4AmlPPLbhcrKUV2hE7QIOdMEID5oIKtKy5du7FSvNhtCQuILDi
7l4HWGwMpwvBd1NAjqfdhDak4GjFjKr3vrdmJQUqKHzwmTCzanioY8dpqo2/hlib
sszUbCKgUyZL6x4tJDDxSeiaSamlPeMVZqlPj7N7Qx1unWXHlNvl7L+WJsKxyGvj
NdvV+su5CpNP1bGLsGKHd6YlNxdiy/eLCdGXRun0ev1zOTUsid2uCAznLMPoS4UU
Au23xC5SU5IloNV/wFxikyjiMlE4A81UTO/z7S+dMsOOoCs66t3xLU8SCMUKW1Jt
awcJbeTDmkhzp+B8Oh0o3AhRl3U+ce2nJ5peETko9ruxJ/08rx68Q9Nm4Cf8fy5L
4bDkQOIRPEuYiqwgyYr8cE8Kp0OMtI5+vJL8pbK9DOVQE5r2zFk=
=miLy
-----END PGP SIGNATURE-----

--9+VnUxDxRuy97YQ+--
