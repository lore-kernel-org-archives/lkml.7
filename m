Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB982CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894E321925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dZOxx5ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395283AbfJRUm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 16:42:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34942 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfJRUm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 16:42:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id p30so3998150pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VhVtaFR4lC9WpDLZGJuvhTXL3MmkTO55Z2XEXjz4Fqg=;
        b=dZOxx5httOrKFoPQTyS276YZ2LuctMWAGeVKZClbnb3AEMHvWZufFPrh7SjZ9EzM17
         YqTX/myX5BqFptcS1BISyWeGxpOUaEM2CfLC+4SLIKAHoqOYgCgcbT5B71Zxno8HsPyT
         9eWovCFL0gi5RhJJlUQVcu94GiXfZp3XqclcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VhVtaFR4lC9WpDLZGJuvhTXL3MmkTO55Z2XEXjz4Fqg=;
        b=WQdrkJr2ic/0S2LET1gFEnTjGDa8YF3RX8N0Ll436u94bKn1UOwfBaTiPx3H2MAzCE
         VYt7cfXTxiQYqs5TCBZkbb94hBAeTDxUhat7cHGWHLg6574y/y7T9rZrMGYm9p6YosnB
         mF7nLRFERWNe+IgOA+HLdDJcXqoYovFCp6eVgIJ8afo+JM7ZAUE1+j3xRpOaVS2kLcuu
         TCKfYLBE/mZsaiQYOHosrz0dXazj/dGBmEd9LU/mdxmsPRhj7R9MfWo9/fxDK9spZfK0
         YN+19TIEi4WmbQz5NuNWoNg1p2ZOV+zCPMoF3PiicOP4EmD8j7k0EGOdEW0juBuMcs7o
         OjYQ==
X-Gm-Message-State: APjAAAVR3dSEzfZMYuqpfDv65tlcT5s9vNj7IA/s481zF9K3h1ZChHCw
        d5ngpQgU0Moc1c68EiOxEwEt7Q==
X-Google-Smtp-Source: APXvYqzXJ/D3AABQOCh7mjUXCd8Dze6oOUF1vUVLaB1bqQzMDY3OgjNlRrK9x8ayHxXqFnyMqsICXg==
X-Received: by 2002:a63:778f:: with SMTP id s137mr12009512pgc.147.1571431347415;
        Fri, 18 Oct 2019 13:42:27 -0700 (PDT)
Received: from cork (c-67-180-85-52.hsd1.ca.comcast.net. [67.180.85.52])
        by smtp.gmail.com with ESMTPSA id u11sm4645761pgc.61.2019.10.18.13.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 13:42:26 -0700 (PDT)
Date:   Fri, 18 Oct 2019 13:42:20 -0700
From:   =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: make try_to_generate_entropy() more robust
Message-ID: <20191018204220.GD31027@cork>
References: <20191018203704.GC31027@cork>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018203704.GC31027@cork>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 01:37:04PM -0700, Jörn Engel wrote:
> Sorry for coming late to the discussion.  I generally like the approach
> in try_to_generate_entropy(), but I think we can do a little better
> still.  Would something like this work?

Fixed lkml address.

> From 90078333edb6e720f13f6668376a69c0f9c570f5 Mon Sep 17 00:00:00 2001
> From: Joern Engel <joern@purestorage.com>
> Date: Fri, 18 Oct 2019 13:25:52 -0700
> Subject: [PATCH] random: make try_to_generate_entropy() more robust
> 
> We can generate entropy on almost any CPU, even if it doesn't provide a
> high-resolution timer for random_get_entropy().  As long as the CPU is
> not idle, it changed the register file every few cycles.  As long as the
> ALU isn't fully synchronized with the timer, the drift between the
> register file and the timer is enough to generate entropy from.
> 
> Also print a warning on systems where entropy collection might be a
> problem.  I have good confidence in two unsynchronized timers generating
> entropy.  But I cannot tell whether timer and ALU are synchronized and
> we ought to warn users if all their crypto is likely to be broken.
> 
> Signed-off-by: Joern Engel <joern@purestorage.com>
> ---
>  drivers/char/random.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index de434feb873a..00a04efd0686 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1748,6 +1748,16 @@ EXPORT_SYMBOL(get_random_bytes);
>   */
>  static void entropy_timer(struct timer_list *t)
>  {
> +	struct pt_regs *regs = get_irq_regs();
> +
> +	/*
> +	 * Even if we don't have a high-resolution timer in our system,
> +	 * the register file itself is a high-resolution timer.  It
> +	 * isn't monotonic or particularly useful to read the current
> +	 * time.  But it changes with every retired instruction, which
> +	 * is enough to generate entropy from.
> +	 */
> +	mix_pool_bytes(&input_pool, regs, sizeof(*regs));
>  	credit_entropy_bits(&input_pool, 1);
>  }
>  
> @@ -1764,9 +1774,8 @@ static void try_to_generate_entropy(void)
>  
>  	stack.now = random_get_entropy();
>  
> -	/* Slow counter - or none. Don't even bother */
> -	if (stack.now == random_get_entropy())
> -		return;
> +	/* Slow counter - or none.  Warn user */
> +	WARN_ON(stack.now == random_get_entropy());
>  
>  	timer_setup_on_stack(&stack.timer, entropy_timer, 0);
>  	while (!crng_ready()) {
> -- 
> 2.20.1
> 

Jörn

--
...one more straw can't possibly matter...
-- Kirby Bakken
