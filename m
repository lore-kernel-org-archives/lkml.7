Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327A1C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090922187F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 23:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfGPXjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 19:39:14 -0400
Received: from anholt.net ([50.246.234.109]:54008 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfGPXjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 19:39:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9682C10A264A;
        Tue, 16 Jul 2019 16:39:13 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 12F3ajGnutvd; Tue, 16 Jul 2019 16:39:12 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 61F0710A1AE9;
        Tue, 16 Jul 2019 16:39:12 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 600D12FE2547; Tue, 16 Jul 2019 16:39:13 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Emil Velikov <emil.velikov@collabora.com>,
        Eric Biggers <ebiggers@google.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drm/vgem: use normal cached mmap'ings
In-Reply-To: <20190716213746.4670-3-robdclark@gmail.com>
References: <20190716213746.4670-1-robdclark@gmail.com> <20190716213746.4670-3-robdclark@gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Tue, 16 Jul 2019 16:39:11 -0700
Message-ID: <87lfwxh7mo.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Rob Clark <robdclark@gmail.com> writes:

> From: Rob Clark <robdclark@chromium.org>
>
> Since there is no real device associated with VGEM, it is impossible to
> end up with appropriate dev->dma_ops, meaning that we have no way to
> invalidate the shmem pages allocated by VGEM.  So, at least on platforms
> without drm_cflush_pages(), we end up with corruption when cache lines
> from previous usage of VGEM bo pages get evicted to memory.
>
> The only sane option is to use cached mappings.

This may be an improvement, but...

pin/unpin is only on attaching/closing the dma-buf, right?  So, great,
you flushed the cached map once after exporting the vgem dma-buf to the
actual GPU device, but from then on you still have no interface for
getting coherent access through VGEM's mapping again, which still
exists.

I feel like this is papering over something that's really just broken,
and we should stop providing VGEM just because someone wants to write
dma-buf test code without driver-specific BO alloc ioctl code.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAl0uYB8ACgkQtdYpNtH8
nugJRw/9EiWQGRfpgMVOaSPrCIjAmsQZR/yI4mMxq6i3W567axR5MUXdes8PKkJW
5LDqVM4OBs7GY/Rl76LiSO+LeMXuUH57MYAhsvzeweB4vkuPibrFjPLhzHdRz5/P
augC8mcdlSuP7xZKKGlMuOHfNsMipAZR0lOT+yiVfZ+UfWLNXTky5moA33yyPT1n
d3YuPIYFWUrZxwGlEQocBJUE6Us5lMieNWdfuAFk9Uhqtz47N8KwbnKPW0FkVKuF
E3oedpmxIyySwWF16gJn0jwy9gYtnmxyFmSk57V2F8fNvnwGP9JWkpAZEEqv4NMy
vhWf+lUHxSVj48oWg0B7jXliFA50qjeJA3cQWujXyaKusV99ujoQzWzxAWCWhDCG
K/kSMHgkLTbz+hOSXfOupKLV7I0aysXZB/USQOln/wSk6AajkEzYMr6l2BxZWuko
BcGoBCmt6z77yqyAbQOPWuP0LivFore0bLQyXauOSOV8fkUpmx8gNXtkUPy9drCs
axR3qVp0pfLItCdFTUXhV594hX3J4aN9SMojcAW+Lfmw8/3xDwEPWM5eAR10b2uo
QioDDThXBXTrc6Vx/NEIouY9zMPuD/mWknuS06x84HmLmFNj0MaD96CQU4yjy5he
eg2k8an5SqjXoSVC2Pk3Cm3A3Yq4P9FHMiUh9wWtj78r0yIO9j8=
=koaP
-----END PGP SIGNATURE-----
--=-=-=--
