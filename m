Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35ACC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6757F20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfEWADy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:03:54 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:13601 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726890AbfEWADx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:03:53 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 22 May 2019 17:03:38 -0700
Received: from rlwimi.localdomain (unknown [10.129.221.32])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id F1DAEB2031;
        Wed, 22 May 2019 20:03:51 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 00/13] Cleanup recordmcount and begin objtool conversion
Date:   Wed, 22 May 2019 17:03:23 -0700
Message-ID: <cover.1558569448.git.mhelsley@vmware.com>
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

 scripts/.gitignore                         |   1 -
 scripts/Makefile                           |   1 -
 scripts/Makefile.build                     |  22 +-
 tools/objtool/.gitignore                   |   1 +
 tools/objtool/Build                        |   1 +
 tools/objtool/Makefile                     |   7 +-
 tools/objtool/builtin-mcount.c             |  72 +++++
 tools/objtool/builtin-mcount.h             |  23 ++
 tools/objtool/builtin.h                    |   6 +
 tools/objtool/objtool.c                    |   6 +
 {scripts => tools/objtool}/recordmcount.c  | 350 ++++++++++-----------
 {scripts => tools/objtool}/recordmcount.h  | 197 +++++++-----
 {scripts => tools/objtool}/recordmcount.pl |   0
 13 files changed, 420 insertions(+), 267 deletions(-)
 create mode 100644 tools/objtool/builtin-mcount.c
 create mode 100644 tools/objtool/builtin-mcount.h
 rename {scripts => tools/objtool}/recordmcount.c (78%)
 rename {scripts => tools/objtool}/recordmcount.h (78%)
 rename {scripts => tools/objtool}/recordmcount.pl (100%)

-- 
2.20.1

