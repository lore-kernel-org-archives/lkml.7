Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E128C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E702466E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9ZI6UP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbfLEVwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:34 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:39966 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbfLEVwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:24 -0500
Received: by mail-io1-f53.google.com with SMTP id x1so5235124iop.7;
        Thu, 05 Dec 2019 13:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=axIeDX2ZuzeMwEDGdzKEGgiMR3V0p3vdxKl8XUb96Yk=;
        b=G9ZI6UP25/SpVKvWIB6fsm0sCEhWGpI+Ui+ygRJM180TynebLJiaTK29BpHEaTPsGp
         SD4wWpv3MlmS1CqBKyKXYXXN49W4s5iJBEW6uApKs7bjDn/lpUMSQKKFHRYrSbZ3X471
         4tvxmMOvDs9WG2NabCY/JNN2E/iikrGAqjWLJD7wMl43zijQh1hZe5IeK8zExxm97iTi
         RP1v/1Z89DyYAZ+iCGauUUF7bQz2r2pivxCwOkjqh9mG336AEFoYeQr6w+tC3mFiIyzT
         Vv67jOryeacDcuA1Mhrl2F7NWzeUOaaqrx3cX4wQ3AidSNegmrOc50Yf9LSEZyZ1xxXh
         Lheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axIeDX2ZuzeMwEDGdzKEGgiMR3V0p3vdxKl8XUb96Yk=;
        b=aa9t+dOKT9QbvARy2gJMC1L9VKPuOjvH+ZZiTndcoBAF9UZ6ZQ8q/YW+lquE8VQdaF
         mmvFslrSZXPaONF9QOYOX3w80uPK7VwxNd7DJw6wRyNtkzeSdDYzkx8IVKl1leK3ibp3
         qL3Dfhdrn6NV0HR5/BP3+uLuKs22kf39fEHyXnq7314SWLgC6N3ziisakHHhBWITTwea
         YbAcGvXUmnC9anquj30rQco8aUVaZ7QRP/nAjl+5PgneAF2L8wyYjlijuUf9fweWkeGD
         JCXjZd+SkG+CHuvSW3j+YiLjgXCFW9Z9wHsfiDTe73ZNcPEkDsOv/9z9sPFxMxbH2pIu
         beEA==
X-Gm-Message-State: APjAAAU0NJhOp4Ujkev9JY0Hs+SyWKjTpk1xwAqzb9VzoAQGyXtThI0V
        6Xf7R+xwwt7elhCPtm6MTP4=
X-Google-Smtp-Source: APXvYqwvOFCYcY7BzS4YkzGQmBx2gkRp9Gt2kOT4lm96EDR2Gn7xeahiB/GzRaybKao9GBWcXtlXJA==
X-Received: by 2002:a6b:7618:: with SMTP id g24mr8266624iom.31.1575582743696;
        Thu, 05 Dec 2019 13:52:23 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:23 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 12/18] dyndbg: extend ddebug_parse_flags to accept optional filter-flags
Date:   Thu,  5 Dec 2019 14:51:43 -0700
Message-Id: <20191205215151.421926-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change ddebug_parse_flags to accept /^ filterflags? OP modflags /x, as
well as the currently accepted /^ OP modflags /.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 18 +++++++----
 lib/dynamic_debug.c                           | 30 ++++++++++---------
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 689a30316589..cdc45dcb3e0c 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -209,13 +209,19 @@ line
 	line -1605          // the 1605 lines from line 1 to line 1605
 	line 1600-          // all lines from line 1600 to the end of the file
 
-The flags specification comprises a change operation followed
-by one or more flag characters.  The change operation is one
-of the characters::
+Flags Specification::
 
-  -    remove the given flags
-  +    add the given flags
-  =    set the flags to the given flags
+  flagspec	::= filterflags? OP modflags
+  filterflags	::= flagset
+  modflags	::= flagset
+  flagset	::= ([pfmlt_xyz] | [PFMLT_XYZ])+
+  OP		::= [-+=]
+
+OP: modify callsites per following flagset::
+
+  -    remove the following flags
+  +    add the following flags
+  =    set the flags to the following flags
 
 The flags are::
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8c62c76badcf..be8299e119ab 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -441,34 +441,36 @@ static int ddebug_read_flags(const char *str, struct flagsettings *f)
 }
 
 /*
- * Parse `str' as a flags specification, format [-+=][p]+.
- * Sets up *maskp and *flagsp to be used when changing the
- * flags fields of matched _ddebug's.  Returns 0 on success
- * or <0 on error.
+ * Parse `str' as a flags-spec, ie: [pfmlt_]*[-+=][pfmlt_]+
+ * Fills flagsettings provided.  Returns 0 on success or <0 on error.
  */
-
 static int ddebug_parse_flags(const char *str,
 			      struct flagsettings *mods,
 			      struct flagsettings *filter)
 {
 	int op;
+	char *opp = strpbrk(str, "-+=");
 
-	switch (*str) {
-	case '+':
-	case '-':
-	case '=':
-		op = *str++;
-		break;
-	default:
-		pr_err("bad flag-op %c, at start of %s\n", *str, str);
+	if (!opp) {
+		pr_err("no OP given in %s\n", str);
 		return -EINVAL;
 	}
+	op = *opp;
 	vpr_info("op='%c'\n", op);
 
+	if (opp != str) {
+		/* filterflags precedes OP, grab it */
+		*opp++ = '\0';
+		if (ddebug_read_flags(str, filter))
+			return -EINVAL;
+		str = opp;
+	} else
+		str++;
+
 	if (ddebug_read_flags(str, mods))
 		return -EINVAL;
 
-	/* calculate final flags, mask based upon op */
+	/* calculate final mods: flags, mask based upon op */
 	switch (op) {
 	case '=':
 		mods->mask = 0;
-- 
2.23.0

