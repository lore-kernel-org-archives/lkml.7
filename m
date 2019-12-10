Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D637C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40E02080D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCKdD5jA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfLJC2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:28:44 -0500
Received: from mail-il1-f180.google.com ([209.85.166.180]:33411 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfLJC2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:28:21 -0500
Received: by mail-il1-f180.google.com with SMTP id r81so14757132ilk.0;
        Mon, 09 Dec 2019 18:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=axIeDX2ZuzeMwEDGdzKEGgiMR3V0p3vdxKl8XUb96Yk=;
        b=KCKdD5jAYf2WGEFNS51Op9Xxf9LFCn8YVmJ3CXyIpyzcjMeawd2C92NlWPqp9co62d
         dVWRuq2EpBFtoXtysR1uE5sFS2AUuHaqH//V1KtdvLkcaYxTgNpkbF6brGMn56Ci0G7V
         5iCFW3cjKSK4wETV+9VoJGptPNE8LNCWI3ra4Q/A/mLjcxdyEzpSbh8g2E31PIK3M9C6
         ZAMyl8rHXJTYgBNpbJpIsg5KYhClonpN05ZURCXDjD6rDYGTr343XU0HGra+BqJJkXxg
         7FCy9AkMPo4hDnY+WBa6gz6oDZLsTIPS/O5FqqJRXA2OkLpsM8NXdwftub3Lw1C3f5+e
         8/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axIeDX2ZuzeMwEDGdzKEGgiMR3V0p3vdxKl8XUb96Yk=;
        b=SCQFZ4AGAJHGFALxV7jh4N+P6ml9FBXSLb+/RP3heMQnaGwsdNx6mHdW4zgkbkI/BJ
         wZp6EL9ThFc3VW+0k3jQoZWa7SnmJl2suEReQ+tnnebf7536A6JpFSiafAjvLPBd2b52
         uWgMgcSRE5APhspDkOquymiYgXkNtjTDxpPJQhExAzppN4ul3LbscmOri53CymMJbbL6
         P7fOdX0vmpyr2lE9q9LKroC16QmC+ZTbWsVxc/wzYc6tByqnWUOYJpxEaUdZcQJ7LzHh
         W+zMAt9OAaXOMGM8RLJTaWvq9hsQZ0gcied+LCu0q/GjTHYiHAzgc8wYx1figUVbRZgb
         87rA==
X-Gm-Message-State: APjAAAW+aksaUZY3r8FAM4j/D6LkIyHEj9FzL7bS7w9AfRf/BADCcerQ
        OLbTKu0jPtOnQFKEcwyuiTg=
X-Google-Smtp-Source: APXvYqy+qDiCDPi/Q3epXoCQM5eKdvww1bOydUnug3cTM7xuMic45/zAdb6rW+gDMjWQyVXKwFWAYg==
X-Received: by 2002:a92:1a0a:: with SMTP id a10mr29704496ila.295.1575944900703;
        Mon, 09 Dec 2019 18:28:20 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l9sm334052ioh.77.2019.12.09.18.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:28:20 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v4 12/16] dyndbg: extend ddebug_parse_flags to accept optional filter-flags
Date:   Mon,  9 Dec 2019 19:27:38 -0700
Message-Id: <20191210022742.822686-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210022742.822686-1-jim.cromie@gmail.com>
References: <20191210022742.822686-1-jim.cromie@gmail.com>
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

