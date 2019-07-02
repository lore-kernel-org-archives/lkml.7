Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2ABC0650E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2CA2186A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034457;
	bh=N6WiVOhBnlIFmTfJLZK7jsC1+ccnU6pKOtqDjcmj86o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wWu7FFQlcyzuqAcK5TpeqrE5EiTslnj8u6aI0xjrdgeZPZiOYlsJaE2nMI1jA+eDI
	 rMcuPUhQFOYqZTJ0Jhy9r81uPqgv5f2LXXXUhmitSL3rn+9UcGNwntx7NoPBQmpNwV
	 je3TewnOlXMjnX+pyOV85abBZhLxuwrXAmwADy/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfGBC1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbfGBC1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:27:35 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B30522184E;
        Tue,  2 Jul 2019 02:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034454;
        bh=N6WiVOhBnlIFmTfJLZK7jsC1+ccnU6pKOtqDjcmj86o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qm0U0XyQypT9Hn3ngNOfJznKDj+Kv4eqvf+BvgZStUf8zMTRIX3JdRX56criz+lu6
         I9wvK+xFWbRE0FmWhsl6WIt3/6LMk9TT5D6fhfTjokpkTSlP4ZNZl7WU38QO84RId5
         GokhEJgff85LMgRFpmtgimEZmmplPxa5q729uz7E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
Subject: [PATCH 23/43] tools lib: Adopt skip_spaces() from the kernel sources
Date:   Mon,  1 Jul 2019 23:25:56 -0300
Message-Id: <20190702022616.1259-24-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Same implementation, will be used to replace ad-hoc equivalent code in
tools/.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: André Goddard Rosa <andre.goddard@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dig691cg9ripvoiprpidthw7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/string.h |  4 +++-
 tools/lib/string.c           | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index 6c3e2cc274c5..cee239350a6b 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -29,4 +29,6 @@ static inline bool strstarts(const char *str, const char *prefix)
 	return strncmp(str, prefix, strlen(prefix)) == 0;
 }
 
-#endif /* _LINUX_STRING_H_ */
+extern char * __must_check skip_spaces(const char *);
+
+#endif /* _TOOLS_LINUX_STRING_H_ */
diff --git a/tools/lib/string.c b/tools/lib/string.c
index 93b3d4b6feac..50d400822bb3 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -17,6 +17,7 @@
 #include <string.h>
 #include <errno.h>
 #include <linux/string.h>
+#include <linux/ctype.h>
 #include <linux/compiler.h>
 
 /**
@@ -106,3 +107,16 @@ size_t __weak strlcpy(char *dest, const char *src, size_t size)
 	}
 	return ret;
 }
+
+/**
+ * skip_spaces - Removes leading whitespace from @str.
+ * @str: The string to be stripped.
+ *
+ * Returns a pointer to the first non-whitespace character in @str.
+ */
+char *skip_spaces(const char *str)
+{
+	while (isspace(*str))
+		++str;
+	return (char *)str;
+}
-- 
2.20.1

