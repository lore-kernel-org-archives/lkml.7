Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FB8C282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFAD2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFEBzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 21:55:11 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41806 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726427AbfFEBzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 21:55:11 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x551su7B031707
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jun 2019 21:54:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7555B420481; Tue,  4 Jun 2019 21:54:56 -0400 (EDT)
Date:   Tue, 4 Jun 2019 21:54:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2] Add a document on rebasing and merging
Message-ID: <20190605015456.GA2710@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Rientjes <rientjes@google.com>
References: <20190604134835.16fc6bfa@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604134835.16fc6bfa@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:48:35PM -0600, Jonathan Corbet wrote:
> +
> +Maintaining a subsystem, as a general rule, requires a familiarity with
> the +Git source-code management system.  Git is a powerful tool with a lot
> of +features; as is often the case with such tools, there are right and
> wrong +ways to use those features.  This document looks in particular at
> the use +of rebasing and merging.  Maintainers often get in trouble when
> they use +those tools incorrectly, but avoiding problems is not actually
> all that +hard.

FYI, it looks like your patch somehow got hit by your text editor (or
MUA's) line wrapping...

> +
> + - Realize that the rebasing a patch series changes the environment in
> +   which it was developed and, likely, invalidates much of the testing
> that
> +   was done.  A rebased patch series should, as a general rule, be treated
> +   like new code and retested from the beginning.

Shouldn't "reparenting" be used in this paragraph?

I suppose if a patch is getting dropped or modified that can
invalidate some of the testing (although it really depends on the
nature of what's being dropped or modified).  And if it's just adding
a Tested-by tag or a CVE number in the commit description, it's not
going to invalidate any testing.


As an aside, I wonder if git could pass down some kind of hint at "git
fetch" time that a particular branch is one that is subject to
frequent history rewriting, so it shouldn't be used as the basis for
further work (unless the developer is someone who is really good at
the "git rebase --onto ..." syntax).

> +Even in the absence of known conflicts, doing a test merge before sending
> a +pull request is a good idea.  It may alert you to problems that you
> somehow +didn't see from linux-next and helps to understand exactly what
> you are +asking upstream to do.

Some maintainers will actually do a test merge and then run regression
tests on the result --- more than just a "it builds, ship it!"  :-)

> +
> +Another reason for doing merges of upstream or another subsystem tree is
> to +resolve dependencies.  These dependency issues do happen at times, and
> +sometimes a cross-merge with another tree is the best way to resolve them;
> +as always, in such situations, the merge commit should explain why the
> +merge has been done.  Take a momehnt to do it right; people will read those
> +changelogs.

It might also be useful to mention it might be useful to put the
commits which are needed to solve the dependency problem on its own
separate branch, based off of something like -rc2, and then each of
the trees which need the prerequisite commits can merge in that
branch.

BTW, this is another example where, if we couldn't figure this out in
advance, I might consider it worthwhile to separate out prerequisite
patches, and reparent them on top of -rc2, so that other trees don't
have to do a cross-merge which pulls in half of some other subsystem's
branch.  Rewriting history on one branch and reparenting the changes
so they are on their own branch might be a good tradeoff if it avoids
messy cross-merges on multiple other trees.  It also avoids this
problem:

> .... If that subsystem tree fails to be pulled
> +upstream, whatever problems it had will block the merging of your tree as
> +well.

						- Ted
