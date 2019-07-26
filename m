Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96446C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E78F22C7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 03:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PzjYIAS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfGZDFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 23:05:53 -0400
Received: from ozlabs.org ([203.11.71.1]:32901 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfGZDFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 23:05:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45vv995nQwz9sBF;
        Fri, 26 Jul 2019 13:05:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564110350;
        bh=0K/XHBDx2AK0BmozXVaR4LsURmjKerChMHFy9WpHNaw=;
        h=Date:From:To:Cc:Subject:From;
        b=PzjYIAS0R6ND1t0BgSu2K14aOFnWCjdAWuCbqqysGUjN8gN23+IjfI8HbQlo+aUfb
         kCaJsQZ7dX3AAe2+DEnEHUpf0+78FY60Onlqh3EOe5FLx+iNQpmUtprk94R4wvCht/
         NFDXqos/1+zrezf2S2c+9hhIk7OmeUCUX5yBym7BsCciUvXUD3YywHqAs31pF7m3H2
         Ga9Q7g8iVxXGiKfZBK6SYKpjJXkE4tQtizYhdKtHeDuPXYw0QVpCvPfZN+LAX29gDO
         WFKInc9rMDsq4vmd+bLE0UebF4PL4Aua0YfKm863LP/SspwCOYoLxLRhDnv1Oyup83
         NMqBjUeDAGhtw==
Date:   Fri, 26 Jul 2019 13:05:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: linux-next: build warning after merge of the tip tree
Message-ID: <20190726130327.1f707cb3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x.AnxvGrxdOAGaWD69s4mBv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x.AnxvGrxdOAGaWD69s4mBv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr=
_replacement+0x1c: redundant UACCESS disable

Presuambly introduced/uncovered by commit

  882a0db9d143 ("objtool: Improve UACCESS coverage")

--=20
Cheers,
Stephen Rothwell

--Sig_/x.AnxvGrxdOAGaWD69s4mBv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl06bg0ACgkQAVBC80lX
0Gw9hAf/QzWurfTbRgfhLlatyHtwIDSI6Lfv9I4wMKNBdHLS3DBCkzALm8L2HX1F
neq3DVbxDT+Ce9B3aalWwrmsiuuU14Yuuic0SDOmF25kWOdXZUHljhBwUQv3RDLl
XP7QWZggUjqFEed8ZVKeEEgC6ph70gmPs78wX7UfyqK8TBxfgWTaiGs7PMMH0zj0
CO1zKSFJjM4wn85QU5PjLM/UZ3aW+L09mpdNH5sctbUV+SMp7qxbIOPXWY/zGMx5
xeu8SkXfUIN1XhsBe6luNTfEJ3hkzpTCRUFGPxddqmR9iKS8AYy2PbgknWvgzITc
SX8EKExp4JBGORkF8UKnN/BWLNRMXQ==
=z4eN
-----END PGP SIGNATURE-----

--Sig_/x.AnxvGrxdOAGaWD69s4mBv--
