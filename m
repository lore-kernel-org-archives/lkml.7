Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC926C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3382064A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbfGaPH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:07:28 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45634 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387662AbfGaPH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:07:28 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hsqCM-0001Qa-NS; Wed, 31 Jul 2019 11:07:26 -0400
Message-ID: <76dbc397e21d64da75cd07d90b3ca15ca50d6fbb.camel@surriel.com>
Subject: Re: [PATCH v3] sched/core: Don't use dying mm as active_mm of
 kthreads
From:   Rik van Riel <riel@surriel.com>
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Michal Hocko <mhocko@kernel.org>
Date:   Wed, 31 Jul 2019 11:07:26 -0400
In-Reply-To: <01125822-c883-18ce-42e4-942a4f28c128@redhat.com>
References: <20190729210728.21634-1-longman@redhat.com>
         <ec9effc07a94b28ecf364de40dee183bcfb146fc.camel@surriel.com>
         <3e2ff4c9-c51f-8512-5051-5841131f4acb@redhat.com>
         <8021be4426fdafdce83517194112f43009fb9f6d.camel@surriel.com>
         <b5a462b8-8ef6-6d2c-89aa-b5009c194000@redhat.com>
         <c91e6104acaef118ae09e4b4b0c70232c4583293.camel@surriel.com>
         <01125822-c883-18ce-42e4-942a4f28c128@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-LA3XQyUFN0DfKhuFWUzC"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LA3XQyUFN0DfKhuFWUzC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-31 at 10:15 -0400, Waiman Long wrote:
> On 7/31/19 9:48 AM, Rik van Riel wrote:
> > On Tue, 2019-07-30 at 17:01 -0400, Waiman Long wrote:
> > > On 7/29/19 8:26 PM, Rik van Riel wrote:
> > > > On Mon, 2019-07-29 at 17:42 -0400, Waiman Long wrote:
> > > >=20
> > > > > What I have found is that a long running process on a mostly
> > > > > idle
> > > > > system
> > > > > with many CPUs is likely to cycle through a lot of the CPUs
> > > > > during
> > > > > its
> > > > > lifetime and leave behind its mm in the active_mm of those
> > > > > CPUs.  My
> > > > > 2-socket test system have 96 logical CPUs. After running the
> > > > > test
> > > > > program for a minute or so, it leaves behind its mm in about
> > > > > half
> > > > > of
> > > > > the
> > > > > CPUs with a mm_count of 45 after exit. So the dying mm will
> > > > > stay
> > > > > until
> > > > > all those 45 CPUs get new user tasks to run.
> > > > OK. On what kernel are you seeing this?
> > > >=20
> > > > On current upstream, the code in native_flush_tlb_others()
> > > > will send a TLB flush to every CPU in mm_cpumask() if page
> > > > table pages have been freed.
> > > >=20
> > > > That should cause the lazy TLB CPUs to switch to init_mm
> > > > when the exit->zap_page_range path gets to the point where
> > > > it frees page tables.
> > > >=20
> > > I was using the latest upstream 5.3-rc2 kernel. It may be the
> > > case
> > > that
> > > the mm has been switched, but the mm_count field of the active_mm
> > > of
> > > the
> > > kthread is not being decremented until a user task runs on a CPU.
> > Is that something we could fix from the TLB flushing
> > code?
> >=20
> > When switching to init_mm, drop the refcount on the
> > lazy mm?
> >=20
> > That way that overhead is not added to the context
> > switching code.
>=20
> I have thought about that. That will require changing the active_mm
> of
> the current task to point to init_mm, for example. Since TLB flush is
> done in interrupt context, proper coordination between interrupt and
> process context will require some atomic instruction which will
> defect
> the purpose.

Would it be possible to work around that by scheduling
a work item that drops the active_mm?

After all, a work item runs in a kernel thread, so by
the time the work item is run, either the kernel will
still be running the mm you want to get rid of as
active_mm, or it will have already gotten rid of it
earlier.

--=20
All Rights Reversed.

--=-LA3XQyUFN0DfKhuFWUzC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1Brq4ACgkQznnekoTE
3oO3eQf5AccmrRMXxWm78tqusxi+4qeoJTYk0e55qTe9ICxJJM1GjyKCEok1mcRz
MKCKG1Gf6OMsZSp76dqQ3/WhbveHGMM7q+TBRqS3uKi2T+1kn3iPju0X66OYJ3jV
GCxf3mhuBwgbMAlJ/orHvbX0TUwE7yHnVWQOLU0PdivEvfA9FBU7LsnnDHhm8EzL
BSPJ1Qugfn7o9PrrFTGAARfEYQ2/ZHIhL3c1SZOfF6psCDIJaNJJbzCrUG12OVZU
eWZgt8mtpmozWRxZ+7s1UkYSXfIDOJQkRtHNcRtikonqBO3Tt/e8RFJBP5Rp0ond
HvpD66RQSO4zrn91S5EaUfnGmos7Zg==
=yJHK
-----END PGP SIGNATURE-----

--=-LA3XQyUFN0DfKhuFWUzC--

