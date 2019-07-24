Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70316C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE9722ADB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997291;
	bh=GxwN1mmkCycNO3fHNV+ZrdYXA6d6xmqH0Z4BO14KspE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=plMBhmh1wpxIGX4wDVY9xjZ+07XJsdxcNWcE32Mtxc6tS1JO+EQ4uJ7Y1NZJzHrfL
	 S9VVMirKg5p1eC6eR8k4KyEfGpmy2uvoXwKGeBWRvbkzjDnO0+uYBT+qBkONK4Xu0K
	 Nbg++CC6f+UutUdwzN9VK0x4j7RiGROqf/2asTp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390197AbfGXTl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390178AbfGXTlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:41:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71F9B2083B;
        Wed, 24 Jul 2019 19:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997284;
        bh=GxwN1mmkCycNO3fHNV+ZrdYXA6d6xmqH0Z4BO14KspE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1f5ajdp93+UPKPK5tURNCa6L+3xEjZTQkd/Ptg/0IetZmDf+emOUtM95rOY93/i5
         Vz/vriE30ZV+L8G9hKbNB3GMzuWnytOo3MIlok0+o0S07L4MuZyz/+9CggiOvsRjOd
         FLXYA0ASA2v/GCQKB1g+Z1E8vZkXHVshDymMxE/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Drew Davenport <ddavenport@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.2 381/413] include/asm-generic/bug.h: fix "cut here" for WARN_ON for __WARN_TAINT architectures
Date:   Wed, 24 Jul 2019 21:21:12 +0200
Message-Id: <20190724191802.355654185@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Drew Davenport <ddavenport@chromium.org>

commit 6b15f678fb7d5ef54e089e6ace72f007fe6e9895 upstream.

For architectures using __WARN_TAINT, the WARN_ON macro did not print
out the "cut here" string.  The other WARN_XXX macros would print "cut
here" inside __warn_printk, which is not called for WARN_ON since it
doesn't have a message to print.

Link: http://lkml.kernel.org/r/20190624154831.163888-1-ddavenport@chromium.org
Fixes: a7bed27af194 ("bug: fix "cut here" location for __WARN_TAINT architectures")
Signed-off-by: Drew Davenport <ddavenport@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/asm-generic/bug.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -104,8 +104,10 @@ extern void warn_slowpath_null(const cha
 	warn_slowpath_fmt_taint(__FILE__, __LINE__, taint, arg)
 #else
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
-#define __WARN()		__WARN_TAINT(TAINT_WARN)
-#define __WARN_printf(arg...)	do { __warn_printk(arg); __WARN(); } while (0)
+#define __WARN() do { \
+	printk(KERN_WARNING CUT_HERE); __WARN_TAINT(TAINT_WARN); \
+} while (0)
+#define __WARN_printf(arg...)	__WARN_printf_taint(TAINT_WARN, arg)
 #define __WARN_printf_taint(taint, arg...)				\
 	do { __warn_printk(arg); __WARN_TAINT(taint); } while (0)
 #endif


