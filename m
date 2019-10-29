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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B311CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C529820656
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1vH/mlu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfJ2UBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:01:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34449 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfJ2UBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:01:44 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so16219330ion.1;
        Tue, 29 Oct 2019 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L1TEkJlkfejbze2cmAWSKEZZrCX7D12g3/XOLqMQZT8=;
        b=B1vH/mluKwg8S9e6Qz/dagsWFVR3kBZSlzQtIdAzEczJ32iLZ5p8Mer1r85FUht1aT
         v/ad1MONE+9U4fzBZNh584LBvwZZbFmjVDklfaRgAvZhGAMVN+PZKAkURhpJxDq6fUN6
         EEaxO6SPkSfKRz10TkfGcSLZYMPsRegnH+LiNyMOKeuQSvRB95lI6b0//3xkLOGmJW1p
         NxLXnak0OWsquPvpDR7rUY7lKWOpCrN65QZyQnVQgfWA9zqJWk0S7+YIkCTyAMY2lnp6
         baih6FrrcZghrn5ZAP6zfk8H35ROE3ETlYQN290qnlSedIMkwt54FGOkbyvR1QESGMdC
         FPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L1TEkJlkfejbze2cmAWSKEZZrCX7D12g3/XOLqMQZT8=;
        b=RbetobD4l/v+T0vOW5CPv3MOVHnPSugW6lKcc+zTCT5nNdeaoW8hnog11jtmXlmEBK
         79NizMixcZ7eS+904uqX/XYBGrTiN1kd2aBVaiVtMfFEdRUZXy5d8Z0ofe9PG9+oSlq+
         W2aOkh+hQx2QsHqkRXn5uEHFXnC6KHIe32xkB1lVtaXg7xggtUZowPsczp/APbD4XdXx
         8A9AgHa5S2To6Mtxgo11hZP7X19KesPfVbdJrknuI4ilKNJs6E+W0K05RRMl28tkgpdJ
         tzKh/fYS+EJhmVJlp3rtLZF8FkO4kdCeWzovUJOi/L6fbFZrzbitkp7vaQgw3qwgtSmv
         K44g==
X-Gm-Message-State: APjAAAWLtI2prOY5sTOtdDJBht+TF4VcUXxqWCBqh7etwtsswnTQchxG
        3a3Do98/KTGlOW8RyS8+U9C4Ctrkra8=
X-Google-Smtp-Source: APXvYqz+NHtCJ3PnesHnj5LsVp9I7EDYyodjA1sFDaM9sC3RiPNSjW2K7RYJAzQUmJcLQh9uatLhNw==
X-Received: by 2002:a02:c855:: with SMTP id r21mr21081447jao.120.1572379302160;
        Tue, 29 Oct 2019 13:01:42 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id d197sm2345iog.15.2019.10.29.13.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:01:41 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: [PATCH 15/16] dyndbg: add inverted-flags, implement filtering on flags
Date:   Tue, 29 Oct 2019 14:01:33 -0600
Message-Id: <20191029200134.10368-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add 3 user-flags [xyz] which work like original [pfmlt] flags, but
have no effect on callsite behavior.  This is literally just the added
flags, behavior follows other flags.

2. Add [PFMLT],[XYZ] flags, which invert their counterparts; P===!p etc.
And in ddebug_read_flags():
   current code does:	[pfmlt_xyz] -> flags
   reuse as		[PFMLT_XYZ] -> mask
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
 .../admin-guide/dynamic-debug-howto.rst       | 28 +++++++++++++--
 include/linux/dynamic_debug.h                 |  3 ++
 lib/dynamic_debug.c                           | 34 ++++++++++++++-----
 3 files changed, 55 insertions(+), 10 deletions(-)

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
index a829c86364d4..0c099283bf1b 100644
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
index 4369afeb52f0..f1ff7e30753e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -72,13 +72,16 @@ static LIST_HEAD(ddebug_tables);
 static int verbose;
 module_param(verbose, int, 0644);
 
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
@@ -180,6 +183,13 @@ static int ddebug_change(const struct ddebug_query *query,
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
@@ -414,9 +424,17 @@ static int ddebug_read_flags(const char *str, struct flagsettings *f)
 				f->flags |= opt_array[i].flag;
 				break;
 			}
+			else if (*str == opt_array[i].not_char) {
+				f->mask |= opt_array[i].flag;
+				break;
+			}
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
2.21.0

