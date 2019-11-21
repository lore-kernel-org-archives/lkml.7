Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBEDC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A471320878
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NJqzhMhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfKUADP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:03:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46456 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfKUADN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:03:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id r18so557111pgu.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 16:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x//g3D21vWGwG/RhBLblP0rKHJ6VZUOUfN3oNVWDiSE=;
        b=NJqzhMhLJICCf5qJMl+TNG+sSEH4R/DlE9aDYaGlbweivfvOOJQa6VQxDYNhcw/U9t
         YZBnJUjG+3AcvvO3yIKNSW4lCAPdVCpA5BPmA1YWjjpzaOAduVif+C5xVk+E/ryM7vd1
         uuTBP5iylemd6FFCSBjIPF1u5PAS9YbOLn9xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x//g3D21vWGwG/RhBLblP0rKHJ6VZUOUfN3oNVWDiSE=;
        b=cHcI1uy9BcyhLJ/jEmZdB0125LY7VVRBs+o7Wl9qW8Knt1WMXvslI8fDr/JmphtdDW
         /WiC+jO91yfjH3N5vSPeGHcK2AzlGEesPZZzu0Mmnh+A5JYK0eSY7oT//ci4/TwZ7eHJ
         l3A1P0sndAnOBizeT6ja0FwiIFIQWQ9DvlKBrigOERCdg1TnTgwMLfhoOZHshJAPNzVF
         V5mwx/u1iInN9VreuZieyooMYPQFye+pFAqFoeMhCcKOU/fg7t9pLHHqHG2BogzrCSIE
         31qgEeswepCxbX+RuUSc/etYkc1IABrpEkqr85gawMZJ/ArDoXd61gr7iBXsg55L/tMb
         N66Q==
X-Gm-Message-State: APjAAAUUemVmuIdVXgeXECu+FSYsHH0joM/fn5oULXqnxObwiVJhixWS
        +mdXWU4VccqALf0V9sCQqTIbvQ==
X-Google-Smtp-Source: APXvYqwStyJTrur6Um6X5gdnLSs05KUM0vEvX7S95Lr4MJfOROwA8QgHHWEsLmoYwK5zC4lSNlbP5Q==
X-Received: by 2002:a63:101:: with SMTP id 1mr6069915pgb.336.1574294592164;
        Wed, 20 Nov 2019 16:03:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r28sm555496pfl.37.2019.11.20.16.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:03:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] docs, parallelism: Fix failure path and add comment
Date:   Wed, 20 Nov 2019 16:03:02 -0800
Message-Id: <20191121000304.48829-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121000304.48829-1-keescook@chromium.org>
References: <20191121000304.48829-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus noted that the failure path didn't correctly exit. Fix this and
add another comment about GNU Make's job server environment variable
names over time.

Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Link: https://lore.kernel.org/lkml/eb25959a-9ec4-3530-2031-d9d716b40b20@rasmusvillemoes.dk
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/jobserver-count | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/jobserver-count b/scripts/jobserver-count
index 0b482d6884d2..6e15b38df3d0 100755
--- a/scripts/jobserver-count
+++ b/scripts/jobserver-count
@@ -24,6 +24,8 @@ try:
 	flags = os.environ['MAKEFLAGS']
 
 	# Look for "--jobserver=R,W"
+	# Note that GNU Make has used --jobserver-fds and --jobserver-auth
+	# so this handles all of them.
 	opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
 
 	# Parse out R,W file descriptor numbers and set them nonblocking.
@@ -53,6 +55,7 @@ os.write(writer, jobs)
 # If the jobserver was (impossibly) full or communication failed, use default.
 if len(jobs) < 1:
 	print(default)
+	sys.exit(0)
 
 # Report available slots (with a bump for our caller's reserveration).
 print(len(jobs) + 1)
-- 
2.17.1

