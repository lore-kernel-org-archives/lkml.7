Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23999C0650E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F033821851
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034494;
	bh=VWa8dEAlcPod1Ec2sEKlu1iw6gByLIkEbAxyW5kq104=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wM6l//wx77D1sBForBvdPfkY6QJ/YccdFMVKtYyGSaIEZzfLEhtzKm9DOVS3kUZUc
	 ONllQZX9EuEaFax0eTLG6DsJLcNsq065V7NaYcmXhYfrRVhMNsamjiHkoJ8sew4sX7
	 PLOWDWEGX6s8RDZRfqSl7xmBNnG4pfZB2mJkWDvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfGBC2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbfGBC2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:28:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8FDC2173E;
        Tue,  2 Jul 2019 02:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034491;
        bh=VWa8dEAlcPod1Ec2sEKlu1iw6gByLIkEbAxyW5kq104=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l5Zkhzyt883japO5XDMVtmA3eaDYPQ6md5yJg7ZT5EbwV6gwLvOVkqXorSaxGeCuF
         fPmcFqYZwaStRAMOo4rqhoJf28nDn+46P1NS2b/jleAxEs1YYcmiuWQmzGVDhVj1ie
         q/RIGGJjdE0tdHGvDp675oEQn3lg5WNJFMtmHn2U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
Subject: [PATCH 32/43] tools lib: Adopt strim() from the kernel
Date:   Mon,  1 Jul 2019 23:26:05 -0300
Message-Id: <20190702022616.1259-33-acme@kernel.org>
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

Since we're working on moving stuff out of tools/perf/util/ to
tools/lib/, take the opportunity to adopt routines from the kernel that
are equivalent, so that tools/ code look more like the kernel.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: André Goddard Rosa <andre.goddard@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-zqy1zdu2ok17qvi0ytk8z13c@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/string.h |  2 ++
 tools/lib/string.c           | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index cee239350a6b..e436f8037c87 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -31,4 +31,6 @@ static inline bool strstarts(const char *str, const char *prefix)
 
 extern char * __must_check skip_spaces(const char *);
 
+extern char *strim(char *);
+
 #endif /* _TOOLS_LINUX_STRING_H_ */
diff --git a/tools/lib/string.c b/tools/lib/string.c
index 50d400822bb3..80472e6b3829 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -120,3 +120,28 @@ char *skip_spaces(const char *str)
 		++str;
 	return (char *)str;
 }
+
+/**
+ * strim - Removes leading and trailing whitespace from @s.
+ * @s: The string to be stripped.
+ *
+ * Note that the first trailing whitespace is replaced with a %NUL-terminator
+ * in the given string @s. Returns a pointer to the first non-whitespace
+ * character in @s.
+ */
+char *strim(char *s)
+{
+	size_t size;
+	char *end;
+
+	size = strlen(s);
+	if (!size)
+		return s;
+
+	end = s + size - 1;
+	while (end >= s && isspace(*end))
+		end--;
+	*(end + 1) = '\0';
+
+	return skip_spaces(s);
+}
-- 
2.20.1

