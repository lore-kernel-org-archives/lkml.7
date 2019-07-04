Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65557C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437622189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfGDFzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:55:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:17596 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfGDFzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:55:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 22:55:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,449,1557212400"; 
   d="scan'208";a="164547665"
Received: from pedapalapati-ip.iind.intel.com ([10.106.124.123])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jul 2019 22:55:48 -0700
From:   Nitin Gote <nitin.r.gote@intel.com>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, apw@canonical.com, joe@perches.com,
        keescook@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Nitin Gote <nitin.r.gote@intel.com>
Subject: [PATCH] checkpatch: Added warnings in favor of strscpy().
Date:   Thu,  4 Jul 2019 11:24:43 +0530
Message-Id: <1562219683-15474-1-git-send-email-nitin.r.gote@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added warnings in checkpatch.pl script to :

1. Deprecate strcpy() in favor of strscpy().
2. Deprecate strlcpy() in favor of strscpy().
3. Deprecate strncpy() in favor of strscpy() or strscpy_pad().

Updated strncpy() section in Documentation/process/deprecated.rst
to cover strscpy_pad() case.

Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
---
 This patch is already reviewed by mailing list
 kernel-hardening@lists.openwall.com. Refer below link
 <https://www.openwall.com/lists/kernel-hardening/2019/07/03/4>
Acked-by: Kees Cook <keescook@chromium.org>

 Documentation/process/deprecated.rst | 6 +++---
 scripts/checkpatch.pl                | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 49e0f64..f564de3 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -93,9 +93,9 @@ will be NUL terminated. This can lead to various linear read overflows
 and other misbehavior due to the missing termination. It also NUL-pads the
 destination buffer if the source contents are shorter than the destination
 buffer size, which may be a needless performance penalty for callers using
-only NUL-terminated strings. The safe replacement is :c:func:`strscpy`.
-(Users of :c:func:`strscpy` still needing NUL-padding will need an
-explicit :c:func:`memset` added.)
+only NUL-terminated strings. In this case, the safe replacement is
+:c:func:`strscpy`. If, however, the destination buffer still needs
+NUL-padding, the safe replacement is :c:func:`strscpy_pad`.
 
 If a caller is using non-NUL-terminated strings, :c:func:`strncpy()` can
 still be used, but destinations should be marked with the `__nonstring
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 342c7c7..3d80967 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -595,6 +595,11 @@ our %deprecated_apis = (
 	"rcu_barrier_sched"			=> "rcu_barrier",
 	"get_state_synchronize_sched"		=> "get_state_synchronize_rcu",
 	"cond_synchronize_sched"		=> "cond_synchronize_rcu",
+	"strcpy"				=> "strscpy",
+	"strlcpy"				=> "strscpy",
+	"strncpy"				=> "strscpy, strscpy_pad or for
+	non-NUL-terminated strings, strncpy() can still be used, but
+	destinations should be marked with the __nonstring",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.7.4

