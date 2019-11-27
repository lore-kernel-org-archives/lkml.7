Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3585C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BB9206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sd60D36c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfK0Rv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:51:56 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:35662 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfK0Rv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:51:56 -0500
Received: by mail-io1-f50.google.com with SMTP id x21so25868637ior.2;
        Wed, 27 Nov 2019 09:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkTFpkb5r8yGg3ZllYhT/TfhMsW8y8XB6bOw4rnyvIg=;
        b=sd60D36c3gKuRUo0c8JHhGZ4Mv/X9usffrUt7h6oIqM8CZx40W4OEKCQayAkHzC3sE
         ADP8ol7roUh4s4QFwoFnDHq+7Kex/I/kSJ7q3IUvQ7PRFjEvAHIyS2RSXhC/597uD9Vx
         NvYuD2Lvkcva3ooK5lwqd8GnVn/lBLewB7rwzdVGUGCLRzAF5evrVvfYAw+JmZNQ+qZd
         Or0afYsOX9H+GpRZF65iDEgi3V4mquV5aVk+Q0WPjeLbQiV0IN99JIpEpejlIfe9egwj
         ZMpxtdcP/bvECZg/dpxnCwVuEcdJj8v4pejac45n9Y+kq9VCm4pJqyAS8kK2Hk1g9U2u
         h76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xkTFpkb5r8yGg3ZllYhT/TfhMsW8y8XB6bOw4rnyvIg=;
        b=b9ESC0Xlse+PhPa1Aaze77JEAJioUlq50FAazkrzqsLLVt8YwdFZdxJz46JUx50rkv
         GrdWJTlziJrvqzcKwvP6fcDM5iEfCStdp1wPbKCwEXlBZv6lh6Ayq5TLPQUqHCEVCR23
         Wz8UJuYhUlpVo0x9zkn20R4ToU/zVXz28xEdSfFhqzSXyZfJ07FzaYsXTX8HkhYAycQD
         ogul/UVgP94qJHsYTRPcO0smP9iBK1phv2NVNJp81FaDLjVVlTmIP7y5C/upiPNFLtnT
         SPTn72z8kjddf74o0MDGEkyMgUYsFj8vhOWRrlV1EysY9a2O6hrWY6hThuzfLaf0Y5sH
         Jm9g==
X-Gm-Message-State: APjAAAXQ0qcdslSOkpc1vVwB6VOnjL3GBP0wlLxmm5eeSRl7I6XaZ5tG
        QKhTa5V/gqLNpbzk0auMvV0=
X-Google-Smtp-Source: APXvYqzAAhmy4HRWKkl4v8JsQijaLV6aRF80X+52bCol8elZ+6Jq69LpKTIzKi9EU1SsFQFevDMlWA==
X-Received: by 2002:a5d:958d:: with SMTP id a13mr36252257ioo.144.1574877115174;
        Wed, 27 Nov 2019 09:51:55 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id j79sm4588510ila.70.2019.11.27.09.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:51:54 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 15/16] dyndbg: allow inverted-flag-chars in modflags
Date:   Wed, 27 Nov 2019 10:51:50 -0700
Message-Id: <20191127175151.1351999-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend flags modifications to allow [PFMLT_XYZ] inverted flags.
This allows control-queries like:

  #> Q () { echo file inode.c $* > control } # to type less
  #> Q -P	# same as +p
  #> Q +X	# same as -x
  #> Q xyz-P	# same as xyz+p

This allows flags in a callsite to be simultaneously set and cleared,
while still starting with the current flagstate (with +- ops).
Generally, you chose -p or +p 1st, then set or clear flags
accordingly.

  # enable print on callsites with 'xy'; and re-mark with just 'z'
  #> Q xy+pXYz

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 8 +++++---
 lib/dynamic_debug.c                               | 6 ++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 5404e23eeac8..493e74a14bdd 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -250,9 +250,11 @@ only callsites with x&y cleared.
 
 Flagsets cannot contain ``xX`` etc, a flag cannot be true and false.
 
-modflags containing upper-case flags is reserved/undefined for now.
-inverted-flags are currently ignored, usage gets trickier if given
-``-pXy``, it should leave x set.
+modflags may contain upper-case flags also, using these lets you
+invert the flag setting implied by the OP; '-pX' means disable
+printing, and mark that callsite with usr-x flag to create a group,
+for optional further manipulation.  Generally, '+p' and '-p' is your
+main choice, and use of inverted flags in modflags is rare.
 
 Notes::
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b2630df0c3a5..82daf95b8f64 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -488,15 +488,17 @@ static int ddebug_parse_flags(const char *str,
 
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

