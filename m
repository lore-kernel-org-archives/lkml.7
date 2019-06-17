Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6234C31E54
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 04:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E6220820
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 04:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="W92Essvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFQEwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 00:52:50 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54535 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfFQEwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 00:52:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45RzNZ4TK9z9s3C;
        Mon, 17 Jun 2019 14:52:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560747167;
        bh=NhWQOXJCvrlQJpYKQREYcFcqGfZTQWzqVfbAUlxCZ+w=;
        h=Date:From:To:Cc:Subject:From;
        b=W92Essvi66xi3pPghCdvPvgCHzqIEywmR318CSspX3kSPxmBjf3JdLSx6Y5bqtptP
         buYPotSjk6l5utFgyMCtVcSF7j1/kbnExtZSZB+Y4hshJZv6Eup2e0AFJQHP6d1kA2
         QwS7oGoiMr/k06TG2KMUxek71FVgE5NS98Qt3ATQu2i3Pg2+ph9EegVvz40RoIXET0
         6iF4dB+OwPbvGVlXZuKvsVI42w2rIJSHwZv2MM29kGdZqbZDETb9wNDz7oDLuJJzpq
         Ywo8BSdsmDBG9IkmF8erUQ5jBQEq6uK7UT/i6D+Yd3QllehmklKobWouLL6AwVdECE
         G1CwZeGGJuO/g==
Date:   Mon, 17 Jun 2019 14:52:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: linux-next: build warnings after merge of the clockevents tree
Message-ID: <20190617145245.0e03163d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/sK4IR13dSP4hPGCWXaZZwlK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sK4IR13dSP4hPGCWXaZZwlK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the clockevents tree, today's linux-next build (arm
multi_v7_defconfig) produced these warnings:

In file included from arch/arm/kernel/vdso.c:30:
arch/arm/include/asm/arch_timer.h: In function 'arch_timer_set_evtstrm_feat=
ure':
arch/arm/include/asm/arch_timer.h:131:1: warning: no return statement in fu=
nction returning non-void [-Wreturn-type]
 }
 ^
In file included from drivers/clocksource/arm_arch_timer.c:31:
arch/arm/include/asm/arch_timer.h: In function 'arch_timer_set_evtstrm_feat=
ure':
arch/arm/include/asm/arch_timer.h:131:1: warning: no return statement in fu=
nction returning non-void [-Wreturn-type]
 }
 ^

Introduced by commit

  11e34eca5d0a ("clocksource/arm_arch_timer: Extract elf_hwcap use to arch-=
helper")

Look like a missed "return".

--=20
Cheers,
Stephen Rothwell

--Sig_/sK4IR13dSP4hPGCWXaZZwlK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0HHJ0ACgkQAVBC80lX
0GwwsggAgkI1Nc1Kj3evTFOhrhWkag7pLz7gSJzaOjOLsJaNampSbm28c/L+XuPT
8jpnHG0Q+ZwTIzFqsoCSleOLMPfQW9HWvC/e/zdo3+/N7eSb5NRyjfkQPAgPFw7w
9DLC6cRs0KzB1/SYgFW7ThbE20Y+IXW3RUxRx1WlmdwmxY2S+hSU1OuuzFX3eWhc
PWrm8RQIQcTqrN7DgyHb8sz4XuFUoljM58XsSVgNK7Gf6TYQN0atCKzJXXBlzfmS
smVR204vS7pYXGPseDaa+UqJbbCXXaLEuNEAuTqKrGyZFKWuaWIsWJEMHskcCSkn
6xKzCSC7ONbZi+ojbMXiPx5Ha4PWRg==
=LDBG
-----END PGP SIGNATURE-----

--Sig_/sK4IR13dSP4hPGCWXaZZwlK--
