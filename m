Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E14C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389EC204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfDPPHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:07:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52608 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725796AbfDPPHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:07:21 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3GF6nSo015691
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Apr 2019 11:06:49 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BF6BA420497; Tue, 16 Apr 2019 11:06:48 -0400 (EDT)
Date:   Tue, 16 Apr 2019 11:06:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kees Cook <keescook@google.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: BPF RNG
Message-ID: <20190416150648.GA3004@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Kees Cook <keescook@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <CAGXu5jL6LVU7KyUvwaEHWE6t2TaVBs5TWNayB5cW2=PWzSMyEw@mail.gmail.com>
 <CAGXu5j+Ny=1YF0BkATbU3Xb-fb=_0a1W-iZ3jYFhTcWrTPqCJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+Ny=1YF0BkATbU3Xb-fb=_0a1W-iZ3jYFhTcWrTPqCJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 08:55:59AM -0500, Kees Cook wrote:
> [correcting Alexei's email address and resending...]
> On Tue, Apr 16, 2019 at 8:54 AM Kees Cook <keescook@google.com> wrote:
> >
> > In looking at prandom_u32() users, I noticed that BPF uses its own
> > state variable with bpf_user_rnd_u32(). It appears that this state is
> > never reseeded like regular prandom_u32(). (See __prandom_timer().) Is
> > this intentional, or should reseeding be happening?

It looks like this isn't the only place where prandom's machinery is
being used w/o reseeding.  See also net/netfilter/nft_meta.c and
net/netfilter/nft_numgen.c.

That being said, guarantees we give for prandom are extremely weak.
The only reason why we reseed for net_rand_state was they wanted
something sorta-kinda secure, but they weren't willing to pay the cost
of calling get_random_u64() or get_random_u32().

So I don't think we should be encouraging people to think that
reseeding should actually be happening, at least with some explicit
explanation of documentation somewhere about why it's needed, and what
security guarantees people should be expecting.  (e.g., for the
networking subsystem, the claim is that it's trying to make certain
DOS attackers harder, and it shouldn't be mistaken for real security).

In fact, why we're supporting multiple prandom per-cpu state families
makes me worried we're going in the wrong direction.  I suspect the
reason why people are settng up separate prandom states is because
they don't want to leak knowledge about the prandom internal state to
an external attacker.  That should only matter for a small set of
network stack users; so maybe we should just have two prandom states.
One for the vast majority of users where there should be no security
concerns around using prandom (because if there are, 99% of the time
they should be get_random_u32), and then for those people who want
get_random_fast_but_maybe_insecure_u64() --- and maybe for those
architectures where there is some instruction like RDRAND which is
really super-fast, it would use RDRAND for the
get_random_fast_but_maybe_insecure_u64().

						- Ted
