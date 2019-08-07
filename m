Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36A9C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D2F22305
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfHGI6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:58:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:58740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbfHGI6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:58:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9589EAC20;
        Wed,  7 Aug 2019 08:58:45 +0000 (UTC)
Message-ID: <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?ISO-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 07 Aug 2019 10:58:40 +0200
In-Reply-To: <20190802153715.GA18075@sinkpad>
References: <20190612163345.GB26997@sinkpad>
         <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
         <20190613032246.GA17752@sinkpad>
         <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
         <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
         <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
         <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
         <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
         <20190802153715.GA18075@sinkpad>
Organization: SUSE
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4tYvlZYzl693s5My87+b"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4tYvlZYzl693s5My87+b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

This is Dario, from SUSE. I'm also interesting in core-scheduling, and
using it in virtualization use cases.

Just for context, I'm working in virt since a few years, mostly on Xen,
but I've done Linux stuff before, and I am getting back at it.

For now, I've been looking at the core-scheduling code, and run some
benchmarks myself.

On Fri, 2019-08-02 at 11:37 -0400, Julien Desfossez wrote:
> We tested both Aaron's and Tim's patches and here are our results.
>=20
> Test setup:
> - 2 1-thread sysbench, one running the cpu benchmark, the other one
> the
>   mem benchmark
> - both started at the same time
> - both are pinned on the same core (2 hardware threads)
> - 10 30-seconds runs
> - test script: https://paste.debian.net/plainh/834cf45c
> - only showing the CPU events/sec (higher is better)
> - tested 4 tag configurations:
>   - no tag
>   - sysbench mem untagged, sysbench cpu tagged
>   - sysbench mem tagged, sysbench cpu untagged
>   - both tagged with a different tag
> - "Alone" is the sysbench CPU running alone on the core, no tag
> - "nosmt" is both sysbench pinned on the same hardware thread, no tag
> - "Tim's full patchset + sched" is an experiment with Tim's patchset
>   combined with Aaron's "hack patch" to get rid of the remaining deep
>   idle cases
> - In all test cases, both tasks can run simultaneously (which was not
>   the case without those patches), but the standard deviation is a
>   pretty good indicator of the fairness/consistency.
>=20
This, and of course the numbers below too, is very interesting.

So, here comes my question: I've done a benchmarking campaign (yes,
I'll post numbers soon) using this branch:

https://github.com/digitalocean/linux-coresched.git  vpillai/coresched-v3-v=
5.1.5-test
https://github.com/digitalocean/linux-coresched/tree/vpillai/coresched-v3-v=
5.1.5-test

Last commit:
7feb1007f274 "Fix stalling of untagged processes competing with tagged
processes"

Since I see that, in this thread, there are various patches being
proposed and discussed... should I rerun my benchmarks with them
applied? If yes, which ones? And is there, by any chance, one (or maybe
more than one) updated git branch(es)?

Thanks in advance and Regards
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-4tYvlZYzl693s5My87+b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl1KksEACgkQFkJ4iaW4
c+5h2xAA33JxoIgaoAyjD7w2D8stxoH8YVy+eeWBr4oACLGpAhK3ioijR0RN03h3
w+AA8GWrfWlU0tGOFqsdbHyqf8MA2KhoWQmN/7BUJdYAR8WiX2BwhMFSP5J1YB7A
DHD3xN2MMRUioStiKbCKukgvIW2wwmZ9N6uhIdJIywdQtwRZMsvCT8kEqeOrJmRS
h3xV1kl5NNpqz73FxWltecI4YL2N5h4L6mFupiKvc+rUhuJNax/K2QgIYmZga2eC
DyZ+q/jDVF98SFmJ+NIAqcC517w8s6Ovcw/3SMWkorIl1t0Aszgrcq2eGTCQWA74
Gr5FI5dkUZL0o32g/s2xVYKRKDPm/C211sbz51TRq0RfGRpFlRUZ5V2Xe8ux/SQJ
D3i2GXn/xc3NksdqJpPjHY1Btln3iQUEL3ZsVsyZeLZW2ASqUNuaukBhBRw+Eemh
rgoDKrtYCNKWztITHe/mrQzu0tDDvF+6vGxuaWdGbVJOXmvpiZ9BMijWN0OseJ5s
25K1n2JXIqDlYBV9W6yGDiLBIk6NLy8qtkpK/EtvpJORTovJFiISge1mhZw7RjgH
dRRQmoNELIJQku7AEVXPviTp6iAx9mKWoqYts7oio7A4n8X6Pr8e8MCi62Mx9lPX
ExZs8wF93EiVZ3yWAl0vtzJbPx8Lc8etMF8sRWxBOtWoRyawdXc=
=LKN2
-----END PGP SIGNATURE-----

--=-4tYvlZYzl693s5My87+b--

