Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D43C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D259520715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420189;
	bh=AZovaWb7kUE5S+uJuZWRgFGbFjGvS0V6bJLQ2mcQLZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u69KHE6GlTdtkQiPLjKH06zNAYfwgE4atTD7jffckaw+7Rs+2yVQaxZcLNk3++tLf
	 kiL/B6MOudFlZgKKZsji3jMk2Tbj4X2hfsa0mQ3GGDMlHbIPRLcQcXY+NRaxOtRKfK
	 SDWJh+JrlfwY1kydZHA2EtpCqOxigL0zxZHEM8Kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfKVK42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:56:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730580AbfKVK4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:56:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2807C2073B;
        Fri, 22 Nov 2019 10:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420183;
        bh=AZovaWb7kUE5S+uJuZWRgFGbFjGvS0V6bJLQ2mcQLZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h30SwN6HjlVCBkFRHAqyy4dyRHZE+4xTAnwfGFsQjCgYt8f0Z+k+xGvCGAVGr+icm
         PTeUo0YzdFvOhl4K94YJglJ4vI9zrgEaTtuEqbnrUzAwQu6x0wG0/NBfevemX9MYG7
         r5zJexqg8Rc7pOYuJF8ksaeGFe2SfVPHVhG/tEi8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 021/220] f2fs: return correct errno in f2fs_gc
Date:   Fri, 22 Nov 2019 11:26:26 +0100
Message-Id: <20191122100914.034146505@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 61f7725aa148ee870436a29d3a24d5c00ab7e9af ]

This fixes overriding error number in f2fs_gc.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index dd29a49143f54..8c4cb1eee10a6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1244,7 +1244,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 
 	put_gc_inode(&gc_list);
 
-	if (sync)
+	if (sync && !ret)
 		ret = sec_freed ? 0 : -EAGAIN;
 	return ret;
 }
-- 
2.20.1



