Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1984C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E40206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfFEOKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:10:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:36172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbfFEOKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:10:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94249AE84;
        Wed,  5 Jun 2019 14:10:03 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [RFC 0/3] watchdog/softlockup: Make softlockup reports more reliable and useful
Date:   Wed,  5 Jun 2019 16:09:51 +0200
Message-Id: <20190605140954.28471-1-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we were analyzing logs with several softlockup reports in flush_tlb_kernel_range().
They were confusing. Especially it was not clear whether it was deadlock,
livelock, or separate softlockups.

It went out that even a simple busy loop:

	while (true)
	      cpu_relax();

is able to produce several softlockups reports:

[  168.277520] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
[  196.277604] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
[  236.277522] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [cat:4865]


I tried to understand the tricky watchdog code and produced two patches
that would be helpful to debug the original real bug:

   1st patch prevents restart of the watchdog from unrelated locations.

   2nd patch helps to distinguish several possible situations by
   regular reports.

   3rd patch can be used for testing the problem.


The watchdog code might deserve even more clean up. Anyway, I would
like to hear other's opinion first.


Petr Mladek (3):
  watchdog/softlockup: Preserve original timestamp when touching
    watchdog externally
  watchdog/softlockup: Report the same softlockup regularly
  Test softlockup

 fs/proc/consoles.c |  5 ++++
 fs/proc/version.c  |  7 +++++
 kernel/watchdog.c  | 85 +++++++++++++++++++++++++++++++-----------------------
 3 files changed, 61 insertions(+), 36 deletions(-)

-- 
2.16.4

