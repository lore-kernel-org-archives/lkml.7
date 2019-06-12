Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2427EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E353B21734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560353778;
	bh=HpcaMDHf6apvppP8x1d2hnvQGsEvTJUrmUraAlHDIJU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=H3+3XxNfGDjKHERXBQ5nG2t+n+sd97Xpu4Pjd2ppuMOgGCLVgqbGCVu3osNXmBn2C
	 46bw+PKnECLPYNxTukekcdoxMoiR9aJ1km/eK70ZFc007Q1IBPmPwZ97Y0KRp45EIF
	 8wqbKE9/i7b001AJzL3OSGyGC7lnsuuU1t4mbNBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409454AbfFLPgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409443AbfFLPgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:36:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 794D7215EA;
        Wed, 12 Jun 2019 15:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560353776;
        bh=HpcaMDHf6apvppP8x1d2hnvQGsEvTJUrmUraAlHDIJU=;
        h=Date:From:To:Cc:Subject:From;
        b=V5i4TYClZNXSEepTT76JWjOsB0zEF+EF5m9+f/JvCOmiWsKnwOdwyjW0w2BwYwVRr
         ECYbjVa4bOvKF9hxwBbkNNeni8VaIWEdMVCvc5cYQMkje62tUzDIUs+YUkZt9Znblm
         7hwuOFvZva7pm/aH44ijpEL4rlmUtUN14ZhSyqEw=
Date:   Wed, 12 Jun 2019 17:36:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: notifier-error-inject: no need to check return value of
 debugfs_create functions
Message-ID: <20190612153613.GA21239@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/notifier-error-inject.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/lib/notifier-error-inject.c b/lib/notifier-error-inject.c
index 3d2ba7cf83f4..21016b32d313 100644
--- a/lib/notifier-error-inject.c
+++ b/lib/notifier-error-inject.c
@@ -59,33 +59,22 @@ struct dentry *notifier_err_inject_init(const char *name, struct dentry *parent,
 	err_inject->nb.priority = priority;
 
 	dir = debugfs_create_dir(name, parent);
-	if (!dir)
-		return ERR_PTR(-ENOMEM);
 
 	actions_dir = debugfs_create_dir("actions", dir);
-	if (!actions_dir)
-		goto fail;
 
 	for (action = err_inject->actions; action->name; action++) {
 		struct dentry *action_dir;
 
 		action_dir = debugfs_create_dir(action->name, actions_dir);
-		if (!action_dir)
-			goto fail;
 
 		/*
 		 * Create debugfs r/w file containing action->error. If
 		 * notifier call chain is called with action->val, it will
 		 * fail with the error code
 		 */
-		if (!debugfs_create_errno("error", mode, action_dir,
-					&action->error))
-			goto fail;
+		debugfs_create_errno("error", mode, action_dir, &action->error);
 	}
 	return dir;
-fail:
-	debugfs_remove_recursive(dir);
-	return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL_GPL(notifier_err_inject_init);
 
-- 
2.22.0

