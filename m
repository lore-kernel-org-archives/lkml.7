Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C7AC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3B921850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kuMMWMKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfGCOZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:25:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45689 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGCOZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:25:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EPcN73326302
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:25:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EPcN73326302
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163939;
        bh=13mmOXdJ7x+fdKqtVLacoTWSg/Q6BRG/tbHO80C2OsE=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=kuMMWMKcLMy3U7DAWzS+QYIhDp/B0fBCRYT7myu+WRnJQ/co0vRemH45huAdRkAe7
         og1+osUkG8E4KJQizudXz2id5kvJZlUEZch44vQyj3nta1w4n2V11FO0eHtwA+AqF5
         s6MVw+q0Jr+4sZgNbd/x4+/z0l3vNT14SKgWAIpLEughV/Gs7R3c6oriN/taAjNANb
         02qLPRv4v2K2GxlIAXN9CVKMDkwLutoG4zccJx/D8t5OL0uHvz/AWj1LhUH5/DOxd6
         Va6FoW+xsXw2vihlQoGZFbee+mPckwpKHeWgsxC5RkAk/2/9o250Hi/jfK/GPbTSQm
         vIK9t9dLI4lEQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EPcUk3326298;
        Wed, 3 Jul 2019 07:25:38 -0700
Date:   Wed, 3 Jul 2019 07:25:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-x3r61ikjrso1buygxwke8id3@git.kernel.org>
Cc:     acme@redhat.com, jolsa@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com
Reply-To: adrian.hunter@intel.com, hpa@zytor.com, acme@redhat.com,
          jolsa@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib: Adopt strreplace() from the kernel
Git-Commit-ID: 2a60689a33a61f000bd90596b1289babcb861cd9
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

Commit-ID:  2a60689a33a61f000bd90596b1289babcb861cd9
Gitweb:     https://git.kernel.org/tip/2a60689a33a61f000bd90596b1289babcb861cd9
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 26 Jun 2019 12:24:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Jul 2019 22:50:40 -0300

tools lib: Adopt strreplace() from the kernel

We'll use it to further reduce the size of tools/perf/util/string.c,
replacing the strxfrchar() equivalent function we have there.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-x3r61ikjrso1buygxwke8id3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/string.h |  2 ++
 tools/lib/string.c           | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index e436f8037c87..a76d4df10435 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -19,6 +19,8 @@ extern size_t strlcpy(char *dest, const char *src, size_t size);
 
 char *str_error_r(int errnum, char *buf, size_t buflen);
 
+char *strreplace(char *s, char old, char new);
+
 /**
  * strstarts - does @str start with @prefix?
  * @str: string to examine
diff --git a/tools/lib/string.c b/tools/lib/string.c
index 80472e6b3829..f2ae1b87c719 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -145,3 +145,19 @@ char *strim(char *s)
 
 	return skip_spaces(s);
 }
+
+/**
+ * strreplace - Replace all occurrences of character in string.
+ * @s: The string to operate on.
+ * @old: The character being replaced.
+ * @new: The character @old is replaced with.
+ *
+ * Returns pointer to the nul byte at the end of @s.
+ */
+char *strreplace(char *s, char old, char new)
+{
+	for (; *s; ++s)
+		if (*s == old)
+			*s = new;
+	return s;
+}
