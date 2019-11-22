Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A177CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7903E2071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418919;
	bh=mpnD1p0KP4BOslkv4vlEJkovyvNqqsZASE1Gajsr6Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eyf71iYGHNvwMPCH0bugY+OfoScAjb2X39euYLdISIQhK1f7iiUkcncwOt+DJPVrb
	 3qC+W/jzwHfwPc963X1ADnXT7n3R9nM74cccRiQa69zl+BJLBBNDe1ykq0Uk/B8y8C
	 4DbqQD2wU00/jRJ3Fb+FunGwCjg66yKrvLPCJERA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfKVKfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:35:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbfKVKfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:35:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8404820715;
        Fri, 22 Nov 2019 10:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418915;
        bh=mpnD1p0KP4BOslkv4vlEJkovyvNqqsZASE1Gajsr6Ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aH5soeMA54wpNkH1b+P1Qtjmc97bPdKivYoImeTraYEW0xdgcppBbRFjlgU8iKWOi
         F41Plvf1ScFCp7bsV8tMNHOTXxe+6DMkUx/6a67IUqRT/MiMaPqA9DEMOEtmNAi7Ic
         VjzDh0jjwuLqGc4eRW7UW68XB6QuurSKafaPZtG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 095/159] fuse: use READ_ONCE on congestion_threshold and max_background
Date:   Fri, 22 Nov 2019 11:28:06 +0100
Message-Id: <20191122100815.607212036@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
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
index 89a4b231e79cb..bb56c6a58fa76 100644
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



