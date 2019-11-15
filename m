Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6161EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327A420730
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfKOQaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:30:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:43828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727552AbfKOQaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:30:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA53CC01F;
        Fri, 15 Nov 2019 16:30:14 +0000 (UTC)
Message-ID: <0f79f842c8a5988e82d95a201ae849a8349c7e1b.camel@suse.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Date:   Fri, 15 Nov 2019 17:30:12 +0100
In-Reply-To: <20191029203447.GA13345@sinkpad>
References: <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
         <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
         <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
         <20190911140204.GA52872@aaronlu>
         <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
         <20190912120400.GA16200@aaronlu>
         <CAERHkrsrszO4hJqVy=g7P74h9d_YJzW7GY4ptPKykTX-mc9Mdg@mail.gmail.com>
         <20190915141402.GA1349@aaronlu>
         <277737d6034b3da072d3b0b808d2fa6e110038b0.camel@suse.com>
         <d30d343a8d9bf2c2e2977be7ac8370f26fd4df3d.camel@suse.com>
         <20191029203447.GA13345@sinkpad>
Organization: SUSE
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-eDY/eOZnOMvzBYl/rukj"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eDY/eOZnOMvzBYl/rukj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-29 at 16:34 -0400, Julien Desfossez wrote:
> On 29-Oct-2019 10:20:57 AM, Dario Faggioli wrote:
> > > Hello,
> > >=20
> > > As anticipated, I've been trying to follow the development of
> > > this
> > > feature and, in the meantime, I have done some benchmarks.
>=20
> Hi Dario,
>=20
Hi!

> Thank you for this comprehensive set of tests and analyses !
>=20
Sure. And sorry for replying so late. I was travelling (for speaking
about core scheduling and virtualization at KVMForum :-P) and, after
that, had some catch up to do

> It confirms the trend we are seeing for the VM cases. Basically when
> the
> CPUs are overcommitted, core scheduling helps compared to noHT.=20
>
Yep.

> But when
> we have I/O in the mix (sysbench-oltp), then it becomes a bit less
> clear, it depends if the CPU is still overcommitted or not. About the
> 2nd VM that is doing the background noise, is it enough to fill up
> the
> disk queues or is its disk throughput somewhat limited ? Have you
> compared the results if you disable the disk noise ?
>=20
There were some IO, but it was mostly CPU noise. Anyway, sure, I can
repeat the experiments with different kind of noise. TBH, I also have
other ideas for different setup. And of course, I'll work on v4 now.

> Our approach for bare-metal tests is a bit different, we are
> constraining a set of processes only on a limited set of cpus, but I
> like your approach because it pushes more the number of processes
> against the whole system.=20
>
Yes, and for this time, I deliberately choose a small system, to avoid
having NUMA effects, etc. But I'm working toward running the evaluation
on a bigger box.

> I am curious, for the tagging in KVM, do you move all the vcpus into
> the
> same cgroup before tagging ?  Did you leave the emulator threads
> untagged at all time ?
>=20
So, for this round, yes, all the vcpus of the VM were put in the same
cgroup, and then I set the tag for it.

All the other threads that libvirt creates were left out of such group
(and were, hence, untagged). I did a few manual runs with _all_ the
tasks related to a VM in a tagged cgroup, but I did not see much
differences (that's why the numbers for these runs are not reported).

The VM did not have any virtual topology defined.

And in fact, one thing that I want to try is to put pairs of vcpus in
the same cgroup, tag it, and define a virtual HT topology for the VM
(i.e., mark the two vcpu that will be in the same cgroup with the same
tag as threads of the same core).

> For the overhead (without tagging), have you tried bisecting the
> patchset to see which patch introduces the overhead ? it is more than
> I
> had in mind.
>=20
Yes, there is definitely something weird. Well, in the meantime, I
improved my automated procedure for running the benchmarks. I'll rerun
on v4. And I'll do a bisect if the overhead is still that big.

> And for the cases when core scheduling improves the performance
> compared
> to the baseline numbers, could it be related to frequency scaling
> (more
> work to do means a higher chance of running at a higher frequency) ?
>=20
Governor was 'performance' during all the experiments. But yes, since
it's intel_pstate that is in charge, frequency can still vary, and
something like what you suggest may indeed be happening, I think.

> We are almost ready to send the v4 patchset (most likely tomorrow),
> it
> has been rebased on v5.3.5, so stay tuned and ready for another set
> of
> tests ;-)
>=20
Already on it. :-)

Thanks and Regards
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-eDY/eOZnOMvzBYl/rukj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl3O0pQACgkQFkJ4iaW4
c+70KA//VmpKGuaCyeg/F0Q9GXcBwdRWnHgKgVPwid4NYtO7n2ZbHEcVlJt7b3zO
XagsBzcyWjjHeINB8wltRa34xoOf64xoiIfx1rkkkIU7my6qa6lZlulJXnDXUYio
haQ0IRQQqE4IwptDJ2GsUbYHc/ycAwqTSHX3F2uGigsjpHDVN5ITfSGhbinEwKi9
ExEo8F6xnwqwMnzwDL/Eet/BCmZs0IxcMhyDh58Gasm2yFmm3woMEYiGDcDoVkRL
MiuSkTbYm+K5vDlPza875BOXIr0RuoPRl2/dKeLeZ+uvcfqwzl7o/mKwP3hu62vV
fRmEglUkqRBOAlhkad2aPsCOPuAGcW/sJPwyXjdO4/Kx3dsJ5g0X9hD9wYuOb4Uv
tTRluW00+Ll5N0yB4BKnBj+JBcPg3zhKJ+M+lp+CghKEy+RWmGMvgqiT3KQBboxL
GQei1xof+9rzsWvoXuoMFIN7QpVHhiG4iTZcUR29dy+rxmeBIif9aWiqdG8U1BZN
SRekmVVpUpKgSZklpeGA2UTXIQY48CGD5FzLjoshEEDlujUwYCY3xd72dY5HvLE1
Xcu/Ng+B7Z4zoVIlVi9KVDUUCWr3xo2QVEMJ/2pC/2j0j0KTetzdORbhEh/Gz7Ih
yl7TV6cvatFeyKmhsgbCX9vu+wO35p3A31JV3UUXZNNaCzv1/Gk=
=8WaX
-----END PGP SIGNATURE-----

--=-eDY/eOZnOMvzBYl/rukj--

