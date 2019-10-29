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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399DCCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089C920656
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3sbd4Oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfJ2UBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:01:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45064 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfJ2UBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:01:50 -0400
Received: by mail-io1-f67.google.com with SMTP id s17so9073953iol.12;
        Tue, 29 Oct 2019 13:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z4hr0FMxfA+kYkgm3Ro1D5BbnteVX2yo0/0yuGrjRdA=;
        b=X3sbd4OeC6FrppO2Pg9wCkdRUI39oEJdQ5xobYASHaOm4HesmYJUMjOyJAhRipuYJM
         atctOwga15+8JWc/HVovyN2m62TFr8c5jEo8pc8b1cjjuB2T7HBKX5vF4cmXBAYG/5qZ
         FBjO+3udauyMc1aui3GghRNXt7a+cDSgmKvtkKR1sUA5JGsC4Yd14iInGkLVZxrQODdS
         sJWqjwy7So4b5V4D8EwtHaXYS4pzXPXOH/AIT/MlAApxYlnD7SKKQe/8gf6Sik3+ZsKi
         gRtEGtvbgPnZ7mwyDSYVBk4GPLp5UAlk6ct2pzcWfrUljmTv64jW43tSxmsyda8Q3Roz
         5cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z4hr0FMxfA+kYkgm3Ro1D5BbnteVX2yo0/0yuGrjRdA=;
        b=Py98NmrpLbkQ8lBPy4I+4ILIDdQQFNcis3f9Jqw0j+biZ5BxBBjxoDniWakHJzMZVA
         KnOo0FRZWTBKCisoGh/qo2CzY6MVgWYIUbGkCWinsjMNy7q1U1H9lqZlV3LoZ387Odq1
         eqNzIJUKL6nmBS4VayiHuk9OiXPOxb6pDKtSdNjF9M5SXJpddpR7JGqumK3MmXfhEAO2
         PpxXIB0CL6avE5oE+8x4s8i8PHk2nU3fLGN/vBwlnJuMcw5SlWV4WxDUEwt5uTjFSij0
         drdWOhyu+btIy/xEFmmfDeUKENpDI+A3bGgVqpXa4FehdU+yp1zJr/vZ+vMWixWxhq1H
         SbRw==
X-Gm-Message-State: APjAAAViX+m/pM01G7w+s0t90Ysb61wX4xXnAMGgwPLBD8Y62I4d3uVW
        SFSpdCAs1tH6quvjmMH3Rjc=
X-Google-Smtp-Source: APXvYqyMz+67RLhk7pF+qzmwP5hCboAVMJ8/07pniVOZwFDC7MWPvU60FwI6qHGFlmhU/9kyw/yBxw==
X-Received: by 2002:a6b:5503:: with SMTP id j3mr5643169iob.151.1572379309543;
        Tue, 29 Oct 2019 13:01:49 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l24sm3615ioh.6.2019.10.29.13.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:01:48 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: [PATCH 16/16] dyndbg: allow inverted-flag-chars in modflags
Date:   Tue, 29 Oct 2019 14:01:42 -0600
Message-Id: <20191029200143.10421-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
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
index f1ff7e30753e..4e14fc588b4d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -474,15 +474,17 @@ static int ddebug_parse_flags(const char *str,
 
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
2.21.0

