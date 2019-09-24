Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749CEC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 06:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3742064A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 06:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZiSRj4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409047AbfIXGS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 02:18:59 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:40349 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405843AbfIXGS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 02:18:59 -0400
Received: by mail-pg1-f173.google.com with SMTP id w10so672681pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 23:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Y7XhwP7BTb1U4UXbbt1qOe8OPB80ewv8WxysEAqyaE=;
        b=oZiSRj4NPaQvtDu8F26chZOKBNycK+TOQ2YfdhyI1+5cDeaqgMdZT9UBubc+rPCSI7
         qjYROEY972Ly9gZvRXPTq3C7nz+SZapgkyrTu5m8SBpWxHaIfpy7hqs5rQBvLdZJIKkP
         5i5hTv0crIXXD48bBiGctdjCUkDaNxd+x1WumxhjPfo+oYmcZsZdgPqQFNX5HcxAVmwM
         yKKJRmUUBfyJRy3mGZ4zMbTwL9F6St5sfMIEJ0nHnt5fZJgwtCkUYeuiJhfyl59dlaaA
         Ai6vfr8vzfM0mK0FUIGo54T6qH8RRZCTrYhgQMf2pqKo0niv56XDtfgLWb2zSl0POyiI
         9i4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Y7XhwP7BTb1U4UXbbt1qOe8OPB80ewv8WxysEAqyaE=;
        b=Qq8GjSseXisUG33iWPKuSvOrEb0Zybt7o/2ohoEx5jFkgseOTkluIZSIuKRCnTBkvw
         R8NLfWKr/eqPOzGktR1uZK43c6cj6FXatnyKC/naakzb/3MlsR8AhSAietQpguyFH8GI
         waGzqgmOdap2+jxGqtBLNRdvgmtb1pDwa5NofFbnA/dTs0V3GflsM336As6DGlxJE5P9
         MVaEkC60QAc46/8mWavheO3wzKn7P93S7/chE2/Zpy6Oi0n/10aLuzYqdSINc+3Z3271
         oPY5Et2HiEbXPCS5sdff59PwcLdbKNBdAD7dRV/O7ZcI3JYW/Qg/TAI8fZywTKFY6e9+
         S3OQ==
X-Gm-Message-State: APjAAAU3jHgGVuFCv/iXKHbdb5isPPOfqT3IkJzIdxPJGmbv8MidedCy
        eYsvczE4EGB7UkwgzHTeH1I=
X-Google-Smtp-Source: APXvYqx2PLsdxB7ytTRN7DcH/ZOPiAdWk2Z3o3C70naLKUaJXN8w2lzdHE45X7WdeBScG1xAGQB3iw==
X-Received: by 2002:a17:90a:be13:: with SMTP id a19mr1124055pjs.55.1569305937093;
        Mon, 23 Sep 2019 23:18:57 -0700 (PDT)
Received: from Gentoo ([103.231.90.170])
        by smtp.gmail.com with ESMTPSA id r30sm699117pfl.42.2019.09.23.23.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 23:18:56 -0700 (PDT)
Date:   Tue, 24 Sep 2019 11:48:45 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Ben sent 132 patches and Sasa sent 203 patches..woohooo!
Message-ID: <20190924061843.GC29856@Gentoo>
References: <20190924053003.GA29856@Gentoo>
 <20190924055202.GB26202@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline
In-Reply-To: <20190924055202.GB26202@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 07:52 Tue 24 Sep 2019, Willy Tarreau wrote:
>On Tue, Sep 24, 2019 at 11:00:06AM +0530, Bhaskar Chowdhury wrote:
>> Is this kind of heaving patching done before?? I can't recollect.
>
>Yes it's being done, and quite frankly Bhaskar, this e-mail as well as
>all your other automated ones ("thanks a bunch") after each and every
>release do not bring any value and only add noise, particularly when
>developers are directly CCed. You should avoid this because you're
>training developers to systematically ignore your messages and the day
>you have a real question or issue to report, nobody will notice nor
>respond.
>
>Just my two cents,
>Willy

I will take your suggestion Willy. Thanks for the heads up.

Thanks,
Bhaskar

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl2JtUMACgkQsjqdtxFL
KRXSAAf9HxZXBcLimPQr/RqXvdp6NSvS8G+7Ry6Zb2h1uooo6liNfrbBQKtq83kE
jU5pchhWDrl/V0C3dIrXyTJWT1I/luQw9XU2pvNTjSJr0dX/zdIWDe4SfV6sBWg0
9XPLKPIZDU0IhgZUprFRP5475jh+83Txti6bGWcLylgw2jlZJ/51iT5a4UwugYZ7
nNTtQqbOGm/s+H2uHuXJpLQPN9lKYlnp/SQuiljGds2Yq1W3pu+OANHPSyZM6wmH
Q+pEYRROlx2sHQe8rEIKa9NNUt2CYAPSpNAMLOqzIFT/UDcCue9jFrhdymahQK+W
N2PRcdjTRTJ9ah1yb+yOdSE6/ThEiA==
=Vtgj
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
