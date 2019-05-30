Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7812C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9B3245C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfE3DPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:15:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39245 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729337AbfE3DNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:13:09 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4U3C1r7025530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 23:12:02 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 34535420481; Wed, 29 May 2019 23:12:01 -0400 (EDT)
Date:   Wed, 29 May 2019 23:12:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     linux-kernel@vger.kernel.org, Steve Grubb <sgrubb@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Fix xoring of arch_get_random_long into crng->state array
Message-ID: <20190530031201.GA2751@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Neil Horman <nhorman@tuxdriver.com>, linux-kernel@vger.kernel.org,
        Steve Grubb <sgrubb@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190402220025.14499-1-nhorman@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402220025.14499-1-nhorman@tuxdriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 06:00:25PM -0400, Neil Horman wrote:
> When _crng_extract is called, any arch that has a registered
> arch_get_random_long method, attempts to mix an unsigned long value into
> the crng->state buffer, it only mixes in 32 of the 64 bits available,
> because the state buffer is an array of u32 values, even though 2 u32
> are expected to be filled (owing to the fact that it expects indexes 14
> and 15 to be filled).

Index 15 does get initialized; in fact, it's changed each time
crng_reseed() is called.

The way things currently work is that we use state[12] and state[13]
as 64-bit counter (it gets incremented each time we call
_extract_crng), and state[14] and state[15] are nonce values.  After
crng->state has been in use for five minutes, we reseed the crng by
grabbing randomness from the input pool, and using that to initialize
state[4..15].  (State[0..3] are always set to the ChaCha20 constant of
"expand 32-byte k".)

If the CPU provides and RDRAND-like instruction (which can be the case
for x86, PPC, and S390), we xor it into state[14].  Whether we xor any
extra entropy into state[15] to be honest, really doesn't matter much.
I think I was trying to keep things simple, and it wasn't worth it to
call RDRAND twice on a 32-bit x86.  (And there isn't an
arch_get_random_long_long.  :-)

Why do we do this at all?  Well, the goal was to feed in some
contributing randomness from RDRAND when we turn the CRNG crank.  (The
reason why we don't just XOR in the RDRAND into the output ohf the
CRNG is mainly to assuage critics that hypothetical RDRAND backdoor
has access to the CPU registers.  So we perturb the inputs to the
CRNG, on the theory that if malicious firmware can reverse
CHACHA20... we've got bigger problems.  :-)  We get up to 20 bytes out
of a single turn of the CRNG crank, so whether we mix in 4 bytes or 8
bytes from RDRAND, we're never going to be depending on RDRAND
completely in any case.

The bottom line is that I'm not at all convinced it worth the effort
to mix in 8 bytes versus 4 bytes from RDRAND.  This is really a CRNG,
and the RDRAND inputs really don't change that.

    	       	      	     	   	  - Ted
