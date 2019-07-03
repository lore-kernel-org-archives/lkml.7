Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AEEC06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65AD21881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="djVsPIIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfGCOR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:17:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55505 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:17:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EH6OV3322900
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:17:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EH6OV3322900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163427;
        bh=d5+SELwfHXuIfTz5tUg6Hs238eg+lPGNYrewLBIZ5Uc=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=djVsPIIslbyaIGx5Xi5btMZO32z0ZhBNTuAmFjvE31lP44Q0Lt8IofkPmEAJjuRqk
         kCO38esDabModyMH9w36jxUIgVOMmxjPVSoRlWpLoFG//GUoWSiaibGISX7FOWJB1i
         nN83tASaCRxJPN1Sy/gi/OUd09TA5dtvoifqEOtigFRgBQ/DqrdsZt7aIyPh6LBnHC
         GGgUecE7U1hbWGLNOJaFcAhRX3KOATH42s2iMn1UCd2K0HIoEYpm521chl1wLIQolY
         jiUdT5eLdhMvaqqVG2kKcdlZ4j6rC4xAzcJYXgjdkkwThfiDzi0GltnY+WgmWEVRru
         bJ5ygQW/pqX7Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EH6Rw3322897;
        Wed, 3 Jul 2019 07:17:06 -0700
Date:   Wed, 3 Jul 2019 07:17:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-dig691cg9ripvoiprpidthw7@git.kernel.org>
Cc:     hpa@zytor.com, andre.goddard@gmail.com, acme@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
          jolsa@kernel.org, hpa@zytor.com, acme@redhat.com,
          andre.goddard@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib: Adopt skip_spaces() from the kernel
 sources
Git-Commit-ID: 7bd330de43fd5693e90be13dac7fbd9af3b6335d
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

Commit-ID:  7bd330de43fd5693e90be13dac7fbd9af3b6335d
Gitweb:     https://git.kernel.org/tip/7bd330de43fd5693e90be13dac7fbd9af3b6335d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 25 Jun 2019 21:23:18 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 21:23:18 -0300

tools lib: Adopt skip_spaces() from the kernel sources

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
