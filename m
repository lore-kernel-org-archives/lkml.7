Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20264C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57AA2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582123;
	bh=fnroCBWhzEpe1XRMnfZdJz2SvjsDbiywAyVQWI1ZeZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ghBBB64lFt1t3locpHSNC+09AKdhvm+XrMdaWwiaTfieYRIvMkCYyThnyyk3LeDaQ
	 yTUSB/Iac+cJRfnrtQgLTX/QOMuF3DH0VEwSgmGirBQkKEzDg+BGua8i9vyVVCMqGt
	 SYIhTzWAIPtzVUdk9H22SavXCmM/+kpoUeCQh0kY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbfCZGfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731612AbfCZGfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:35:20 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFEF020823;
        Tue, 26 Mar 2019 06:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582119;
        bh=fnroCBWhzEpe1XRMnfZdJz2SvjsDbiywAyVQWI1ZeZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BeLJxlykyqPIzhQ99XBjXq9x7FUXYz9Vy8HfPASZtdeNH0OSs1vtthPOGZFqfN22Z
         pkeIwe63vpAqyx3xEMUX38xK3CW4YcjbEF1p1MBUhP1cOnoqZC9gXNQbOidnvHasll
         jv5G3dN60T9bgdyJvSu9HenSTD1NAQgGwD/Bjn5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jules Maselbas <jules.maselbas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Redpath <chris.redpath@arm.com>,
        Dietmar Eggermann <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Stephen Kyle <stephen.kyle@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, nd@arm.com,
        Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 38/41] sched/cpufreq/schedutil: Fix error path mutex unlock
Date:   Tue, 26 Mar 2019 15:30:15 +0900
Message-Id: <20190326042651.965892960@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jules Maselbas <jules.maselbas@arm.com>

commit 1b5d43cfb69759d8ef8d30469cea31d0c037aed5 upstream.

This patch prevents the 'global_tunables_lock' mutex from being
unlocked before being locked.  This mutex is not locked if the
sugov_kthread_create() function fails.

Signed-off-by: Jules Maselbas <jules.maselbas@arm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Chris Redpath <chris.redpath@arm.com>
Cc: Dietmar Eggermann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Stephen Kyle <stephen.kyle@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: nd@arm.com
Link: http://lkml.kernel.org/r/20180329144301.38419-1-jules.maselbas@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/cpufreq_schedutil.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -605,10 +605,9 @@ fail:
 
 stop_kthread:
 	sugov_kthread_stop(sg_policy);
-
-free_sg_policy:
 	mutex_unlock(&global_tunables_lock);
 
+free_sg_policy:
 	sugov_policy_free(sg_policy);
 
 disable_fast_switch:


