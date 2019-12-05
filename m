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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A80C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457C821835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffaYczkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbfLEVw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:59 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:33231 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbfLEVwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:34 -0500
Received: by mail-il1-f171.google.com with SMTP id r81so4422752ilk.0;
        Thu, 05 Dec 2019 13:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkTFpkb5r8yGg3ZllYhT/TfhMsW8y8XB6bOw4rnyvIg=;
        b=ffaYczkn/kQm7dm/iFZImyt/WYcBEj9KRyZiBUzvm+skncdGrLVtSFy6t3UN5zTJbk
         uKou2USrUqz3Tzbs3t9DPa0As25fXXJVvoglPU6KiVITC7+RX6iFSvMpsfgvhaEEWWEC
         JnxR0iNaw4sqhpNfgNEeJdAJJxZBFdUFfZ9TNtShb5gjDtSe3eYbgGh3E5ltclZUxHSf
         LOAqE4676d9rR8/JOxIlIXqWie9N73hUSTZFFeN51lZUnVvozRkRW+0EeDrB6er//dq+
         71z3lXVqrHg6zya6q9ghiNQeuE8XVxak5YBDHJ+L2EabhhieFpj1ms/1mujGhJQ/X9le
         o5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkTFpkb5r8yGg3ZllYhT/TfhMsW8y8XB6bOw4rnyvIg=;
        b=S9OXaP1KutV+cigNuwNzUIWyS3cHZdDDwSmiYI7b1lJ6M/JJK69LJkrEsp6PMKdv70
         BS+LVp3EP2LPHl80seaBuwd/5tjAdYtLazw4R7a+4kSBKi2ejQ6n4ZWzOGzkw8tdwye6
         x2CRq/qaAJloyJb2KEXiUEt3phjALAYlzzaL2kazsid9nU96Mrwk9kf7Xb8W66CsMhXe
         /RgWtEwb539DfGrmlo2KaE9bkwXEOuA6mOVepOdhhTuoKJ+fHl4CS6Q0ZrcXb+X18+38
         xOopxH6riwg0JaNTyvAsiy9iBSa2ZqGmBHnF5djgY0niGlXTyEPzycbHf7SAir48Vcyx
         FgTA==
X-Gm-Message-State: APjAAAVbv7i+VKD9XQPiVv/zoVJ3J/Mltlm9P+uf6Q3Xcwz4aIAFEcqx
        s1ZJQAqkmtDAveFF18/CEpc=
X-Google-Smtp-Source: APXvYqx+XPYzXvmX0MKUwz9EcptmAZLbCBrEH3P+FfTZmPHw95bvHuPfn7BNJvDtfk1zURFmD+dG3A==
X-Received: by 2002:a92:b604:: with SMTP id s4mr11666899ili.114.1575582752925;
        Thu, 05 Dec 2019 13:52:32 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:32 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 15/16] dyndbg: allow inverted-flag-chars in modflags
Date:   Thu,  5 Dec 2019 14:51:47 -0700
Message-Id: <20191205215151.421926-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
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

