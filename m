Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E52DCA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF3E2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439349AbfJXLtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:49:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:50006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbfJXLtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:49:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41745ABB1;
        Thu, 24 Oct 2019 11:49:44 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/3] watchdog/softlockup: Report overall time and some cleanup
Date:   Thu, 24 Oct 2019 13:49:25 +0200
Message-Id: <20191024114928.15377-1-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is rework of the softlockup improvements sent as
https://lkml.kernel.org/r/20190819104732.20966-1-pmladek@suse.com
based on feedback from Peter Zijlstra.

      + merged the two patches
      + moved some cleanup changes into separate patches
      + improved the code and commit messages

The main change is in 2nd patch. It fixes the time spent in softlockup.

Original:

  [  168.277520] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
  [  196.277604] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
  [  236.277522] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [cat:4865]
                                                              ^^^

New:

  [  480.372418] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4943]
  [  508.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 52s! [cat:4943]
  [  548.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 89s! [cat:4943]
  [  576.372351] watchdog: BUG: soft lockup - CPU#2 stuck for 115s! [cat:4943]
                                                              ^^^^^
1st and 3rd patch clean up the code.


Petr Mladek (3):
  watchdog/softlockup: Remove obsolete check of last reported task
  watchdog/softlockup: Report the overall time of softlockups
  watchdog/softlockup: Remove logic that tried to prevent repeated
    reports

 kernel/watchdog.c | 67 ++++++++++++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

-- 
2.16.4

