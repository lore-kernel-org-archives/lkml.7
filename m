Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCECC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67935222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611050;
	bh=U80dEjPfm6c8g/zCXeJHwAcr8VYZTGqXuhGXKJNLaYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dKA2vI4jQm7JjSLLH86SJfYWGPIOC71bX4fIB7IYHMFow0MyyDhgxYVb0sOav7FM7
	 kspa/lIxK103mpQxMooxrBYpxooc+aPX5sUODyRaCZBFNEF2WK2qpZ2RlrO46WL5c+
	 t1kacKQZ7O2sZPyXmghfar5EHEG1jds9qb0OQn78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbfKMCKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:10:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbfKMB7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:59:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A9C022467;
        Wed, 13 Nov 2019 01:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610350;
        bh=U80dEjPfm6c8g/zCXeJHwAcr8VYZTGqXuhGXKJNLaYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpauDPGhAk3/w7SHtxGVvFFXvP+3ChoVsVNC9pc2eaZgXZc+Wb5rsZr9Y2RoJH0ZN
         G0tWxw4lCqvf1XKmn0lsMqpTzSTBO7jP13AQGmUmdVN9Zjk8dsYeoz42eOKy5c0myw
         /oxmUbuS3ypg1viwFZEb0lfy4BDxxs/AKSLQxcOA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Sasha Levin <sashal@kernel.org>, devel@lists.orangefs.org
Subject: [PATCH AUTOSEL 4.14 101/115] orangefs: rate limit the client not running info message
Date:   Tue, 12 Nov 2019 20:56:08 -0500
Message-Id: <20191113015622.11592-101-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 2978d873471005577e7b68a528b4f256a529b030 ]

Currently accessing various /sys/fs/orangefs files will spam the
kernel log with the following info message when the client is not
running:

[  491.489284] sysfs_service_op_show: Client not running :-5:

Rate limit this info message to make it less spammy.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mike Marshall <hubcap@omnibond.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/orangefs/orangefs-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/orangefs-sysfs.c b/fs/orangefs/orangefs-sysfs.c
index 079a465796f3e..bc56df2ae705d 100644
--- a/fs/orangefs/orangefs-sysfs.c
+++ b/fs/orangefs/orangefs-sysfs.c
@@ -323,7 +323,7 @@ static ssize_t sysfs_service_op_show(struct kobject *kobj,
 	/* Can't do a service_operation if the client is not running... */
 	rc = is_daemon_in_service();
 	if (rc) {
-		pr_info("%s: Client not running :%d:\n",
+		pr_info_ratelimited("%s: Client not running :%d:\n",
 			__func__,
 			is_daemon_in_service());
 		goto out;
-- 
2.20.1

