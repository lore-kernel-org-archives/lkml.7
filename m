Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DB6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEC7208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfGaSYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:24:39 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:7789 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbfGaSYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:24:38 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 31 Jul 2019 11:24:33 -0700
Received: from rlwimi.localdomain (unknown [10.166.66.112])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 064B4B2841;
        Wed, 31 Jul 2019 14:24:36 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH v4 0/8] recordmcount cleanups
Date:   Wed, 31 Jul 2019 11:24:08 -0700
Message-ID: <cover.1564596289.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

recordmcount presents unnecessary challenges to reviewers:

	It pretends to wrap access to the ELF file in
	uread/uwrite/ulseek functions which aren't related
	the way you might think (i.e. not the way read, write,
	and lseek are releated to each other).

	It uses setjmp/longjmp to handle errors (and success)
	during processing of the object files. This makes it
	hard to review what functions are doing, how globals
	change over time, etc.

	There are some kernel style nits.

This series addresses all of those by removing un-helper functions,
unused parameters, and rewriting the error/success handling to
better resemble regular kernel C code.

--

This series was formerly part of a v3 posted under the subject
"Cleanup recordmcount and begin objtool conversion". I am
reposting it split into two series: these cleanups of recordmcount
and a second series that begins the conversion of the cleaned-up
recordmcount into an objtool subcommand called mcount.

v4:
   Addressed feedback on v3 from Steven Rostedt:
       Moved already_has_mcount into recordmcount.c to avoid
                unnecessary multiple definitions.
       Changed return semantics of find_secsym_ndx() to avoid
                need for missing_sym (and multiple definitions)
                and to separate the returned symbol info
                (value, index) from success/failure indication.
       Fixed up local variable declaration to follow inverted
		christmas tree style.


Matt Helsley (8):
  recordmcount: Remove redundant strcmp
  recordmcount: Remove uread()
  recordmcount: Remove unused fd from uwrite() and ulseek()
  recordmcount: Rewrite error/success handling
  recordmcount: Kernel style function signature formatting
  recordmcount: Kernel style formatting
  recordmcount: Remove redundant cleanup() calls
  recordmcount: Clarify what cleanup() does

 scripts/recordmcount.c | 321 ++++++++++++++++++++---------------------
 scripts/recordmcount.h | 150 +++++++++++++------
 2 files changed, 259 insertions(+), 212 deletions(-)

-- 
2.20.1

