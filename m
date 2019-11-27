Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82412C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A5B206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1IoBEtp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfK0Rvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:51:31 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42727 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfK0Rv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:51:29 -0500
Received: by mail-io1-f68.google.com with SMTP id k13so25814895ioa.9;
        Wed, 27 Nov 2019 09:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=axIeDX2ZuzeMwEDGdzKEGgiMR3V0p3vdxKl8XUb96Yk=;
        b=D1IoBEtpYpoEMaZL8zSpM4CxUw6mIEfouJwlzICHwT0eP7hvRP/N/YtL5K+1hFZcWG
         jzx3ZSmYq2Sec6dWCT4q44CqVoGpdIKlPQgPjU8Sd2vYqZl6HHpZCaMbIILutkL3jxHQ
         FXJ5MXYaxrHQomSMyRgvhkgjj2zYp+zEgshS++cDM0qK3q/KuZl9XS/aJ9oefM1Ddvwr
         4MF7vrB8vOAfgxuBVFG8yMnXJSB347fk860MgnrP5quPWMdz/2e+QzUmIBvYs9kznN/p
         6TeuLw3eKTOxYnI5mFTMnYZ/dYGitc2qQPs7unJdmuvFlIsg7J7E7+XS4hMMgHIKX450
         H7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=axIeDX2ZuzeMwEDGdzKEGgiMR3V0p3vdxKl8XUb96Yk=;
        b=Nf3us8VFTAzK4B+s92z45tjAWER7WyLmfJK4C7FsoijyYn2IEuSdXd1P1A2s1Mn8FB
         pVDSj5dXICtU3cH7/wGQ1KjQNO1CAlg9sUi+60hKR4wHfiDEW/ff55OmwfIPoHFh1NXH
         GCPc5y750+p4zy60rdBfLo9sP7Xk/D1xPhb+m3F8ghJmysmZR6obkbsVxgxi20CCmQO2
         33IYaSG+4BHvu2aiKHDZw7Kq0EWo2umeOWvq7Dw+7rOsZRKhsDpl9zgkuXA4UwkGo7ti
         3W2GPBWWttI4coDUsWqHm4k2DdtWiXIYM0uKnAAZaN78bDeXN5Ev1+K/R1h1q6/s9iAN
         IMKw==
X-Gm-Message-State: APjAAAUiJb4eYgPh6YczNS4sucbkO5ZUGvfggvFoNxiCg5bgXEHBYJHk
        L+kW2PhPORsEQjxuUVoccwA=
X-Google-Smtp-Source: APXvYqw5mR4qCkwkkFC2wRiKQzny/Sl48aLcxCJlteK8fMx6gWfc+WW5/CkxcAd4wI6VnH+3IL/vFA==
X-Received: by 2002:a6b:8b89:: with SMTP id n131mr26965779iod.55.1574877088555;
        Wed, 27 Nov 2019 09:51:28 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n3sm4612911ilm.74.2019.11.27.09.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:51:27 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 12/16] dyndbg: extend ddebug_parse_flags to accept optional filter-flags
Date:   Wed, 27 Nov 2019 10:51:24 -0700
Message-Id: <20191127175125.1351810-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
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

