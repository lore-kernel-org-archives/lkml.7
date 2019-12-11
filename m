Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505E0C2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCF4214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0fDarWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLKFfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 00:35:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34425 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfLKFfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 00:35:09 -0500
Received: by mail-pl1-f196.google.com with SMTP id x17so955766pln.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 21:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2OO7/mhUSy6qobOmjDi9q9vof+DP3uQZkiBVuacLKKk=;
        b=P0fDarWXXzotrsEuyawGcdziLBTOsrIYSry5uGgXRfzDcHHAkK+viauFdTpnQ4yve8
         1xgWmcCiSjeQDpwG24LIJ4yhJS3Kg2pFn1yTG/QrccPysq4l+cLFFd/agHx/9Z728n37
         iYskg5KWq81OaEPY5Ji0YbDdIO3IZ1pGTTaVth6r2xNC9dhcbf7y07X70s9rFMCN33/v
         IYjvIe1K3xt10Bv3LW2HnVpj3zkqDbnNpDi373F715xMbuxTQNGWFlkqyasSKU/mJvHo
         OSWrQ9VkbMxXS8kEOGlMHtxWdsAuJtIxSFxp5BW0NgnvFhACqFcQ3Uw6xnEBG6uq+gPw
         PWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2OO7/mhUSy6qobOmjDi9q9vof+DP3uQZkiBVuacLKKk=;
        b=gs4lNz48Yjh2JDoszxTEU1XxdMEk88HSDulq+Wygv7WU3BHYWj3VjubGI0yHEIqtPy
         wv3AWVYYTmXBqfvEkPZf26d9jPnpz4uHLAjeKOOmM3Grd+0wdynXYcF7pHQhOEGbzOce
         aBm92/2EQlI2Sf12m5WZECrwuueRJWA+n64BTY99zBD8Qu2IOy6h8bCPWg3JADOD6yVI
         uGXw45O+4gqvNOUmGcHIbuoBZdDSTo9aOQNUuTSTuj1NTznT3oQUj3JqUliGbytd/10a
         uSoBv3Co+ITk/x44zt1XsPLyR4lQ3ARtGQsbVZFwnC+Pt680TQCCPVxog3cZ6u+qOITt
         KjnQ==
X-Gm-Message-State: APjAAAUYWQWlSG0hOAHDNx6+LJz1HxwMPnx2+eWd5N8xAQlTLgdSjANp
        SXokHhtmABq3XyCLD5ua744=
X-Google-Smtp-Source: APXvYqzs5IaM4QXj9sDAUMc2e5r8pCcEJ1XckzsWRuzDpDHC5KaA+/JP+VjHheuXLslNWhkU8rHkWg==
X-Received: by 2002:a17:902:c509:: with SMTP id o9mr1358256plx.112.1576042508773;
        Tue, 10 Dec 2019 21:35:08 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id n188sm876052pga.84.2019.12.10.21.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 21:35:07 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:35:05 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH] printk: Fix preferred console selection with
 multiple matches
Message-ID: <20191211053505.GO88619@google.com>
References: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
 <20191210080154.GJ88619@google.com>
 <98df321d16adb67c5579ac4b67d845fc0c2c97df.camel@kernel.crashing.org>
 <20191211020149.GN88619@google.com>
 <38b543cb91e936d7bd9f8885e585dd55032d83a4.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b543cb91e936d7bd9f8885e585dd55032d83a4.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/12/11 15:02), Benjamin Herrenschmidt wrote:
> On Wed, 2019-12-11 at 11:01 +0900, Sergey Senozhatsky wrote:
> > On (19/12/11 09:26), Benjamin Herrenschmidt wrote:
> > 
[..]
> > If we could perform simple alias matching, without ->setup() call, and
> > exact matching (strcmp()), and then, if newcon would match two entries,
> > we would pick up the last matching entry and configure newcon only once.
> > 
> > This changes the order, tho.
> 
> Walking the array backwards might just be what we want actually for the
> case at hand, but of course if some platforms or driver call
> add_preferred_console *after* the command line parsing, then it will
> break those.

Reverse loop sounds like a nice idea. But yes I guess this can break
things.

> Simple alias matching would require re-working all the match()
> callbacks. That said I think it was a mistake to begin with to have
> them include setup(). Those should have remained separate.

Agreed. strcmp(alias) and strcmp(exact name) are the same things.
The latter does "match" and setup() as separate steps, but the former
does both at once.

> What about a compromise here:
>
> Instead of walking the array and testing for preferred_console as we do
> so, we first test the array entry pointed to by preferred_console
> (doing both match & setup as today) and if that doesn't work, fallback
> to our existing mechanism ?

This may do the trick.
And perform preferred_console fast-path configuration only if
`has_preferred' is false.

> > Well, it still looks to me that what you want is to "ignore alias
> > match and prefer exact match".
>
> We don't want to ignore the alias match. But we do want to prefer the
> exact match. We still want to keep the fallback to the alias match.

Yeah, "prefer" is the key word here.

	-ss
