Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0CBC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7521C204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HAgDZAaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfDSSlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:41:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55637 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfDSSlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:41:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JIeX5k385441
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 11:40:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JIeX5k385441
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555699234;
        bh=TH8ZMqlWAxP8nq3mVsbBmVtxoHcw7UwxFkagK7Ypcg8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HAgDZAaIAMDkaSiEcGhmtCjcBdVYffG2lvKqfWeLGWmyiCk4NwSzHcYBfiGeUGjRj
         O+uD6TYkneEoW1PrVftAy1Mc/Xo9eMoWH0r5xG6VKewLXe8JUcoP4mXF8lxhuXk4ZH
         KHB2quoWBe06ncGdAR04aGNcMkQOr698kJS2DcEMW3Dk5J3HRXYALWnfM2lAuMSnkI
         hOEwRRIfjdujAbBCvlzzDiaYW/H7oCzfkw/NWzmZffACATkBw42E+HlJ1osCGPc29S
         AqM2n8lmyhv+YElTNdO2G2y1ZqAiuBRK2Rvfy/qxCPPiLSp5hi0SuZDYq6IijU93CD
         CzeweVJ4W4AXQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JIeXUi385438;
        Fri, 19 Apr 2019 11:40:33 -0700
Date:   Fri, 19 Apr 2019 11:40:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Message-ID: <tip-1ca3398278341e1db3568f2d9c015ee4f5ad0b56@git.kernel.org>
Cc:     jkosina@suse.cz, acme@redhat.com, crecklin@redhat.com,
        bristot@redhat.com, jolsa@redhat.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, swood@redhat.com, jbaron@akamai.com,
        hpa@zytor.com, bp@alien8.de, dvlasenk@redhat.com,
        rostedt@goodmis.org, luto@kernel.org, mhiramat@kernel.org,
        alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
        brgerst@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        jpoimboe@redhat.com, williams@redhat.com, peterz@infradead.org,
        mtosatti@redhat.com
Reply-To: mhiramat@kernel.org, gregkh@linuxfoundation.org,
          alexander.shishkin@linux.intel.com, luto@kernel.org,
          hpa@zytor.com, bp@alien8.de, rostedt@goodmis.org,
          dvlasenk@redhat.com, williams@redhat.com, jpoimboe@redhat.com,
          peterz@infradead.org, mtosatti@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, brgerst@gmail.com, jkosina@suse.cz,
          swood@redhat.com, jbaron@akamai.com, bristot@redhat.com,
          jolsa@redhat.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, acme@redhat.com,
          crecklin@redhat.com
In-Reply-To: <7006ec86c40e5ec5d546dcd76ccc42d46079a963.1545228276.git.bristot@redhat.com>
References: <7006ec86c40e5ec5d546dcd76ccc42d46079a963.1545228276.git.bristot@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/alternatives] jump_label: Sort entries of the same key by
 the code
Git-Commit-ID: 1ca3398278341e1db3568f2d9c015ee4f5ad0b56
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

Commit-ID:  1ca3398278341e1db3568f2d9c015ee4f5ad0b56
Gitweb:     https://git.kernel.org/tip/1ca3398278341e1db3568f2d9c015ee4f5ad0b56
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Fri, 21 Dec 2018 11:27:31 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 19:37:34 +0200

jump_label: Sort entries of the same key by the code

In the batching mode, entries with the same key should also be sorted by the
code, enabling a bsearch() of a code/addr when updating a key.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Scott Wood <swood@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/7006ec86c40e5ec5d546dcd76ccc42d46079a963.1545228276.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/jump_label.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 456c0d7cbb5b..53b7c85c0b09 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -36,12 +36,28 @@ static int jump_label_cmp(const void *a, const void *b)
 	const struct jump_entry *jea = a;
 	const struct jump_entry *jeb = b;
 
+	/*
+	 * Entrires are sorted by key.
+	 */
 	if (jump_entry_key(jea) < jump_entry_key(jeb))
 		return -1;
 
 	if (jump_entry_key(jea) > jump_entry_key(jeb))
 		return 1;
 
+#ifdef HAVE_JUMP_LABEL_BATCH
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
+#endif
+
 	return 0;
 }
 
