Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EDAC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB39527A4A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aSIFYxHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfFCOcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:32:01 -0400
Received: from ozlabs.org ([203.11.71.1]:49757 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728975AbfFCOcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:32:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45HcvH3K3cz9s7h;
        Tue,  4 Jun 2019 00:31:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559572317;
        bh=9CSpMug+i5yMEa9Kh1285Mi9cdGyu1MghkPju4EXwHk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aSIFYxHneOS8/EOrgnuN6HYuL+Kq/SKfwpd5sfHzNxUD5wqS8A5eOJoxCpfkxShsR
         DIa0BgZF8/jrwFdkNwpuVCqzy/jlmM0/MPUuciMfNvNzwRL8M4rJyiSoXig+eU97Uq
         /LVxMKvQXiTLuXlhxJrQjkKSlsYQ8QOGqdyarRMTtHm9jtMmdi5J0nm/bpEU9XUtGD
         cIbztJ3tOY3MOEIzcQ+nznEwe0b9CM6xH42VrTnrHUIoLilVyChzQOcCMZXirU2/m9
         HU9BONazvVQqhNZ+ggH6uR9xc3GbQh6ZKB6B+J33UQHRaVjeDD5tWbmyDvqmc5uHRl
         Svamyc6afxd1Q==
Date:   Tue, 4 Jun 2019 00:31:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, Andrei Vagin <avagin@gmail.com>
Subject: Re: [BUG BISECT] bug mm/vmalloc.c:470 (mm/vmalloc.c: get rid of one
 single unlink_va() when merge)
Message-ID: <20190604003153.76f33dd2@canb.auug.org.au>
In-Reply-To: <CAJKOXPdczUnsaBeXTuutZXCQ70ejDT68xnVm-e+SSdLZi-vyCA@mail.gmail.com>
References: <CAJKOXPcTVpLtSSs=Q0G3fQgXYoVa=kHxWcWXyvS13ie73ByZBw@mail.gmail.com>
        <20190603135939.e2mb7vkxp64qairr@pc636>
        <CAJKOXPdczUnsaBeXTuutZXCQ70ejDT68xnVm-e+SSdLZi-vyCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/T8JB7vmA6.0wdOso2xn.yrp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T8JB7vmA6.0wdOso2xn.yrp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Mon, 3 Jun 2019 16:10:40 +0200 Krzysztof Kozlowski <krzk@kernel.org> wro=
te:
>
> Indeed it looks like effect of merge conflict resolution or applying.
> When I look at MMOTS, it is the same as yours:
> http://git.cmpxchg.org/cgit.cgi/linux-mmots.git/commit/?id=3Db77b8cce67f2=
46109f9d87417a32cd38f0398f2f
>=20
> However in linux-next it is different.
>=20
> Stephen, any thoughts?

Have you had a look at today's linux-next?  It looks correct in
there.  Andrew updated his patch series over the weekend.

--=20
Cheers,
Stephen Rothwell

--Sig_/T8JB7vmA6.0wdOso2xn.yrp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz1L1kACgkQAVBC80lX
0Gy6Nwf/eOmUW6/H8C+yiT3y7MfpDwgD9FP9IuOOQsC1eGfyZ//CGE7jojPjuwCp
827J8ZM8CaEvBsV9iELlKg+w1zy+RrNVDoNQE+l2z8O7MJYW9Tm9u95cdAsLqWwA
oZfzmqKp+5GJ/rYEXm/zRzT9rkR/NnKdUr5WumOp7gUlVhzjQ9KgFQPnhjrIB94Z
Ib+WdHZ9IgaisVD1pA8rWju5wTAq2SyKLKfAL35h18Lj6T0+QZiEx23Je8GiiWtR
30VF4LCZvtL95TjMz8vNDOIEU57lDRSXEGQcM17KHLVLpM3a1VmN6IKYyVTKd21m
0FAZGs8EWDEh4iitzOEbJD0KE6N0jA==
=59/d
-----END PGP SIGNATURE-----

--Sig_/T8JB7vmA6.0wdOso2xn.yrp--
