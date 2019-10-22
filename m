Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6375CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD24218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571771564;
	bh=Okum0wathcf1ScrSzrZsCiqUTVvdU9caLoqJnp5U0KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0s4xVkh3IE2pxdageXTa0X4SZJd6VsqU/KSQMAPlFvid6el+bKAOzpZOj9vOnZ9av
	 7imJuzlTIGEp2kUpmG5i/bsgqbDsLutPF0iJLrdhrqVCwGP87jp2ns3xVeXA2R0V14
	 gPezdzn1+/OCywJolGHDJorx4BjpLraY/2/zfYZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbfJVTMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388467AbfJVTMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:12:39 -0400
Received: from localhost.localdomain (rrcs-50-75-166-42.nys.biz.rr.com [50.75.166.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06965222CD;
        Tue, 22 Oct 2019 19:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571771558;
        bh=Okum0wathcf1ScrSzrZsCiqUTVvdU9caLoqJnp5U0KY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PROCQPtZDZmaKyYXPxYHvgKsVUd/icvfFR9ashemkF8b/cixY0p8T5H1q9SF38sBr
         8iri0bC7CQke9mmhPYmo4U1NgsMRLbOQQabuABTlzoaPZa8D4+ShipM7VUQ0Rqj8Nj
         o4TNk7r5ZBTlxeytc81cjTk1hXuefFEPw5RjLaqg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Micah Morton <mortonm@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH tip/core/rcu 10/10] security/safesetid: Replace rcu_swap_protected() with rcu_replace()
Date:   Tue, 22 Oct 2019 12:12:15 -0700
Message-Id: <20191022191215.25781-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191022191136.GA25627@paulmck-ThinkPad-P72>
References: <20191022191136.GA25627@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit replaces the use of rcu_swap_protected() with the more
intuitively appealing rcu_replace() as a step towards removing
rcu_swap_protected().

Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Reported-by: kbuild test robot <lkp@intel.com>
[ paulmck: From rcu_replace() to rcu_replace_pointer() per Ingo Molnar. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Micah Morton <mortonm@chromium.org>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: <linux-security-module@vger.kernel.org>
---
 security/safesetid/securityfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 74a13d4..f8bc574 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -179,8 +179,8 @@ static ssize_t handle_policy_update(struct file *file,
 	 * doesn't currently exist, just use a spinlock for now.
 	 */
 	mutex_lock(&policy_update_lock);
-	rcu_swap_protected(safesetid_setuid_rules, pol,
-			   lockdep_is_held(&policy_update_lock));
+	pol = rcu_replace_pointer(safesetid_setuid_rules, pol,
+				  lockdep_is_held(&policy_update_lock));
 	mutex_unlock(&policy_update_lock);
 	err = len;
 
-- 
2.9.5

