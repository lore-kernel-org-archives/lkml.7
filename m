Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C1AC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1226C208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ltD1od8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfFNM6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:58:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38765 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfFNM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:58:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5ECwDsW1697032
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 Jun 2019 05:58:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5ECwDsW1697032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560517094;
        bh=PDl8JTUgpqB3LLdov/TctBAi0gM+7NEpuJxH2pLc75Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ltD1od8yQp6yCqJxSTnwlfNYk6/q/XdJbvfXVKy0NVjPcV/UV+CsLX8JNpQCR/Mit
         Eb5kDEso1S6n+5IoXQ8o7VV92RtMjt8okBK+p3kdW1ZT+JjW88lv556Hcjgkn3kJTg
         f8GBXGeGQXhznoZo2J2+UD4uB6yAmLq/8KlOV2MUYwwXDUxFTR2R/YzVKyOCf72jl8
         PWnOSw3H63hwR1JUEyVxB4qfLZbzUhBioloKPGm7EaRz/MLpeLpzz/KqIgOJyNYTjx
         AiESGmTRmTJZ5b4iigviv0BfEVkjbIvAj20EyhJBZ1LsuDSUSdW+owc16c4Ya8cWDW
         YYsjU9VsqDrXQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5ECwCwd1697029;
        Fri, 14 Jun 2019 05:58:12 -0700
Date:   Fri, 14 Jun 2019 05:58:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Greg Kroah-Hartman <tipbot@zytor.com>
Message-ID: <tip-fecb0d95cdf752836cafdfffc1661f61ba4e2101@git.kernel.org>
Cc:     akpm@linux-foundation.org, longman@redhat.com, tglx@linutronix.de,
        cai@gmx.us, joel@joelfernandes.org, zhongjiang@huawei.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        gregkh@linuxfoundation.org
Reply-To: mingo@kernel.org, gregkh@linuxfoundation.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, zhongjiang@huawei.com,
          joel@joelfernandes.org, cai@gmx.us, tglx@linutronix.de,
          longman@redhat.com, akpm@linux-foundation.org
In-Reply-To: <20190612153513.GA21082@kroah.com>
References: <20190612153513.GA21082@kroah.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/debugobjects] debugobjects: No need to check return value
 of debugfs_create()
Git-Commit-ID: fecb0d95cdf752836cafdfffc1661f61ba4e2101
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

Commit-ID:  fecb0d95cdf752836cafdfffc1661f61ba4e2101
Gitweb:     https://git.kernel.org/tip/fecb0d95cdf752836cafdfffc1661f61ba4e2101
Author:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
AuthorDate: Wed, 12 Jun 2019 17:35:13 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 14 Jun 2019 14:51:14 +0200

debugobjects: No need to check return value of debugfs_create()

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Qian Cai <cai@gmx.us>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: Zhong Jiang <zhongjiang@huawei.com>
Link: https://lkml.kernel.org/r/20190612153513.GA21082@kroah.com

---
 lib/debugobjects.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 55437fd5128b..2ac42286cd08 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -850,26 +850,16 @@ static const struct file_operations debug_stats_fops = {
 
 static int __init debug_objects_init_debugfs(void)
 {
-	struct dentry *dbgdir, *dbgstats;
+	struct dentry *dbgdir;
 
 	if (!debug_objects_enabled)
 		return 0;
 
 	dbgdir = debugfs_create_dir("debug_objects", NULL);
-	if (!dbgdir)
-		return -ENOMEM;
 
-	dbgstats = debugfs_create_file("stats", 0444, dbgdir, NULL,
-				       &debug_stats_fops);
-	if (!dbgstats)
-		goto err;
+	debugfs_create_file("stats", 0444, dbgdir, NULL, &debug_stats_fops);
 
 	return 0;
-
-err:
-	debugfs_remove(dbgdir);
-
-	return -ENOMEM;
 }
 __initcall(debug_objects_init_debugfs);
 
