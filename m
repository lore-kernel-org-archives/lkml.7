Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7D1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF5620811
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NI2m1mTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfCTAPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:15:21 -0400
Received: from ozlabs.org ([203.11.71.1]:32779 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfCTAPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:15:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44P9RT2k7Zz9sNG;
        Wed, 20 Mar 2019 11:15:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553040918;
        bh=le9TbhZDItapW6nvIxpJwzRAc81dmNc+5o3O5xGMAeE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NI2m1mTBHRjd7kgvfU1Br2PoLv8Ehp+2MGlCsVwXmPjd5wA1zZQqrnU4elSdYnmkc
         k/lZk48rLLwdnHlwItgXPwtxPc2e6YOcUnPjTjxscrlvV0mKkOvyWfH4Ow+0J6NfCi
         /RKcysO0HJu//7TBh27y6+i+r/vFoX5Wk5jdaUYxLiDG+S+qGhFF7CfjLhLOshUY+9
         0LJ9vDMQ78+7pDVOZ1Toyp8q9GhSooPLER84bIOQ3+Vo73PqPLye/lfp17qkCsYLVE
         xIAEhmqRpv3GvcxLW79/WZ2wbqdSNYobOG4ykedB+68kvQyoHqt4fua8NUgTofeclz
         gpdAJwcvOzPYg==
Date:   Wed, 20 Mar 2019 11:15:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, axboe@kernel.dk,
        dennis@kernel.org, Dennis Zhou <dennisszhou@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v6 1/7] psi: introduce state_mask to represent stalled
 psi states
Message-ID: <20190320111516.6e151efe@canb.auug.org.au>
In-Reply-To: <CAJuCfpFEqv+x2GnSeU_JLQ3ahvfgNVPYyoRAxkDHcvVw-4r=jg@mail.gmail.com>
References: <20190319235619.260832-1-surenb@google.com>
        <20190319235619.260832-2-surenb@google.com>
        <20190320110249.652ec153@canb.auug.org.au>
        <CAJuCfpFEqv+x2GnSeU_JLQ3ahvfgNVPYyoRAxkDHcvVw-4r=jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lana8mbTZC3vblqYeUy4oci"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lana8mbTZC3vblqYeUy4oci
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Suren,

On Tue, 19 Mar 2019 17:06:50 -0700 Suren Baghdasaryan <surenb@google.com> w=
rote:
>
> Sorry about that. This particular patch has not changed since then,
> that's why I kept all the lines there. Please let me know if I should
> remove it and re-post the patchset.

As long as anyone who is going to apply this patch is aware, there is
no need to repost just for that.  In the future, if you are modifying a
patch that you are resubmitting, you should start from the original
patch (not the version that someone else has applied to their git tree
or quilt series).

--=20
Cheers,
Stephen Rothwell

--Sig_/lana8mbTZC3vblqYeUy4oci
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyRhhQACgkQAVBC80lX
0GxMQAf9HtDOa/glS11zisJgskGjpJIb4d1mRQfZl2A7I1rgPBRgfZIcx8xWTjXG
DTqMbVKmA6JEmwiQw979yPRrTcxMJexn6Tshyb5B65rFgIVUqEbQWKShlGTDoVvU
LQKmkhqW6m6KdTWZiF9LreQyt8HkyUYP250OTr9hREuDhZBAXs422BBw5/Xpf1nR
NlloZtEs3ofcZ79cN9ltoeYu9cF7iR1KAuRbXRJxztsnu7Jm4R5OB+m6tKRugy8t
XNfvMvdwnPrD2Shfnl++ft8MCBj2UCL/ryoeHl8mz2zI/StnZAr07YoQIIeXL1au
bDs6utAh2+KlWgI/Ihrlc2M8DYPmJA==
=ftsv
-----END PGP SIGNATURE-----

--Sig_/lana8mbTZC3vblqYeUy4oci--
