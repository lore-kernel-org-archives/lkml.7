Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FF2C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE4922ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfE2Nnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:43:37 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:48400 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfE2Nng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:43:36 -0400
Received: from cpe-2606-a000-111b-405a-0-0-0-162e.dyn6.twc.com ([2606:a000:111b:405a::162e] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1hVyqZ-0000lu-Gj; Wed, 29 May 2019 09:43:34 -0400
Date:   Wed, 29 May 2019 09:42:00 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steve Grubb <sgrubb@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Fix xoring of arch_get_random_long into crng->state array
Message-ID: <20190529134200.GA31099@hmswarspite.think-freely.org>
References: <20190402220025.14499-1-nhorman@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402220025.14499-1-nhorman@tuxdriver.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
> 
> Bring the expected behavior into alignment by casting index 14 to an
> unsignled long pointer, and xoring that in instead.
> 
> Tested successfully by myself
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> Reported-by: Steve Grubb <sgrubb@redhat.com>
> CC: "Theodore Ts'o" <tytso@mit.edu>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/random.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 38c6d1af6d1c..8178618458ac 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -975,14 +975,16 @@ static void _extract_crng(struct crng_state *crng,
>  			  __u8 out[CHACHA_BLOCK_SIZE])
>  {
>  	unsigned long v, flags;
> -
> +	unsigned long *archrnd;
>  	if (crng_ready() &&
>  	    (time_after(crng_global_init_time, crng->init_time) ||
>  	     time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL)))
>  		crng_reseed(crng, crng == &primary_crng ? &input_pool : NULL);
>  	spin_lock_irqsave(&crng->lock, flags);
> -	if (arch_get_random_long(&v))
> -		crng->state[14] ^= v;
> +	if (arch_get_random_long(&v)) {
> +		archrnd = (unsigned long *)&crng->state[14];
> +		*archrnd ^= v;
> +	}
>  	chacha20_block(&crng->state[0], out);
>  	if (crng->state[12] == 0)
>  		crng->state[13]++;
> -- 
> 2.20.1
> 
> 

Ping, Arnd, Ted, Greg, any comment here?
Neil

