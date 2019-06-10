Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67866C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416E02082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560199620;
	bh=yOaPojV03VlR5PRPjQCd0Dcv4xItWM/yJTZWCGgRFRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=km9LeqgkcIUT6uf6FsdTg8wTw2kpqVtlP6o5nOeVMLvvFuuKG8h5rSoYNW6IwF+yb
	 juXBm49i2YNKrwdyhaUfb8b5Bz7nSA2PfOyJQp6iQIE1tSGBdkFhjFPShRCwrn3w43
	 PEPKhCLGq4cmQ4raK1yjB5E2rQjPWzCnwwzM+g8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389797AbfFJUq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:46:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35354 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389653AbfFJUq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:46:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id a25so7635775lfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 13:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3dZjFALioLfmWT2gX0OovbSYoNZY24tjNWFjpsEzRZY=;
        b=OW2Dex0kC9JUsK1CtK5L0J10uoGXFqGOUG1VA+0wauSzJMHtqZFtHeg4zvU9maNl4n
         OZW+g4o0pnDdCxvJBdZHVHjOtF90nTXwp8sBsSG1/heY+cBzcFDob/dNI51E/aFazn/e
         Q0imxrIBOzeOvg0igH+hFLwCY647B83Q0fqew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dZjFALioLfmWT2gX0OovbSYoNZY24tjNWFjpsEzRZY=;
        b=EuV4H91v5lfLHpxQG9xg9aOEmC4ccyUOsdle4TjZr9qCWkoPJBKaAIDb/teaxTSGjT
         7tvTAC3senYEsRyjiRg8RUun00q6/0ftjxohhIwmfF6oEBNwTOEmwlO8tKuJpw62ShWc
         laIp2pHIVKAvQX71FYvZNBXosuwap+YFpWz1rcvfFoxwIe3SoSDGZrbzKl5ih6Jo22iQ
         w/JMdp/mSQ0foko8EFDaJ5IOYlzrdZUJpF2tuEziWES7IEo82OQNTLvqq3OG/Air8L2n
         QNnvRXLoVGZqmpUXqJtZdMQbraAlAMed+5V5cYGaYoRHERbr6DS6JrUU67U82wWnrWt7
         fZzQ==
X-Gm-Message-State: APjAAAUmDfk6pwG3ta+XotpWDkC4lPDRxcSMFa66RN/0t44nntqVI3lE
        agDjrhtELRkmOmza42vBCPvE+myEmNA=
X-Google-Smtp-Source: APXvYqxFCrVako86+cB+eUHIFPQHvqTj8gVVDcRXr6nlicNAu4kS7MtS2CmoedMxUKm/y1CoH5CcmQ==
X-Received: by 2002:a19:750b:: with SMTP id y11mr22798270lfe.16.1560199615520;
        Mon, 10 Jun 2019 13:46:55 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id w8sm2192791lfq.62.2019.06.10.13.46.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 13:46:52 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id a25so7635653lfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 13:46:52 -0700 (PDT)
X-Received: by 2002:a19:ae01:: with SMTP id f1mr34920353lfc.29.1560199612181;
 Mon, 10 Jun 2019 13:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
In-Reply-To: <20190610191420.27007-1-kent.overstreet@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jun 2019 10:46:35 -1000
X-Gmail-Original-Message-ID: <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
Message-ID: <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
Subject: Re: bcachefs status update (it's done cooking; let's get this sucker merged)
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-bcache@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 9:14 AM Kent Overstreet
<kent.overstreet@gmail.com> wrote:
>
> So. Here's my bcachefs-for-review branch - this has the minimal set of patches
> outside of fs/bcachefs/. My master branch has some performance optimizations for
> the core buffered IO paths, but those are fairly tricky and invasive so I want
> to hold off on those for now - this branch is intended to be more or less
> suitable for merging as is.

Honestly, it really isn't.

There are obvious things wrong with it - like the fact that you've
rebased it so that the original history is gone, yet you've not
actually *fixed* the history, so you find things like reverts of
commits that should simply have been removed, and fixes for things
that should just have been fixed in the original commit the fix is
for.

And this isn't just "if you rebase, just fix things". You have actual
bogus commit messages as a result of this all.

So to point at the revert, for example. The commit message is

    This reverts commit 36f389604294dfc953e6f5624ceb683818d32f28.

which is wrong to begin with - you should always explain *why* the
revert was done, not just state that it's a revert.

But since you rebased things, that commit 36f3896042 doesn't exist any
more to begin with.  So now you have a revert commit that doesn't
explain why it reverts things, but the only thing it *does* say is
simply wrong and pointless.

Some of the "fixes" commits have the exact same issue - they say things like

    gc lock must be held while invalidating buckets - fixes
    "1f7a95698e bcachefs: Invalidate buckets when writing to alloc btree"

and

    fixes b0f3e786995cb3b12975503f963e469db5a4f09b

both of which are dead and stale git object pointers since the commits
in question got rebased and have some other hash these days.

But note that the cleanup should go further than just fix those kinds
of technical issues. If you rebase, and you have fixes in your tree
for things you rebase, just fix things as you rewrite history anyway
(there are cases where the fix may be informative in itself and it's
worth leaving around, but that's rare).

Anyway, aside from that, I only looked at the non-bcachefs parts. Some
of those are not acceptable either, like

    struct pagecache_lock add_lock
        ____cacheline_aligned_in_smp; /* protects adding new pages */

in 'struct address_space', which is completely bogus, since that
forces not only a potentially huge amount of padding, it also requires
alignment that that struct simply fundamentally does not have, and
_will_ not have.

You can only use ____cacheline_aligned_in_smp for top-level objects,
and honestly, it's almost never a win. That lock shouldn't be so hot.

That lock is somewhat questionable in the first place, and no, we
don't do those hacky recursive things anyway. A recursive lock is
almost always a buggy and mis-designed one.

Why does the regular page lock (at a finer granularity) not suffice?

And no, nobody has ever cared. The dio people just don't care about
page cache anyway. They have their own thing going.

Similarly, no, we're not starting to do vmalloc in non-process context. Stop it.

And the commit comments are very sparse. And not always signed off.

I also get the feeling that the "intent" part of the six-locks could
just be done as a slight extension of the rwsem, where an "intent" is
the same as a write-lock, but without waiting for existing readers,
and then the write-lock part is just the "wait for readers to be
done".

Have you talked to Waiman Long about that?

                    Linus
