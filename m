Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241F6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78C72082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDJUkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:40:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38383 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJUkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:40:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3AKeMqx925710
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Apr 2019 13:40:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3AKeLV6925706;
        Wed, 10 Apr 2019 13:40:21 -0700
Date:   Wed, 10 Apr 2019 13:40:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rasmus Villemoes <tipbot@zytor.com>
Message-ID: <tip-899cbdfa8d147c873fe4e66c38d2cca3c1ac6286@git.kernel.org>
Cc:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org,
        linux@rasmusvillemoes.dk, keescook@chromium.org,
        willy@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, bp@suse.de, willy@infradead.org,
          keescook@chromium.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, linux@rasmusvillemoes.dk, mingo@kernel.org
In-Reply-To: <20190405045711.30339-1-bp@alien8.de>
References: <20190405045711.30339-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/core] overflow.h: Add comment documenting __ab_c_size()
Git-Commit-ID: 899cbdfa8d147c873fe4e66c38d2cca3c1ac6286
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  899cbdfa8d147c873fe4e66c38d2cca3c1ac6286
Gitweb:     https://git.kernel.org/tip/899cbdfa8d147c873fe4e66c38d2cca3c1ac6286
Author:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
AuthorDate: Wed, 10 Apr 2019 22:27:25 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 10 Apr 2019 22:35:47 +0200

overflow.h: Add comment documenting __ab_c_size()

__ab_c_size() is a somewhat opaque name. Document its purpose, and while
at it, rename the parameters to actually match the abc naming.

 [ bp: glued a complete patch from chunks on LKML. ]

Reported-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>
Link: https://lkml.kernel.org/r/20190405045711.30339-1-bp@alien8.de
---
 include/linux/overflow.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 40b48e2133cb..6534a727cadb 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -278,11 +278,15 @@ static inline __must_check size_t array3_size(size_t a, size_t b, size_t c)
 	return bytes;
 }
 
-static inline __must_check size_t __ab_c_size(size_t n, size_t size, size_t c)
+/*
+ * Compute a*b+c, returning SIZE_MAX on overflow. Internal helper for
+ * struct_size() below.
+ */
+static inline __must_check size_t __ab_c_size(size_t a, size_t b, size_t c)
 {
 	size_t bytes;
 
-	if (check_mul_overflow(n, size, &bytes))
+	if (check_mul_overflow(a, b, &bytes))
 		return SIZE_MAX;
 	if (check_add_overflow(bytes, c, &bytes))
 		return SIZE_MAX;
