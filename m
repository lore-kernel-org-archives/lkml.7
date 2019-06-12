Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C7DC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8414920896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437838AbfFLJ5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731931AbfFLJ5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:57:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E8822F8BFA;
        Wed, 12 Jun 2019 09:57:50 +0000 (UTC)
Received: from localhost.default (ovpn-116-101.phx2.redhat.com [10.3.116.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26A822CFA7;
        Wed, 12 Jun 2019 09:57:46 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [PATCH V6 3/6] jump_label: Sort entries of the same key by the code
Date:   Wed, 12 Jun 2019 11:57:28 +0200
Message-Id: <f57ae83e0592418ba269866bb7ade570fc8632e0.1560325897.git.bristot@redhat.com>
In-Reply-To: <cover.1560325897.git.bristot@redhat.com>
References: <cover.1560325897.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 12 Jun 2019 09:57:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the batching mode, all the entries of a given key are updated at once.
During the update of a key, a hit in the int3 handler will check if the
hitting code address belongs to one of these keys.

To optimize the search of a given code in the vector of entries being
updated, a binary search is used. The binary search relies on the order
of the entries of a key by its code. Hence the keys need to be sorted
by the code too, so sort the entries of a given key by the code.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Scott Wood <swood@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 kernel/jump_label.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 468ca421ad9a..2bd172e1e95f 100644
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
 
-- 
2.20.1

