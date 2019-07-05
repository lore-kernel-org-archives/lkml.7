Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC6BC0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 01:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8F421852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 01:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfGEBCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 21:02:38 -0400
Received: from shelob.surriel.com ([96.67.55.147]:33454 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfGEBCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 21:02:37 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hjCcT-00033v-9G; Thu, 04 Jul 2019 21:02:33 -0400
Message-ID: <422f78651940a1b13f41fc126b7e95e8071db69e.camel@surriel.com>
Subject: Re: [PATCH 05/10] sched,fair: remove cfs rqs from leaf_cfs_rq_list
 bottom up
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Date:   Thu, 04 Jul 2019 21:02:32 -0400
In-Reply-To: <CAKfTPtBOWeEH1T77Cm92R3BfM85ii6mbocidtAPyWN4Vq0q7SA@mail.gmail.com>
References: <20190628204913.10287-1-riel@surriel.com>
         <20190628204913.10287-6-riel@surriel.com>
         <CAKfTPtBOWeEH1T77Cm92R3BfM85ii6mbocidtAPyWN4Vq0q7SA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-QHn6K+DAVLQF2fswAdlJ"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QHn6K+DAVLQF2fswAdlJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-07-04 at 11:33 +0200, Vincent Guittot wrote:
> On Fri, 28 Jun 2019 at 22:49, Rik van Riel <riel@surriel.com> wrote:
> > Reducing the overhead of the CPU controller is achieved by not
> > walking
> > all the sched_entities every time a task is enqueued or dequeued.

> > @@ -7687,6 +7700,10 @@ static inline bool cfs_rq_is_decayed(struct
> > cfs_rq *cfs_rq)
> >         if (cfs_rq->avg.util_sum)
> >                 return false;
> >=20
> > +       /* Remove decayed parents once their decayed children are
> > gone. */
> > +       if (cfs_rq->children_on_list)
>=20
> I'm not sure that you really need to count whether childrens are on
> the list.
> Instead you can take advantage of the list ordering and you only have
> to test if the previous cfs_rq in the list is a child. If it's not
> then there is no more child
>=20
> and you can remove the new field children_on_list and inc/dec it

Good suggestion. I'll do that for v3.

Thank you.

--=20
All Rights Reversed.

--=-QHn6K+DAVLQF2fswAdlJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0eoagACgkQznnekoTE
3oM5UQgAo55+GMijHhjejYhB2bx8PpgGhlAso0whA1DcmecPXVZczWk9Fyq5oyLc
aqCbxf94P2KUut119bz+1Nof/xB85Z0cc9E23NChpMXHFe2O179pgrSJrRa5lYy/
Yo6MXlhZzO1cnXnuKo9mp7fmAhrvqn+FGRnn4lksx6bQDRMpPI0sqXy3VbRRxAjJ
BwZ2a3b6J2zBXDBbzQGh9hmxgsMMmbirXWJggZfN+B3mbxBdV0ip+7yO9NrOQRTm
u3KRrQZrtm4WbONPJ5lwpXk7hc5Z47nvM0QcUz7ooBrvxmW5UaT79HbH55pofCkK
9IF/1hqQ7Y9FaHyU60n+k3AjUZPViQ==
=BIT/
-----END PGP SIGNATURE-----

--=-QHn6K+DAVLQF2fswAdlJ--

