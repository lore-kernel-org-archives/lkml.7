Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDAEC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3629521880
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387930AbfGXVF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 17:05:26 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:53146 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbfGXVFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 17:05:25 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 24 Jul 2019 14:05:03 -0700
Received: from rlwimi.localdomain (unknown [10.166.65.164])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id F1869407C8;
        Wed, 24 Jul 2019 14:05:22 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH v3 00/13] Cleanup recordmcount and begin objtool conversion
Date:   Wed, 24 Jul 2019 14:04:54 -0700
Message-ID: <cover.1563992889.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up recordmcount and then makes it into
an objtool subcommand.

The series starts with 8 cleanup patches which make recordmcount
easier to review and integrate with objtool. The final 5 patches
show the beginning steps of converting recordmcount to use objtool's
ELF code rather than its own open-coded methods of accessing ELF
files.

---

v3:
	Rebased on mainline. s/elf_open/elf_read/ in recordmcount.c

v2:
	Fix whitespace before line continuation

	Add ftrace/mcount/record.h to objtool_dep

	Rename the Makefile variable BUILD_C_RECORDMCOUNT to
	    better reflect its purpose

	Similar: rename recordmcount_source => recordmcount_dep
	    When using objtool we can just depend on the
	    binary rather than the source the binary is
	    built from. This should address Josh's feedback and
	    make the Makefile code a bit clearer

	Add a comment to make reading the Makefile a little
	    easier

	Rebased to latest mainline -rc

	Collected some build time measurements

Build times measurements (measured for v2 posting) -- median of multiple
runs in a VM measured with "time":

	mainline (5.2.0-rc4) build times (median of 3 runs):
		real    2m58.379s
		user    2m29.621s
		sys     1m35.116s

	Post recordmcount-cleanup build times (median of 5 runs):
		real    2m51.973s
		user    2m29.094s
		sys     1m33.688s
		
	objtool mcount build times (median of 7 runs):
		real	2m57.92s
		user	2m33.73s
		sys	1m37.06s

Note: I saw some significant variation especially in the "real" time
	measurements probably because it was in a VM on a machine with
	various "idle" GUI tasks running. This is why I took the median
	rather than the mean. Though I haven't run the statistics, my
	sense is the numbers don't support concluding that things really
	got any faster or slower.

Matt Helsley (13):
  recordmcount: Remove redundant strcmp
  recordmcount: Remove uread()
  recordmcount: Remove unused fd from uwrite() and ulseek()
  recordmcount: Rewrite error/success handling
  recordmcount: Kernel style function signature formatting
  recordmcount: Kernel style formatting
  recordmcount: Remove redundant cleanup() calls
  recordmcount: Clarify what cleanup() does
  objtool: Prepare to merge recordmcount
  objtool: Make recordmcount into an objtool subcmd
  objtool: recordmcount: Start using objtool's elf wrapper
  objtool: recordmcount: Search for __mcount_loc before walking the
    sections
  objtool: recordmcount: Convert do_func() relhdrs

 Makefile                                   |   6 +-
 scripts/.gitignore                         |   1 -
 scripts/Makefile                           |   1 -
 scripts/Makefile.build                     |  25 +-
 tools/objtool/.gitignore                   |   1 +
 tools/objtool/Build                        |   1 +
 tools/objtool/Makefile                     |   1 +
 tools/objtool/builtin-mcount.c             |  72 +++++
 tools/objtool/builtin-mcount.h             |  23 ++
 tools/objtool/builtin.h                    |   1 +
 tools/objtool/objtool.c                    |   1 +
 {scripts => tools/objtool}/recordmcount.c  | 350 ++++++++++-----------
 {scripts => tools/objtool}/recordmcount.h  | 197 +++++++-----
 {scripts => tools/objtool}/recordmcount.pl |   0
 14 files changed, 406 insertions(+), 274 deletions(-)
 create mode 100644 tools/objtool/builtin-mcount.c
 create mode 100644 tools/objtool/builtin-mcount.h
 rename {scripts => tools/objtool}/recordmcount.c (78%)
 rename {scripts => tools/objtool}/recordmcount.h (78%)
 rename {scripts => tools/objtool}/recordmcount.pl (100%)

-- 
2.20.1

