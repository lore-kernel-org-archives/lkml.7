Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741FBC31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439E1206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="B0S9FP1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfFQOPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:15:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41865 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQOPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:15:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEEUjD3451965
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:14:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEEUjD3451965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560780871;
        bh=NUM7WikzHXDWjnge0MpQUTTzBIAcUAAp0UB9kPwyqE0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=B0S9FP1oHiWksmbiicNbl8kpbTFJb0GkPky0I9csG7m2UHX1tDUfkbPySc2l2c6NG
         SqIHyrmrFj4/8EifxixzlH9EImYCUrJhrEV5eN9JJhgyRQ6fzHZ5ieW81voZpmX8qT
         ZyChQIVXBTx87wlgLFV5OcWA6HaNlXFLK9R9NWLl8sYByMhBAH6lKKE0FWEIpM8meJ
         +RSpWODKl+V614Gb/QXf42dZMGuW/uKyvO3yXYEVoiTvne3y88F43DBipHfV81+Dne
         Dyqjzb3jnAcVrojvgmw7yCA+M4zM61RcXccaoyTltoBM/q4ZFJqz/tTg5GA/ev75ZM
         Pel059skes9xg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEEUng3451957;
        Mon, 17 Jun 2019 07:14:30 -0700
Date:   Mon, 17 Jun 2019 07:14:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Message-ID: <tip-0f133021bd82548a33580bfb7b055e8857f46c2a@git.kernel.org>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, tglx@linutronix.de,
        crecklin@redhat.com, gregkh@linuxfoundation.org, jbaron@akamai.com,
        bp@alien8.de, peterz@infradead.org, jkosina@suse.cz,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        mtosatti@redhat.com, torvalds@linux-foundation.org,
        williams@redhat.com, hpa@zytor.com, jpoimboe@redhat.com,
        bristot@redhat.com, swood@redhat.com
Reply-To: jpoimboe@redhat.com, hpa@zytor.com, bristot@redhat.com,
          swood@redhat.com, peterz@infradead.org, jkosina@suse.cz,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, williams@redhat.com,
          mtosatti@redhat.com, gregkh@linuxfoundation.org,
          jbaron@akamai.com, bp@alien8.de, rostedt@goodmis.org,
          mhiramat@kernel.org, crecklin@redhat.com, tglx@linutronix.de
In-Reply-To: <f57ae83e0592418ba269866bb7ade570fc8632e0.1560325897.git.bristot@redhat.com>
References: <f57ae83e0592418ba269866bb7ade570fc8632e0.1560325897.git.bristot@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] jump_label: Sort entries of the same key by the
 code
Git-Commit-ID: 0f133021bd82548a33580bfb7b055e8857f46c2a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0f133021bd82548a33580bfb7b055e8857f46c2a
Gitweb:     https://git.kernel.org/tip/0f133021bd82548a33580bfb7b055e8857f46c2a
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Wed, 12 Jun 2019 11:57:28 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:09:21 +0200

jump_label: Sort entries of the same key by the code

In the batching mode, all the entries of a given key are updated at once.
During the update of a key, a hit in the int3 handler will check if the
hitting code address belongs to one of these keys.

To optimize the search of a given code in the vector of entries being
updated, a binary search is used. The binary search relies on the order
of the entries of a key by its code. Hence the keys need to be sorted
by the code too, so sort the entries of a given key by the code.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Scott Wood <swood@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/f57ae83e0592418ba269866bb7ade570fc8632e0.1560325897.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/jump_label.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 24f0d3b1526b..ca00ac10d9b9 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -37,12 +37,26 @@ static int jump_label_cmp(const void *a, const void *b)
 	const struct jump_entry *jea = a;
 	const struct jump_entry *jeb = b;
 
+	/*
+	 * Entrires are sorted by key.
+	 */
 	if (jump_entry_key(jea) < jump_entry_key(jeb))
 		return -1;
 
 	if (jump_entry_key(jea) > jump_entry_key(jeb))
 		return 1;
 
+	/*
+	 * In the batching mode, entries should also be sorted by the code
+	 * inside the already sorted list of entries, enabling a bsearch in
+	 * the vector.
+	 */
+	if (jump_entry_code(jea) < jump_entry_code(jeb))
+		return -1;
+
+	if (jump_entry_code(jea) > jump_entry_code(jeb))
+		return 1;
+
 	return 0;
 }
 
