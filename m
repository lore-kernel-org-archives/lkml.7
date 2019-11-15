Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02C2C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0AD2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z0MqtVeP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HDl9BTrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfKOR23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:28:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35704 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfKOR23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:28:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4F5E260C5F; Fri, 15 Nov 2019 17:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573838908;
        bh=GYmPEXvxT/OZTdh5b9aiAB0ZpYeDWC04SZk0qHLp/Mw=;
        h=From:To:Cc:Subject:Date:From;
        b=Z0MqtVeP25YA3RWwYJuXDiDOJaL9g/YVjgZeNP2fdXgA6VLvKcQl7pVYDck5gp4M9
         1Bdp3CxRFGZLc66NaM+LKvQLEoJeGg0olhCjwpCVLt5vr9RY6VYO5DSCft4piSRMcG
         4QOn9MPfygh5mjf/co0cULH15h1n4bsIVTxP0mko=
Received: from neeraju-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 454D560C5F;
        Fri, 15 Nov 2019 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573838907;
        bh=GYmPEXvxT/OZTdh5b9aiAB0ZpYeDWC04SZk0qHLp/Mw=;
        h=From:To:Cc:Subject:Date:From;
        b=HDl9BTrwU0aaxOsxtqXaV9gYmuXQmv3mMqX2L3UMwzhRmVOCeOYM8JkiULr30s1s2
         Ij23qONg3YLc1gwUi7eHut+tny0850fcR6Zq9MPmsL/fyatmbZ9uxKKnF5GANMG8ol
         jXfMxBxnKM6ktm8ImHdqLhMK15e+J4FAMsQS+jCg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 454D560C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        joel@joelfernandes.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        pkondeti@codeaurora.org, prsood@codeaurora.org,
        gkohli@codeaurora.org, Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu: Fix missed wakeup of exp_wq waiters
Date:   Fri, 15 Nov 2019 22:58:14 +0530
Message-Id: <1573838894-23027-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the tasks waiting in exp_wq inside exp_funnel_lock(),
there is a chance that they might be indefinitely blocked
in below scenario:

1. There is a task waiting on exp sequence 0b'100' inside
   exp_funnel_lock().

   _synchronize_rcu_expedited()
     s = 0b'100
     exp_funnel_lock()
       wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3]

2. The Exp GP completes and task (task1) holding exp_mutex queues
   worker and schedules out.

   _synchronize_rcu_expedited()
     s = 0b'100
     queue_work(rcu_gp_wq, &rew.rew_work)
       wake_up_worker()
         schedule()

3. kworker A picks up the queued work and completes the exp gp
   sequence.

   rcu_exp_wait_wake()
     rcu_exp_wait_wake()
       rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence is incremented
                               // to 0b'100'

4. task1 does not enter wait queue, as sync_exp_work_done() returns true,
   and releases exp_mutex.

   wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
     sync_exp_work_done(rsp, s));
   mutex_unlock(&rsp->exp_mutex);

5. Next exp GP completes, and sequence number is incremented:

   rcu_exp_wait_wake()
     rcu_exp_wait_wake()
       rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence = 0b'200'

6. As kworker A uses current expedited_sequence, it wakes up workers
   from wrong wait queue index - it should have worken wait queue
   corresponding to 0b'100' sequence, but wakes up the ones for
   0b'200' sequence. This results in task at step 1 indefinitely blocked.

   rcu_exp_wait_wake()
     wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rsp->expedited_sequence) & 0x3]);

Fix this by using the correct sequence number for wake_up_all() inside
rcu_exp_wait_wake().

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index e4b77d3..28979d3 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -557,7 +557,7 @@ static void rcu_exp_wait_wake(unsigned long s)
 			spin_unlock(&rnp->exp_lock);
 		}
 		smp_mb(); /* All above changes before wakeup. */
-		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rcu_state.expedited_sequence) & 0x3]);
+		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(s) & 0x3]);
 	}
 	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("endwake"));
 	mutex_unlock(&rcu_state.exp_wake_mutex);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

