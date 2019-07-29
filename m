Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5223CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7AE2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfG2QKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:10:15 -0400
Received: from shelob.surriel.com ([96.67.55.147]:33160 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfG2QKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:10:14 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hs8E0-0006Sx-QS; Mon, 29 Jul 2019 12:10:12 -0400
Message-ID: <aba144fbb176666a479420eb75e5d2032a893c83.camel@surriel.com>
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of
 kthreads
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Andy Lutomirski <luto@kernel.org>
Date:   Mon, 29 Jul 2019 12:10:12 -0400
In-Reply-To: <20190729154419.GJ31398@hirez.programming.kicks-ass.net>
References: <20190727171047.31610-1-longman@redhat.com>
         <20190729085235.GT31381@hirez.programming.kicks-ass.net>
         <4cd17c3a-428c-37a0-b3a2-04e6195a61d5@redhat.com>
         <20190729150338.GF31398@hirez.programming.kicks-ass.net>
         <25cd74fcee33dfd0b9604a8d1612187734037394.camel@surriel.com>
         <20190729154419.GJ31398@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Wc6jN0+BMJTfEPLvJuKE"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Wc6jN0+BMJTfEPLvJuKE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-07-29 at 17:44 +0200, Peter Zijlstra wrote:
> On Mon, Jul 29, 2019 at 11:28:04AM -0400, Rik van Riel wrote:
> > On Mon, 2019-07-29 at 17:03 +0200, Peter Zijlstra wrote:
> >=20
> > > The 'sad' part is that x86 already switches to init_mm on idle
> > > and we
> > > only keep the active_mm around for 'stupid'.
> >=20
> > Wait, where do we do that?
>=20
> drivers/idle/intel_idle.c:              leave_mm(cpu);
> drivers/acpi/processor_idle.c:  acpi_unlazy_tlb(smp_processor_id());

This is only done for deeper c-states, isn't it?

> > > Rik and Andy were working on getting that 'fixed' a while ago,
> > > not
> > > sure
> > > where that went.
> >=20
> > My lazy TLB stuff got merged last year.=20
>=20
> Yes, but we never got around to getting rid of active_mm for x86,
> right?

True, we still use active_mm. Getting rid of the
active_mm refcounting alltogether did not look
entirely worthwhile the hassle.

--=20
All Rights Reversed.

--=-Wc6jN0+BMJTfEPLvJuKE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0/GmQACgkQznnekoTE
3oN1Mwf+M8ilckJKazPB0sap6Gw+VcoPa1Ij8YnYtR0OIXGLktOKIWlJY9b3hYfY
Gn4yYJDoz1z8seaj6Ww+spOBzCxlS9qJlRxSqbijqR9zS4pC19y22l6OUfVPX0AO
zXirw8e+2OSbVcb26eAe4pzamJtW0kmf9YQgxJ545nZo4xV4uJ1FyJGKxL9OyJdR
/0JS1Vdi9Nlisa7YQw61k2USbGyFROvO3igHf5ii/2M2Rk1JictO4cYSfQrMYBy+
B3R3zlc0v5bNVl9MnBw6AjQs/sseEY/912Vzrsss05OyLI6zgmgsxBF+xsiEGsQW
nVdkkuBHbSQwKIQGKfM+JzF/F+ltrw==
=TidT
-----END PGP SIGNATURE-----

--=-Wc6jN0+BMJTfEPLvJuKE--

