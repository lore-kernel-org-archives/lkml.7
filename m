Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BC4CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BD520867
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096593;
	bh=gt9bph1GrJGHkztpsT4H/EYp/BQ6SfJCH9lx63DYKUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kyv/xAD2FcuvinMJhxM+ML+QrscO8pRPmI1PqaulzHae2tZ+QyoXr29FF70CKIONA
	 NOOxoMP3tmemD25H+G595W43B0hEzjQKsIOHwnr01hA14ZZRcicLYSKNbUqI+rwACQ
	 vfQpQxq9VmxMrJDKo8MG/GL1upevgXWj+BGxnJuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfJZN3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:29:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfJZNUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:20:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C386320867;
        Sat, 26 Oct 2019 13:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572096017;
        bh=gt9bph1GrJGHkztpsT4H/EYp/BQ6SfJCH9lx63DYKUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1+xn5Ik1plaOaeucdg7dFpOU+3OkGejM4cdKQ7VMRDZIVyYVFXLJTnk1LmK8s+Ik+
         2jwe+A+Ml3XGFT1gKxej9KCy9Oe+GHk/PC3AQwM++uRQnZG7QWAG5aip8bEoZ1pO9d
         hAafUYPekzTmOd7gaB8rBLva8Mkdxk9NpxUKw+No=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 32/59] act_mirred: Fix mirred_init_module error handling
Date:   Sat, 26 Oct 2019 09:18:43 -0400
Message-Id: <20191026131910.3435-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131910.3435-1-sashal@kernel.org>
References: <20191026131910.3435-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 11c9a7d38af524217efb7a176ad322b97ac2f163 ]

If tcf_register_action failed, mirred_device_notifier
should be unregistered.

Fixes: 3b87956ea645 ("net sched: fix race in mirred device removal")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_mirred.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 399e3beae6cf4..a30c17a282819 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -445,7 +445,11 @@ static int __init mirred_init_module(void)
 		return err;
 
 	pr_info("Mirror/redirect action on\n");
-	return tcf_register_action(&act_mirred_ops, &mirred_net_ops);
+	err = tcf_register_action(&act_mirred_ops, &mirred_net_ops);
+	if (err)
+		unregister_netdevice_notifier(&mirred_device_notifier);
+
+	return err;
 }
 
 static void __exit mirred_cleanup_module(void)
-- 
2.20.1

