Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4D0C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A5D2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u0BN/6Ny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbfEWSty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:49:54 -0400
Received: from mail-yw1-f49.google.com ([209.85.161.49]:42929 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731397AbfEWStx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:49:53 -0400
Received: by mail-yw1-f49.google.com with SMTP id s5so2655292ywd.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/4hzu5ZLVp3mgIPesJPmq/IWbfe4flwA2HG1sCD0TQ=;
        b=u0BN/6Ny8Z4+blOm22Z5UCSC8Wy5XnV4pzNa9RSEvcRmexqQPvcwNghBha2X4MQ36C
         7dzsdV+f6ydrqcsngoZ6b81Z6BiBjBfDHoUWeZaLAK49agcruYHxVKfgwvl6vkbI7a2g
         qWF7FK3K5DeBcV4zvxpXp0o81by/At5dYBRjnk7yfQBXl0RTZNucfLEpe2dPkSFCumKX
         lM23S8zrXdpTm2qs3mlX+TjAUJg+SGmA3p+ePvgDlWxlg/5n+eJfvBZ/ka/EFGLzfvai
         bSt2zk6ItfPP82e9IfgqRiHMA9BW3IYp9vtRWaIl180exc8Z8hQL9gAUR3c4PwBkBOO2
         q+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/4hzu5ZLVp3mgIPesJPmq/IWbfe4flwA2HG1sCD0TQ=;
        b=m8zyB0fvAZ+2G6jFniR64pk0oRa0EMsF7IIFT9DImYbINBuwcuPJo3kukpiTrLrZ5u
         OegjNzEk5ca4pObDkCYvpKiwNq3nsnr7503PwH7zWJsbudaWu+qpWMgF8JFPJIFBrkye
         2xODCiFuxKlIne+a5mnx/1UEbUpzabRR1GOdQFVWpyS0KUzwQsx3k8f+TXyR/sajPKdm
         kuVNpZSyFKVB2vvZbB3CZ5Igji5DMvP28sfBsawL0xaiSsvhcDv+BQm+ps4I1ISE1N8t
         KulF6B7Wc5XGE6PrSbfVQeE+1aZGT8HZqFTaEn6YQslSkbFhYhr4VuACRXr5NzGPWgS8
         5sKg==
X-Gm-Message-State: APjAAAWYeMpEObKyx3qL7rrZI+nVas2gl2ujKtT3zscc1VPxmkcRNv4y
        gr/A44KmmJT/+iGWufwr4IoYnKVE1jdbLbhmlZOdRw==
X-Google-Smtp-Source: APXvYqzw3j/oSC5Q9iYfqvGAp+HoFdUfIIMs+Btzd/EKLDObZYBH8mQUpoL/qVeAVC9OPWePoER5CA68wIGZsaWSqM0=
X-Received: by 2002:a81:5ec3:: with SMTP id s186mr47879009ywb.308.1558637392374;
 Thu, 23 May 2019 11:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190523174349.GA10939@cmpxchg.org> <20190523183713.GA14517@bombadil.infradead.org>
In-Reply-To: <20190523183713.GA14517@bombadil.infradead.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 23 May 2019 11:49:41 -0700
Message-ID: <CALvZod4o0sA8CM961ZCCp-Vv+i6awFY0U07oJfXFDiVfFiaZfg@mail.gmail.com>
Subject: Re: xarray breaks thrashing detection and cgroup isolation
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 11:37 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, May 23, 2019 at 01:43:49PM -0400, Johannes Weiner wrote:
> > I noticed that recent upstream kernels don't account the xarray nodes
> > of the page cache to the allocating cgroup, like we used to do for the
> > radix tree nodes.
> >
> > This results in broken isolation for cgrouped apps, allowing them to
> > escape their containment and harm other cgroups and the system with an
> > excessive build-up of nonresident information.
> >
> > It also breaks thrashing/refault detection because the page cache
> > lives in a different domain than the xarray nodes, and so the shadow
> > shrinker can reclaim nonresident information way too early when there
> > isn't much cache in the root cgroup.
> >
> > I'm not quite sure how to fix this, since the xarray code doesn't seem
> > to have per-tree gfp flags anymore like the radix tree did. We cannot
> > add SLAB_ACCOUNT to the radix_tree_node_cachep slab cache. And the
> > xarray api doesn't seem to really support gfp flags, either (xas_nomem
> > does, but the optimistic internal allocations have fixed gfp flags).
>
> Would it be a problem to always add __GFP_ACCOUNT to the fixed flags?
> I don't really understand cgroups.

Does xarray cache allocated nodes, something like radix tree's:

static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };

For the cached one, no __GFP_ACCOUNT flag.

Also some users of xarray may not want __GFP_ACCOUNT. That's the
reason we had __GFP_ACCOUNT for page cache instead of hard coding it
in radix tree.

Shakeel
