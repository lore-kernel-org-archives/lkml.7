Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2E1C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1536920868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfFFJJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:09:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:29087 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbfFFJJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:09:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 02:09:41 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jun 2019 02:09:40 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2] Add a document on rebasing and merging
In-Reply-To: <20190604134835.16fc6bfa@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190604134835.16fc6bfa@lwn.net>
Date:   Thu, 06 Jun 2019 12:12:45 +0300
Message-ID: <87imtj13hu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jun 2019, Jonathan Corbet <corbet@lwn.net> wrote:
> Every merge window seems to involve at least one episode where subsystem
> maintainers don't manage their trees as Linus would like.  Document the
> expectations so that at least he has something to point people to.

Good stuff. Some notes inline.

BR,
Jani.

>
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
> Changes in v2:
>   - Try to clear up "reparenting" v. "history modification"
>   - Make the "don't rebase public branches" rule into more of a guideline
>   - Fix typos noted by Geert
>   - Rename the document to better reflect its contents
>
>  Documentation/maintainer/index.rst            |   1 +
>  .../maintainer/rebasing-and-merging.rst       | 216 ++++++++++++++++++
>  2 files changed, 217 insertions(+)
>  create mode 100644 Documentation/maintainer/rebasing-and-merging.rst
>
> diff --git a/Documentation/maintainer/index.rst
> b/Documentation/maintainer/index.rst index 2a14916930cb..56e2c09dfa39
> 100644 --- a/Documentation/maintainer/index.rst
> +++ b/Documentation/maintainer/index.rst
> @@ -10,5 +10,6 @@ additions to this manual.
>     :maxdepth: 2
>  
>     configure-git
> +   rebasing-and-merging
>     pull-requests
>  
> diff --git a/Documentation/maintainer/rebasing-and-merging.rst
> b/Documentation/maintainer/rebasing-and-merging.rst new file mode 100644
> index 000000000000..2987bd45dfb2
> --- /dev/null
> +++ b/Documentation/maintainer/rebasing-and-merging.rst
> @@ -0,0 +1,216 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================
> +Rebasing and merging
> +====================
> +
> +Maintaining a subsystem, as a general rule, requires a familiarity with
> the +Git source-code management system.  Git is a powerful tool with a lot
> of +features; as is often the case with such tools, there are right and
> wrong +ways to use those features.  This document looks in particular at
> the use +of rebasing and merging.  Maintainers often get in trouble when
> they use +those tools incorrectly, but avoiding problems is not actually
> all that +hard.
> +
> +One thing to be aware of in general is that, unlike many other projects,
> +the kernel community is not scared by seeing merge commits in its
> +development history.  Indeed, given the scale of the project, avoiding
> +merges would be nearly impossible.  Some problems encountered by
> +maintainers result from a desire to avoid merges, while others come from
> +merging a little too often.
> +
> +Rebasing
> +========
> +
> +"Rebasing" is the process of changing the history of a series of commits
> +within a repository.  There are two different types of operations that are
> +referred to as rebasing since both are done with the ``git rebase``
> +command, but there are significant differences between them:
> +
> + - Rebasing can change the parent (starting) commit upon which a series of
> +   patches is built.  For example, a rebase operation could take a patch
> +   set built on the previous kernel release and base it, instead, on the
> +   current release.  We'll call this operation "reparenting" in the
> +   discussion below.
> +
> + - Changing the history of a set of patches by fixing (or deleting) broken
> +   commits, adding patches, adding tags to commit changelogs, or changing
> +   the order in which commits are applied.  In the following text, this
> +   type of operation will be referred to as "history modification"
> +
> +The term "rebasing" will be used to refer to both of the above operations.
> +Used properly, rebasing can yield a cleaner and clearer development
> +history; used improperly, it can obscure that history and introduce bugs.
> +
> +There are a few rules of thumb that can help developers to avoid the worst
> +perils of rebasing:
> +
> + - History that has been exposed to the world beyond your private system
> +   should usually not be changed.  Others may have pulled a copy of your
> +   tree and built on it; modifying your tree will create pain for them.
> If
> +   work is in need of rebasing, that is usually a sign that it is not yet
> +   ready to be committed to a public repository.
> +
> +   That said, there are always exceptions.  Some trees (linux-next being
> +   a significant example) are frequently rebased by their nature, and
> +   developers know not to base work on them.  Developers will sometimes
> +   expose an unstable branch for others to test with or for automated
> +   testing services.  If you do expose a branch that may be unstable in
> +   this way, be sure that prospective users know not to base work on it.
> +
> + - Do not rebase a branch that contains history created by others.  If you
> +   have pulled changes from another developer's repository, you are now a
> +   custodian of their history.  You should not change it.  With few
> +   exceptions, for example, a broken commit in a tree like this should be
> +   explicitly reverted rather than disappeared via history modification.
> +
> + - Do not reparent a tree without a good reason to do so.  Just being on a
> +   newer base or avoiding a merge with an upstream repository is not
> +   generally a good reason.
> +
> + - If you must reparent a repository, do not pick some random kernel
> commit
> +   as the new base.  The kernel is often in a relatively unstable state
> +   between release points; basing development on one of those points
> +   increases the chances of running into surprising bugs.  When a patch
> +   series must move to a new base, pick a stable point (such as one of
> +   the -rc releases) to move to.
> +
> + - Realize that the rebasing a patch series changes the environment in
> +   which it was developed and, likely, invalidates much of the testing
> that
> +   was done.  A rebased patch series should, as a general rule, be treated
> +   like new code and retested from the beginning.
> +
> +A frequent cause of merge-window trouble is when Linus is presented with a
> +patch series that has clearly been reparented, often to a random commit,
> +shortly before the pull request was sent.  The chances of such a series
> +having been adequately tested are relatively low - as are the chances of
> +the pull request being acted upon.
> +
> +If, instead, rebasing is limited to private trees, commits are based on a
> +well-known starting point, and they are well tested, the potential for
> +trouble is low.
> +
> +Merging
> +=======
> +
> +Merging is a common operation in the kernel development process; the 5.1
> +development cycle included 1,126 merge commits - nearly 9% of the total.
> +Kernel work is accumulated in over 100 different subsystem trees, each of
> +which may contain multiple topic branches; each branch is usually
> developed +independently of the others.  So naturally, at least merge will
> be required +before any given branch finds its way into an upstream
> repository. +
> +Many projects require that branches in pull requests be based on the
> +current trunk so that no merge commits appear in the history.  The kernel
> +is not such a project; any rebasing of branches to avoid merges will, as
> +described above, lead to certain trouble.
> +
> +Subsystem maintainers find themselves having to do two types of merges:
> +from lower-level subsystem trees and from others, either sibling trees or
> +the mainline.  The best practices to follow differ in those two
> situations. +
> +Merging from lower-level trees
> +------------------------------
> +
> +Larger subsystems tend to have multiple levels of maintainers, with the
> +lower-level maintainers sending pull requests to the higher levels.
> Acting +on such a pull request will almost certainly generate a merge
> commit; that +is as it should be.  In fact, subsystem maintainers may want
> to use +the --no-ff flag to force the addition of a merge commit in the
> rare cases +where one would not normally be created so that the reasons
> for the merge +can be recorded.  The changelog for the merge should, for
> any kind of +merge, say *why* the merge is being done.  For a lower-level
> tree, "why" is +usually a summary of the changes that will come with that
> pull. +
> +Maintainers at all levels should be using signed tags on their pull
> +requests, and upstream maintainers should verify the tags when pulling
> +branches.  Failure to do so threatens the security of the development
> +process as a whole.
> +
> +As per the rules outlined above, once you have merged somebody else's
> +history into your tree, you cannot rebase that branch, even if you
> +otherwise would be able to.
> +
> +Merging from sibling or upstream trees
> +--------------------------------------
> +
> +While merges from downstream are common and unremarkable, merges from
> other +trees tend to be a red flag when it comes time to push a branch
> upstream. +Such merges need to be carefully thought about and well
> justified, or +there's a good chance that a subsequent pull request will
> be rejected. +
> +It is natural to want to merge the master branch into a repository; it can
> +help to make sure that there are no conflicts with parallel development
> and +generally gives a warm, fuzzy feeling of being up-to-date.  But this
> +temptation should be avoided almost all of the time.
> +
> +Why is that?  Merges with upstream will muddy the development history of
> +your own branch.  They will significantly increase your chances of
> +encountering bugs from elsewhere in the community and make it hard to
> +ensure that the work you are managing is stable and ready for upstream.
> +Frequent merges can also obscure problems with the development process in
> +your tree; they can hide interactions with other trees that should not be
> +happening (often) in a well-managed branch.
> +
> +One of the most frequent causes of merge-related trouble is when a
> +maintainer merges with the upstream in order to resolve merge conflicts
> +before sending a pull request.  Again, this temptation is easy enough to
> +understand, but it should absolutely be avoided.  This is especially true
> +for the final pull request: Linus is adamant that he would much rather see
> +merge conflicts than unnecessary back merges.  Seeing the conflicts lets

I think "backmerge" as a term deserves to be highlighted in the heading
or first paragraph of the section.

Occasionally backmerges are required. As a rule of thumb, it might be
worth mentioning you probably shouldn't do such merges across subsystem
hierarchies, i.e. ask the level above you to do a backmerge first, and
then backmerge from them. And that when backmerging from Linus' tree,
the merge point should be a tag.

> +him know where potential problem areas are.  He does a lot of merges (382
> +in the 5.1 development cycle) and has gotten quite good at conflict
> +resolution - often better than the developers involved.
> +
> +So what should a maintainer do when there is a conflict between their
> +subsystem branch and the mainline?  The most important step is to warn
> +Linus in the pull request that the conflict will happen; if nothing else,
> +that demonstrates an awareness of how your branch fits into the whole.
> For +especially difficult conflicts, create and push a *separate* branch
> to show +how you would resolve things.  Mention that branch in your pull
> request, +but the pull request itself should be for the unmerged branch.
> +
> +Even in the absence of known conflicts, doing a test merge before sending
> a +pull request is a good idea.  It may alert you to problems that you
> somehow +didn't see from linux-next and helps to understand exactly what
> you are +asking upstream to do.
> +
> +Another reason for doing merges of upstream or another subsystem tree is
> to +resolve dependencies.  These dependency issues do happen at times, and
> +sometimes a cross-merge with another tree is the best way to resolve them;
> +as always, in such situations, the merge commit should explain why the
> +merge has been done.  Take a moment to do it right; people will read those
> +changelogs.
> +
> +Often, though, dependency issues indicate that a change of approach is
> +needed.  Merging another subsystem tree to resolve a dependency risks
> +bringing in other bugs.  If that subsystem tree fails to be pulled
> +upstream, whatever problems it had will block the merging of your tree as
> +well.  Possible alternatives include agreeing with the maintainer to carry
> +both sets of changes in one of the trees or creating a special branch
> +dedicated to the dependent commits.  If the dependency is related to major
> +infrastructural changes, the right solution might be to hold the dependent
> +commits for one development cycle so that those changes have time to
> +stabilize in the mainline.

Is it not a common convention to call these special branches "topic
branches"?

FWIW, I don't think I've ever done a cross-merge or a direct merge from
a sibling tree. I've always solved the cases either by topic branches
merged to both trees or by having both trees merged to the first common
upstream tree, and then backmerging. From my POV feels like these
solutions should be presented more prominently than cross-merges.

> +
> +Finally
> +=======
> +
> +It is relatively common to merge with the mainline toward the beginning of
> +the development cycle in order to pick up changes and fixes done elsewhere
> +in the tree.  As always, such a merge should pick a well-known release
> +point rather than some random spot.  If your upstream-bound branch has
> +emptied entirely into the mainline during the merge window, you can pull
> it +forward with a command like::
> +
> +  git merge v5.2-rc1^0
> +
> +The "^0" will cause Git to do a fast-forward merge (which should be
> +possible in this situation), thus avoiding the addition of a spurious
> merge +commit.
> +
> +The guidelines laid out above are just that: guidelines.  There will
> always +be situations that call out for a different solution, and these
> guidelines +should not prevent developers from doing the right thing when
> the need +arises.  But one should always think about whether the need has
> truly +arisen and be prepared to explain why something abnormal needs to
> be done. -- 
> 2.21.0
>

-- 
Jani Nikula, Intel Open Source Graphics Center
