Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5650C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 03:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAA221D81
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 03:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfJCDhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 23:37:11 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50401 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725860AbfJCDhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 23:37:11 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x933atx5019088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Oct 2019 23:36:56 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 523C142088C; Wed,  2 Oct 2019 23:36:55 -0400 (EDT)
Date:   Wed, 2 Oct 2019 23:36:55 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Kurt Roeckx <kurt@roeckx.be>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Stop breaking the CSRNG
Message-ID: <20191003033655.GA3226@mit.edu>
References: <20191002165533.GA18282@roeckx.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191002165533.GA18282@roeckx.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 06:55:33PM +0200, Kurt Roeckx wrote:
> 
> But it seems people are now thinking about breaking getrandom() too,
> to let it return data when it's not initialized by default. Please
> don't.

"It's complicated"

The problem is that whether a CRNG can be considered secure is a
property of the entire system, including the hardware, and given the
large number of hardware configurations which the kernel and OpenSSL
can be used, in practice, we can't assure that getrandom(2) is
"secure" without making certain assumptions.  For example, if we
assume that the CPU is an x86 processor new enough to support RDRAND,
and that RDRAND is competently implemented (e.g., it won't disappear
after a suspend/resume) and doesn't have any backdoors implanted in
it, then it's easy to say that getrandom() will always be secure.

But if you assume that there is no hardware random number generator,
and everything is driven from a single master oscillator, with no
exernal input, and the CPU is utterly simple, with speculation or
anything else that might be non-determinstic, AND if we assume that
the idiots who make an IOT device use the same random seed across
millions of devices all cloned off of the same master imagine, there
is ***absoutely*** nothing the kernel can do to guarantee, with 100%
certainty, that the CRNG will be initialzied.  (This is especially
true if the idiots who design the IOT device call OpenSSL to generate
their long-term private key the moment the device is first plugged in,
before any networking device is brought on-line.)

The point with all of this is that both the kernel and OpenSSL, and
whether or not they can be combined to create a secure overall
solution is going to be dependent on the hardware choices, and choices
of the distribution and the application programmers in terms of what
other software components are used, and when and where those
components try to request random numbers, especially super-early in
the boot process.

Historically, I've tried to work around this problem by being super
paranoid about the choices of thresholds before declaring the CRNG to
be initialized, while *also* making sure that at least on most common
x86 systems, the CRNG could be considered initialized before the root
file system was mounted read/write.

But over time, assumptions of what is common hardware changes.  SSD's
replace HDD's; NAPI and other polling techniques are more common to
reduce the number of interrupts; the use of a single master oscillator
to drive the all of the various clocks on the system, etc.  And
software changes --- systemd running boot scripts in parallel means
that boot times are reduced, which is good, but it also means the time
to when the root is mounted read/write is much shortened.

So in the absence of a hardware RNG, or a hardware random number
generator which is considered trusted (i.e., should RDRAND
beconsidered trusted?), there *will* be times when we will simply fail
to be able to generate secure random numbers (at least by our
hueristics, which can potentially be overly optimistic on some
hardware platforms, and overly conservative on others).

The question is then, what do we do?  Do we hang the boot --- at which
point users will complain to Linus?  Or do we just hope that things
are "good enough", and that even if the user has elected to say that
they don't trust RDRAND, that we'll hope it's competently implement
and not backdoored?  Or do we assume that using a jitter entropy
scheme is actually secure, as opposed to security through obscurity
(and maybe is completely pointless on a simple and completely open
architecture with no speculation such as RISC-V)?

There really are no good choices here.  The one thing which Linus has
made very clear is that hanging at boot is Not Acceptable.  Long term,
the best we can do is to through the kitchen sink at the problem.  So
we should try to use UEFI's RNG if available; use the TPM's RNG if
available; use RDRAND if available; try to use a seed file if
available (and hope it's not cloned to be identical on a million IOT
devices); and so on.  Hopefully, they won't *all* incompetently
implemented and/or implanted with a backdoor from the NSA or MSS or
the KGB.

The only words of hope that I can give you is that it's likely that
there are so many zero day bugs in the kernel, in userspace
applications, and crypto libraries (including maybe OpenSSL), that we
don't have to make the CRNG impossible to attack in order to make a
difference.  We just have to make it harder than finding and
exploiting zero day security bugs in *other* parts of the system.

   "When a mountain bear is chasing after you, you don’t have to
   outrun the bear. You only have to outrun the person running next to
   you."  :-)

Bottom line, we can do the best we can with each of our various
components, but without control over the hardware that will be in use,
or for OpenSSL, what applications are trying to call OpenSSL for, and
when they might try to generate long-term public keys during the first
boot, perfection is always going to be impossible to achieve.  The
only thing we can choose is how do we handle failure.

And Linus has laid down the law that a performance improving commit
should never cause boot-ups to hang due to the lack of randomness.
Given that I can't control when some application might try to call
OpenSSL to generate a long-term public key, and OpenSSL certainly
can't control if it gets called during early boot, if getrandom(2)
ever boots, we can't meet Linus's demand.

And given that many users are just installing some kind of userspace
jitter entropy to square this particular circle, even though I don't
trust a jitter entropy scheme, even if it is insecure, we're also
using RDRAND, and ultimately I'll trust RDRAND more than I trust a
jitter entropy scheme.  And that's where we are right now.  Linus has
introduced a simple in-kernel jitter entropy system so getrandom(2)
will never boot.  Is it secure?  Who can say?  I have my doubts on
RISC-V, but I don't use a RISC-V, and hopefully this will be a spur to
encourage all RISC-V implementations to include the cryptographic
extensions which include a RDRAND-like hardware random number
generator into ISA.  And since all of *my* x86 systems have RDRAND,
I'm at least personally comfortable enough with where we've landed.
Your mileage may vary.

Regards,

						- Ted

