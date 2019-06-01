Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EF8C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 15:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEAA27607
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 15:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfFAPm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 11:42:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52724 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725946AbfFAPm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 11:42:57 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x51Fgnih031925
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Jun 2019 11:42:49 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D4029420481; Sat,  1 Jun 2019 11:42:48 -0400 (EDT)
Date:   Sat, 1 Jun 2019 11:42:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC] Rough draft document on merging and rebasing
Message-ID: <20190601154248.GA17800@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
References: <20190530135317.3c8d0d7b@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530135317.3c8d0d7b@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 01:53:17PM -0600, Jonathan Corbet wrote:
> +Rebasing
> +========
> +
> +"Rebasing" is the process of changing the history of a series of commits
> +within a repository.  At its simplest, a rebase could change the starting
> +point of a patch series from one point to another.  Other uses include
> +fixing (or deleting) broken commits, adding tags to commits, or changing
> +the order in which commits are applied.  Used properly, rebasing can yield
> +a cleaner and clearer development history; used improperly, it can obscure
> +that history and introduce bugs.

Rebasing is being used in two senses here.  The first is where the
diffs don't change (much), but the starting point of the changes is
being changed.  The second is where a broken commit is dropped, adding
a signed-off-by, etc.

Both have the property that they can used for good or ill, but the
details when this is an issue can change a bit.  More below...

> +There are a few rules of thumb that can help developers to avoid the worst
> +perils of rebasing:
> +
> + - History that has been exposed to the world beyond your private system
> +   should not be rebased.  Others may have pulled a copy of your tree and
> +   built on it; rebasing your tree will create pain for them.  If work is
> +   in need of rebasing, that is usually a sign that it is not yet ready to
> +   be committed to a public repository.

That seems to be a bit too categorical.  It's been recommended, and
some people do, push patches to a branch so the zero-day bot will pick
it up and test for potential problems.  And broken commits *do* get
dropped from candidate stable kernel releases.  And, of course,
there's linux-next, which is constantly getting rebased.

And there have been people who have pushed out RFC patche series onto
a git branch, and publicized it on LKML for the convenience of
reviewers.  (Perhaps because there is a patch which is so big it
exceeds the LKML size restrictions.)

I think it's more about whether people know that a branch is
considered unstable from a historical perspective or not.  No one
builds on top of linux-next because, well, that would be silly.

Finally, I'm bit concerned about anything which states absolutes,
because there are people who tend to be real stickler for the rules,
and if they see something stated in absolute terms, they fail to
understand that there are exceptions that are well understood, and in
use for years before the existence of the document which is trying to
codify best practices.

> + - Realize the rebasing a patch series changes the environment in which it
> +   was developed and, likely, invalidates much of the testing that was
> +   done.  A rebased patch series should, as a general rule, be treated like
> +   new code and retested from the beginning.

In this paragraph, "rebasing" is being used in the change the base
commit on top of which a series of changes were based upon.  And it's
what most people think of when they see the word "rebase".

However "git rebase" is also used to rewrite git history when dropping
a bad commit, or fixing things so the branch is bisectable, etc.  But
in the definitions above, the word "rebase" was defined to include
both "changing the base of a patch stack", and "rewriting git
history".  I wonder if that helps more than it hinders understanding.

At least in my mind, "rebasing" is much more often the wrong thing,
where as "rewriting git history" for a leaf repository can be more
often justifable.  And of course, if someone is working on a feature
for which the review and development cycle takes several kernel
releases, I'd claim that "rebasing" in that case always makes sense,
even if they *have* exposed their patch series via git for review /
commenting purposes.

Regards,

						- Ted
