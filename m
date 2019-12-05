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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B21C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D6821835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9UtKpvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbfLEVwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:22 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44426 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbfLEVwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:17 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so4362262iln.11;
        Thu, 05 Dec 2019 13:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grd1rakogw2BEn4tAE432N08EqUy4BjMhxHYtZmywo4=;
        b=g9UtKpvdmqkb8LED/sHy5z6LtpDExLhvMqpSfIh3BH/8egEL2QzxM92WHpXPCKU/UX
         GQ47PT8+lOFHuU0CAsJK0RDtfoID7GvXBTrYwH2X35rNqD2d5LCeLY3EZqNnYUrWDSpz
         H+mdzlSVK2GwM23/ydBj7qGdjqeKzIA422ZVXoJtmk7cJs6SRhQweobQ8nhP0fPKTz/R
         7CQWJSmsFd5ZNbU/CJsRJbowVaAUx6G+QnyJIIvnnkuHxVHXST+uTFU84XeLJuDSW8z8
         MhkKBlslHA7XdUaE9N9BI9tf3DBd7WT4pTh/uzyq5X5cgMpnYAMY3SM0O59uMRX/hObP
         WJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grd1rakogw2BEn4tAE432N08EqUy4BjMhxHYtZmywo4=;
        b=GjgjrYA/SU2io/wFgaZe+QJQsCaKFublfFcsI5AE/bw5MuTISN3I36T4fFmwXbHCaU
         HTgj9Ul5zhsHb83ox5wS3wRgBQ0l7af6kFhgF0UYSdgXeuxxATcGk9iXdY5z25+Heh2C
         4NxLvM3TIVbqM0qQ0aB7FrDWUAlTCmKKQGhJkUGMFZXB3riQSHM8DJ4qSTIu4hljOWvf
         kCwAvdg2yXaZ5PEG58EcEcOkxkZdwfzvmqegJeCHgHn0Rt4XaWLcpDY1wCYESgWSy9Yu
         s4gK6FdIUw38hXJKFM4ZdxdleCR5XJe1peU476zj4qMVOefqbyztjjYma8n40GsBpc3E
         vNyw==
X-Gm-Message-State: APjAAAWMQT87Ywzt0TEQVNdjqXs2l2xwz0g6apQmeEJ1fkJAMJDayeDM
        shGsEVco7l0WghA00ihyO/Y=
X-Google-Smtp-Source: APXvYqxtsOguVD5OjiAl2LXWs61tkwUaHZgqCoQ81BONy+REW3HUxgS8dbNMif1KAdlVb9lXygxS6w==
X-Received: by 2002:a92:cd4f:: with SMTP id v15mr11425153ilq.230.1575582736991;
        Thu, 05 Dec 2019 13:52:16 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:16 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 08/18] dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
Date:   Thu,  5 Dec 2019 14:51:39 -0700
Message-Id: <20191205215151.421926-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
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

Doc these changes, and sprinkle in a few extra wild-card examples and
trailing # explanation texts.

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
index f0cf90e672b8..9fa6d4eeae5c 100644
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

