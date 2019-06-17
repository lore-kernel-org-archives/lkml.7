Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C65C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28642085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="seL5bmME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfFQOOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:14:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34849 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfFQOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:14:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HED7Ge3451756
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:13:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HED7Ge3451756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560780788;
        bh=IVAF3u9sBf7OaHnuDR5O/sVczWfFLKJNP+gAO/yxOdI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=seL5bmMEU5P3kFEoEc2McT0ac42Mfri48ZE7bcIckmZO4EAjlFTTDmZ971VrTePox
         1UwzKfvdVU5z6IBEvtR1N6t4Iudrhbq2toRoGoHOGREdIYuWCHhGOzemoLOUGXATnz
         f8k26ri8NBSrQk9WNmYQXLZyqvFyDxV6K7xR5YlWnLWepHzaIqZCdqgTPWCbuBK3So
         U6V4JDEYbJRrZV90NDgDp8gn0JZOWMuuOWNsY08GHzVq9Bgg4rpdMl5bHQBFguHEge
         D7trbDVCvFIm2dtyNaiX/i2xTFQrz/Sbj5H96zJuSvwXfsmUukYKML5MAL/ZbfUeJo
         Um0bIb2/78hpw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HED6nZ3451753;
        Mon, 17 Jun 2019 07:13:06 -0700
Date:   Mon, 17 Jun 2019 07:13:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Message-ID: <tip-e1aacb3f4adc1bcd4273a1d538a2dc3e50f1cbb5@git.kernel.org>
Cc:     peterz@infradead.org, rostedt@goodmis.org, williams@redhat.com,
        jkosina@suse.cz, jbaron@akamai.com, swood@redhat.com,
        crecklin@redhat.com, bristot@redhat.com, mhiramat@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, gregkh@linuxfoundation.org,
        mtosatti@redhat.com, torvalds@linux-foundation.org,
        mingo@kernel.org, bp@alien8.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, mtosatti@redhat.com,
          gregkh@linuxfoundation.org, bp@alien8.de, mingo@kernel.org,
          torvalds@linux-foundation.org, jpoimboe@redhat.com,
          linux-kernel@vger.kernel.org, rostedt@goodmis.org,
          peterz@infradead.org, jkosina@suse.cz, williams@redhat.com,
          swood@redhat.com, jbaron@akamai.com, crecklin@redhat.com,
          bristot@redhat.com, mhiramat@kernel.org
In-Reply-To: <56b69bd3f8e644ed64f2dbde7c088030b8cbe76b.1560325897.git.bristot@redhat.com>
References: <56b69bd3f8e644ed64f2dbde7c088030b8cbe76b.1560325897.git.bristot@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] jump_label: Add a jump_label_can_update() helper
Git-Commit-ID: e1aacb3f4adc1bcd4273a1d538a2dc3e50f1cbb5
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

Commit-ID:  e1aacb3f4adc1bcd4273a1d538a2dc3e50f1cbb5
Gitweb:     https://git.kernel.org/tip/e1aacb3f4adc1bcd4273a1d538a2dc3e50f1cbb5
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Wed, 12 Jun 2019 11:57:26 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:09:19 +0200

jump_label: Add a jump_label_can_update() helper

Move the check if a jump_entry is valid to a function. No functional
change.

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
Link: https://lkml.kernel.org/r/56b69bd3f8e644ed64f2dbde7c088030b8cbe76b.1560325897.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/jump_label.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 0bfa10f4410c..24f0d3b1526b 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -384,23 +384,30 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
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
-		}
+		if (jump_label_can_update(entry, init))
+			arch_jump_label_transform(entry, jump_label_type(entry));
 	}
 }
 
