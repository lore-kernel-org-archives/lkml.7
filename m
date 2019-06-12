Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4549C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4750208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbfFLJ5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:57:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbfFLJ5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:57:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72BBA2F8BF5;
        Wed, 12 Jun 2019 09:57:43 +0000 (UTC)
Received: from localhost.default (ovpn-116-101.phx2.redhat.com [10.3.116.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 474DC614C4;
        Wed, 12 Jun 2019 09:57:39 +0000 (UTC)
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
Subject: [PATCH V6 1/6] jump_label: Add a jump_label_can_update() helper
Date:   Wed, 12 Jun 2019 11:57:26 +0200
Message-Id: <56b69bd3f8e644ed64f2dbde7c088030b8cbe76b.1560325897.git.bristot@redhat.com>
In-Reply-To: <cover.1560325897.git.bristot@redhat.com>
References: <cover.1560325897.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 12 Jun 2019 09:57:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the check if a jump_entry is valid to a function. No functional
change.

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
 kernel/jump_label.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 0bfa10f4410c..468ca421ad9a 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -384,22 +384,30 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
 	return enabled ^ branch;
 }
 
+static bool jump_label_can_update(struct jump_entry *entry, bool init)
+{
+	/*
+	 * Cannot update code that was in an init text area.
+	 */
+	if (!init && jump_entry_is_init(entry))
+		return false;
+
+	if (!kernel_text_address(jump_entry_code(entry))) {
+		WARN_ONCE(1, "can't patch jump_label at %pS", (void *)jump_entry_code(entry));
+		return false;
+	}
+
+	return true;
+}
+
 static void __jump_label_update(struct static_key *key,
 				struct jump_entry *entry,
 				struct jump_entry *stop,
 				bool init)
 {
 	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++) {
-		/*
-		 * An entry->code of 0 indicates an entry which has been
-		 * disabled because it was in an init text area.
-		 */
-		if (init || !jump_entry_is_init(entry)) {
-			if (kernel_text_address(jump_entry_code(entry)))
-				arch_jump_label_transform(entry, jump_label_type(entry));
-			else
-				WARN_ONCE(1, "can't patch jump_label at %pS",
-					  (void *)jump_entry_code(entry));
+		if (jump_label_can_update(entry, init)) {
+			arch_jump_label_transform(entry, jump_label_type(entry));
 		}
 	}
 }
-- 
2.20.1

