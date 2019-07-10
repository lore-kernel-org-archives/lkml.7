Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86919C74A33
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D7C2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfGJRJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfGJRJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:09:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F38A620844;
        Wed, 10 Jul 2019 17:09:25 +0000 (UTC)
Date:   Wed, 10 Jul 2019 13:09:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Matt Helsley <mhelsley@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 00/13] Cleanup recordmcount and begin objtool
 conversion
Message-ID: <20190710130924.16aee549@gandalf.local.home>
In-Reply-To: <cover.1560285597.git.mhelsley@vmware.com>
References: <cover.1560285597.git.mhelsley@vmware.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Josh,

Can you have a look at these? I can apply them if you think they are OK.

-- Steve


On Tue, 11 Jun 2019 15:21:42 -0700
Matt Helsley <mhelsley@vmware.com> wrote:

> This series cleans up recordmcount and then makes it into
> an objtool subcommand.
> 
> The series starts with 8 cleanup patches which make recordmcount
> easier to review and integrate with objtool. The final 5 patches
> show the beginning steps of converting recordmcount to use objtool's
> ELF code rather than its own open-coded methods of accessing ELF
> files.
> 
> ---
> 
> v2:
> 	Fix whitespace before line continuation
> 
> 	Add ftrace/mcount/record.h to objtool_dep
> 
> 	Rename the Makefile variable BUILD_C_RECORDMCOUNT to
> 	    better reflect its purpose
> 
> 	Similar: rename recordmcount_source => recordmcount_dep
> 	    When using objtool we can just depend on the
> 	    binary rather than the source the binary is
> 	    built from. This should address Josh's feedback and
> 	    make the Makefile code a bit clearer
> 
> 	Add a comment to make reading the Makefile a little
> 	    easier
> 
> 	Rebased to latest mainline -rc
> 
> 	Collected some build time measurements
> 
> Build times measurements -- median of multiple runs in a VM measured
> with "time":
> 
> 	mainline (5.2.0-rc4) build times (median of 3 runs):
> 		real    2m58.379s
> 		user    2m29.621s
> 		sys     1m35.116s
> 
> 	Post recordmcount-cleanup build times (median of 5 runs):
> 		real    2m51.973s
> 		user    2m29.094s
> 		sys     1m33.688s
> 		
> 	objtool mcount build times (median of 7 runs):
> 		real	2m57.92s
> 		user	2m33.73s
> 		sys	1m37.06s
> 
> Note: I saw some significant variation especially in the "real" time
> 	measurements probably because it was in a VM on a machine with
> 	various "idle" GUI tasks running. This is why I took the median
> 	rather than the mean. Though I haven't run the statistics, my
> 	sense is the numbers don't support concluding that things really
> 	got any faster or slower.
> 
> I'm working on a separate, follow-on RFC set which implements the
> pseudo-pipe idea.
> 
> Matt Helsley (13):
>   recordmcount: Remove redundant strcmp
>   recordmcount: Remove uread()
>   recordmcount: Remove unused fd from uwrite() and ulseek()
>   recordmcount: Rewrite error/success handling
>   recordmcount: Kernel style function signature formatting
>   recordmcount: Kernel style formatting
>   recordmcount: Remove redundant cleanup() calls
>   recordmcount: Clarify what cleanup() does
>   objtool: Prepare to merge recordmcount
>   objtool: Make recordmcount into an objtool subcmd
>   objtool: recordmcount: Start using objtool's elf wrapper
>   objtool: recordmcount: Search for __mcount_loc before walking the
>     sections
>   objtool: recordmcount: Convert do_func() relhdrs
> 
>  Makefile                                   |   6 +-
>  scripts/.gitignore                         |   1 -
>  scripts/Makefile                           |   1 -
>  scripts/Makefile.build                     |  27 +-
>  tools/objtool/.gitignore                   |   1 +
>  tools/objtool/Build                        |   1 +
>  tools/objtool/Makefile                     |   1 +
>  tools/objtool/builtin-mcount.c             |  72 +++++
>  tools/objtool/builtin-mcount.h             |  23 ++
>  tools/objtool/builtin.h                    |   1 +
>  tools/objtool/objtool.c                    |   1 +
>  {scripts => tools/objtool}/recordmcount.c  | 350 ++++++++++-----------
>  {scripts => tools/objtool}/recordmcount.h  | 197 +++++++-----
>  {scripts => tools/objtool}/recordmcount.pl |   0
>  14 files changed, 407 insertions(+), 275 deletions(-)
>  create mode 100644 tools/objtool/builtin-mcount.c
>  create mode 100644 tools/objtool/builtin-mcount.h
>  rename {scripts => tools/objtool}/recordmcount.c (78%)
>  rename {scripts => tools/objtool}/recordmcount.h (78%)
>  rename {scripts => tools/objtool}/recordmcount.pl (100%)
> 

