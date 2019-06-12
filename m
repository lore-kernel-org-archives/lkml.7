Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF08C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84E4217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560353738;
	bh=+aHl5NrkDT3+InWLoy1+v9nphRhPYL9Sf+9f4GwPkfQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=AVn/eEiWRH/t/KCNMZ+1TEjJwmKsYjOpVgyBFAJgnfeHBicec78R4wLAZsFOH3pfd
	 b4w4GZ5uN3EUKnRANwBlgJ4ZpVeAQxTOCe4dlHLRDAUqaeDVK2teHU9Ve/989gq23k
	 pbU5CyLg7S0kocowQMqmMJdRzXJPGLelSp1gfP5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409425AbfFLPfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:35:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408737AbfFLPfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:35:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D9F3215EA;
        Wed, 12 Jun 2019 15:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560353737;
        bh=+aHl5NrkDT3+InWLoy1+v9nphRhPYL9Sf+9f4GwPkfQ=;
        h=Date:From:To:Cc:Subject:From;
        b=CyQSCY4Y+BLL+EbfdUb1NiejZRxXRU4ely6+EabI1tgAyIQaYhXF841SVKjY8w505
         caonTc2AhPsXRttgs16eUypZQOxOpybgZlRz3wT49WDysvKhD25ynneSdHfZsCM9s0
         PFQEHl0UlZIVaS6883rvW9xeWVDggYqdmVMlPCNQ=
Date:   Wed, 12 Jun 2019 17:35:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: dynamic_debug: no need to check return value of
 debugfs_create functions
Message-ID: <20190612153534.GA21141@kroah.com>
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

Cc: Jason Baron <jbaron@akamai.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/dynamic_debug.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8a16c2d498e9..c60409138e13 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -993,20 +993,14 @@ static __initdata int ddebug_init_success;
 
 static int __init dynamic_debug_init_debugfs(void)
 {
-	struct dentry *dir, *file;
+	struct dentry *dir;
 
 	if (!ddebug_init_success)
 		return -ENODEV;
 
 	dir = debugfs_create_dir("dynamic_debug", NULL);
-	if (!dir)
-		return -ENOMEM;
-	file = debugfs_create_file("control", 0644, dir, NULL,
-					&ddebug_proc_fops);
-	if (!file) {
-		debugfs_remove(dir);
-		return -ENOMEM;
-	}
+	debugfs_create_file("control", 0644, dir, NULL, &ddebug_proc_fops);
+
 	return 0;
 }
 
-- 
2.22.0

