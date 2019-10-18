Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E156CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6288E21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PY3/Po/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504734AbfJRHv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:51:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504683AbfJRHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Oj8zH6+/xCj/G3jY2+2E8ub8KpY3i+WGmGVOUbOAPRc=; b=PY3/Po/hwir1kh1R/h4t+RVLSw
        hnRLNixNOEgWbNO1gtAlXzn6TttzbNRm+k2wCAOwsj9srT5yqtq/DQz758eksy68ffzTrNVFtqgUk
        F3/TfrCpOu+1Q/uRbQgL2U8J2QNG3aV1PHy0Ty6BcM69TXocjdyGUzrnC6AlsYUiLzbSvt5o8mwjM
        QYhBtzCmHTTUzfbGypn7XeI18gpKrY0n+59VB9A44yZzDmYLo3o82gH+bLD6GTmtE3ikRT97Tj5Ej
        u5nHIFFGcrJl9twpjW87VsVgTWBGq2Y5LDXYcJ52QVBch/rhaDTLAV9Z7M50+6ev3lPF5gDuTsRv4
        REmEVwdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLN2d-0001PE-2S; Fri, 18 Oct 2019 07:51:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26B29306BF0;
        Fri, 18 Oct 2019 09:50:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6BF102B17811B; Fri, 18 Oct 2019 09:51:15 +0200 (CEST)
Message-Id: <20191018074634.801435443@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 18 Oct 2019 09:35:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org
Subject: [PATCH v4 15/16] module: Move where we mark modules RO,X
References: <20191018073525.768931536@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that set_all_modules_text_*() is gone, nothing depends on the
relation between ->state = COMING and the protection state anymore.
This enables moving the protection changes later, such that the COMING
notifier callbacks can more easily modify the text.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jessica Yu <jeyu@kernel.org>
---
 kernel/module.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3683,10 +3683,6 @@ static int complete_formation(struct mod
 	/* This relies on module_mutex for list integrity. */
 	module_bug_finalize(info->hdr, info->sechdrs, mod);
 
-	module_enable_ro(mod, false);
-	module_enable_nx(mod);
-	module_enable_x(mod);
-
 	/* Mark state as coming so strong_try_module_get() ignores us,
 	 * but kallsyms etc. can see us. */
 	mod->state = MODULE_STATE_COMING;
@@ -3852,6 +3848,10 @@ static int load_module(struct load_info
 	if (err)
 		goto bug_cleanup;
 
+	module_enable_ro(mod, false);
+	module_enable_nx(mod);
+	module_enable_x(mod);
+
 	/* Module is ready to execute: parsing args may do that. */
 	after_dashes = parse_args(mod->name, mod->args, mod->kp, mod->num_kp,
 				  -32768, 32767, mod,


