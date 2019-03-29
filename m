Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA14C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9724C218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfC2TU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:20:29 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:44516 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfC2TU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:20:29 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E316C72CC64;
        Fri, 29 Mar 2019 22:20:25 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id D32377CC74C; Fri, 29 Mar 2019 22:20:25 +0300 (MSK)
Date:   Fri, 29 Mar 2019 22:20:25 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Roland McGrath <roland@hack.frob.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC][PATCH 0/4 v2] sycalls: Remove args i and n from
 syscall_get_arguments()
Message-ID: <20190329192025.GC32651@altlinux.org>
References: <20190328230512.486297455@goodmis.org>
 <CAHk-=whtDB2HiEgyKcJPN7m8c83GrY=hQ=p-m-um1N6eSqxczg@mail.gmail.com>
 <20190329134045.3fb2e69f@gandalf.local.home>
 <CAHk-=wjOQpkGb43zE8+djZ99tiVRefJ7mmWFOUN=v6RFRTBvCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjOQpkGb43zE8+djZ99tiVRefJ7mmWFOUN=v6RFRTBvCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2019 at 11:12:18AM -0700, Linus Torvalds wrote:
> On Fri, Mar 29, 2019 at 10:40 AM Steven Rostedt <rostedt@goodmis.org> wro=
te:
> >
> > I'll keep it around for now, but this should go as a warning to Dmitry,
> > to get something using it soon, or they may be dropped.
>=20
> I don't think _that_ is the argument.
>=20
> Quite the reverse: nobody has ever used it, why have it around, and
> much less try to hurry some new pointless user to use it?
>=20
> The "get system call arguments" code at least can be used somewhat
> generically for things like tracing and strace.
>=20
> The "set system call arguments" can NOT.
>=20
> Anybody who sets system call arguments had better intimately know the
> details anyway, and any user code has to have any legacy ptrace
> interface anyway for all but the newest kernels.

In strace we have a feature called system call tampering.
Initially limited to system call number and return code tampering,
it's being extended to tamper with system call arguments as well.

Currently it's implemented in strace using traditional
PTRACE_SETREGSET/PTRACE_SETREGS/PTRACE_POKEUSER interfaces.
These interfaces indeed require intimate knowledge of the target
architecture.  Fortunately, strace already has this intimate knowledge,
but the corresponding code would be much more trivial if an
architecture-agnostic ptrace interface for setting syscall info
existed in the kernel.

I didn't plan to start the discussion about this new ptrace command
before PTRACE_GET_SYSCALL_INFO [1] finally landed into the kernel.

For us userspace people it takes a lot of time not only to get a new
kernel interface accepted, but even to reintroduce an old internal kernel
interface that was removed due to lack of users.  For example, it took me
roughly 4 months to get a relatively simple partial revert of commit
5e937a9ae913 accepted into linux-next.

This was the reason why I asked to delay the removal of
syscall_set_arguments() until PTRACE_GET_SYSCALL_INFO
is merged into the kernel.

[1] https://lore.kernel.org/lkml/20190322041409.GA27266@altlinux.org/


--=20
ldv

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcnm/5AAoJEAVFT+BVnCUIB8MP/AgpTmOfzpzU7Vmg05aY/JLF
9/jZeCDVOgvXQJ8ZYWq9xhwt7XNafhrx7u8stzDUQ1Aytxj2eljlMR2EvbcT4/w9
0fdKGhBV6TfWffskw/1KRGRZnK0xpJ9w/k9JPyAasI4s6KY0TkiA7zgAJt5oFgdw
qXgZLS5+UzM/yyBPRxPED5H+991FqNS0cZ1SHH2KyMh5g/i0v9d7fNsloLMJK1Xi
dW2F51kwqjIQHZUaIlzPyBdJGlZQaY8I6rGpbZM5ShOIZfHshStX7HZJnfLjt0YO
C7HTwllGNAiLl7YB7aI/6qNur2qNJaetuDp4uqeNNp+ux09FsA6wfNd3ujiW1MKw
Z5WnZcvnA/R9wsIcErrX8iU4C0ljPBEYAcuUjcAa79i4e/zp0PKgIef5337RRjUm
LgFB53qG+bNNZwURMRvTAX9hcgAr0GeFfYXha6Kla4rRC2JJf7cEfTnOt2ufO2oG
u+dLOl8iEp5KxiV0Q+YeNT0pYNcRW07QETpvkf+wR5RlcZGApwfyIIeJ/E/a7o/H
ndb2gfSLCkePq69QkMyh2dFTIa6C06w5hNldWD/8kzPvnPHp+d/wZmoGY+7EKQpv
V0MNaCV/yWo3hzJ7AD1xsE8l7tSmyeiVlktry5Bceb3KX/E5F2zw/v1sBMshZWkf
G0aQg+TRavHMyyr42JjV
=8k32
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
