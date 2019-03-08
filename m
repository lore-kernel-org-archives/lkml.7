Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2834C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEF620684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kWtE2UA1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kFoQm0JZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfCHJqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:46:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37930 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfCHJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:46:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 309CE60398; Fri,  8 Mar 2019 09:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552038391;
        bh=Gc8UwSTE2bXEnNXYwtzKXyXLquSQXK1AjHyS31CYsq4=;
        h=From:To:Cc:Subject:Date:From;
        b=kWtE2UA1lCo8+WLxu+kRenmZ4Pw+6Hou2Ohm9mEY7BQkEGCsoa2G7vT4pTmFrtSnG
         t3KMQhWX9CeT+PTpTEmRbhsRcM3XMXsljaPn1mhtFUj1qkTFqqO+I5cYrbbFARG2cj
         bn+En82lDkcIRpnVeSu/qyvwKe7S2GpvfHbE5lRc=
Received: from neeraju-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 830EC60264;
        Fri,  8 Mar 2019 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552038390;
        bh=Gc8UwSTE2bXEnNXYwtzKXyXLquSQXK1AjHyS31CYsq4=;
        h=From:To:Cc:Subject:Date:From;
        b=kFoQm0JZyt6hcJEL0q49FkhEQ+n2z29Z3cjkkaWvngtrxcwMSyqK3kZpC/o0muclH
         Au4HXzDDSIQ22pnQv3wDfHpBi9y01WYXVQ2dTBt/PwU8vf+sMD6azjZJdNS459UCHS
         g0ofwjT67nB+lYZAu03G5wUnOnTZyzaD8ouAxFTU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 830EC60264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu/tree: Fix self wakeups for grace period kthread
Date:   Fri,  8 Mar 2019 15:16:18 +0530
Message-Id: <1552038378-11166-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the code to match the comment that self wakeup of
grace period kthread is allowed from interrupt handler, and
softirq handler, running in the grace period kthread's
context. Present code allows self wakeups from all
interrupt contexts - nmi, softirq and hardirq contexts.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index acd6ccf..57cac6d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1585,7 +1585,7 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
 static void rcu_gp_kthread_wake(void)
 {
 	if ((current == rcu_state.gp_kthread &&
-	     !in_interrupt() && !in_serving_softirq()) ||
+	     !in_irq() && !in_serving_softirq()) ||
 	    !READ_ONCE(rcu_state.gp_flags) ||
 	    !rcu_state.gp_kthread)
 		return;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

