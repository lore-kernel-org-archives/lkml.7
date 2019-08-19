Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46420C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BAFE20843
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfHSKfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:35:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5151 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727351AbfHSKfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:35:22 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 64C2A6BD296137F55081;
        Mon, 19 Aug 2019 18:35:17 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 19 Aug
 2019 18:35:06 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-fsdevel@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/6] staging: erofs: cannot set EROFS_V_Z_INITED_BIT if fill_inode_lazy fails
Date:   Mon, 19 Aug 2019 18:34:22 +0800
Message-ID: <20190819103426.87579-3-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819103426.87579-1-gaoxiang25@huawei.com>
References: <20190819080218.GA42231@138>
 <20190819103426.87579-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by erofs-utils fuzzer, unsupported compressed
clustersize will make fill_inode_lazy fail, for such case
we cannot set EROFS_V_Z_INITED_BIT since we need return
failure for each z_erofs_map_blocks_iter().

Fixes: 152a333a5895 ("staging: erofs: add compacted compression indexes support")
Cc: <stable@vger.kernel.org> # 5.3+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/zmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/zmap.c b/drivers/staging/erofs/zmap.c
index b61b9b5950ac..7408e86823a4 100644
--- a/drivers/staging/erofs/zmap.c
+++ b/drivers/staging/erofs/zmap.c
@@ -85,12 +85,11 @@ static int fill_inode_lazy(struct inode *inode)
 
 	vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits +
 					((h->h_clusterbits >> 5) & 7);
+	set_bit(EROFS_V_Z_INITED_BIT, &vi->flags);
 unmap_done:
 	kunmap_atomic(kaddr);
 	unlock_page(page);
 	put_page(page);
-
-	set_bit(EROFS_V_Z_INITED_BIT, &vi->flags);
 out_unlock:
 	clear_and_wake_up_bit(EROFS_V_BL_Z_BIT, &vi->flags);
 	return err;
-- 
2.17.1

