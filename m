Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DF7C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F58C222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570067002;
	bh=Zw0CRg+Lnjau6ZnXDxzvWs0DBHdnwFB+dQFY5Z45GsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I1r6A0FkioE70lG2npVqmIVNfCyLwz83b4UPVPAm2VSDZ3ebOEEvTRJ4x6oIi9/5u
	 eudB+RIiVHplE9IUgMkXR4sdNkjYsTL3YDG98ooV7cPP7q4DgvwSJ19xfNKht6JGy1
	 ilIYPQi23+9hoNOHtXbe8fan//PtYooE/rtRaChs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfJCBnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfJCBnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:43:14 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BA6A222C4;
        Thu,  3 Oct 2019 01:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066993;
        bh=Zw0CRg+Lnjau6ZnXDxzvWs0DBHdnwFB+dQFY5Z45GsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=go9gL1rnB+9IEoHYvnOLiKjNS2+W58Kc/zUmQlnZIKemEw2TUdDyRwiblmrRcxRls
         nxAr15o7woTpFk1UHmdqdOH9ekEXNI4qm2Svwi7T1wI8qhn5FZcKXvhu3j/+MgyRgg
         FHfrHLuTySOI08VpQl9xR5GIjlstNJL2A8jLbV/8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH tip/core/rcu 6/9] bpf/cgroup: Replace rcu_swap_protected() with rcu_replace()
Date:   Wed,  2 Oct 2019 18:43:07 -0700
Message-Id: <20191003014310.13262-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003014153.GA13156@paulmck-ThinkPad-P72>
References: <20191003014153.GA13156@paulmck-ThinkPad-P72>
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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: <netdev@vger.kernel.org>
Cc: <bpf@vger.kernel.org>
---
 kernel/bpf/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index ddd8add..06a0657 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -180,8 +180,8 @@ static void activate_effective_progs(struct cgroup *cgrp,
 				     enum bpf_attach_type type,
 				     struct bpf_prog_array *old_array)
 {
-	rcu_swap_protected(cgrp->bpf.effective[type], old_array,
-			   lockdep_is_held(&cgroup_mutex));
+	old_array = rcu_replace(cgrp->bpf.effective[type], old_array,
+				lockdep_is_held(&cgroup_mutex));
 	/* free prog array after grace period, since __cgroup_bpf_run_*()
 	 * might be still walking the array
 	 */
-- 
2.9.5

