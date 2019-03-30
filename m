Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B0DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 22:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4262070B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 22:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbfC3W7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 18:59:45 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35585 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbfC3W7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 18:59:45 -0400
Received: by mail-oi1-f178.google.com with SMTP id j132so4481204oib.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 15:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=72OuE+5FE16zVmZ0RxRJsb6Pj1wXoHbaXd/jFV8tW9I=;
        b=kBdwcqd+uj7MrlgZ54FeYT/EX4ISqIUlXxKK//lT9CCSYMkfDbho7Re9jitHKGMgTj
         Yy6Gnp5pNW4rvocnA0IIALnk4wjLCv6yoAtM9ixvYQ2m+CNIQOWUQrX7nGJzuOrFAMFe
         kzEJ/n3VX5hkIZbhZ0Jru3t94L449mkeg42WZWJ1tbU0MxUUSNFrNJ1/hZP3LSmGZHci
         nCg+prvqlERBEDwIi0Ylh64jvqLGvM3+9RR1nq60UJQDDPTdJ45ET3bhQdaYggvESzF7
         2PSvDy6eTldTaWtK7FpGdKkq1HpmEAVSYuhKX3HFe1oaCSJJ3HvE/dHk49hAs6hdjL1s
         RPEQ==
X-Gm-Message-State: APjAAAWg7+UZ4ccb2JRRXOPIEdvy3pjTULhmPlnwDDHrFM6T8NPVa/c8
        5hQuGwKkwli6Oqz5/GqlugLrh7bH
X-Google-Smtp-Source: APXvYqx5+Q7B7J1VTy8LvmnnUc9gyPr1UDxS/aQ7gk2qb1W5xoBMoPn/+wR47AyGHXuAy9yBOPsyBw==
X-Received: by 2002:aca:d608:: with SMTP id n8mr8257434oig.35.1553986784362;
        Sat, 30 Mar 2019 15:59:44 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id p132sm2435361oig.37.2019.03.30.15.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 15:59:43 -0700 (PDT)
Date:   Sat, 30 Mar 2019 15:59:41 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [RFCv2] string: Use faster alternatives when constant arguments
 are used
Message-ID: <20190330225941.GA7456@sultan-box.localdomain>
References: <20190324014445.28688-1-sultan@kerneltoast.com>
 <20190324022406.GA18988@sultan-box.localdomain>
 <2293c54f-40b1-1e59-665a-bd8f2cb957d2@rasmusvillemoes.dk>
 <20190324223202.GA875@sultan-box.localdomain>
 <8672b98c-bf71-7b5b-625e-2f241807d46c@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8672b98c-bf71-7b5b-625e-2f241807d46c@rasmusvillemoes.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:24:00PM +0100, Rasmus Villemoes wrote:
> What I'm worried about is your patch changing every single strcmp(,
> "literal") into a memcmp, with absolutely no way of knowing or checking
> anything about the other buffer. And actually, it doesn't have to be a
> BE arch with a word-at-a-time memcmp.
> If (as is usually the case) the strcmp() result is compared to zero, after you
> change
> 
>   !strcmp(buf, "literal")
> 
> into
> 
>   !memcmp(buf, "literal", 8)
> 
> the compiler may (exactly as you want it to) change that into a single
> 8-byte load (or two 4-byte loads) and comparisons to literals, no
> memcmp() involved. And how do you know that _that_ is ok, for every one
> of the hundreds, if not thousands, of instances in the tree?

When would this not be ok though? From what I've always known,

  strcmp(terminated_buf1, terminated_buf2)

is equivalent to

  memcmp(terminated_buf1, terminated_buf2, strlen(terminated_buf1))

  and

  memcmp(terminated_buf1, terminated_buf2, strlen(terminated_buf2))

regardless of whether or not one side is a literal (my patch just leverages the
compiler's ability to recognize strlen called on literals and optimize it out).
The latter memcmp instances would indeed perform worse than the first strcmp
when neither arguments are literals, but I don't see what makes the memcmp usage
"dangerous". How can the memcmps cross a page boundary when memcmp itself will
only read in large buffers of data at word boundaries?

And if there are concerns for some arches but not others, then couldn't this be
a feasible optimization for those which would work well with it?

Sultan
