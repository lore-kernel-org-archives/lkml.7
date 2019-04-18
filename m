Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21EEC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31C821871
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610820;
	bh=WKjXY9YQ4rlmY3c6kfn5KH2MNcBYwYehcR3Tk7r+pPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kaipgaW6RsSqJ2jR7qAEVr5mJKbYOW0GhBy3LzrcmW+LXcl+/kL9zg0mtby1aNeWt
	 HXx0SNaquivMaduC4ltCzSylOHkdD0ESaX0o+P21jvTLIuTt91LmiivpEJa0YRq/sI
	 5dUA/jfUPdqNNXtKwf+p9wTlGNjELJ4dRWcV0LMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391563AbfDRSG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391547AbfDRSG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B21B217FA;
        Thu, 18 Apr 2019 18:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610815;
        bh=WKjXY9YQ4rlmY3c6kfn5KH2MNcBYwYehcR3Tk7r+pPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qy6KaiS7rPSLdeD8aVgJBKFI2Av+e9mNH5OwkTdHmvSFVXQJT/ngdIddX98dI9GX0
         ipNCdVa1nYu7Azv6/LPX7e5FP04+rXFvyojqcEknBoQUP3PNwA2o/8eQXyQgbe7Xwe
         CGvO2Z2wkLsX8edi23scqBuvNudSNJU9XIipQyF0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Balbir Singh <sblbir@amzn.com>
Subject: [PATCH 4.14 74/92] bpf: fix verifier memory leaks
Date:   Thu, 18 Apr 2019 19:57:32 +0200
Message-Id: <20190418160436.689944333@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <ast@fb.com>

commit 1969db47f8d0e800397abd4ee4e8d27d2b578587 upstream.

fix verifier memory leaks

Fixes: 638f5b90d460 ("bpf: reduce verifier memory consumption")
Signed-off-by: Alexei Starovoitov <ast@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -491,10 +491,12 @@ static int realloc_verifier_state(struct
 	return 0;
 }
 
-static void free_verifier_state(struct bpf_verifier_state *state)
+static void free_verifier_state(struct bpf_verifier_state *state,
+				bool free_self)
 {
 	kfree(state->stack);
-	kfree(state);
+	if (free_self)
+		kfree(state);
 }
 
 /* copy verifier state from src to dst growing dst stack space
@@ -532,6 +534,7 @@ static int pop_stack(struct bpf_verifier
 	if (prev_insn_idx)
 		*prev_insn_idx = head->prev_insn_idx;
 	elem = head->next;
+	free_verifier_state(&head->st, false);
 	kfree(head);
 	env->head = elem;
 	env->stack_size--;
@@ -549,14 +552,14 @@ static struct bpf_verifier_state *push_s
 	if (!elem)
 		goto err;
 
-	err = copy_verifier_state(&elem->st, cur);
-	if (err)
-		return NULL;
 	elem->insn_idx = insn_idx;
 	elem->prev_insn_idx = prev_insn_idx;
 	elem->next = env->head;
 	env->head = elem;
 	env->stack_size++;
+	err = copy_verifier_state(&elem->st, cur);
+	if (err)
+		goto err;
 	if (env->stack_size > BPF_COMPLEXITY_LIMIT_STACK) {
 		verbose("BPF program is too complex\n");
 		goto err;
@@ -3812,7 +3815,7 @@ static int is_state_visited(struct bpf_v
 	struct bpf_verifier_state_list *new_sl;
 	struct bpf_verifier_state_list *sl;
 	struct bpf_verifier_state *cur = env->cur_state;
-	int i;
+	int i, err;
 
 	sl = env->explored_states[insn_idx];
 	if (!sl)
@@ -3850,7 +3853,12 @@ static int is_state_visited(struct bpf_v
 		return -ENOMEM;
 
 	/* add new state to the head of linked list */
-	copy_verifier_state(&new_sl->state, cur);
+	err = copy_verifier_state(&new_sl->state, cur);
+	if (err) {
+		free_verifier_state(&new_sl->state, false);
+		kfree(new_sl);
+		return err;
+	}
 	new_sl->next = env->explored_states[insn_idx];
 	env->explored_states[insn_idx] = new_sl;
 	/* connect new state to parentage chain */
@@ -4692,6 +4700,7 @@ static void free_states(struct bpf_verif
 		if (sl)
 			while (sl != STATE_LIST_MARK) {
 				sln = sl->next;
+				free_verifier_state(&sl->state, false);
 				kfree(sl);
 				sl = sln;
 			}
@@ -4768,7 +4777,7 @@ int bpf_check(struct bpf_prog **prog, un
 	env->allow_ptr_leaks = capable(CAP_SYS_ADMIN);
 
 	ret = do_check(env);
-	free_verifier_state(env->cur_state);
+	free_verifier_state(env->cur_state, true);
 	env->cur_state = NULL;
 
 skip_full_check:
@@ -4878,7 +4887,7 @@ int bpf_analyzer(struct bpf_prog *prog,
 	env->allow_ptr_leaks = capable(CAP_SYS_ADMIN);
 
 	ret = do_check(env);
-	free_verifier_state(env->cur_state);
+	free_verifier_state(env->cur_state, true);
 	env->cur_state = NULL;
 
 skip_full_check:


