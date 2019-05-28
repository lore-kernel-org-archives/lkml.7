Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551A0C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A8021726
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfE1Oni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:43:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbfE1Onh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:43:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6432130833AF;
        Tue, 28 May 2019 14:43:37 +0000 (UTC)
Received: from treble (ovpn-122-72.rdu2.redhat.com [10.10.122.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 488B37C550;
        Tue, 28 May 2019 14:43:34 +0000 (UTC)
Date:   Tue, 28 May 2019 09:43:28 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 00/13] Cleanup recordmcount and begin objtool
 conversion
Message-ID: <20190528144328.6wygc2ofk5oaggaf@treble>
References: <cover.1558569448.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1558569448.git.mhelsley@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 28 May 2019 14:43:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 05:03:23PM -0700, Matt Helsley wrote:
> This series cleans up recordmcount and then makes it into
> an objtool subcommand.
> 
> The series starts with 8 cleanup patches which make recordmcount
> easier to review and integrate with objtool. The final 5 patches
> show the beginning steps of converting recordmcount to use objtool's
> ELF code rather than its own open-coded methods of accessing ELF
> files.

Hi Matt,

Thanks for the patches.  This looks like a good step in the right
direction.

What's the performance difference between the old recordmcount and the
new version which relies on elf_open()?  It would be useful to compare
kernel build times, before and after.

Would it be feasible to eventually combine subcommands so that objtool
could do both ORC and mcount generation in a single invocation?  I
wonder what what the interface would look like.

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
>  scripts/.gitignore                         |   1 -
>  scripts/Makefile                           |   1 -
>  scripts/Makefile.build                     |  22 +-
>  tools/objtool/.gitignore                   |   1 +
>  tools/objtool/Build                        |   1 +
>  tools/objtool/Makefile                     |   7 +-
>  tools/objtool/builtin-mcount.c             |  72 +++++
>  tools/objtool/builtin-mcount.h             |  23 ++
>  tools/objtool/builtin.h                    |   6 +
>  tools/objtool/objtool.c                    |   6 +
>  {scripts => tools/objtool}/recordmcount.c  | 350 ++++++++++-----------
>  {scripts => tools/objtool}/recordmcount.h  | 197 +++++++-----
>  {scripts => tools/objtool}/recordmcount.pl |   0
>  13 files changed, 420 insertions(+), 267 deletions(-)
>  create mode 100644 tools/objtool/builtin-mcount.c
>  create mode 100644 tools/objtool/builtin-mcount.h
>  rename {scripts => tools/objtool}/recordmcount.c (78%)
>  rename {scripts => tools/objtool}/recordmcount.h (78%)
>  rename {scripts => tools/objtool}/recordmcount.pl (100%)
> 
> -- 
> 2.20.1
> 

-- 
Josh
