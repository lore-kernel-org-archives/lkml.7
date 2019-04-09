Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D1EC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0397120883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 21:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dLrB8M3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDIV0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:26:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37147 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfDIVZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 17:25:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id l20so135749edv.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 14:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=egu/ShKNB6lPlRGpHkDqNDnUlrXghqZM5FQYZ1eQ3vo=;
        b=dLrB8M3ypxu3nnmBeKkwwj+n6jmQPQGAU8J82Q4SzFmJPCnpcNXG8P7bXfB7+UJ+fA
         KppAylZAFQHhEJU/k+sjdHEqoiU4A7i4s3Z9JK9LCGU127fw+RTnWvXH1I4Oqt1P7x+9
         9FQA3fXo2niLP+nDPJAEDpfBuknYxLHLn++I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=egu/ShKNB6lPlRGpHkDqNDnUlrXghqZM5FQYZ1eQ3vo=;
        b=JN92XXcNHWrQGzuJv5qFe+ioIraWgHXyadWmuc5sAsobZj7OYRRpSkAZa7HmP3VzrH
         AOxtWW/w3ArqhXaFHxC/QIfIXWl8ZI07T64MOEtBNAyokP95KKjpXVurI9BduFKDgqpF
         atzdcaApwENIGsX/v+PQtpg8j7paWWuOi7bWvlhsElAAcbyoTcsyvk/Y1sxf7hUgrd6+
         u/Xhys79FqE6XabeCSWfM9DpiXmmNc05RPjJzmjpqncOurNButj2NJMmgWw202cuQ7Hy
         mnDezf0Wo0FkeTNGCC0xTGPdtIWRsN9VVtxrxLcQkASBy0UhsaCuOeadAYYu2tPLshte
         Ze7w==
X-Gm-Message-State: APjAAAX9ODqZQTS7OkTej+nk7p2OPHcr4P9zZT2aDyZVcnzp/bWOc3O0
        ekBJ9EwEtPlxdsgQAVkukN3/Ug==
X-Google-Smtp-Source: APXvYqyvHI9nKdGF5RyFv1d01GaNBytneA+jlYKdUJV3Hj41VPnrUy1yoq3pWU1vpUGklmkC6bvxCQ==
X-Received: by 2002:a17:906:19db:: with SMTP id h27mr3401615ejd.4.1554845154084;
        Tue, 09 Apr 2019 14:25:54 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id i26sm3477986ejc.51.2019.04.09.14.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 14:25:53 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 03/10] linux/printk.h: use unique identifier for each struct _ddebug
Date:   Tue,  9 Apr 2019 23:25:10 +0200
Message-Id: <20190409212517.7321-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes on x86-64 later in this series require that all struct _ddebug
descriptors in a translation unit uses distinct identifiers. Realize
that for pr_debug_ratelimited by generating such an identifier via
__UNIQUE_ID and pass that to an extra level of macros.

No functional change.

Acked-by: Petr Mladek <pmladek@suse.com>
Acked-by: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/printk.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index d7c77ed1a4cb..0fcc588db649 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -454,7 +454,7 @@ extern int kptr_restrict;
 /* If you are writing a driver, please use dev_dbg instead */
 #if defined(CONFIG_DYNAMIC_DEBUG)
 /* descriptor check is first to prevent flooding with "callbacks suppressed" */
-#define pr_debug_ratelimited(fmt, ...)					\
+#define _pr_debug_ratelimited(descriptor, fmt, ...)			\
 do {									\
 	static DEFINE_RATELIMIT_STATE(_rs,				\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
@@ -464,6 +464,8 @@ do {									\
 	    __ratelimit(&_rs))						\
 		__dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);	\
 } while (0)
+#define pr_debug_ratelimited(fmt, ...)		\
+	_pr_debug_ratelimited(__UNIQUE_ID(ddebug), fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define pr_debug_ratelimited(fmt, ...)					\
 	printk_ratelimited(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
-- 
2.20.1

