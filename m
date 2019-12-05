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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9D3C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84D521835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6HuTKaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbfLEVxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:53:05 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:46375 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbfLEVw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:28 -0500
Received: by mail-il1-f193.google.com with SMTP id t17so4346801ilm.13;
        Thu, 05 Dec 2019 13:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q2tEW7FTsA73HHhNSU6k3P4LajEnR3VGBalEePUDQOw=;
        b=g6HuTKaYBp1L2eaffybIkMAm1FWjqz3D7YHu5fG8iLoCdE17h2tAsk6sOsYCL4SvYa
         1YQGuQ69F6J50BNAsrhIQ2UGnFTeXNKtzzXhWjJDfwIqyHn4phelGg2X7whbVBbKpI2T
         U1mR0BIEQSVhUS6Erswku99pW5gs/dkpFxCJIHtrFkIRCQqHRdYKl6mAWuCxE/dLlcQ4
         BT1gGoZG03t6PqPIObp/2jrt2AXqkBgl4bW/IEPDt5uc9AN7xZHQO+AwskbW3/MR5Bnc
         OTTeeb3xrAwa0fGXotrhIq0M0pQKFo+mZO4Xc4sNde5BJw7AxW3XQx/ONgjAd0iBXfle
         osLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q2tEW7FTsA73HHhNSU6k3P4LajEnR3VGBalEePUDQOw=;
        b=Xn62MXg+n5/zxFg2iP+ChJgRSSm38O7bsbSC5o3k9Oym2u3fTIY/OqGJQz7xvMaD2S
         62oU0+1CJnS6htQTeWQ6j9qsBFpi7IlpHxWrZEy6UAgiYXaKlEnz8gtFIDs5Fa08CpbE
         Z+uP+4+FaC4M1TrGWEhpg6rq95ji8PgTN4Xp12C30CDgUI6Ynu1Drld59YUgU4cTS9Nz
         Jr6Nnl0WM2RrXdO1jFQ/w2hGFmDVqzQ4MEXdb1bEwCYuh0BTEK80w+YjdiK106HrG9Sg
         ww2gnTOpJjmPir7svdjfjIXPwggc7F/5gg4R3l18NNv7ZSl79BFx20Sqgu1eap3A5Sgr
         vkpA==
X-Gm-Message-State: APjAAAW1ezmVWASEWGhXkYE+ezbaIETKcY3pHHqjipQWFkNyTlxcfZZt
        zFDk2PGeudAXYHElN8fdzXI=
X-Google-Smtp-Source: APXvYqxXuYk8Wn951Eh+wLzIXTSnX8rANm+b3r6adJMiIJaC3qZFjyF2KnVguNhL/su+qJTXOlqVTQ==
X-Received: by 2002:a92:258e:: with SMTP id l136mr11603897ill.225.1575582747698;
        Thu, 05 Dec 2019 13:52:27 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:27 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 14/16] dyndbg: add inverted-flags, implement filtering on flags
Date:   Thu,  5 Dec 2019 14:51:45 -0700
Message-Id: <20191205215151.421926-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add 3 user-flags [xyz] which work like original [pfmlt] flags, but
have no effect on callsite behavior; they allow marking of arbitrary
sets of callsites.  Just adding the flag defs themselves is enough,
they inherit the existing flags mechanics.

2. Add [PFMLT],[XYZ] flags, which invert their counterparts; P===!p etc.
And in ddebug_read_flags():
   current code does:	[pfmlt_xyz] -> flags
   copy it to:		[PFMLT_XYZ] -> mask
also disallow both of a pair: ie no 'xX', no true & false.

3. Add filtering ops into ddebug_change(), right after all the
callsite-property selections are complete.  These test the callsite's
current flagstate before applying modflags.

Why ?

The 3 new/user flags facilitate batching of changes.  By marking
individual callsites with 'xyz', user can compose an arbitrary set of
changes, then activate them together by selecting on 'xyz':

  #> echo 'file foo.c +xyz; file bar.c +xyz' > control
  #> echo 'xyz+p' > control

These user flags aren't strictly needed, but with them you can avoid
using [fmlt] flags for marking, which would alter logging.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 28 ++++++++++++++--
 include/linux/dynamic_debug.h                 |  3 ++
 lib/dynamic_debug.c                           | 33 ++++++++++++++-----
 3 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index cdc45dcb3e0c..5404e23eeac8 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -231,9 +231,33 @@ The flags are::
   m    Include module name in the printed message
   t    Include thread ID in messages not generated from interrupt context
   _    No flags are set. (Or'd with others on input)
+  x    user flag, to mark callsites into a group
+  y    user flag, ...
+  z    user flag, ...
 
-For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only ``p`` flag
-have meaning, other flags ignored.
+Additionally, the flags above have upper-case versions, which invert
+their respective meanings.  Their use follows.
+
+Using Filters::
+
+Filter-flags specify an optional additional selector on pr_debug
+callsites; with them you can compose an arbitrary set of callsites, by
+iteratively marking them with ``+xyz``, then enabling them all with
+``xyz+p``.
+
+Filters can also contain upper-case flags, like ``XY``, which select
+only callsites with x&y cleared.
+
+Flagsets cannot contain ``xX`` etc, a flag cannot be true and false.
+
+modflags containing upper-case flags is reserved/undefined for now.
+inverted-flags are currently ignored, usage gets trickier if given
+``-pXy``, it should leave x set.
+
+Notes::
+
+For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
+``p`` flag has meaning, other flags are ignored.
 
 For display, the flags are preceded by ``=``
 (mnemonic: what the flags are currently equal to).
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 802480ea8708..0d7c9a3538b6 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -32,6 +32,9 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+#define _DPRINTK_FLAGS_USR_X		(1<<5)
+#define _DPRINTK_FLAGS_USR_Y		(1<<6)
+#define _DPRINTK_FLAGS_USR_Z		(1<<7)
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
 #else
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 26432f88b329..b2630df0c3a5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -85,13 +85,16 @@ static inline const char *trim_prefix(const char *path)
 	return path + skip;
 }
 
-static struct { unsigned flag:8; char opt_char; } opt_array[] = {
-	{ _DPRINTK_FLAGS_PRINT, 'p' },
-	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
-	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
-	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
-	{ _DPRINTK_FLAGS_INCL_TID, 't' },
-	{ _DPRINTK_FLAGS_NONE, '_' },
+static struct { unsigned flag:8; char opt_char, not_char; } opt_array[] = {
+	{ _DPRINTK_FLAGS_PRINT,		'p', 'P' },
+	{ _DPRINTK_FLAGS_INCL_MODNAME,	'm', 'M' },
+	{ _DPRINTK_FLAGS_INCL_FUNCNAME,	'f', 'F' },
+	{ _DPRINTK_FLAGS_INCL_LINENO,	'l', 'L' },
+	{ _DPRINTK_FLAGS_INCL_TID,	't', 'T' },
+	{ _DPRINTK_FLAGS_NONE,		'_', '_' },
+	{ _DPRINTK_FLAGS_USR_X,		'x', 'X' },
+	{ _DPRINTK_FLAGS_USR_Y,		'y', 'Y' },
+	{ _DPRINTK_FLAGS_USR_Z,		'z', 'Z' },
 };
 
 /* format a string into buf[] which describes the _ddebug's flags */
@@ -195,6 +198,13 @@ static int ddebug_change(const struct ddebug_query *query,
 			    dp->lineno > query->last_lineno)
 				continue;
 
+			/* filter for required flags */
+			if ((dp->flags & filter->flags) != filter->flags)
+				continue;
+			/* filter on prohibited bits */
+			if ((~dp->flags & filter->mask) != filter->mask)
+				continue;
+
 			nfound++;
 
 			newflags = (dp->flags & mods->mask) | mods->flags;
@@ -428,10 +438,17 @@ static int ddebug_read_flags(const char *str, struct flagsettings *f)
 			if (*str == opt_array[i].opt_char) {
 				f->flags |= opt_array[i].flag;
 				break;
+			} else if (*str == opt_array[i].not_char) {
+				f->mask |= opt_array[i].flag;
+				break;
 			}
 		}
 		if (i < 0) {
-			pr_err("unknown flag '%c' in \"%s\"\n", *str, str);
+			pr_err("unknown flag '%c'", *str);
+			return -EINVAL;
+		}
+		if (f->flags & f->mask) {
+			pr_err("flag '%c' conflicts with earlier one\n", *str);
 			return -EINVAL;
 		}
 	}
-- 
2.23.0

