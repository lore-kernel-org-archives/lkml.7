Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CEDCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164C62245C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ib8rONFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506112AbfJRU4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 16:56:55 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:38505 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388245AbfJRU4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 16:56:53 -0400
Received: by mail-wm1-f74.google.com with SMTP id n3so3297635wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 13:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2yGsXMIwSm/Oms9K6hm98bhT5jbYAusnTPbiHrrYad0=;
        b=ib8rONFiSdw0BDSG+fxUDZtXMMwPngNeUEA6AjlPYGXaxYKaIGNXfGuedTpaJhacz3
         gWcNXXKa7OPTQXI0awBSIQLQc2NnAlHK3JYKKA1ClYrxoNCNyrmKk6CfE2ZGKCGUWQYg
         x3DQ8eg/T78rQFgfpTotHKHcF+p3HTsr7LwQEfk/a9hmFpyPgSrn4G5HQa8ks8I64jXy
         HEl7wNLMJRNSNi3tN/jIklfJzsAEm1bkWGLbGuKP/qS63rAhQSJr/NKULm1MnFcUHEIu
         SorZARfImxD2SAWZcXHZfp4F76N/wiZdxPenIfXHj4Sqs9iZy4j8D9flN7sigoLW05PH
         6zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2yGsXMIwSm/Oms9K6hm98bhT5jbYAusnTPbiHrrYad0=;
        b=aYc0CaYdyqqZnVLI2USMjWHAEv+qAKy/ba3siPDUPHwapIXC9WwPoBIWsdHbFJLoPe
         vewi85bHjD7Nb9nvZuEbCY7q3WTZbkSuElLdWFmuMHydqinDEsMV/M0f692SN9TEHgMG
         dRB0XQj/GoejKJCeWb45BxCVfqRcTJSpvn1H8ajJRSYe9QNKmkmmcnvnrqGPjc1BbVoU
         egLEASVQwMnv0r3c8vcCJDwuE0IoxnRvTV5kyV+5go2aKXlr5N8XWG5yGwsRzcOXjilY
         ECftFRNB0JNVuVB/d15GDtU1vpB8vwjzlzkxOEo/3RHIDP33wsQdsc6q4oDAVDYgOGlR
         7gmw==
X-Gm-Message-State: APjAAAViudug+lY3yIfLz3OiY0LAfkApvosrpC+hl6+h9UGLuKM2j5qS
        ZeMtz+3MVQEvJ4x4tBwTDZFvKBsItg==
X-Google-Smtp-Source: APXvYqwm/CSefU1WSdV1bcQP44CWNwDtbRYPxtlsoSCbHb/sBn682/brX+Qi6nmw4KJj+tq8Ei8AzOxerQ==
X-Received: by 2002:adf:e38a:: with SMTP id e10mr9805449wrm.348.1571432210347;
 Fri, 18 Oct 2019 13:56:50 -0700 (PDT)
Date:   Fri, 18 Oct 2019 22:56:31 +0200
In-Reply-To: <20191018205631.248274-1-jannh@google.com>
Message-Id: <20191018205631.248274-3-jannh@google.com>
Mime-Version: 1.0
References: <20191018205631.248274-1-jannh@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 3/3] binder: Handle start==NULL in binder_update_page_range()
From:   Jann Horn <jannh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>, jannh@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old loop wouldn't stop when reaching `start` if `start==NULL`, instead
continuing backwards to index -1 and crashing.

Luckily you need to be highly privileged to map things at NULL, so it's not
a big problem.

Fix it by adjusting the loop so that the loop variable is always in bounds.

This patch is deliberately minimal to simplify backporting, but IMO this
function could use a refactor. The jump labels in the second loop body are
horrible (the error gotos should be jumping to free_range instead), and
both loops would look nicer if they just iterated upwards through indices.
And the up_read()+mmput() shouldn't be duplicated like that.

Cc: stable@vger.kernel.org
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/android/binder_alloc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 539385634151..7067d5542a82 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -277,8 +277,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	return 0;
 
 free_range:
-	for (page_addr = end - PAGE_SIZE; page_addr >= start;
-	     page_addr -= PAGE_SIZE) {
+	for (page_addr = end - PAGE_SIZE; 1; page_addr -= PAGE_SIZE) {
 		bool ret;
 		size_t index;
 
@@ -291,6 +290,8 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		WARN_ON(!ret);
 
 		trace_binder_free_lru_end(alloc, index);
+		if (page_addr == start)
+			break;
 		continue;
 
 err_vm_insert_page_failed:
@@ -298,7 +299,8 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		page->page_ptr = NULL;
 err_alloc_page_failed:
 err_page_ptr_cleared:
-		;
+		if (page_addr == start)
+			break;
 	}
 err_no_vma:
 	if (mm) {
-- 
2.23.0.866.gb869b98d4c-goog

