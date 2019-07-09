Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125B6C48BE9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF75121537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Pd3824bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfGILQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:16:05 -0400
Received: from ozlabs.org ([203.11.71.1]:43231 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfGILQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:16:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jfrf2864z9sN1;
        Tue,  9 Jul 2019 21:16:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562670962;
        bh=mbCIY5CRtRgY9CYsdg8sqFidcGWcrM+FZsIZRPd9EgQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Pd3824bjR1gb9fg4yuFXd2y30vqsHpfZyhw15pvM2tw6qFjMvHZa7xCHflrnkqsWb
         5oTFP38QDWOnsHLvx9PGAC2VDtWmDMPUCuDI/znRCimU9uwWViGU2O02BNDUMg1+b1
         XFRro4t8mAJSQSZN6ug/kkV6YLF5op+wW7LMD53Ua6I98RLeAEATWbX8ivHOSMh5tI
         clDJCyel1YJfSP4kSboHdsOjdB3ZiN4hbhrpfrQPhQ5hjGcSroykOs4iXGlnPYkSzl
         eAU+KKZB2EAOhp7OyijPcnygdxI1xH/VgnQmE4GkOHqWHe2cd4H4islKJ2+ZttUh+B
         EuKV6x3huhLag==
Date:   Tue, 9 Jul 2019 21:15:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190709211559.6ffd2f4e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EsDjB3Ui6E2wumxtzLSIE+x"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EsDjB3Ui6E2wumxtzLSIE+x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

arm-linux-gnueabi-ld: mm/list_lru.o: in function `list_lru_add':
list_lru.c:(.text+0x1a0): undefined reference to `memcg_set_shrinker_bit'

Caused by commit

  ca37e9e5f18d ("mm-shrinker-make-shrinker-not-depend-on-memcg-kmem-fix-2")

CONFIG_MEMCG is not set for this build.

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/EsDjB3Ui6E2wumxtzLSIE+x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0kd28ACgkQAVBC80lX
0Gxj0Af7Bsq63ob7jUg37ZqO1yIZfuvViZsqsoQHElEBEIqK9czOgfDOGruvwDhr
u5/euv99AuuEBByTjjTt2bf/hfgNn260Qc+V5dkGK0DQPYCa/0r7DijfbqGsl68p
9huVy89QLHKNSAXuRPCxIHI+8zNOSMVxvjZ9zyVbaSR/niRZ8vzA1sBEgE+SgyQ9
sofDQ9f/k8y9yUQHQixjyzHii7KvX8j9Q03HN+91QU9KtMJmioyCDIm6O32Jibuo
+Hvm7SVzauGwg8N5JHFdrDyDVbZi0LyBitzTG+TMJNAPZfPk7kfyL49/AADOAtRI
R+AYLOMnHcVXlZniyM1/oRd1pF8ZIg==
=nB85
-----END PGP SIGNATURE-----

--Sig_/EsDjB3Ui6E2wumxtzLSIE+x--
