Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF31C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7822B25800
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfE3LPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 07:15:04 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:36458 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3LPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:15:04 -0400
Received: from cpe-2606-a000-111b-405a-0-0-0-162e.dyn6.twc.com ([2606:a000:111b:405a::162e] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1hWJ1K-0006Uv-O0; Thu, 30 May 2019 07:15:01 -0400
Date:   Thu, 30 May 2019 07:14:27 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Steve Grubb <sgrubb@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Fix xoring of arch_get_random_long into crng->state array
Message-ID: <20190530111427.GA1966@hmswarspite.think-freely.org>
References: <20190402220025.14499-1-nhorman@tuxdriver.com>
 <20190530031201.GA2751@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530031201.GA2751@mit.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 11:12:01PM -0400, Theodore Ts'o wrote:
> On Tue, Apr 02, 2019 at 06:00:25PM -0400, Neil Horman wrote:
> > When _crng_extract is called, any arch that has a registered
> > arch_get_random_long method, attempts to mix an unsigned long value into
> > the crng->state buffer, it only mixes in 32 of the 64 bits available,
> > because the state buffer is an array of u32 values, even though 2 u32
> > are expected to be filled (owing to the fact that it expects indexes 14
> > and 15 to be filled).
> 
> Index 15 does get initialized; in fact, it's changed each time
> crng_reseed() is called.
> 
> The way things currently work is that we use state[12] and state[13]
> as 64-bit counter (it gets incremented each time we call
> _extract_crng), and state[14] and state[15] are nonce values.  After
> crng->state has been in use for five minutes, we reseed the crng by
> grabbing randomness from the input pool, and using that to initialize
> state[4..15].  (State[0..3] are always set to the ChaCha20 constant of
> "expand 32-byte k".)
> 
> If the CPU provides and RDRAND-like instruction (which can be the case
> for x86, PPC, and S390), we xor it into state[14].  Whether we xor any
> extra entropy into state[15] to be honest, really doesn't matter much.
> I think I was trying to keep things simple, and it wasn't worth it to
> call RDRAND twice on a 32-bit x86.  (And there isn't an
> arch_get_random_long_long.  :-)
> 
> Why do we do this at all?  Well, the goal was to feed in some
> contributing randomness from RDRAND when we turn the CRNG crank.  (The
> reason why we don't just XOR in the RDRAND into the output ohf the
> CRNG is mainly to assuage critics that hypothetical RDRAND backdoor
> has access to the CPU registers.  So we perturb the inputs to the
> CRNG, on the theory that if malicious firmware can reverse
> CHACHA20... we've got bigger problems.  :-)  We get up to 20 bytes out
> of a single turn of the CRNG crank, so whether we mix in 4 bytes or 8
> bytes from RDRAND, we're never going to be depending on RDRAND
> completely in any case.
> 
> The bottom line is that I'm not at all convinced it worth the effort
> to mix in 8 bytes versus 4 bytes from RDRAND.  This is really a CRNG,
> and the RDRAND inputs really don't change that.
> 
Ok, so what I'm getting is that the exclusion of the second 32 bit word here
from &crng->state[15], isn't an oversight, its just skipped because its not
worth taking the time for the extra write there, and this is not a bug.  I'm ok
with that.

Thanks for the explination
Neil

>     	       	      	     	   	  - Ted
> 
