Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA73C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D5C216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfG2QMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:12:19 -0400
Received: from shelob.surriel.com ([96.67.55.147]:33230 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfG2QMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:12:16 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hs8Fz-0006V1-0a; Mon, 29 Jul 2019 12:12:15 -0400
Message-ID: <89d6acc3cc5d72f750f1a77164043dbfd6e599e8.camel@surriel.com>
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of
 kthreads
From:   Rik van Riel <riel@surriel.com>
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Andy Lutomirski <luto@kernel.org>
Date:   Mon, 29 Jul 2019 12:12:14 -0400
In-Reply-To: <c2dfc884-b3e1-6fb3-b05f-2b1f299853f4@redhat.com>
References: <20190727171047.31610-1-longman@redhat.com>
         <20190729085235.GT31381@hirez.programming.kicks-ass.net>
         <4cd17c3a-428c-37a0-b3a2-04e6195a61d5@redhat.com>
         <20190729150338.GF31398@hirez.programming.kicks-ass.net>
         <c2dfc884-b3e1-6fb3-b05f-2b1f299853f4@redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-NYJpmwoU3yRhflJJvggv"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NYJpmwoU3yRhflJJvggv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-07-29 at 11:37 -0400, Waiman Long wrote:
> On 7/29/19 11:03 AM, Peter Zijlstra wrote:
> > On Mon, Jul 29, 2019 at 10:51:51AM -0400, Waiman Long wrote:
> > > On 7/29/19 4:52 AM, Peter Zijlstra wrote:
> > > > On Sat, Jul 27, 2019 at 01:10:47PM -0400, Waiman Long wrote:
> > > > > It was found that a dying mm_struct where the owning task has
> > > > > exited
> > > > > can stay on as active_mm of kernel threads as long as no
> > > > > other user
> > > > > tasks run on those CPUs that use it as active_mm. This
> > > > > prolongs the
> > > > > life time of dying mm holding up memory and other resources
> > > > > like swap
> > > > > space that cannot be freed.
> > > > Sure, but this has been so 'forever', why is it a problem now?
> > > I ran into this probem when running a test program that keeps on
> > > allocating and touch memory and it eventually fails as the swap
> > > space is
> > > full. After the failure, I could not rerun the test program again
> > > because the swap space remained full. I finally track it down to
> > > the
> > > fact that the mm stayed on as active_mm of kernel threads. I have
> > > to
> > > make sure that all the idle cpus get a user task to run to bump
> > > the
> > > dying mm off the active_mm of those cpus, but this is just a
> > > workaround,
> > > not a solution to this problem.
> > The 'sad' part is that x86 already switches to init_mm on idle and
> > we
> > only keep the active_mm around for 'stupid'.
> >=20
> > Rik and Andy were working on getting that 'fixed' a while ago, not
> > sure
> > where that went.
>=20
> Good, perhaps the right thing to do is for the idle->kernel case to
> keep
> init_mm as the active_mm instead of reuse whatever left behind the
> last
> time around.

Absolutely not. That creates heavy cache line
contention on the mm_cpumask as we switch the
mm out and back in after an idle period.

The cache line contention on the mm_cpumask
alone can take up as much as a percent of
CPU time on a very busy system with a large
multi-threaded application, multiple sockets,
and lots of context switches.

--=20
All Rights Reversed.

--=-NYJpmwoU3yRhflJJvggv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0/Gt4ACgkQznnekoTE
3oPxTwf6A73hLtRIBY6LdUGw0KUtoo25HQmixj3omA4ignFK7hQlCkOAyWbrXkTk
y10fXLM0Vhue5pUEQIlYtmp5wGUwlX6ixPkp7OK4uG5Bt4qWxo30zf6LgotkvJ/x
6AefBk+FZquAoe5P/8OjLcLJRlf/+9RuVJ/7KAYr1CBUh2g02lJIRs66BOWTzwzs
YmzXD6kN8SLnlI5rQJrYPKtcwS3I0PFW9GSU/wJe2jEq4vk/hVrHuLze1a20vEHg
RMBGsWVnAWlU6ZPXK23lUOVmtnIR4w2iNNBGMCOBnQTCFrUHij++rc6R9VfpLCgq
DfUJTi4ganXvQctAwKQ+LdLqX6+xPg==
=Zn9I
-----END PGP SIGNATURE-----

--=-NYJpmwoU3yRhflJJvggv--

