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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DA4C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9281C20838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0Yyu8US"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLJC2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:28:18 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40752 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfLJC2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:28:14 -0500
Received: by mail-il1-f193.google.com with SMTP id b15so14705381ila.7;
        Mon, 09 Dec 2019 18:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grd1rakogw2BEn4tAE432N08EqUy4BjMhxHYtZmywo4=;
        b=k0Yyu8USNcaLlkHLr1B2BcnbMxfeLqsgcdeCk30tdl+88Jrs4sGl+0KEhBOrBLqjMT
         O9Su00GeCbS1xk/D8bGigNzX1PSTHFxX4KVTdFO09uyAzMHV70dxWNHcbkzaOiaGzfy8
         Z7aijmS8JHgCXFXwLVgE3AJJn7mLeh2NCPakaFmMmbJn6G63DrS8ce6g3Ogza4UluU7R
         CK/SZgphugg0cMyBS+OPKlbhowzQOIWuIepiGcdySqykNCYns2M71k6iKyP+047Kaa9P
         8NDgs5hCL3MiyUmjgt7OB3x5qMfD+w/d2uGvAfxbv3bz2YMwds/Dzkq8zCRxMmI767P6
         XyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grd1rakogw2BEn4tAE432N08EqUy4BjMhxHYtZmywo4=;
        b=YHP4jNOcfHRK7z0UxOf7DF07K0Lwe9SCcAofJmvheHwqVS1z+X+SsJnI5YzlHEynw/
         EAMV6v+k3mVNQrYUhQjhtXCq5eKTKMdem2lVPlUwlFP6fANie/mLczy+CbBV+52SYrrM
         08uzdoecpU+YZ0w7+aJjBcWgU3lc0d3aNHYgsmPRv7i4+5E1mDPXeyjIe1qgi7Ttsu65
         YO8D+SDMqx1uckqEgdd1/16fE2rIl4RnGoLp7Dg81m7BSdRn5rSuenyDRCLzT6XwS/yO
         8RRHI7LPNtn/zQntuTo5Dp6AQzJCFcEOJ2IgF9HnZ+65GyZKxWua2pVoONn5Fc/vh+v3
         S7Bg==
X-Gm-Message-State: APjAAAWuqaTo5m95rrU+69b/JkeZshZ0KkNyteK9go9t8N0GcYBk3qU3
        E5BbXnWgAMlQYLzT5qnZg/A=
X-Google-Smtp-Source: APXvYqx5QiYPCh/OEvK9vTgkiwrPVEZ8QFbFvMiFCda72UL+2WFQIuxLpLsm6mCu4ayYTYKU+DFs4Q==
X-Received: by 2002:a92:6e09:: with SMTP id j9mr28712626ilc.178.1575944893656;
        Mon, 09 Dec 2019 18:28:13 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l9sm334052ioh.77.2019.12.09.18.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:28:13 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v4 08/16] dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
Date:   Mon,  9 Dec 2019 19:27:34 -0700
Message-Id: <20191210022742.822686-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210022742.822686-1-jim.cromie@gmail.com>
References: <20191210022742.822686-1-jim.cromie@gmail.com>
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

