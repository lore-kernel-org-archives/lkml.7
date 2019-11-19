Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310CDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FF7222A0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142898;
	bh=Y73+dY1Y0k2XuM4+cKQsdic8Xpu6IH+WkIG2UhOnRI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cqg1lVEmXCcVbopBUxDmvEGWQu97zWGJVXFAYis6nTKZMNls4jzDAYMIwMJRxD3JR
	 Jrmi6eP8pSVGMNNISRFfh6zcNnAaGHtn8ZQyswEZa2FnZgE0M5owLOGsbHBENz/42s
	 aBDr+9IGzUY3cV+Tf7zZYpOQtwyMLzGLn5+bRGOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfKSFy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:54:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731898AbfKSFyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:54:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E03D2084D;
        Tue, 19 Nov 2019 05:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142891;
        bh=Y73+dY1Y0k2XuM4+cKQsdic8Xpu6IH+WkIG2UhOnRI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExVEBqsBnyvluQDf4QV1Tuhj+mGE1JgeKlxr9Cvn0iz2uj/QuYI8TCIuSn+428ySG
         npx+xQrNrzQJNPyI/ZGn34mEsXjusAfzWViIzqugmWDUGPyqVcHWBl/ryzJoLAxOJu
         z97bNK7qOQaHGQjZu7ylFzUi8SXNuToQ4aFVJ16Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 236/239] fuse: use READ_ONCE on congestion_threshold and max_background
Date:   Tue, 19 Nov 2019 06:20:36 +0100
Message-Id: <20191119051342.647358118@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 5be0339dcceb2..42bed87dd5ea9 100644
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



