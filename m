Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27023C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5620216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557338127;
	bh=py4ZN8xGhiVrBaIbGbhAIZp22m+TDl0beFlh/vYRUG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zDchER0inHyfzPyCuQohyulC28T5N4P3c7DRxSj8dV1UDTSlnuW/o9pa+dab9jChJ
	 W4+EIKEGo3Ma6aMjWT0TAdNFppA/mtQE1TVFZ1p1i5+PQ41KnyhJ8aivIvbnfR+G7E
	 XlniUFXQj3dlIUkGfaY0oO6F9h55AslM5cp0I0fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfEHRzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:55:25 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46808 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfEHRzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:55:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id k18so15164185lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tB0dEg1LRdoWuwbFpIiC/qOnD5MiJ0Og2mGu9A6NlQo=;
        b=JCVzPV7zayA3wH6+Io+L76NQ2XQ8WUGer5LQj7CW69X+OplpDh3FykX8GJcnSmmntK
         OTIZ8qaVdAmxkZOd5IR6LTfpT5e2bXYmZv/WbMNYfhuZMvs+AgjkFhVxMk5XVgorcaF0
         GMeaq61fFXW9McmxexkVjLBG42BxtDDsoVj1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tB0dEg1LRdoWuwbFpIiC/qOnD5MiJ0Og2mGu9A6NlQo=;
        b=ac2EU/A7PfXzMGnWgE2G9+tJh0YicdiyUjXcdyWGIouqk5I/NHaYv7u8/MFWT7EAjW
         ECjm/ows2Hpb/WWhYpCtBlEBP2Dx475GI7ZGyyedNUnnSZyV2VMJ4ucCEv+nngtnGp+v
         LBRrjGo4yI7uK6GmChxONnTyoQZhG5KmQbh5K5YemdHh0AGnsJKb6BW5YeoqU4mavArJ
         r7CjLnbbj/13MDqyoBa3p03MC0cvonlWgcV6YYzYjA0b9na6d7X/h1KFDlVBJ29+Wyuw
         F59OTkavdOvm0AFcpTCd85M+T5QxQs6ggX+JfPmkQ/wp1/EfC40qdMhIGe1lWxnhRDgO
         uIpw==
X-Gm-Message-State: APjAAAWWHU+kQRQlCJr5qPx7CJh94zYFItB5p/pkl41eISICZCO0x2iC
        dnSR0tN2LD85XHWqzUdUtMPzxwJBPZE=
X-Google-Smtp-Source: APXvYqwM2RXYF10pswrzbznMo313VMPLkdStD5qBl7o72GMjWcmRn0fnuH6rn77uS3hxwg5+f8OPYw==
X-Received: by 2002:ac2:483c:: with SMTP id 28mr11220208lft.93.1557338122044;
        Wed, 08 May 2019 10:55:22 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id u65sm2544703lja.39.2019.05.08.10.55.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 10:55:21 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id k18so15164121lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 10:55:20 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr20978222lfg.88.1557338120579;
 Wed, 08 May 2019 10:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHc6FU5Yd9EVju+kY8228n-Ccm7F2ZBRJUbesT-HYsy2YjKc_w@mail.gmail.com>
In-Reply-To: <CAHc6FU5Yd9EVju+kY8228n-Ccm7F2ZBRJUbesT-HYsy2YjKc_w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 May 2019 10:55:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_L9d8P0Kmtb5f4wudm=KGZ5z0ijJ-NxTY-CcNcNDP5A@mail.gmail.com>
Message-ID: <CAHk-=wj_L9d8P0Kmtb5f4wudm=KGZ5z0ijJ-NxTY-CcNcNDP5A@mail.gmail.com>
Subject: Re: GFS2: Pull Request
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 4:49 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> There was a conflict with commit 2b070cfe582b ("block: remove the i
> argument to bio_for_each_segment_all") on Jens's block layer changes
> which you've already merged. I've resolved that by merging those block
> layer changes; please let me know if you want this done differently.

PLEASE.

I say this to somebody pretty much every single merge window: don't do
merges for me.

You are actually just hurting, not helping. I want to know what the
conflicts are, not by being told after-the-fact, but by just seeing
them and resolving them.

Yes, I like being _warned_ ahead of time - partly just as a heads up
to me, but partly also to show that the maintainers are aware of the
notifications from linux-next, and that linux-next is working as
intended, and people aren't just ignoring what it reports.

But I do *NOT* want to see maintainers cross-merging each others trees.

It can cause nasty problems, ranging from simply mis-merges to causing
me to not pull a tree at all because one side of the development
effort had done something wrong.

And yes, mis-merges happen - and they happen to me too. It's fairly
rare, but it can be subtle and painful when it does happen.

But (a) I do a _lot_ of merges, so I'm pretty good at them, and (b) if
_I_ do the merge, at least I know about the conflict and am not as
taken by surprise by possible problems due to a mis-merge.

And that kind of thing is really really important to me as an upstream
maintainer. I *need* to know when different subtrees step on each
others toes.

As a result, even when there's a conflict and a merge is perfectly
fine, I want to know about it and see it, and I want to have the
option to pull the maintainer trees in different orders (or not pull
one tree at all), which means that maintainers *MUST NOT* do
cross-tree merges. See?

And I don't want to see back-merges (ie merges from my upstream tree,
as opposed to merges between different maintainer trees) either, even
as a "let me help Linus, he's already merged the other tree, I'll do
the merge for him". That's not helping, that's just hiding the issue.

Now, very very occasionally I will hit a merge that is so hard that I
will go "Hmm, I really need the involved parties to sort this out".
Honestly, I can't remember the last time that happened, but it _has_
happened.

Much more commonly, I'll do the merge, but ask for verification,
saying "ok, this looked more subtle than I like, and I can't test any
of it, so can you check out my merge". Even that isn't all that
common, but it definitely happens.

There is _one_ very special kind of merge that I like maintainers
doing: the "test merge".

That test merge wouldn't be sent to me in the pull request as the
primary signed pull, but it's useful for the maintainer to do to do a
final *check* before doing the pull request, so that you as a
maintainer know what's going on, and perhaps to warn me about
conflicts.

If you do a test merge, and you think the test merge was complex, you
might then point to your resolution in the pull request as a "this is
how I would do it". But you should not make that merge be *the* pull
request.

One additional advantage of a test merge is that it actually gives a
"more correct" diffstat for the pull request. Particularly if the pull
request is for something with complex history (ie you as a maintainer
have sub-maintainers, and have pulled other peoples work), a
test-merge can get a much better diffstat. I don't _require_ that
better diffstat, though - I can see how you got the "odd" diffstat if
you don't do a test merge - but it's can be a "quality of pull
request" thing.

See what I'm saying? You would ask me to pull the un-merged state, but
then say "I noticed a few merge conflicts when I did my test merge,
and this is what I did" kind of aside.

                     Linus
