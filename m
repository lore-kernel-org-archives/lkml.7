Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EDBC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 03:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB37219F6
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 03:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y03COGNW";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="a1pxYQM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfKSDRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 22:17:09 -0500
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:47188
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727505AbfKSDRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 22:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574133427;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=DSFxMH9kT34z8Vm44Q+35fj1K2btho1KSltCLrspVFc=;
        b=Y03COGNWcC2E6ORRMjEM65srtvWwA6u/HdJTrLUaioYww+58Z14VNeWzPW+hoRXy
        a5AzOjVfbpjERHJt/fb0atoCnFd0fsKrp3sKXf5BAk9ls1bOm9yDVlQT2Gf6q7YbzRD
        Q746TNvQ6+wNOe0/ZyGrpkJr2l79jkNQU8hk4/Pw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574133427;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=DSFxMH9kT34z8Vm44Q+35fj1K2btho1KSltCLrspVFc=;
        b=a1pxYQM1qoFjc3UNphUru9S9B+jJaIXqSy2nYP6o9IgahlwRfT7dirxdHOYry9YG
        4ibqg7jPFXJ3ZVJcGTnObS6S3SMW3mh1NNgvi+xpFJMq0l0JDIlSFZzSeK3bEJ1wUxd
        xOppEDtmJulhxkfa7Fhk4q9Qbud7y7gcdMyagiAQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D066C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, gkohli@codeaurora.org,
        prsood@codeaurora.org, pkondeti@codeaurora.org,
        rcu@vger.kernel.org, Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH v2] rcu: Fix missed wakeup of exp_wq waiters
Date:   Tue, 19 Nov 2019 03:17:07 +0000
Message-ID: <0101016e81a9ecb9-ce4a6425-f21d-4166-96ed-32d3700717f1-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 1.9.1
X-SES-Outgoing: 2019.11.19-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the tasks waiting in exp_wq inside exp_funnel_lock(),
there is a chance that they might be indefinitely blocked
in below scenario:

1. There is a task waiting on exp sequence 0b'100' inside
   exp_funnel_lock(). This task blocks at wq index 1.

   synchronize_rcu_expedited()
     s = 0b'100'
     exp_funnel_lock()
       wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3]

2. The expedited grace period (which above task blocks for)
   completes and task (task1) holding exp_mutex queues
   worker and schedules out.

   synchronize_rcu_expedited()
     s = 0b'100'
     queue_work(rcu_gp_wq, &rew.rew_work)
       wake_up_worker()
         schedule()

3. kworker A picks up the queued work and completes the exp gp
   sequence and then blocks on exp_wake_mutex, which is held
   by another kworker, which is doing wakeups for expedited_sequence
   0.

   rcu_exp_wait_wake()
     rcu_exp_wait_wake()
       rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence is incremented
                               // to 0b'100'
       mutex_lock(&rcu_state.exp_wake_mutex)

4. task1 does not enter wait queue, as sync_exp_work_done() returns true,
   and releases exp_mutex.

   wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
     sync_exp_work_done(rsp, s));
   mutex_unlock(&rsp->exp_mutex);

5. Next exp GP completes, and sequence number is incremented:

   rcu_exp_wait_wake()
     rcu_exp_wait_wake()
       rcu_exp_gp_seq_end(rsp) // rsp->expedited_sequence = 0b'200'

6. kworker A acquires exp_wake_mutex. As it uses current
   expedited_sequence, it wakes up workers from wrong wait queue
   index - it should have worken wait queue corresponding to
   0b'100' sequence, but wakes up the ones for 0b'200' sequence.
   This results in task at step 1 indefinitely blocked.

   rcu_exp_wait_wake()
     wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rsp->expedited_sequence) & 0x3]);

This issue manifested as DPM device timeout during suspend, as scsi
device was stuck in _synchronize_rcu_expedited().

schedule()
synchronize_rcu_expedited()
synchronize_rcu()
scsi_device_quiesce()
scsi_bus_suspend()
dpm_run_callback()
__device_suspend()

Fix this by using the correct exp sequence number, the one which
owner of the exp_mutex initiated and passed to kworker,
to index the wait queue, inside rcu_exp_wait_wake().

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---

Changes since v1:
 - Updates the commit log with failure information.

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

