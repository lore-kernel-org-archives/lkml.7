Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B6ECA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170FF20656
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPew8o4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfJ2UAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:00:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42124 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfJ2UAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:00:55 -0400
Received: by mail-io1-f65.google.com with SMTP id k1so7208659iom.9;
        Tue, 29 Oct 2019 13:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvArWGhaU3mTjk6yI7cEpfbsp4jj50oWV3j4D4Y3qm4=;
        b=ZPew8o4v1dMjAZcJzqogz3r9chMp7On4fSf54JrX+aKyfqNuT2yeN/pCksOIpOKemD
         HRPXg9yb77KrAnw7zn5uUKpHPbhGVBXxP060iim/NzyBrA5hwjRak19EnCm/RZ5SCHLv
         CTfLJqpPchduxuLcNviu+BR0A34doL+TZteVYjetCiNDI886umK4im4rU7dcEiCj6Bv3
         uKef+HG4wmkhd/Oy0htACWPaVNDir+5KjDKb6Gp/+GCNggffs01+NkM/FkXwhWYVaV1J
         HwWnkLQ3Fh5ZVMCU5rtBuGWyom2iUUqDMz4fSKB73wUHG1lxy3af2BkixDul0DJN5Qzh
         /38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvArWGhaU3mTjk6yI7cEpfbsp4jj50oWV3j4D4Y3qm4=;
        b=NOBTpjL/ol5qB6Gqjd3rwsjAP/4RKlVJEwdR3xameh1E9gl4P7p9oaCuYXwM2BYwFs
         1vERhKGsKKNSTc1+tBs6NSXhjMNamPbEMhKRTMHw5n03+R0GKykXOcWeMKhSOvq9LiX1
         Tg6QtKrM94UDXF3bSSExf4AITInXA+YNHMmPOY0ojSt2mQ7joI2zUyEqdWDzFqyX+Pyx
         E+XSKFxDo/FCKqzqnVA3a9DbaIx+YmORyFIwb6S/UcfIaOg5C4xWpHeVOYi9udQidNaO
         jR7C/rZ66a2s67vRMXEHZnrNrwMra85vKjb87jXXUOo5SALmZ3xk3AZalgfUNVOZuR3v
         Cjlw==
X-Gm-Message-State: APjAAAWP/UCTcMhKIAsfhEtWPvCaAew1ThaSLy4YTmnvsfwDZnZq55lT
        Rxi4Uy80iZ9kx2R6oq9Zk0c=
X-Google-Smtp-Source: APXvYqwxssFkdTlSpTyssBdzhfnyKrnZjQygMWzcc3BHxQ89dfb4ScfcLZWK5vON/R5CR1VKqFxrTA==
X-Received: by 2002:a5e:8f0b:: with SMTP id c11mr6050547iok.102.1572379254167;
        Tue, 29 Oct 2019 13:00:54 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t23sm2117ioc.26.2019.10.29.13.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:00:53 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: [PATCH 09/16] dyndbg: accept 'file foo.c:func1' and 'file foo.c:10-100'
Date:   Tue, 29 Oct 2019 14:00:46 -0600
Message-Id: <20191029200047.10037-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
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
index 2d0aad5af972..1b65821162e5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -307,6 +307,8 @@ static int parse_linerange(struct ddebug_query *query, const char *first)
 	} else {
 		query->last_lineno = query->first_lineno;
 	}
+	vpr_info("parsed line %d-%d\n", query->first_lineno,
+		 query->last_lineno);
 	return 0;
 }
 	
@@ -343,6 +345,7 @@ static int ddebug_parse_query(char *words[], int nwords,
 {
 	unsigned int i;
 	int rc = 0;
+	char *fline;
 
 	/* check we have an even number of words */
 	if (nwords % 2 != 0) {
@@ -359,7 +362,22 @@ static int ddebug_parse_query(char *words[], int nwords,
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
2.21.0

