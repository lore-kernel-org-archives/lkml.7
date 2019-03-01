Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE544C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0AC2083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551441025;
	bh=8UVC6OHIwdcazfIJj3sm5OshMYauX1dxmV71jZvkR+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A7gLoSn9YDntMt8JKS+i9MKvrM5LYZy3maartkp++XiAvqwYNyN6K1Xx+PHOQyCwU
	 H3HdCCFJlxFh2/eUs89PbOW7xP1oMYwhbpkcj1nA+ZILB79IWH7F1vwX7wvzCsEh8f
	 gZeCQRHzz8l1m24ts90RXnh6R38EDmxPq2KMTvz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbfCALuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:50:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54176 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbfCALuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8UVC6OHIwdcazfIJj3sm5OshMYauX1dxmV71jZvkR+g=; b=f4ltOCsTRazPqxmyv16YF27/3
        GWWiKWZtrOV8+B2TtA+qOlmThBixRr4SqcH+DoHnR9+1Lq55/LVzUWtS3Y69yRZBkvABiiXVAv3Uv
        /3dApNah9ALDa1iGfwSg60s7Wi2zOhXd/TTVWe4ZZCrH4XiXerJG349ChIZXlOmlpgPoQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gzgfu-00028G-V8; Fri, 01 Mar 2019 11:49:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 87CCF1126E96; Fri,  1 Mar 2019 11:49:58 +0000 (GMT)
Date:   Fri, 1 Mar 2019 11:49:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Matt Hart <matthew.hart@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, khilman@baylibre.com,
        enric.balletbo@collabora.com, Nicholas Piggin <npiggin@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, info@kernelci.org
Subject: Re: next/master boot bisection: next-20190215 on beaglebone-black
Message-ID: <20190301114958.GB7429@sirena.org.uk>
References: <5c6702da.1c69fb81.12a14.4ece@mx.google.com>
 <20190215104325.039dbbd9c3bfb35b95f9247b@linux-foundation.org>
 <20190215185151.GG7897@sirena.org.uk>
 <20190226155948.299aa894a5576e61dda3e5aa@linux-foundation.org>
 <CAPcyv4ivjC8fNkfjdFyaYCAjGh7wtvFQnoPpOcR=VNZ=c6d6Rg@mail.gmail.com>
 <20190228151438.fc44921e66f2f5d393c8d7b4@linux-foundation.org>
 <CAPcyv4hDmmK-L=0txw7L9O8YgvAQxZfVFiSoB4LARRnGQ3UC7Q@mail.gmail.com>
 <026b5082-32f2-e813-5396-e4a148c813ea@collabora.com>
 <20190301104011.GB5156@rapoport-lnx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <20190301104011.GB5156@rapoport-lnx>
X-Cookie: Yow!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 01, 2019 at 12:40:11PM +0200, Mike Rapoport wrote:

> Another thing to consider is adding "earlyprintk debug" to the kernel
> command line for the boot tests.

We probably don't want to do that on all the tests since it does
occasionally change timing enough to "fix" things but doing a final boot
with the failing commit and earlyprintk turned on is definitely a good
idea.

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx5HGUACgkQJNaLcl1U
h9BTkQf/VrjYWVkvN4y2fMqvKBsYfN7JSwOOYZywThA3uYBAEhgyQgEQU9gfCFZG
GCArUfZPSoLF+QKmaRiH/otILLye8aZDOLfrye3mxgyjtGkOGGQ/MKg1ez+2tKJ5
l/hD+wsMILytbH95oBmXw4GeCKc/7xnBNSAKMBf17X57IIgP5G8qdVxqEFxJc7N/
W9cKcQInyoqMCv4zgu+A6H3cvtYPkArOyoXfaobPn08evl9nj2foLmaJ59jBB3fR
Qsaf10R/O4Wj1lZQx6hLZGGHNIkBNmx1eNdKhCthLbsFs/isfEQo4IFkZ2t2B7ZT
FhMt4KB/mtFOrf0uwjZXISDKJ8dGGQ==
=owaE
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
