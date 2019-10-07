Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DABCC352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4001E21721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfJGLsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:48:06 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48527 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727395AbfJGLsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:48:06 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x97BlYZx002081
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Oct 2019 07:47:35 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6FF0242045A; Mon,  7 Oct 2019 07:47:34 -0400 (EDT)
Date:   Mon, 7 Oct 2019 07:47:34 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: x86/random: Speculation to the rescue
Message-ID: <20191007114734.GA6104@mit.edu>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <20191006114129.GD24605@amd>
 <CAHk-=wjvhovO6V4-zT=xEMFnRonYteZvsPo-S0_n_DetSTUk5A@mail.gmail.com>
 <20191006173501.GA31243@amd>
 <CAHk-=whgfz2+OgBTVrHLoHK57emYb4gN6TtJ_s-607U=jBQ+ig@mail.gmail.com>
 <20191006182103.GA2394@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006182103.GA2394@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 08:21:03PM +0200, Pavel Machek wrote:
> Even without cycle counter... if we _know_ we are trying to generate
> entropy and have MMC available, we don't care about power and
> performance.
> 
> So we can just...
> 
>    issue read request on MMC
>    while (!interrupt_done)
>    	 i++
> 	 
> ...and then use i++ as poor man's version of cycle counter.

I suggest that you try that and see how much uncertainty you really
have before you assume that this is actually going to work.  Again, on
"System on a Chip" systems, there is very likely a single master
oscillator, and the eMMC is going to be on the the same silicon die as
the CPU.  At least for spinning rust platters it's on a physically
separate peripheral, and there was a physical claim about how chaotic
air turbulence might add enough uncertainty that timing HDD reads
could be unpredictable (although note that the paper[1] which claimed
this was written 25 years ago, and HDD's have had to get more precise,
not less, in order to cram more bits into the same squire millimeter).
more.)

[1] D. Davis, R. Ihaka, P.R. Fenstermacher, "Cryptographic Randomness
from Air Turbulence in Disk Drives", in Advances in Cryptology --
CRYPTO '94 Conference Proceedings, edited by Yvo G. Desmedt,
pp.114--120. Lecture Notes in Computer Science #839. Heidelberg:
Springer-Verlag, 1994

But for a flash device that is on the same silicon as the CPU, and
driven off of the same clock crystal, and where you are doing *reads*,
so you can't even depend on SSD GC and uncertainties in programming
the flash cell --- I'm going to be dubious.

If someone wants to use this as a last ditch hope, then we can let
systemd do this, where there's at least a bit more uncertainty in
userspace, and maybe you could be doing something useful, like running
fsck on the stateful partitions of the system.

Ultimately, though, we really want to try to get a hardware RNG, and
for that matter, a cryptographic secure element built into these
devices, and the sooner we can pound it into CPU manufacturers' heads
that not doing this should be professional malpractice, the better.

     	       	    	      		   - Ted

P.S.  Note that this Don Davis's paper[1] claims that they were able
to extract 100 independent unpredictable bits per _minute_.  Given
that modern init scripts want us to be able to boot in under a few
seconds, and we need at least 128 independent bits to securely
initialize the CRNG, people who think that we can get secure random
bits suitable for long-term cryptographic keys (say, such as
initializing the host's SSH key) during early boot based only on HDD
timings may be a bit.... optimistic.

P.P.S.  I actually knew Don; he was at MIT Project Athena as a staff
member at the same time I was working on Kerberos as my day job, and
Linux's e2fsprogs, /dev/random, etc. as a hobby...
