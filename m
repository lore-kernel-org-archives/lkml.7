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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FDBC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901D920835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuBmVjM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfK0RvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:51:14 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37969 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0RvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:51:14 -0500
Received: by mail-io1-f65.google.com with SMTP id u24so24107368iob.5;
        Wed, 27 Nov 2019 09:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4wns2J9TrYSMO0FP1gWVXKw38D0t4uNE7MgIhv6xWoQ=;
        b=EuBmVjM1zv9CjNzTeR0hXvCPhtvo+0r2DzV/ks2q6Ug2YbXh+Yhr96JxAKXU4u6t8y
         0GrE5DkN1vNSdMMgo9GZ2Yus+RHnwjztsaO4aFnEdl8tf3KxMYoMoAuHfn79peOKmc5w
         rf4p9ek6iWIhc7WSFnKyRW+hafv6vzlyVrMJUyve6oJxq1m2Z+PEoS450m7jRTHWAU7U
         +fJ2YVBwLDprArwBpWk9pptVz8j2PiL24zU6PmuJfOD2Hu2I5naMwDMlZU53mFgU+MUw
         /qDqcg30EX5kvkXFpZ3lYzkb/eheyo6jtSGP9ubXOF4S85CSXOFddJrejcvUo2BGyfen
         QjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4wns2J9TrYSMO0FP1gWVXKw38D0t4uNE7MgIhv6xWoQ=;
        b=M5L1/+4Af4vWELSzEr+qkgPRSGZO/+ZGD9kTNkRw906BEd5wMbCpzsEB8DEpyzsTz3
         Vy5Z4fCivsyo72jpXvPtANwsHKBSLfqRan6ruZKKJ6kzB7ia+HhV/37mgD9KOh6TIeiF
         A4VmfiknbiQ5jrVs2cpxb9HbgrDPcyWfLHe3/koB/V8/9SlODl7ylBsw4WXzn6JjvY7h
         PpBKlz5PFlEnmdkPde+98IKcudd9MS7oBGxVk2bMtOhdJJaZvxVVYTa3nZumtiwLqrbQ
         Me0TFzUFVF0PS5HNfkjJTc/IT5+5p6b//mepYssVlw7us67y2g4B5A01SwIEKAG7tkLP
         dPpw==
X-Gm-Message-State: APjAAAX9WopvM7cnmYgUsxUO/cX4hSnlgcaWsk8loC26kkG0HOB0xciM
        PoQTLgDQZY9n05dTkbPHOtI=
X-Google-Smtp-Source: APXvYqzpdCVNY5+aafp+DIbNbZ4IVbtNhcPR80m8aFiAmsER8PKnAytyGimRZarD1OAAvysdYK0gjw==
X-Received: by 2002:a5e:8c0a:: with SMTP id n10mr39914558ioj.78.1574877073044;
        Wed, 27 Nov 2019 09:51:13 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id i22sm4526744ill.40.2019.11.27.09.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:51:12 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 08/16] dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
Date:   Wed, 27 Nov 2019 10:51:05 -0700
Message-Id: <20191127175106.1351574-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accept these additional query forms:

   echo "file $filestr +_" > control

       path/to/file.c:100	# as from control, column 1
       path/to/file.c:1-100	# or any legal line-range
       path/to/file.c:func_A	# as from an editor/browser
       path/to/file.c:drm_\*	# wildcards still work
       path/to/file.c:*_foo	# lead wildcard too

1st 2 examples are treated as line-ranges, 3,4 are treated as func's

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       |  5 +++++
 lib/dynamic_debug.c                           | 20 ++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index e011f8907116..689a30316589 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -156,6 +156,7 @@ func
     of each callsite.  Example::
 
 	func svc_tcp_accept
+	func *recv*		# in rfcomm, bluetooth, ping, tcp
 
 file
     The given string is compared against either the src-root relative
@@ -164,6 +165,9 @@ file
 
 	file svcsock.c
 	file kernel/freezer.c	# ie column 1 of control file
+	file drivers/usb/*	# all callsites under it
+	file inode.c:start_*	# parse :tail as a func (above)
+	file inode.c:1-100	# parse :tail as a line-range (above)
 
 module
     The given string is compared against the module name
@@ -173,6 +177,7 @@ module
 
 	module sunrpc
 	module nfsd
+	module drm*	# both drm, drm_kms_helper
 
 format
     The given string is searched for in the dynamic debug format
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 496c3da48e2b..9a6768e9334a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -322,6 +322,8 @@ static int parse_linerange(struct ddebug_query *query, const char *first)
 	} else {
 		query->last_lineno = query->first_lineno;
 	}
+	vpr_info("parsed line %d-%d\n", query->first_lineno,
+		 query->last_lineno);
 	return 0;
 }
 
@@ -358,6 +360,7 @@ static int ddebug_parse_query(char *words[], int nwords,
 {
 	unsigned int i;
 	int rc = 0;
+	char *fline;
 
 	/* check we have an even number of words */
 	if (nwords % 2 != 0) {
@@ -374,7 +377,22 @@ static int ddebug_parse_query(char *words[], int nwords,
 		if (!strcmp(words[i], "func")) {
 			rc = check_set(&query->function, words[i+1], "func");
 		} else if (!strcmp(words[i], "file")) {
-			rc = check_set(&query->filename, words[i+1], "file");
+			if (check_set(&query->filename, words[i+1], "file"))
+				return -EINVAL;
+
+			/* tail :$info is function or line-range */
+			fline = strchr(query->filename, ':');
+			if (!fline)
+				break;
+			*fline++ = '\0';
+			if (isalpha(*fline) || *fline == '*' || *fline == '?') {
+				/* take as function name */
+				if (check_set(&query->function, fline, "func"))
+					return -EINVAL;
+			} else
+				if (parse_linerange(query, fline))
+					return -EINVAL;
+
 		} else if (!strcmp(words[i], "module")) {
 			rc = check_set(&query->module, words[i+1], "module");
 		} else if (!strcmp(words[i], "format")) {
-- 
2.23.0

