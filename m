Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD5AC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6C02086A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfDZThW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:37:22 -0400
Received: from ms.lwn.net ([45.79.88.28]:50814 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfDZThV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:37:21 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 839AD77D;
        Fri, 26 Apr 2019 19:37:20 +0000 (UTC)
Date:   Fri, 26 Apr 2019 13:37:19 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] Docs: An initial automarkup extension for sphinx
Message-ID: <20190426133719.5d30d4a4@lwn.net>
In-Reply-To: <20190426153255.7e424a45@coco.lan>
References: <20190425200125.12302-1-corbet@lwn.net>
        <20190425200125.12302-2-corbet@lwn.net>
        <20190426153255.7e424a45@coco.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 15:32:55 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> > +# Try to identify "function()" that's not already marked up some
> > +# other way.  Sphinx doesn't like a lot of stuff right after a
> > +# :c:func: block (i.e. ":c:func:`mmap()`s" flakes out), so the last
> > +# bit tries to restrict matches to things that won't create trouble.
> > +#
> > +RE_function = re.compile(r'(^|\s+)([\w\d_]+\(\))([.,/\s]|$)')  
> 
> IMHO, this looks good enough to avoid trouble, maybe except if one
> wants to write a document explaining this functionality at the
> doc-guide/kernel-doc.rst.

Adding something to the docs is definitely on my list.

> Anyway, the way it is written, we could still explain it by adding
> a "\ " after the func, e. g.:
> 
> 	When you write a function like: func()\ , the automarkup
> 	extension will automatically convert it into:
> 	``:c:func:`func()```.
> 
> So, this looks OK on my eyes.

Not sure I like that; the whole point is to avoid extra markup here.  Plus
I like that it catches all function references whether the author thought
to mark them or not.

> > +#
> > +# Lines consisting of a single underline character.
> > +#
> > +RE_underline = re.compile(r'^([-=~])\1+$')  
> 
> Hmm... why are you calling this "underline"? Sounds a bad name to me,
> as it took me a while to understand what you meant.

Seemed OK to me, but I can change it :)

> From the code I'm inferring that this is meant to track 3 of the
> possible symbols used as a (sub).*title markup. On several places 
> we use other symbols:'^', '~', '.', '*' (and others) as sub-sub(sub..)
> title markups.

I picked the ones that were suggested in our docs; it was enough to catch
all of the problems in the current kernel docs.

Anyway, The real documentation gives the actual set, so I'll maybe make it:

	=-'`":~^_*+#<>

I'd prefer that to something more wildcardish.

> You should probably need another regex for the title itself:
> 
> 	RE_possible_title = re.compile(r'^(\S.*\S)\s*$')
> 
> in order to get the size of the matched line. Doing a doing len(previous)
> will get you false positives.

This I don't quite get.  It's easy enough to trim off the spaces with
strip() if that turns out to be a problem (which it hasn't so far).  I can
add that.

> on a separate matter (but related to automarkup matter - and to what
> I would name underline), as a future feature, perhaps we could also add
> a parser for:
> 
> 	_something that requires underlines_
> 
> Underlined text is probably the only feature that we use on several docs
> with Sphinx doesn't support (there are some extensions for that - I guess,
> but it sounds simple enough to have a parser here).
> 
> This can be tricky to get it right, as just underlines_ is a
> cross reference markup - so, I would only add this after we improve the
> script to come after Sphinx own markup processing.

That does indeed sound tricky.  It would also probably have to come
*before* Sphinx does its thing or it's unlikely to survive.

> > +        #
> > +        # Is this an underline line?  If so, and it is the same length
> > +        # as the previous line, we may have mangled a heading line in
> > +        # error, so undo it.
> > +        #
> > +        elif RE_underline.match(line):
> > +            if len(line) == len(previous):  
> 
> No, that doesn't seem enough. I would, instead, use the regex I
> proposed before, in order to check if the previous line starts with
> a non-space, and getting the length only up to the last non-space
> (yeah, unfortunately, we have some text files that have extra blank
> spaces at line's tail).

So I'll make it "if len(line) == len(previous.strip())

Thanks,

jon
