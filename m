Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3192C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEF220B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbfJIPCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:02:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731072AbfJIPCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:02:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 044B810C050B;
        Wed,  9 Oct 2019 15:02:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id CDA531001B30;
        Wed,  9 Oct 2019 15:02:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  9 Oct 2019 17:02:32 +0200 (CEST)
Date:   Wed, 9 Oct 2019 17:02:30 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>
Subject: [PATCH] cgroup: freezer: call cgroup_enter_frozen() with preemption
 disabled in ptrace_stop()
Message-ID: <20191009150230.GB12511@redhat.com>
References: <CADkTA4PBT374CY+UNb85WjQEaNCDodMZu=MgpG8aMYbAu2eOGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADkTA4PBT374CY+UNb85WjQEaNCDodMZu=MgpG8aMYbAu2eOGA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Wed, 09 Oct 2019 15:02:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace_stop() does preempt_enable_no_resched() to avoid the preemption,
but after that cgroup_enter_frozen() does spin_lock/unlock and this adds
another preemption point.

Reported-and-tested-by: Bruce Ashfield <bruce.ashfield@gmail.com>
Fixes: 76f969e8948d ("cgroup: cgroup v2 freezer")
Cc: stable@vger.kernel.org # v5.2+
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 534fec2..f8eed86 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2205,8 +2205,8 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 		 */
 		preempt_disable();
 		read_unlock(&tasklist_lock);
-		preempt_enable_no_resched();
 		cgroup_enter_frozen();
+		preempt_enable_no_resched();
 		freezable_schedule();
 		cgroup_leave_frozen(true);
 	} else {
-- 
2.5.0


