Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D2BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCF520881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfDOHbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:31:11 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2534 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726432AbfDOHbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:31:06 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 5D43BD961816FAEEF327;
        Mon, 15 Apr 2019 15:31:04 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 15 Apr 2019 15:31:03 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 15 Apr 2019 15:31:03 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 12/13] f2fs: fix to set FI_UPDATE_WRITE correctly
Date:   Mon, 15 Apr 2019 15:30:53 +0800
Message-ID: <20190415073054.2577-4-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190415073054.2577-1-yuchao0@huawei.com>
References: <20190415073054.2577-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes to set FI_UPDATE_WRITE only if in-place IO was issued.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ee5c7962b0f3..f6191b5a0e48 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1879,9 +1879,10 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 									true);
 			if (PageWriteback(page))
 				end_page_writeback(page);
+		} else {
+			set_inode_flag(inode, FI_UPDATE_WRITE);
 		}
 		trace_f2fs_do_write_data_page(fio->page, IPU);
-		set_inode_flag(inode, FI_UPDATE_WRITE);
 		return err;
 	}
 
-- 
2.18.0.rc1

