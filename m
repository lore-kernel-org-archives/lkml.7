Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D136C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25181218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbfDENvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:51:24 -0400
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:36468 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbfDENvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:51:23 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id 400C01C38B1
        for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2019 14:51:21 +0100 (IST)
Received: (qmail 28386 invoked from network); 5 Apr 2019 13:51:21 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPA; 5 Apr 2019 13:51:21 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [GIT PULL] mm/compaction functional fixes for v5.1-rc4
Date:   Fri,  5 Apr 2019 14:51:18 +0100
Message-Id: <20190405135120.27532-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git tags/mm-compaction-5.1-rc4

for you to fetch changes up to 5b56d996dd50a9d2ca87c25ebb50c07b255b7e04:

  mm/compaction.c: abort search if isolation fails (2019-04-04 11:56:15 +0100)

----------------

Hi Linus,

The merge window for 5.1 introduced a number of compaction-related patches
authored by myself.  There are intermittent reports of corruption and
functional issues based on them due to sloppy checking of zone boundaries
and a corner case where the free lists are overrun.

Reports are not common but at least two users and 0-day have tripped over them.
There is a chance that one of the syzbot reports are related but it has not
been confirmed properly.

The normal submission path is through Andrew but it's now late on a Friday
and I do not know if a round of updates are coming your way or not and
these patches have been floating around for a while. Given the nature
of the fixes, I really would prefer to avoid another RC with corruption
issues creating duplicate reports.

All of these have been successfully tested on older RC windows. This will
make this branch look like a rebase but they've simply been cherry-picked
from Andrew's tree and placed on a fresh branch. I've no reason to
believe that this has invalidated the testing given the lack of change
in compaction and the nature of the fixes.

Note that you may still receive these from Andrew and there are other
compaction-related fixes in his tree that are less critical. I do not
expect them to conflict but there is a non-zero risk of confusion. If
you get a bunch of patches from Andrew then please ignore this entirely
so the normal submission path is preserved. Otherwise, please either git
pull this or pick up the patches directly at your discretion.

Mel Gorman (1):
  mm/compaction.c: correct zone boundary handling when resetting
    pageblock skip hints

Qian Cai (1):
  mm/compaction.c: abort search if isolation fails

 mm/compaction.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

-- 
2.16.4

