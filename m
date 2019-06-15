Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3DDC31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 01:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F2A21841
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 01:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560561329;
	bh=4p8HqKLMfle4KF8oWCDMGpNs9dXfVfS0IfJxUC1G3Os=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BBYQrLJHuFASC+cLbwcwdV9xM+fTHg2ACGjxUGdz9JmCGpHMcnO9d9ssWFlL7iJV8
	 FThvOli+4qSz/krEwQuS0uVf/iRlQPG+QuWOdzlNeYq70ap0Cp/ywNSYayGZrZzVy1
	 cI0baP9PWaq/ei2ZefAIYt9Y3F7fGNyZZtGLu1XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfFOBP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 21:15:28 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:41532 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfFOBP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 21:15:28 -0400
Received: by mail-lj1-f179.google.com with SMTP id s21so4083529lji.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 18:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0sAjPXXfslJFeHisHU1yrczsKCc0N+yl4i1W3iXGv0=;
        b=RaOwSCtNqtqtil2BG0A89cO+YIcb7ccAuT10ZjRkB+BM/5iXa5e7ccARHhlDEdfwDb
         UNWwmuNiXnI+FDpavul6sS3iDMhBtpB7ngwnNuMNvZlWEDtMgPp9OYEojdQ5XLD6tTG6
         emJyLc9yswuypGzecLiYQUAz3ylLy9F1cagCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0sAjPXXfslJFeHisHU1yrczsKCc0N+yl4i1W3iXGv0=;
        b=fO2BdLyKlQTjYpkEp/2M/OqP4JVnAGARXN3zyQMvtlQ8aMBvmpR6wdj9v3KtmycVaL
         Q1THb7WwBncIIrCfKyQvUTNoZp+xUlrhKI0/iMu2DygMrWtpjY9Y5lm9cBzRUAVOAtf4
         UDsYaQrSu5+rKv2sqV1/TU20ykVeoyO35YQL49NNU8PobHcTlfk4HM9UWXAnXeiOC1LD
         oOprW8uvnWTT4RdZ3wk4ja3G5kJwTbIsTodX4GX6UzKJICNtEa3WsVOXg/R2wo30bvf+
         4mgb921osAFTyGZYr+zTMVZAiDvhJTv3NCkoF7tspwUImEC9BOa7ZtZhutxnXKT5UwG6
         gILw==
X-Gm-Message-State: APjAAAUeY0Q+M71wbwnWp+jf3WuZwojsDRrQEso3GuBR5DhznG9NAOie
        7UDDlprRZsZOiUh4KSAgnsbLtiwdgd8=
X-Google-Smtp-Source: APXvYqysqm/xpR5T4U6DqbrtyR/PP+srxZEcgFl2/KPH3ZrabCnWzhxjT5Qt0S7aFTDFGr69dT0b0w==
X-Received: by 2002:a2e:890a:: with SMTP id d10mr9740139lji.145.1560561323772;
        Fri, 14 Jun 2019 18:15:23 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id v139sm687834lfa.69.2019.06.14.18.15.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 18:15:22 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id y198so2908832lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 18:15:22 -0700 (PDT)
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr48522334lfn.52.1560561321789;
 Fri, 14 Jun 2019 18:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel> <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel> <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel> <20190613235524.GK14363@dread.disaster.area>
 <CAHk-=wj3SQjfHHvE_CNrQAYS2p7bsC=OXEc156cHA_ujyaG0NA@mail.gmail.com> <20190614073053.GQ14363@dread.disaster.area>
In-Reply-To: <20190614073053.GQ14363@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Jun 2019 15:15:05 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgoXo-irWbU1SbKvHuYyAz2nwOkrw2L=+HackVWsXFhpQ@mail.gmail.com>
Message-ID: <CAHk-=wgoXo-irWbU1SbKvHuYyAz2nwOkrw2L=+HackVWsXFhpQ@mail.gmail.com>
Subject: Re: pagecache locking (was: bcachefs status update) merged)
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 9:31 PM Dave Chinner <david@fromorbit.com> wrote:
>
> Yes, they do, I see plenty of cases where the page cache works just
> fine because it is still faster than most storage. But that's _not
> what I said_.

I only quoted one small part of your email, because I wanted to point
out how you again dismissed caches.

And yes, that literally _is_ what you said. In other parts of that
same email you said

   "..it's getting to the point where the only reason for having
    a page cache is to support mmap() and cheap systems with spinning
    rust storage"

and

  "That's my beef with relying on the page cache - the page cache is
   rapidly becoming a legacy structure that only serves to slow modern
   IO subsystems down"

and your whole email was basically a rant against the page cache.

So I only quoted the bare minimum, and pointed out that caching is
still damn important.

Because most loads cache well.

How you are back-tracking a bit from your statements, but don't go
saying was misreading you. How else would the above be read? You
really were saying that caching was "legacy". I called you out on it.
Now you're trying to back-track.

Yes, you have loads that don't cache well. But that does not mean that
caching has somehow become irrelevant in the big picture or a "legacy"
thing at all.

The thing is, I don't even hate DIO. But we always end up clashing
because you seem to have this mindset where nothing else matters
(which really came through in that email I replied to).

Do you really wonder why I point out that caching is important?
Because you seem to actively claim caching doesn't matter. Are you
happier now that I quoted more of your emails back to you?

>         IOWs, you've taken _one
> single statement_ I made from a huge email about complexities in
> dealing with IO concurency, the page cache and architectural flaws n
> the existing code, quoted it out of context, fabricated a completely
> new context and started ranting about how I know nothing about how
> caches or the page cache work.

See above. I cut things down a lot, but it wasn't a single statement
at all. I just boiled it down to the basics.

> Linus, nobody can talk about direct IO without you screaming and
> tossing all your toys out of the crib.

Dave, look in the mirror some day. You might be surprised.

> So, in the interests of further _civil_ discussion, let me clarify
> my statement for you: for a highly concurrent application that is
> crunching through bulk data on large files on high throughput
> storage, the page cache is still far, far slower than direct IO.

.. and Christ, Dave, we even _agree_ on this.

But when DIO becomes an issue is when you try to claim it makes the
page cache irrelevant, or a problem.

I also take issue with you then making statements that seem to be
explicitly designed to be misleading. For DIO, you talk about how XFS
has no serialization and gets great performance. Then in the very next
email, you talk about how you think buffered IO has to be excessively
serialized, and how XFS is the only one who does it properly, and how
that is a problem for performance. But as far as I can tell, the
serialization rule you quote is simply not true. But for you it is,
and only for buffered IO.

It's really as if you were actively trying to make the non-DIO case
look bad by picking and choosing your rules.

And the thing is, I suspect that the overlap between DIO and cached IO
shouldn't even need to be there. We've generally tried to just not
have them interact at all, by just having DIO invalidate the caches
(which is really really cheap if they don't exist - which should be
the common case by far!). People almost never mix the two at all, and
we might be better off aiming to separate them out even more than we
do now.

That's actually the part I like best about the page cache add lock - I
may not be a great fan of yet another ad-hoc lock - but I do like how
it adds minimal overhead to the cached case (because by definition,
the good cached case is when you don't need to add new pages), while
hopefully working well together with the whole "invalidate existing
caches" case for DIO.

I know you don't like the cache flush and invalidation stuff for some
reason, but I don't even understand why you care. Again, if you're
actually just doing all DIO, the caches will be empty and not be in
your way. So normally all that should be really really cheap. Flushing
and invalidating caches that don't exists isn't really complicated, is
it?

And if cached state *does* exist, and if it can't be invalidated (for
example, existing busy mmap or whatever), maybe the solution there is
"always fall back to buffered/cached IO".

For the cases you care about, that should never happen, after all.

IOW, if anything, I think we should strive for a situation where the
whole DIO vs cached becomes even _more_ independent. If there are busy
caches, just fall back to cached IO. It will have lower IO throughput,
but that's one of the _points_ of caches - they should decrease the
need for IO, and less IO is what it's all about.

So I don't understand why you hate the page cache so much. For the
cases you care about, the page cache should be a total non-issue. And
if the page cache does exist, then it almost by definition means that
it's not a case you care about.

And yes, yes, maybe some day people won't have SSD's at all, and it's
all nvdimm's and all filesystem data accesses are DAX, and caching is
all done by hardware and the page cache will never exist at all. At
that point a page cache will be legacy.

But honestly, that day is not today. It's decades away, and might
never happen at all.

So in the meantime, don't pooh-pooh the page cache. It works very well
indeed, and I say that as somebody who has refused to touch spinning
media (or indeed bad SSD's) for a decade.

              Linus
