Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990F0C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DFD2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fVrQtcmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfFZMe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:34:58 -0400
Received: from ozlabs.org ([203.11.71.1]:44945 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfFZMe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:34:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45YjCf3X9Sz9s3l;
        Wed, 26 Jun 2019 22:34:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561552494;
        bh=J5PDmh6SRrKgp6sEYtERooHfMpzUiWLuB1ZBRLYUfIU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fVrQtcmRPrIzaYqWZEBexxFqXI4UGsfoVYY4+0cuAArY5im1qOy5EZI/npYXBmxnb
         ggPCK+NMDRJPa0LQ2VKcvyyhcFZMaxCwDAJZXIJg1CnrQT369xHmtu+NC0oyd2ys2M
         Hor4oWld5F1g5WdV/UD4bSffjAV6TuSSjd5pHNutXnrKbS2fuc4j05v2niVvGnP/wt
         y+h91wxS2UcjBdiuQQzzyagfDNpV3rr9ITSuu6ii3uxiwGvo11gp+ekHVupapPUM3j
         HMxno2TFFAxIiFDxGlauQWVrYMxc+RhW9JlherbKQTNqWeCUZwoBN0HbdGGM4BfvG9
         4nOeuaBU9C+hw==
Date:   Wed, 26 Jun 2019 22:34:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190626223452.5a7deab1@canb.auug.org.au>
In-Reply-To: <9e850319-8564-5b1f-2e1b-7d327215043f@arm.com>
References: <20190626214125.6d313c15@canb.auug.org.au>
        <9e850319-8564-5b1f-2e1b-7d327215043f@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OgO43uiXAj7MuO2GCk80S.I"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OgO43uiXAj7MuO2GCk80S.I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Anshuman,

On Wed, 26 Jun 2019 17:32:18 +0530 Anshuman Khandual <anshuman.khandual@arm=
.com> wrote:
>
> I believe this might be caused by a patch for powerpc enabling HAVE_ARCH_=
HUGE_VMAP
> without an arch_ioremap_p4d_supported() definition.

Ah, OK.

> All it needs is a powerpc definition for arch_ioremap_p4d_supported() whi=
ch can just
> return false if it is not supported. Shall I send a patch for the powerpc=
 fix or just
> re-spin the original patch which added arch_ioremap_p4d_supported(). Plea=
se suggest.

I'll add a merge fix patch tomorrow.  Though if you can send that patch,
that would be nice :-)

> Today's linux-next (next-20190625) does not have powerpc subscribing HAVE=
_ARCH_HUGE_VMAP.
> Could you please point to the branch I should pull for this failure. Than=
ks !

git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git branch next

--=20
Cheers,
Stephen Rothwell

--Sig_/OgO43uiXAj7MuO2GCk80S.I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0TZmwACgkQAVBC80lX
0GwbvggAmeOxSKwcEb5rsdNxfdUpUYLhDvPlFPZcqPofaMS2laFfVK35iuv40TXB
gxlU0t21jckOaVkkLl30bGTrmCRgfx/rrtDkDknMK4JJCIk8qaCzkAhCu2htB19r
mS5Zlph3feMt4md2YoWliS6BRqrIOP8TySs2D6t51fEz906c/81Ldr1+E4L5Qkm5
ng14uHDLFdYhXU92OctX5ps/MsAAJKHHXeHZQkoZRzmFHqjvgifuTsPjBw9M3zSN
Aj/RW+mj1Pje2jXBPoeACVKlbHZwEQ9IKM0prj1cIn6aMGyX7AJ1bfahUqgsCXt0
m2GC0pWSpgxM1DBBDbNsvaJXcz2a9A==
=viRL
-----END PGP SIGNATURE-----

--Sig_/OgO43uiXAj7MuO2GCk80S.I--
