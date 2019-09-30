Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD44C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 03:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9C22086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 03:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfI3Dhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 23:37:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39508 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728853AbfI3Dhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 23:37:37 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8U3b6k9005328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Sep 2019 23:37:07 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C158C42014C; Sun, 29 Sep 2019 23:37:06 -0400 (EDT)
Date:   Sun, 29 Sep 2019 23:37:06 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: x86/random: Speculation to the rescue
Message-ID: <20190930033706.GD4994@mit.edu>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 06:16:33PM -0700, Linus Torvalds wrote:
> 
>  - or just say "hey, a lot of people find jitter entropy reasonable,
> so let's just try this".
> 

I'm OK with this as a starting point.  If a jitter entropy system
allow us to get pass this logjam, let's do it.  At least for the x86
architecture, it will be security through obscurity.  And if the
alternative is potentially failing where the adversary can attack the
CRNG, it's my preference.  It's certainly better than nothing.

That being said, I'd very much like to see someone do an analysis of
how well these jitter schemes work on an RISC-V iplementation (you
know, the ones that were so simplistic and didn't have any speculation
so they weren't vulnerable to Specture/Meltdown).  If jitter
approaches turn out not to work that well on RISC-V, perhaps that will
be a goad for future RISC-V chips to include the crypto extension to
their ISA.

In the long term (not in time for the 5.4 merge window), I'm convinced
that we should be trying as many ways of getting entropy as possible.
If we're using UEFI, we should be trying to get it from UEFI's secure
random number generator; if there is a TPM, we should be trying to get
random numbers from the RPM, and mix them in, and so on.

After all, the reason why lived with getrandom(0) blocking for five
years was because for the vast majority of x86 platforms, it simply
wasn't problem in practice.  We need to get back to that place where
in practice, we've harvested as much uncertainty from hardware as
possible, so most folks are comfortable that attacking the CRNG is no
longer the simplest way to crack system security.

       	     	     	      	     - Ted
