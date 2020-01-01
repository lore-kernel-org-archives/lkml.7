Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A13AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 02:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E65206E4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 02:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjwNHHOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgAACnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 21:43:25 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:45276 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgAACnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 21:43:24 -0500
Received: by mail-pg1-f173.google.com with SMTP id b9so20156433pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 18:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=RiungAfe6C+5SeklziAwU3LRS+YiPryH6DunWlSldAc=;
        b=ZjwNHHOJxg4HoyiWliQbtIeqG/w9Bv8yyhSuyXjJezxPKS3dtOIWnN/qoWT2AvWXGp
         XGkrLMsJA9+CRuySJ7KSzvoTrzpfksmmdOD0VmGlaOR4CANVoXylze3mWgRBPU9mLNaE
         7IXELjehg7TZdSmi75hDPPgEc2sB8HAR3Vo0h8kl6RHUsErfIYAxrlyyplDNuci3NPHI
         BahJtXKTB/oBxCfT6qFOaMISvdXS3ww4mJ+AwMtnFsmczY90Wt4mbap3zAs80h/1h+jo
         Du9TmHMGos9iOLqosPvQIXj20/eLaAYGIHPFjCZp/k7oj1XHldSB4ivLZnSlo+Br6Zab
         Dy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=RiungAfe6C+5SeklziAwU3LRS+YiPryH6DunWlSldAc=;
        b=Z2LAJNRuuToCxWQJvSAMeaUMDzygVih71K81sMrg12RfdSeONy+NdjsD1bytgyT/Ir
         Rzfqxx32rbV4+/MagdB4W96eqYJ18Q3q+UJv2Z382gJ4t+6TOIbDoQ4cVOR9ooDfJtwo
         kmYih4OL5mCqHOLbarVnOM+u928yyepMmZxWpHMPXutRL+PVxvFg6xFiq+csecf/pLUf
         3lYq1IbV0L8OvmErXeLnb62NHe2QGQiojtYQ+/FeqiVZAz9oSPjpI6/avx0a1WxdE7UF
         asB5gA0z1vgqmTN/ZJUa+h+ILTP9kaYMAGxMQOdQ5dwpGvey6Ky3FfJ71FBasGC8dZVY
         zbEA==
X-Gm-Message-State: APjAAAXLJjNV9vz0tx9ZydOWAoR8a8W5MlBan7sBJKt4h7pTqSjW91cZ
        hCQ21wRP3/faM8tkUIcjNJNmgE0X
X-Google-Smtp-Source: APXvYqwKwhPCeN1QSSE0U561mJhFGsCK36OOsoTLhBhYsdGdjHlJjY40vDAhy8jlRFHHf+Zrx2FLKQ==
X-Received: by 2002:a62:1a16:: with SMTP id a22mr80859531pfa.34.1577846603661;
        Tue, 31 Dec 2019 18:43:23 -0800 (PST)
Received: from Gentoo ([103.231.90.173])
        by smtp.gmail.com with ESMTPSA id z11sm48971599pfk.96.2019.12.31.18.43.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 18:43:22 -0800 (PST)
Date:   Wed, 1 Jan 2020 08:13:04 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Have a prosperous year , every one of you! 
Message-ID: <20200101024301.GB30021@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline



--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl4MBzEACgkQsjqdtxFL
KRUIFggAo+HPa/4uC9N3PBljBOjEGYk3irdrzymDxFFgfywSv2QYXzVz+t0VXsh1
pyTHIZIWkh/wv3wxfYT+FCamuc5IaNBR3XsBTMouFCSWa3t6JEUvuN9kDs8KEMaw
NQBmnn8nCQFdf5NrHYr2RT6mdYk1iJ8/hc4t89uFm64XlKVTsqysPWqcJ8F76/Op
zSAETff/hQ6j+e5sSbgtL3AO20vxgoNcvXDGAITQwnt+wnHDtSLIm+mAcWJsMsXZ
/9nUQZFSSHQDoNX7+jC1T6kQf+dUjDFy468Z8B3ZcLcKhKbdFKLcTJhuJGIk7v2v
mKiemja0R3DJczITlG6cZ2Ct2xEQaw==
=pEHj
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
