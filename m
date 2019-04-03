Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A7FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749BA20663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMz6KqWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDCQYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:24:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33630 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCQYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:24:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so22250669wrp.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 09:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kbmFIVp/lyy7tGhkvMqJAX0PKTIo/Fbz9//10OlxtS4=;
        b=cMz6KqWACOMSOrnCCaeZhkp2DOPyGfuzMpH8S/ZZgi/hp4t9aE3+IWBLd6hDVFcsse
         4G1MHRi+4sIg3YQLMOGKS2VikTQcMxAbtQJKaTQg9HiywZNDDfQPbrBdZBgvfbC2u7uM
         Oc4siWQlitfZqMELcYShpiVa7o6TJwa/5QVLuLivBiR4x8ziWDIXEMqu3ypE7+RoR1U8
         LAkyMGrjFPW6j17XaIu5w77vTPN25Vxzk2+DRAbzuAZeOwnvVxPdnKIpEDYYjnj5j1ac
         7GXSUjAdGCbh7bQJpKG4LEX4D1SyVbDJ90KxKEJcA773WyZ472uEGZ8Z/A82tjoXJI2n
         8QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kbmFIVp/lyy7tGhkvMqJAX0PKTIo/Fbz9//10OlxtS4=;
        b=Wh/Z5sMb8ApiuRZkBd2XyfkFSg8OJkX2eUXTPBOT548+/81Min3s1/xlYmCZnGC7JU
         Y1ad4E3dBBMHIojoOCRtvXxYI7Q4rOjyzX1HTRsDjP7nILCmIOGOfTBDNtB6smXpsIqs
         g3spGRYwURa0CbhdJPXZyqw0Jm1Q7iaAfLK0Swy+W0gCr9j0ePdE5iXCJL9jGJ1vDOvY
         /ufTcKAVc1yJ87wYYc/eMnh9Ro0/cf4xCAseTxHkJKfOfbr+zIlW35lL8EVpjX3yeo/2
         q4iGCGilYCNs/pTzfjaabbkjhXiCVxMcYK0raSVXqu1KyNmyOqWxnhR88JYXlApxRtg3
         WTrg==
X-Gm-Message-State: APjAAAW0nDuH3+/kT9/4PTHbBHFpjzrArvp8hGqegbfdsbV5Qmt3KZw/
        dPLIOVr5EqZEOBcvWdNc5H4=
X-Google-Smtp-Source: APXvYqxlmwWjXsAYfEHnA4XvVozgwgZX8uLtJKvWZsCqtzdoX+13n5kukHsS9b9SV98uiUbKLWG9mA==
X-Received: by 2002:adf:e443:: with SMTP id t3mr304965wrm.257.1554308679492;
        Wed, 03 Apr 2019 09:24:39 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id b134sm37774796wmd.26.2019.04.03.09.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:24:38 -0700 (PDT)
Date:   Wed, 3 Apr 2019 18:24:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yannick =?utf-8?Q?Fertr=C3=A9?= <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] drm/panel: otm8009a: no error msg if probe deferred
Message-ID: <20190403162437.GP5238@ulmo>
References: <1553155484-13460-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i0LFOk513GRb+T2w"
Content-Disposition: inline
In-Reply-To: <1553155484-13460-1-git-send-email-yannick.fertre@st.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i0LFOk513GRb+T2w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2019 at 09:04:44AM +0100, Yannick Fertr=C3=A9 wrote:
> Do not print an error message if the regulator framework
> returns EPROBE_DEFER.
>=20
> Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> ---
>  drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--i0LFOk513GRb+T2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyk3kUACgkQ3SOs138+
s6HLbw/8DDLgKd+na0BNzO1/uI12X7c1isWBPxuW0gapIkdI7pLkpVgwSCO8tbT2
ZXjFUGlUD6w/oyirGTxugsLrvgkoFv5L+nTxBNAHZZxuJ/jLXOQJ/ax4BC4tEc/i
xe2TNMAgohYggQYEDy1VRPGMovX389qeLUpaECqrsH2EZk6mBU+7gOfS1diOHwSw
r/ZfqwLwTXv2U+WvCw7Wx4HpukT76vPUBQQOXm8GOo8FuQqUdZj00SYIjMpXuSkc
dXmh0uK/19AneOvRRfYq5UjFGr3LO746+4w+ndUsdsjv8IjJ1VfDTKlHJ5kB1RgO
Vh4M2U3gJYr6iTRs4n5+ZLMVW3GgMHHZauublcENUPmq//QKKqdsp1ioY7g7hQsf
HUcIX3NkWdqQfMcOMmNUk5QTcbW43KkNgPsyXTzYA9aczEANWgqcfvTmYTMZ1yeT
hg6lgODrJBqs2BFeMhHSJ8VQyJUo7lQzl9fIv5MA4KZNjKKlFTzMK1peKaH24EDW
YBepp0pv8Ta+TbOvi9aTaY3d7ItafO3FO0vl7eSrAaYhfDsPhuERtJAcmRZGhBW9
J1VoWb6QwnIsuMzfesx8s1im9+AvTqqXqS/BbkBW9U2AqoelstwxhYwvwPkP54IJ
Oqeq3pSeQ11HT5yGiWuCpt+GTXF2+u2EnRmENId+ypOheezz79Y=
=69aS
-----END PGP SIGNATURE-----

--i0LFOk513GRb+T2w--
