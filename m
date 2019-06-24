Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F35EC4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4513420679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413143;
	bh=mu4kh2m8g3NUCRVqjZPyqVWMMWlc4rYisvzwZar//vs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xsaga8SiMsCdvLK7+Ay0j/Vrgfzo7q6feeHhq6zBbQBfEmKRUq5hlQawfa7uU3JEY
	 4FtJOyQ+MIJwunTf5YGjju4TSUONMUYxMM40AugNzGNnJ3b0//fcmpCT/pjLuXkAiP
	 rHzyJj21Mr640pYkxnJJzZVCwHaQR/CGvW9VSfWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbfFXVwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:52:22 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35420 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfFXVwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:52:21 -0400
Received: by mail-lf1-f67.google.com with SMTP id a25so11151085lfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 14:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2TgnyjeWoDT8cizs+0926CcrBI/Czk7Q1OwFweZT40=;
        b=YW+HL5IBGifOF6jZu1p6PtaguBQyhJkmQ9YMn7Jji10endO+CCULhFAsaLYdbA85HU
         bFUAnpfdTAsZ1Gvy96tlCor3QNdK05lm3AEeLiJmDqpEr3l1mXaGi+f50BoXwSjtl9UA
         vNVPNKHu+JCKTKrlQwc17yT7GYO7Y66TTo8Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2TgnyjeWoDT8cizs+0926CcrBI/Czk7Q1OwFweZT40=;
        b=ZgcyjbAZYsyYYteFFlMAA3eJAFpGwr/EvWQNPVfeONonpKS/0FitnZrhDqBIgQgB68
         L6tjLQq3vICGiE/PH715Tf7TPsBPP+FWAX8ZWZQl1UfWEYI3o2JQ+xWeaypBQvsRCmBe
         wXbUPj+visyi1kinEqHKZNUKZsFo+w5zb2NtvoMkZudHdWgra5Puz6zRHxXEzmoNR1ir
         /UY6Yh3PzqA9CzA9HsYKONYUTRfWYzmTPntU2jYKyW+3z0m5FW2dblfThUTtIyPoRkOs
         V5/CLdkec/McY17UrCWfsc3rQchvrx55NXCmFdr+3MKEekfJ44Eg/tgbsu5CfbpMORCn
         xvrQ==
X-Gm-Message-State: APjAAAWW67OGvcQQRCdfXuzdKapmeIM8Aj4uSz7zSwHMfeEccn8uLAQn
        tDl2v5O8FUg+ph/feof/cyoJM+zQIMg=
X-Google-Smtp-Source: APXvYqyJRyYQTXiEFTi90vGSGNEa9rNvcnLkbhD1SAsCJX0rt9VuaiAnEjsXrOn3WEUyd4muFXF6cg==
X-Received: by 2002:a19:f00a:: with SMTP id p10mr40901604lfc.68.1561413138496;
        Mon, 24 Jun 2019 14:52:18 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id x22sm1715316lfq.20.2019.06.24.14.52.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 14:52:17 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id p24so11124980lfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 14:52:17 -0700 (PDT)
X-Received: by 2002:ac2:44c5:: with SMTP id d5mr28053521lfm.134.1561413136997;
 Mon, 24 Jun 2019 14:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190524153148.18481-1-hannes@cmpxchg.org> <20190524160417.GB1075@bombadil.infradead.org>
 <20190524173900.GA11702@cmpxchg.org> <20190530161548.GA8415@cmpxchg.org>
 <20190530171356.GA19630@bombadil.infradead.org> <20190624151923.GA10572@cmpxchg.org>
In-Reply-To: <20190624151923.GA10572@cmpxchg.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Jun 2019 05:52:00 +0800
X-Gmail-Original-Message-ID: <CAHk-=wjcO7WjWyAoBmXDWcn7spfJbbgF_tXaHrqANVqEH8DGmQ@mail.gmail.com>
Message-ID: <CAHk-=wjcO7WjWyAoBmXDWcn7spfJbbgF_tXaHrqANVqEH8DGmQ@mail.gmail.com>
Subject: Re: [PATCH] mm: fix page cache convergence regression
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 11:19 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hey, it's three weeks later and we're about to miss 5.2.
>
> This sucks, Matthew.

Yes.

And I do think that having a real gfp field there would be better than
the very odd xa_flags that is *marked* as being gfp_t, but isn't
really a gfp_t at all.

So how about we apply Johannes' patch, and then work on making that
xa_flags field be a proper type of its own. Because it really isn't a
gfp_t, and never has been, even if there might be some very limited
and hacky overlap right now.

Alternatrively, the subset of bits that _can_ be used as a gfp should
actually be used as such, in xas_alloc/xas_nomem. So that you can do

    xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ | __GFP_ACCOUNT);

in __address_space_init_once() and it would do what it is supposed to do.

Willy?

               Linus
