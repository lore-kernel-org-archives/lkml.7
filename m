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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57203C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281692077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFtyYHNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfLJC2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:28:21 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:39043 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbfLJC2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:28:15 -0500
Received: by mail-il1-f196.google.com with SMTP id n1so185381ilm.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 18:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YaXRbIcfrfy+6sOtLvNoOiV/KR6L6wO+a8T26somqJk=;
        b=dFtyYHNzhMe6d6IIaiqOA6ee19hNaa4K7qvm/44JFK11k9+8axrvaXOdS6W1WZbH0q
         wxBQqEp2kYyG5EO1AjKdxElGiH1nqE6rl5dbJrPYPbzB1376Vs2ZYOJqvjOj/FXAJ/UC
         Lhxe42zmUyvfNcb0a9hhna0vfkB9qp47L60mjwbW4tCr7MAgLjqgGmXCHRImXEMMcRPA
         ETX3dNqLVEc2q8YOFD5qCDCNQn+s16DLIfH2lN+tAYw3pImnblolSQbQtIxvy0lgHSBN
         1Os7GFI7QjQILY6PVZIKvYbYXFXMIxcBYtjkWCyOx3bX0ObmgEZvZGHxFBS1aNxB1YSE
         s0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YaXRbIcfrfy+6sOtLvNoOiV/KR6L6wO+a8T26somqJk=;
        b=Ow8mM6oVPo8EvOgl1k+xOGPoj4vfV3W5opMNNNcGcYkgrFGE87slZNJr7ezTcGMX52
         L19dWLDcz8kEgkpVYqMuQgpg2uI48ZjdKFJKYzcE82VJ5lLzalW+F2wU3xh6v67NX8aO
         qJHoVNQjL+SuB2Erew+8mCbblBKgGp6TMzQbX5SWPx48FK+5Oe6akd/vz1+Xj88fDFuV
         O/sYwSbYphbMhnD9+Mfb/heu5MIMoL4vsWq+2bdhaed+w7adMsZsaTkKmyeW9K7QHcfW
         BAlDcFwF9tgwsIZ1vlk2wzeDppXhzApATB/w9Ll+GURkUHdKgnEaHHpmH6PSnkDr3bbi
         jSmQ==
X-Gm-Message-State: APjAAAUnv3FFi2XLpRZ62xIzumDM32/HpO5otmOg9p2xD6MpA/ldSYWW
        NSSo3GGvFHxQunNIxCCOi3U=
X-Google-Smtp-Source: APXvYqwRxLok7vgLRJeeZvSNSdfs9UQJaW9sr8aiSU31b19BeapSnbR2i//3FAPP7uMZZ4u4rGyFrg==
X-Received: by 2002:a92:9ecb:: with SMTP id s72mr4287119ilk.47.1575944894983;
        Mon, 09 Dec 2019 18:28:14 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l9sm334052ioh.77.2019.12.09.18.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:28:14 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 09/16] dyndbg: refactor ddebug_read_flags out of ddebug_parse_flags
Date:   Mon,  9 Dec 2019 19:27:35 -0700
Message-Id: <20191210022742.822686-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210022742.822686-1-jim.cromie@gmail.com>
References: <20191210022742.822686-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, ddebug_parse_flags accepts [+-=][pflmt_]+ as flag-spec
strings.  If we allow [pflmt_]*[+-=][pflmt_]+ instead, the (new) 1st
flagset can be used as a filter to select callsites, before applying
changes in the 2nd flagset.  1st step is to split out the flags-reader
so we can use it again.

The point of this is to allow user to compose an arbitrary set of
changes, by marking callsites with [fmlt] flags, and then to
activate that composed set in a single query.

 #> echo '=_' > control			# clear all flags
 #> echo 'module usb* +fmlt' > control	# build the marked set, repeat
 #> echo 'fmlt+p' > control		# activate

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9fa6d4eeae5c..839f89b24474 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -414,6 +414,26 @@ static int ddebug_parse_query(char *words[], int nwords,
 	return 0;
 }
 
+static int ddebug_read_flags(const char *str, unsigned int *flags)
+{
+	int i;
+
+	for (; *str ; ++str) {
+		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
+			if (*str == opt_array[i].opt_char) {
+				*flags |= opt_array[i].flag;
+				break;
+			}
+		}
+		if (i < 0) {
+			pr_err("unknown flag '%c' in \"%s\"\n", *str, str);
+			return -EINVAL;
+		}
+	}
+	vpr_info("flags=0x%x\n", *flags);
+	return 0;
+}
+
 /*
  * Parse `str' as a flags specification, format [-+=][p]+.
  * Sets up *maskp and *flagsp to be used when changing the
@@ -424,7 +444,7 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 			       unsigned int *maskp)
 {
 	unsigned flags = 0;
-	int op = '=', i;
+	int op;
 
 	switch (*str) {
 	case '+':
@@ -438,19 +458,8 @@ static int ddebug_parse_flags(const char *str, unsigned int *flagsp,
 	}
 	vpr_info("op='%c'\n", op);
 
-	for (; *str ; ++str) {
-		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
-			if (*str == opt_array[i].opt_char) {
-				flags |= opt_array[i].flag;
-				break;
-			}
-		}
-		if (i < 0) {
-			pr_err("unknown flag '%c' in \"%s\"\n", *str, str);
-			return -EINVAL;
-		}
-	}
-	vpr_info("flags=0x%x\n", flags);
+	if (ddebug_read_flags(str, &flags))
+		return -EINVAL;
 
 	/* calculate final *flagsp, *maskp according to mask and op */
 	switch (op) {
-- 
2.23.0

