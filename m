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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AADC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DF02466E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHY6KJD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387503AbfLEVwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:37 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:41915 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387465AbfLEVwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:31 -0500
Received: by mail-il1-f193.google.com with SMTP id z90so4381631ilc.8;
        Thu, 05 Dec 2019 13:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xmatraap7utM3UBBXkoOzBBOs4oxtMT13bukNxmEbMs=;
        b=IHY6KJD7bR2BygfLyySCmUZaFKj2FJi7GHSo5ThAazyXT+eWJ/mvfYE4WHetIx34yd
         XUL6kSBYlYSn5Ljpj+/lc+JCOi8jDsoiXUrH7RtDGXTuVKgr7Tcs/k1ZRbfR0PG2Zkkm
         jLExVuXavdsqu7TfoVm7Sbs8tJTI6enCC6595IAC7MFU0ACQ6B4Go5Z+RXo3DE66bs0V
         V5GmiwoTWJtw+jczx1oJSB9dtB0Rdmo/bI74HWzIWCRnWa/JQ3EWbotKvytElDLqNTH2
         SAovt8c50NsAVPFybrYwjA8Mm6oQnjgUdzeUq9x23ogMYjbgqZ1QG3E7A2KCKHynkoQJ
         HdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xmatraap7utM3UBBXkoOzBBOs4oxtMT13bukNxmEbMs=;
        b=JsLSsKLcb+4SZrJqn4tT1M47hy0sASZC7OhzNgS19jF3Wcd1H7nzesT2ln5g4g0URh
         uhQYmmW841nQmy7wtLAkqhez5ydq8RWmS7bWmxyczjieTBp34uDemFPoiy+EMiiJL+za
         aj0eIxA7rU29pTGZGFewxbejjvJQh4lVkgGVY0GQWmpjEBtxstx0vMkGS7TBFt1cJ3cT
         9jiMYsluzTCkr7Mb7gOnhjUvi97XsVb4TxFwRfhITxXLtrOWdNZUzSjCf1XMO8ZyI/hh
         1RA+M+Br0c5J67ioxeGwTgMG3Ms82TgKE6vv2pBwA6CiPp8lyHJJgIwZt01RBvSwXkcJ
         I4nw==
X-Gm-Message-State: APjAAAVejJ05yK+xedMc6klszREWhzMEWST7tiRBcZ4C2Dw0fDRAvOtB
        xnSg2UcPci3X2dn9UWBZj7Y=
X-Google-Smtp-Source: APXvYqz3IvP6RpNHppA6SBNP/EXjSgNn0fD4n1v+ROqfJkFmCv2H1Ut5t5T5AsqUT4u6tj4GmZJqeg==
X-Received: by 2002:a92:3b1b:: with SMTP id i27mr11365745ila.84.1575582750393;
        Thu, 05 Dec 2019 13:52:30 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:29 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 14/18] dyndbg: add user-flag, negating-flags, and filtering on flags
Date:   Thu,  5 Dec 2019 14:51:46 -0700
Message-Id: <20191205215151.421926-16-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add a user-flag [u] which works like original [pfmlt] flags, but
has no effect on callsite behavior; it allows marking of arbitrary
sets of callsites.

2. Add [PFMLTU] flags, which negate their counterparts; P===!p etc.
And in ddebug_read_flags():
   current code does:	[pfmltu_] -> flags
   copy it to:		[PFMLTU_] -> mask

also disallow both of a pair: ie no 'pP', no true & false.

3. Add filtering ops into ddebug_change(), right after all the
callsite-property selections are complete.  These test the callsite's
current flagstate before applying modflags.

Why ?

The new user flag facilitates batching of changes.  By marking
individual callsites with 'u', user can compose an arbitrary set of
changes, then activate them together by selecting on 'u':

  #> echo 'file foo.c +u; file bar.c +u' > control
  #> echo 'u+p' > control

The user flag isn't strictly needed, but with it you can avoid using
[fmlt] flags for marking, which would alter logging when enabled.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       | 31 ++++++++++++++++---
 include/linux/dynamic_debug.h                 |  1 +
 lib/dynamic_debug.c                           | 31 ++++++++++++++-----
 3 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index cdc45dcb3e0c..9f68062ba316 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -230,16 +230,39 @@ The flags are::
   l    Include line number in the printed message
   m    Include module name in the printed message
   t    Include thread ID in messages not generated from interrupt context
+  u    user flag, to mark callsites into a group
   _    No flags are set. (Or'd with others on input)
 
-For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only ``p`` flag
-have meaning, other flags ignored.
+Additionally, the flag-chars ``[pflmtu]`` have negating flag-chars
+``[PFMLTU]``, which invert the meanings above.  Their use follows.
+
+Using Filters::
+
+Filter-flags specify an optional additional selector on pr_debug
+callsites; with them you can compose an arbitrary set of callsites, by
+iteratively marking them with ``+u``, then enabling them all with
+``u+p``.  You can also use ``fmlt`` flags for this, unless the format
+changes are inconvenient.
+
+Filters can also contain the negating flags, like ``UF``, which select
+only callsites with ``u`` and ``f`` cleared.
+
+Flagsets cannot contain ``pP`` etc, a flag cannot be true and false.
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
 
-Note the regexp ``^[-+=][flmpt_]+$`` matches a flags specification.
-To clear all flags at once, use ``=_`` or ``-flmpt``.
+Note the regexp ``^[-+=][flmptu_]+$`` matches a flags specification.
+To clear all flags at once, use ``=_`` or ``-flmptu``.
 
 
 Debug messages during Boot Process
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 802480ea8708..a5d76f8f6b40 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -32,6 +32,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+#define _DPRINTK_FLAGS_USR		(1<<5)
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
 #else
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 26432f88b329..736895efe17d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -85,13 +85,14 @@ static inline const char *trim_prefix(const char *path)
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
+	{ _DPRINTK_FLAGS_USR,		'u', 'U' },
 };
 
 /* format a string into buf[] which describes the _ddebug's flags */
@@ -195,6 +196,13 @@ static int ddebug_change(const struct ddebug_query *query,
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
@@ -428,10 +436,17 @@ static int ddebug_read_flags(const char *str, struct flagsettings *f)
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

