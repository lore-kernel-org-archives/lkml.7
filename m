Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF0BC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B7C20815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfEPQFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:05:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42396 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbfEPP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:58:41 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hRImD-0006z0-J8; Thu, 16 May 2019 16:58:37 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hRImD-0001Nq-04; Thu, 16 May 2019 16:58:37 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Jason Baron" <jbaron@akamai.com>
Date:   Thu, 16 May 2019 16:55:33 +0100
Message-ID: <lsq.1558022133.157799232@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 19/86] locking/static_keys: Fix up the static keys
 documentation
In-Reply-To: <lsq.1558022132.52852998@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.68-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Corbet <corbet@lwn.net>

commit 1975dbc276c6ab62230cf4f9df5ddc9ff0e0e473 upstream.

Fix a few small mistakes in the static key documentation and
delete an unneeded sentence.

Suggested-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20150914171105.511e1e21@lwn.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/static-keys.txt |  4 ++--
 include/linux/jump_label.h    | 10 ++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

--- a/Documentation/static-keys.txt
+++ b/Documentation/static-keys.txt
@@ -15,8 +15,8 @@ The updated API replacements are:
 
 DEFINE_STATIC_KEY_TRUE(key);
 DEFINE_STATIC_KEY_FALSE(key);
-static_key_likely()
-static_key_unlikely()
+static_branch_likely()
+static_branch_unlikely()
 
 0) Abstract
 
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -21,8 +21,8 @@
  *
  * DEFINE_STATIC_KEY_TRUE(key);
  * DEFINE_STATIC_KEY_FALSE(key);
- * static_key_likely()
- * static_key_unlikely()
+ * static_branch_likely()
+ * static_branch_unlikely()
  *
  * Jump labels provide an interface to generate dynamic branches using
  * self-modifying code. Assuming toolchain and architecture support, if we
@@ -45,12 +45,10 @@
  * statement, setting the key to true requires us to patch in a jump
  * to the out-of-line of true branch.
  *
- * In addtion to static_branch_{enable,disable}, we can also reference count
+ * In addition to static_branch_{enable,disable}, we can also reference count
  * the key or branch direction via static_branch_{inc,dec}. Thus,
  * static_branch_inc() can be thought of as a 'make more true' and
- * static_branch_dec() as a 'make more false'. The inc()/dec()
- * interface is meant to be used exclusively from the inc()/dec() for a given
- * key.
+ * static_branch_dec() as a 'make more false'.
  *
  * Since this relies on modifying code, the branch modifying functions
  * must be considered absolute slow paths (machine wide synchronization etc.).

