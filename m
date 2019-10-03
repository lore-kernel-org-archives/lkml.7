Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D75C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B76B222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066100;
	bh=nz1DQghQPqNXCQB3B3L2cYGBEjjTUuGQPspayMEPaSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oXHLpQmi+KVyWp1OtrgMOKLqWoN2VQcHd8/EVpxKIKgRrZjdYXnFQcnFRhV9b+zVz
	 sA7VxN02CDWSFov2/8tIIT/t9wns+7QIbfmZ3l7i+hK67btTzluOSCqf7Z1q84PS+p
	 DaaINA5ilEAWGCeFUnbirmMTh1A66wPL0JLWTt58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfJCB2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbfJCB2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:28:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67260222C3;
        Thu,  3 Oct 2019 01:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066098;
        bh=nz1DQghQPqNXCQB3B3L2cYGBEjjTUuGQPspayMEPaSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KA5GiAehZMEpssZG97MdBXxyKnqoU5OS82sMxhoMxRBjbxCpoaSy7C2+x+A1xZnVn
         sysfSJw4Gtjm/V6s8HIjo2vqMQeMk0CPkdaUmjfz4VsMsSohjDEOZ/s0+8yKJE9f6V
         eRuyoaZz/1bmztteqVpjsKfjcPI5OjSVCNj2YBTM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 2/9] Revert docs from "treewide: Rename rcu_dereference_raw_notrace() to _check()"
Date:   Wed,  2 Oct 2019 18:28:08 -0700
Message-Id: <20191003012815.12639-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003012741.GA12456@paulmck-ThinkPad-P72>
References: <20191003012741.GA12456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This reverts docs from commit 355e9972da81e803bbb825b76106ae9b358caf8e.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/RCU/Design/Requirements/Requirements.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index bdbc84f..5a9238a 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -2512,7 +2512,7 @@ disabled across the entire RCU read-side critical section.
 <p>
 It is possible to use tracing on RCU code, but tracing itself
 uses RCU.
-For this reason, <tt>rcu_dereference_raw_check()</tt>
+For this reason, <tt>rcu_dereference_raw_notrace()</tt>
 is provided for use by tracing, which avoids the destructive
 recursion that could otherwise ensue.
 This API is also used by virtualization in some architectures,
-- 
2.9.5

