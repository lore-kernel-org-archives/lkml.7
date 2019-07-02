Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A016C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D062A2184E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034503;
	bh=wcl+CMYcOT3dY6+B4araXSneXx9oiksAP/Bc0cLWKYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z8aVh8cHFH0V3lS39qJ5ie/48L2Du2q2qig0eWODb3SIxvjjLtCYcq3vJszTxgJ3I
	 n9018zx8zB9QP3aG8jdOzxLV0YuQ46sR9I69lKOr4zS3vobCWFIiqsTGgi8SULJ2TQ
	 cuVbM1FQCNZ4/y/geYlZgmpDO4dFTG0mHCeCi0xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfGBC2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbfGBC2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:28:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89758206A2;
        Tue,  2 Jul 2019 02:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034499;
        bh=wcl+CMYcOT3dY6+B4araXSneXx9oiksAP/Bc0cLWKYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoAz2Emhuo5N93VI+Ys+m+rZXOeJHXnfLFw3PtOq/g3jJkICHkIbgnKn7tkRFsnio
         4BOrNw9VAgs9eN6zNfp+DVHTFi5k6LbCR2yNg1W8KyCYECkwqjw0H+aSYFTfAg/7iv
         +k6WvSa0CZB0B0uDKXRuqJ6VDfkqsv5LOS8EFT5U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 35/43] tools lib: Adopt strreplace() from the kernel
Date:   Mon,  1 Jul 2019 23:26:08 -0300
Message-Id: <20190702022616.1259-36-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.20.1

