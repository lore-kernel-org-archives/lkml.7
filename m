Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AE8C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658AD21734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560352853;
	bh=eSlOl/FrKZdWcnfDywclEUx75S0pbToZnLCx/u6+Wls=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=G62mdbky9zEWfErAHXVJU1e87wm8akoPPqJY/Fbz3sGbQiHZTTw3rAzIzwgjbEilf
	 BT3gVFGj8oH/D8YiyE+r+bWFsB2/C7iK57JZj1iC6Qd9XRjb56RlcMENEXGPVOzJ9v
	 h+P8wK9WSWj3I4xrwCFodsyGS/u6y4kr26nM4vaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502031AbfFLPUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2501983AbfFLPUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:20:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CDF21019;
        Wed, 12 Jun 2019 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560352836;
        bh=eSlOl/FrKZdWcnfDywclEUx75S0pbToZnLCx/u6+Wls=;
        h=Date:From:To:Cc:Subject:From;
        b=QkEgIInAKRVyU04Dhe5elLte+yGBRK4tC0ARQqovcwqTqpenKCFxewQXFl2M4lVvv
         Lpr68smrIZJCGDX6jZXy5NxQBw2BW8u5phnK3xG/e1/SUHO5KbNuSZpAVSpUQMRrY+
         KhvvYmeE7qn3G2NW9Hzwn/aX/VZnQwmbt/7Jj06M=
Date:   Wed, 12 Jun 2019 17:20:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: no need to check return value of debugfs_create
 functions
Message-ID: <20190612152033.GA17290@kroah.com>
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
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/pstore/ftrace.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
index b8a0931568f8..fd9468928bef 100644
--- a/fs/pstore/ftrace.c
+++ b/fs/pstore/ftrace.c
@@ -120,27 +120,13 @@ static struct dentry *pstore_ftrace_dir;
 
 void pstore_register_ftrace(void)
 {
-	struct dentry *file;
-
 	if (!psinfo->write)
 		return;
 
 	pstore_ftrace_dir = debugfs_create_dir("pstore", NULL);
-	if (!pstore_ftrace_dir) {
-		pr_err("%s: unable to create pstore directory\n", __func__);
-		return;
-	}
-
-	file = debugfs_create_file("record_ftrace", 0600, pstore_ftrace_dir,
-				   NULL, &pstore_knob_fops);
-	if (!file) {
-		pr_err("%s: unable to create record_ftrace file\n", __func__);
-		goto err_file;
-	}
 
-	return;
-err_file:
-	debugfs_remove(pstore_ftrace_dir);
+	debugfs_create_file("record_ftrace", 0600, pstore_ftrace_dir, NULL,
+			    &pstore_knob_fops);
 }
 
 void pstore_unregister_ftrace(void)
-- 
2.22.0

