Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FCDFA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D1C2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394159AbfJPPaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:30:03 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:61477 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfJPPaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:30:03 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2a.mailbox.org (Postfix) with ESMTPS id F1804A1834;
        Wed, 16 Oct 2019 17:29:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id kkkccsEGnCco; Wed, 16 Oct 2019 17:29:55 +0200 (CEST)
Date:   Thu, 17 Oct 2019 02:29:46 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cgroup: pids: use {READ,WRITE}_ONCE for pids->limit
 operations
Message-ID: <20191016152946.34j5x45ko5auhv3g@yavin.dot.cyphar.com>
References: <20191012010539.6131-1-cyphar@cyphar.com>
 <20191014154136.GF18794@devbig004.ftw2.facebook.com>
 <20191014155931.jl7idjebhqxb3ck3@yavin.dot.cyphar.com>
 <20191014163307.GG18794@devbig004.ftw2.facebook.com>
 <20191016083218.ttsaqnxpjh5i5bgv@yavin.dot.cyphar.com>
 <20191016142756.GN18794@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xxhpmezvextnbaiz"
Content-Disposition: inline
In-Reply-To: <20191016142756.GN18794@devbig004.ftw2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xxhpmezvextnbaiz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-16, Tejun Heo <tj@kernel.org> wrote:
> Hello, Aleksa.
>=20
> On Wed, Oct 16, 2019 at 07:32:19PM +1100, Aleksa Sarai wrote:
> > Maybe I'm misunderstanding Documentation/atomic_t.txt, but it looks to
> > me like it's explicitly saying that I shouldn't use atomic64_t if I'm
> > just using it for fetching and assignment.
>=20
> Hah, where is it saying that?

Isn't that what this says:

> Therefore, if you find yourself only using the Non-RMW operations of
> atomic_t, you do not in fact need atomic_t at all and are doing it
> wrong.

Doesn't using just atomic64_read() and atomic64_set() fall under "only
using the non-RMW operations of atomic_t"? But yes, I agree that any
locking is overkill.

> > As for 64-bit on 32-bit machines -- that is a separate issue, but from
> > [1] it seems to me like there are more problems that *_ONCE() fixes than
> > just split reads and writes.
>=20
> Your explanations are too wishy washy.  If you wanna fix it, please do
> it correctly.  R/W ONCE isn't the right solution here.

Sure, I will switch it to use atomic64_read() and atomic64_set() instead
if that's what you'd prefer. Though I will mention that on quite a few
architectures atomic64_read() is defined as:

  #define atomic64_read(v)        READ_ONCE((v)->counter)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--xxhpmezvextnbaiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXac3ZgAKCRCdlLljIbnQ
EgBeAP40qsKIa/xjyp5QTDwPZUTxUPFnsAGGUbniwVLQeb2vXAEA+tT7cTDK410D
c5RreKV4Dwzp3kNtNNHnA5BxvXioJAI=
=kEi+
-----END PGP SIGNATURE-----

--xxhpmezvextnbaiz--
