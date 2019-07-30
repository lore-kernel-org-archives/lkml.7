Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB04C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC092070B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfG3A0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 20:26:48 -0400
Received: from shelob.surriel.com ([96.67.55.147]:49322 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730023AbfG3A0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 20:26:47 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hsFyU-0000oP-0f; Mon, 29 Jul 2019 20:26:42 -0400
Message-ID: <8021be4426fdafdce83517194112f43009fb9f6d.camel@surriel.com>
Subject: Re: [PATCH v3] sched/core: Don't use dying mm as active_mm of
 kthreads
From:   Rik van Riel <riel@surriel.com>
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Michal Hocko <mhocko@kernel.org>
Date:   Mon, 29 Jul 2019 20:26:41 -0400
In-Reply-To: <3e2ff4c9-c51f-8512-5051-5841131f4acb@redhat.com>
References: <20190729210728.21634-1-longman@redhat.com>
         <ec9effc07a94b28ecf364de40dee183bcfb146fc.camel@surriel.com>
         <3e2ff4c9-c51f-8512-5051-5841131f4acb@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-lY3NRPxUErEaURZG51iL"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lY3NRPxUErEaURZG51iL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-07-29 at 17:42 -0400, Waiman Long wrote:

> What I have found is that a long running process on a mostly idle
> system
> with many CPUs is likely to cycle through a lot of the CPUs during
> its
> lifetime and leave behind its mm in the active_mm of those CPUs.  My
> 2-socket test system have 96 logical CPUs. After running the test
> program for a minute or so, it leaves behind its mm in about half of
> the
> CPUs with a mm_count of 45 after exit. So the dying mm will stay
> until
> all those 45 CPUs get new user tasks to run.

OK. On what kernel are you seeing this?

On current upstream, the code in native_flush_tlb_others()
will send a TLB flush to every CPU in mm_cpumask() if page
table pages have been freed.

That should cause the lazy TLB CPUs to switch to init_mm
when the exit->zap_page_range path gets to the point where
it frees page tables.

> > If it is only on the CPU where the task is exiting,
> > would the TASK_DEAD handling in finish_task_switch()
> > be a better place to handle this?
>=20
> I need to switch the mm off the dying one. mm switching is only done
> in
> context_switch(). I don't think finish_task_switch() is the right
> place.

mm switching is also done in flush_tlb_func_common,
if the CPU received a TLB shootdown IPI while in lazy
TLB mode.

--=20
All Rights Reversed.

--=-lY3NRPxUErEaURZG51iL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0/jsEACgkQznnekoTE
3oOE1ggAg1gUM2xB6saQQir2gSvZrUyxU6Zo52SS5CmO3mkJP2423lRU37awDIez
nM76nLTpWiME/vXpMA3lzHxnCcQ0uQuXOt9JvXUn3Cn1C+fd6sAC7NjD/aCMEnam
AHSk0qRNcoiwN56n3r5bVlkBi7UymKO+NLXA2hlMLNl9vNKRGYshbo8b44h2Cv6M
Mbbe2ap47z5siyZUphm6/lbK1hZlNLXuf79CCYJDEKzuqXac4ij0RUieOkWpgJxw
4SH8meLRYykoIj2PPFCELl/urg/sIaDQlVqLd5G5ejMMrBQDKdfb4/coCdnhqL1l
0jCbfSYDSxlucg4rvV5J1zmjT9pTEA==
=dova
-----END PGP SIGNATURE-----

--=-lY3NRPxUErEaURZG51iL--

