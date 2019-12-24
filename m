Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F758C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D06D206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgPURDOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfLXM0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:26:07 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:41252 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfLXM0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:26:06 -0500
Received: by mail-pl1-f169.google.com with SMTP id bd4so8419543plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 04:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=ESzq0vzDZddYDDmLkk7e3v4MrrceRrpkmdPMPFKyS0E=;
        b=DgPURDOhK4fh/Lyd+M91t6W+yokOrcExwIEPcYEvxpHtG7jMQ5Eh8jo/KPHXaxAKQ8
         LyMKwhHsuoAWq7U2mUpU5zGp9+A4VsDP7YQHr2iyfTzjmsrjUF9d64B31hRTgDldQ8FQ
         nKdfVCqi+zhr3OLQjzrtypR8Da5PwO+fOx9BfR8JWJO9zZB6uwdpM80qTWWjbADjvluN
         CxtYNjzWdGCXoSIwkLwV3cyNeGJO3zH6xsT02NZwJDGMTBWrhyrRUaOP69xbCST1abst
         stsktFmRLarridj4H5z57QHMbWcDD9tNexAb743Bj4Tx3xdI8JzrV4iyUijbJstgiqWe
         CmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=ESzq0vzDZddYDDmLkk7e3v4MrrceRrpkmdPMPFKyS0E=;
        b=SDNiLU/bzvrqj3Mduw4qZ9d4Tew1PH7J+jGeTxa3sxndZEcVy0L8MhITMlibzsnxwH
         1jGasofIIVq2cDg1EqkRWs8kSyZ8quSRIbYqZL7+YWyyv77kiW6UaIVxnT6dKBi9Z7Nm
         IxI1gDs7jUwomL8dTfCyw0THiNYvpOPbFGHchJdKT3y3uBjiiKtr1uqocLYbsaH8iUOF
         vLGkQH+FEE7YudAYc6I5bBWVdWg6euJz93bn2PjgHV/KnJ/25aifVe5TGd19Ia9jFFyJ
         8ISQBx4TKiIitKUh6mAwKgWP9s6UDAcw9mwowtHkGdv0uUu/MZFFhGNEodW9+yv2Ipsv
         42zA==
X-Gm-Message-State: APjAAAVIT0teJ+lL41gpLqZCpIFvR9FkOhyPXKO3a7HauqT1H5VXLGbV
        +ocvrnP02cmABNiFXGSbw9buv1MywOI=
X-Google-Smtp-Source: APXvYqxv9Lt+YjKZkinT6T+5l2rz4huK0zODOuwHUtoqJVdDs4uhTJTo2RWBE1WQJOHNbHNTnbDyjA==
X-Received: by 2002:a17:90a:868b:: with SMTP id p11mr5580177pjn.60.1577190365789;
        Tue, 24 Dec 2019 04:26:05 -0800 (PST)
Received: from Gentoo ([103.231.90.174])
        by smtp.gmail.com with ESMTPSA id j8sm2661926pfe.182.2019.12.24.04.26.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 04:26:04 -0800 (PST)
Date:   Tue, 24 Dec 2019 17:55:54 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Merry Christmas to everyone!! Have a good one
Message-ID: <20191224122551.GA9214@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline



--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl4CA8sACgkQsjqdtxFL
KRVP0gf/RjTMTMwWxK7iFbxV1kpTUp7//quJYj84emIQ7sc7tICGjnjsuIOX+p7p
UhuYN2e0qtMRLG0iU6UYXBmPCDB8NBHHFU2SLJ/S6DYd6DgvRRjJOjNFfiDjruJW
rFE61vj1V+CoTwYeMT7UfST6uj5yAOzul0+lLU+nEVkmJMCI/M1FHRDFRynEyBC+
cdCT3A/B2hq3148wCteIvSGOVy9XpYrghTKYJYDP5PvcZ4qe2FF8aR5z3fzTvkIX
0DVtBzzmuTA6ge2TTuF1rnkdZr87Gsuq/wMRudChhkl9lbsVS3W+v4h1IObfN79L
Qmhk9M8sCr43wbTQI6QrsuDh4VhE6A==
=JNup
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
