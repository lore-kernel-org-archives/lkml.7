Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6725BC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F79C208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355241;
	bh=blpqi0RXovzkfLlmQ9MMcwXtTOCskwWkjcijEU41dFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iEB/essGyV/2cQflp7tBW85j0Kd3RrhPrnRCPUiIHSozN2e57n1WHD3wg8TLR2UI1
	 lOybQskmUgfYLg2iV5mk0n2RZwaUrHkBDRH8W1/IqrS+VV/rKgO4+7H9iKKw1SF3B+
	 OG297uuHrmZN+3aAoNenp9WHv87kFzWfI9zKhpdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfKJDHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:07:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfKJCpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:45:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5550E21D7E;
        Sun, 10 Nov 2019 02:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353925;
        bh=blpqi0RXovzkfLlmQ9MMcwXtTOCskwWkjcijEU41dFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q9oktXTF3YzLEKlbLeBr9tNNbZ8uNkv7zmsabi9tjnaRdWD8sZOXhCAvZrb59mbAA
         VDTLQOjtdkKHBP3YP4dLYRlFjpftsMK7M4nPzD0EOhSELp5LoV7q87T2heV1+nXEeC
         WL4UOL/xgnxZOgq2FyX8YINHssyzjlHeeQRGTDGY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 186/191] fuse: use READ_ONCE on congestion_threshold and max_background
Date:   Sat,  9 Nov 2019 21:40:08 -0500
Message-Id: <20191110024013.29782-186-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>

[ Upstream commit 2a23f2b8adbe4bd584f936f7ac17a99750eed9d7 ]

Since they are of unsigned int type, it's allowed to read them
unlocked during reporting to userspace. Let's underline this fact
with READ_ONCE() macroses.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/control.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 0b694655d9880..acc35819aae64 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -107,7 +107,7 @@ static ssize_t fuse_conn_max_background_read(struct file *file,
 	if (!fc)
 		return 0;
 
-	val = fc->max_background;
+	val = READ_ONCE(fc->max_background);
 	fuse_conn_put(fc);
 
 	return fuse_conn_limit_read(file, buf, len, ppos, val);
@@ -144,7 +144,7 @@ static ssize_t fuse_conn_congestion_threshold_read(struct file *file,
 	if (!fc)
 		return 0;
 
-	val = fc->congestion_threshold;
+	val = READ_ONCE(fc->congestion_threshold);
 	fuse_conn_put(fc);
 
 	return fuse_conn_limit_read(file, buf, len, ppos, val);
-- 
2.20.1

