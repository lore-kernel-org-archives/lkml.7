Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E579EC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE2021855
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JLB0DUS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCTAC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:02:57 -0400
Received: from ozlabs.org ([203.11.71.1]:42361 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfCTAC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:02:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44P9956DWbz9sNH;
        Wed, 20 Mar 2019 11:02:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553040173;
        bh=jehP9+YT/rAivcVGOfJHVCT+k92Lsz+iBSFzJvUFN/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JLB0DUS0XtDVE1T2hGU9fOTTCcPEXNuudOsbOY2P9sBGeACPjFJRvurNz1hv4BTSL
         Uj82m2Jd+FuuKJMmj+QHXF1gWDmATsDVYcAtzs+qR0XwLQ7PLGXIaxqNn1NGnLhGtU
         SWFMStDnDHgKbyDYvxMsk4xN9fvPXeGjjhHh/2qb6EX9OAlunS/yB0Gj0yKZNiS7eB
         Ji6GENiI1GQiY99aHr8fMba7nmuJJS69cm3KIQr06PwOXRP3jgZXXu/iizdctQzwjW
         CfvEvUzSKGAY8LL3tviwU3qjkIRgkE3bl942ktLdOx4jUYd1r5auLSOEIDwr1nWqfA
         yXNHtkm/V8GwA==
Date:   Wed, 20 Mar 2019 11:02:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, axboe@kernel.dk, dennis@kernel.org,
        dennisszhou@gmail.com, mingo@redhat.com, peterz@infradead.org,
        akpm@linux-foundation.org, corbet@lwn.net, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v6 1/7] psi: introduce state_mask to represent stalled
 psi states
Message-ID: <20190320110249.652ec153@canb.auug.org.au>
In-Reply-To: <20190319235619.260832-2-surenb@google.com>
References: <20190319235619.260832-1-surenb@google.com>
        <20190319235619.260832-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gcf3x9pNF4bWcL9pBwUmVyY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gcf3x9pNF4bWcL9pBwUmVyY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Suren,

On Tue, 19 Mar 2019 16:56:13 -0700 Suren Baghdasaryan <surenb@google.com> w=
rote:
>
> The psi monitoring patches will need to determine the same states as
> record_times().  To avoid calculating them twice, maintain a state mask
> that can be consulted cheaply.  Do this in a separate patch to keep the
> churn in the main feature patch at a minimum.
>=20
> This adds 4-byte state_mask member into psi_group_cpu struct which results
> in its first cacheline-aligned part becoming 52 bytes long.  Add explicit
> values to enumeration element counters that affect psi_group_cpu struct
> size.
>=20
> Link: http://lkml.kernel.org/r/20190124211518.244221-4-surenb@google.com
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

This last SOB line should not be here ... it is only there on the
original patch because I import Andrew's quilt series into linux-next.

--=20
Cheers,
Stephen Rothwell

--Sig_/gcf3x9pNF4bWcL9pBwUmVyY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyRgykACgkQAVBC80lX
0GzGdwgAkeERrC49NHtT6/Phx/CoT0fGnk18tNUFLom+rq3rOBQK2wx1PjucbibK
vXCE9EjVXmM1DNhVakECzW140fJtlo/sepGVTJhmSOUsMbOF1OI5PrAvszpgSjSU
5UF7ikasO20gSNsechnFvkJo4NA5zx/se85Mr62VKU8UgfAUcY3DQwATE6EJiQOY
vuaHEsGdYYpgctzrz9buJn2eXKSqatWwteCeyQj2UDsfXz63CCJxlQrO4p96B//c
wjfoSNMnOa25s418YxLiRmLA/9Upk9CMWPzQ7J6v3/TVGUNLvjZPRd1qBUE2za6g
xvo9LR9TcLA3X/p682Ykd4lk+ccBZA==
=KZbq
-----END PGP SIGNATURE-----

--Sig_/gcf3x9pNF4bWcL9pBwUmVyY--
