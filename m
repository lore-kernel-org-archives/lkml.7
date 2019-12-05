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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F5C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FFB2466E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOxPNe8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbfLEVwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:40 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44548 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387488AbfLEVwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:36 -0500
Received: by mail-io1-f68.google.com with SMTP id z23so5191703iog.11;
        Thu, 05 Dec 2019 13:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hpIeNO/rrHxqmmLp7RAfiIu08DiGGroLpGDwIlCW7M=;
        b=MOxPNe8WPtSybtjHa0RjD3KJL4IhgjYoRlaEx55/rqpvYo9Ky6IkP8BxUSKa8W//Ul
         PBG3mLdwri+d+vIivintMAMlESZr7QBNgX+YOA+gIimPYIK7mtAPhdDh9zjI9X6cgTy8
         hpkh7n7a3Mv6QLc9k+pMlahHM3SBi/a/fE0hKWOAEPaSVUcQhfKiIR4OqWXPvXm+YyhS
         A6XN6ru7o1ETHZLiBAbpXFeG/QwR/yS+OrF2xV4Q52E2TtUpb9MYk+Gahv/RdbWaCzCw
         7OubreR8PMWUxQJo9r/xnvAmqklOf85y46yPHqKR5/Zl6ay195i+WhsPx0gbg5S7POwy
         OZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hpIeNO/rrHxqmmLp7RAfiIu08DiGGroLpGDwIlCW7M=;
        b=Qe5A5Gt23WUNeQgU6raBeiXMvg3q1Qk6K5mquM7+rx9c1F683kHtOx6XW4ammSqQo9
         ieb+sjAlgBxl9e70TBKgkfKr/TgptoWOxMeikphcpBwQUCdkcKI8KJL3iAeG1pllqCBG
         wZadyCU+TRgFx9LY0t+y1+RI3qbGnjKrYzZ3OeyrHoq0Ngw2EdZQSxv8OzHqI3M5yVQy
         FrH1JyMQLta4LQFhr5tRFMcz1++9cHsJFMUnL3WQyhrYFbDqALD6N1NTy2uwz074gQKS
         oTLJ2swHhQQnqMtbiJZA5SdPtNla3XXAaM8CX0X0oBe02S8/G/VyJVYxgvmkl8mysZwG
         JXug==
X-Gm-Message-State: APjAAAWvvyRrX0576wL7KYiiQTSCqRXC1M6MCmHqtksSHELX8F7EHSMJ
        e55SVtZphasYdtmdTdD3tlMH3eZauis=
X-Google-Smtp-Source: APXvYqxPNCcMlZKwCPlWpIF1OSmY5ID6nrckbjANU//r7OZaeuSpKzUBkXCqcUDfwIGUhTXIGlR9Cw==
X-Received: by 2002:a02:c4da:: with SMTP id h26mr10742177jaj.47.1575582755356;
        Thu, 05 Dec 2019 13:52:35 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:34 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 15/18] dyndbg: allow negating flag-chars in modflags
Date:   Thu,  5 Dec 2019 14:51:48 -0700
Message-Id: <20191205215151.421926-18-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend flags modifications to allow [PFMLTU] inverted flags.
This allows control-queries like:

  #> Q () { echo file inode.c $* > control } # to type less
  #> Q -P	# same as +p
  #> Q +U	# same as -u
  #> Q u-P	# same as u+p

This allows flags in a callsite to be simultaneously set and cleared,
while still starting with the current flagstate (with +- ops).
Generally, you chose -p or +p 1st, then set or clear flags
accordingly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 10 ++++++----
 lib/dynamic_debug.c                               |  6 ++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 9f68062ba316..5c170e49121d 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -249,9 +249,11 @@ only callsites with ``u`` and ``f`` cleared.
 
 Flagsets cannot contain ``pP`` etc, a flag cannot be true and false.
 
-modflags containing upper-case flags is reserved/undefined for now.
-inverted-flags are currently ignored, usage gets trickier if given
-``-pXy``, it should leave x set.
+modflags may contain upper-case flags also, using these lets you
+invert the flag setting implied by the OP; '-pU' means disable
+printing, and mark that callsite with the user-flag to create a group,
+for optional further manipulation.  Generally, '+p' and '-p' is your
+main choice, and use of negating flags in modflags is rare.
 
 Notes::
 
@@ -261,7 +263,7 @@ For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
 For display, the flags are preceded by ``=``
 (mnemonic: what the flags are currently equal to).
 
-Note the regexp ``^[-+=][flmptu_]+$`` matches a flags specification.
+Note the regexp ``/^[-+=][flmptu_]+$/i`` matches a flags specification.
 To clear all flags at once, use ``=_`` or ``-flmptu``.
 
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 736895efe17d..15bb9939df97 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -486,15 +486,17 @@ static int ddebug_parse_flags(const char *str,
 
 	/* calculate final mods: flags, mask based upon op */
 	switch (op) {
+		unsigned int tmp;
 	case '=':
 		mods->mask = 0;
 		break;
 	case '+':
-		mods->mask = ~0U;
+		mods->mask = ~mods->mask;
 		break;
 	case '-':
+		tmp = mods->mask;
 		mods->mask = ~mods->flags;
-		mods->flags = 0;
+		mods->flags = tmp;
 		break;
 	}
 
-- 
2.23.0

