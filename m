Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CBDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF73522312
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141455;
	bh=sJpnYYA+MXxb7Zkkl21ND/xHqtmHcYZH+6QgZoeKKU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AxCEStquo438P2G6Rdv4qXnFIw/tmdnMEi8Qy8ZKukqqaAwlzMMJ2TOEzh7K7NEps
	 bNgCdRvP2aEPdE67lH92Cyn13SdhVY6j1hXdhxgdMTO8QbWx1OlXoGTHWdNlAQQVnO
	 H1D+VnYHZO/on56aeJuh2vucehBkX+/zp1kB2yv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfKSFax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:30:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:49740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbfKSFav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:30:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF483222DC;
        Tue, 19 Nov 2019 05:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141451;
        bh=sJpnYYA+MXxb7Zkkl21ND/xHqtmHcYZH+6QgZoeKKU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EMUn2xaCwuLpWtjECNtqELObPAQcA2QLq+fx/r26V8e1r14MtVdMOeq+KjNAwT3ru
         ZekOy8j1ZdNeC/8Sa0IzVGd1FMn1N8lWuHexBpcGkY2bnnzMyqd7prZ7hLe4K58HKS
         dkFgcTW5JQCXQUZ70y98sPJZIyu+rUMxP87H/FUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 165/422] f2fs: fix memory leak of write_io in fill_super()
Date:   Tue, 19 Nov 2019 06:16:02 +0100
Message-Id: <20191119051409.140969784@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 0b2103e886e6de9802e1170e57c573443286a483 ]

It needs to release memory allocated for sbi->write_io in error path,
otherwise, it will cause memory leak.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d9106bbe7df63..58931d55dc1d2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2929,7 +2929,7 @@ try_onemore:
 				     GFP_KERNEL);
 		if (!sbi->write_io[i]) {
 			err = -ENOMEM;
-			goto free_options;
+			goto free_bio_info;
 		}
 
 		for (j = HOT; j < n; j++) {
-- 
2.20.1



