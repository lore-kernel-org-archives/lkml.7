Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C8FC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACC9206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560277938;
	bh=2S8M8v4FB5RHddbCWKRYJB64xPBafiD5zeA1G+leo08=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=cqMpRTAlUNni/khKZgB1CrIARiMtb9SMxq8ChwpIXlTAMJhQhafPsbFJg8wWuASPZ
	 x8HunDYk5JngB76UrDQSWceS8lkTkgqYrQeV5kjXZgT/eocBonFmW2EEEPVDl4JqAi
	 kskopZZ98rm9DD2u9HBdtYwi6XjXu4uhkYtWL1rE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391232AbfFKScR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729074AbfFKScQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:32:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5FA220644;
        Tue, 11 Jun 2019 18:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560277936;
        bh=2S8M8v4FB5RHddbCWKRYJB64xPBafiD5zeA1G+leo08=;
        h=Date:From:To:Cc:Subject:From;
        b=tGgboCs+zpxFBvOUK/Iba/yzvcMm/Jo6BSXEXddMryyKE9UX/V6XObXXipRI2U/Z5
         BTJ1RwsyfDFcYPHPZahEL9+WjvYA9lNqYaqOGAInLzzqj+lQpl8hGg5AAkWYk7Uw1E
         SuMnvThZm/1sXy1CkesltR3i8VSG8J1EjKfEJ/Ag=
Date:   Tue, 11 Jun 2019 20:32:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] lkdtm: no need to check return value of debugfs_create
 functions
Message-ID: <20190611183213.GA31645@kroah.com>
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

Cc: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/lkdtm/core.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 1972dad966f5..bae3b3763f3e 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -429,22 +429,13 @@ static int __init lkdtm_module_init(void)
 
 	/* Register debugfs interface */
 	lkdtm_debugfs_root = debugfs_create_dir("provoke-crash", NULL);
-	if (!lkdtm_debugfs_root) {
-		pr_err("creating root dir failed\n");
-		return -ENODEV;
-	}
 
 	/* Install debugfs trigger files. */
 	for (i = 0; i < ARRAY_SIZE(crashpoints); i++) {
 		struct crashpoint *cur = &crashpoints[i];
-		struct dentry *de;
 
-		de = debugfs_create_file(cur->name, 0644, lkdtm_debugfs_root,
-					 cur, &cur->fops);
-		if (de == NULL) {
-			pr_err("could not create crashpoint %s\n", cur->name);
-			goto out_err;
-		}
+		debugfs_create_file(cur->name, 0644, lkdtm_debugfs_root, cur,
+				    &cur->fops);
 	}
 
 	/* Install crashpoint if one was selected. */
-- 
2.22.0

