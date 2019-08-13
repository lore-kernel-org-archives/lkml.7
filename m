Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9791C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86F720578
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rai9LDgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfHMJqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:46:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54110 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfHMJqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:46:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so884072wmp.3;
        Tue, 13 Aug 2019 02:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=scaR5X+RyCRe+SYYdk2npm/6DlNbnAymQiIB9hKehF4=;
        b=rai9LDgYuel0mVQa/sfub7kdSVgU70GXTwNUSsZ2yqR6rDPuQabCwDt9ZL3ojs/O78
         30uq+BhCdtIZegQlv0hPK5crH+W0mQMWKGD/sO7wegqHxaOnjcp5AgGp40XRKaSPg94o
         fdlxuZxrFxeC++RTdZNgx98E89zfWfcC2Vaz6g6RZ4lsUBVxSRM9ClFzNTx0h8xfZGtw
         Ax0omruq8mFu51ctWWoMAuNgmBPi8XBz4MqeJghWzSER8KoSvSuYAULySDsG16+VCn3o
         h8pilQgX6ffeykcC3WkEIztw3vnrCIuEXjZ0H0e2T2uzFHUPYnCl6EV6BnsXz1ek0jPW
         6eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=scaR5X+RyCRe+SYYdk2npm/6DlNbnAymQiIB9hKehF4=;
        b=YMRij1ZQYAtybXnhNNJWUNCNAfAX0A7PSzt7s5cO0iFEW5t3w95hEq225upfdzRXzu
         /mEERCw2JzBBdN2HQDgF/f7DrsFKK//ykFJBKs0AidWNbM/WLFOEwq5pjh9RdI1NHXGc
         vuVkydDOcww9/AcLc4afDw/jQn1Rsqx0Ks0dCrQDHtubF9OMZkI+bFXZU3gLL8RFY09r
         sY+8pdC03SBhcc3QxhOAmwVvMCILZQmNQRvutRwdI02BPsWTMX3npf+Ybow6VJ9YZgvS
         inHP2EIZjUfa285Sd4oYUKjKkKC/rEJr6oGdYDEehOXqLHPimAlR17mlKrs6bjVyczzQ
         i4IQ==
X-Gm-Message-State: APjAAAXeh3rfcjhMNG8JQUNTbv3CEeUJ5+W5HonRXE3+qUKwX15/9NLC
        rxGmbuxA5naugYd+COCU2WQIDltS
X-Google-Smtp-Source: APXvYqxdB8crd+FQ9c96tmwAfV7tvc88uo+6Bvo2B4YWlzK13Tlue1yP04lY8CuxV7lOllbwXNMwGA==
X-Received: by 2002:a1c:200a:: with SMTP id g10mr2014056wmg.160.1565689597594;
        Tue, 13 Aug 2019 02:46:37 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id w7sm122386485wrn.11.2019.08.13.02.46.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 02:46:35 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:46:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, ldewangan@nvidia.com,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ahung Cheng <ahcheng@nvidia.com>
Subject: Re: [PATCH 04/14] serial: tegra: protect IER against LCR.DLAB
Message-ID: <20190813094635.GI1137@ulmo>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
 <1565609303-27000-5-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cVp8NMj01v+Em8Se"
Content-Disposition: inline
In-Reply-To: <1565609303-27000-5-git-send-email-kyarlagadda@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cVp8NMj01v+Em8Se
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 04:58:13PM +0530, Krishna Yarlagadda wrote:
> From: Ahung Cheng <ahcheng@nvidia.com>
>=20
> The IER and DLH registers occupy the same address space, selected by
> the LCR.DLAB bit. Hence, add port lock to protect IER when LCR.DLAB bit
> is set.
>=20
> Signed-off-by: Ahung Cheng <ahcheng@nvidia.com>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--cVp8NMj01v+Em8Se
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1ShvoACgkQ3SOs138+
s6ELYg/+O1adqcMU5/CWtP2Mlzii/9QsLg7Ocr3E1iAHX1QgRkmcf85BzjkgPUt1
2T6erGS1mdXQFtlWADtskxzCWdKeOoUlKAdPmbApwB0QF+ELBUhjbOGfRS1vUg6I
/9jeiW70PL9cvuw1/X2E/hIwMTNPWmKfnvP+ONzUwlwQ2Kw98FoW9zbNAUlPgS1B
tj61fXIFNgNhVL2PbAUsWXfakFADl/X4dGxs+pDLOL61xUi4Ag4CXhS6tGckEKwS
6alqh/cxVmOl4OFAdaTo5dUX3rZ91dAg7Q420SjpkzVZBqxuj5lW2yHLetYVyXXZ
4LX/QOa7wSo8ImnnxhcNJQcEyL6DxP1szp2Cpp077tfokinqLg7jd1wf+PYJgRcU
8hE2XwpiUOg2+MHCZ2seseQ16zBJIgwI4CW+hmQJaxDeO45TCObZVD2Q/UqT+pFC
s8RnxF33IpYatRaIFrrDMJNOrg0+hPbZQlip2epvheR5uXNmtGVX9D9hIlnaaGLj
VfFr04huq6qaW8VPzYjWNnFQaclFHCt5OLJqa7KUHZlmGD6GB2XPiJIcuQ/MEoBd
iZDvcHNDuonVWu7YlDqaj+Zk+AU/mstYsNjF+j9mdwKbg3/UI61YCvtXLRTgNUmX
A5lpw2v9X1xdro8y9hJ6vKDQCaRSgwxd5nf7KCkNnRtQ6HOgefw=
=itlT
-----END PGP SIGNATURE-----

--cVp8NMj01v+Em8Se--
