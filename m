Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A077BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEC52184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfDKK4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:56:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44542 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726517AbfDKK4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:56:47 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D86701A69786D7FA9083;
        Thu, 11 Apr 2019 18:56:45 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 11 Apr
 2019 18:56:37 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] staging: erofs: fix unexpected out-of-bound data access
Date:   Thu, 11 Apr 2019 18:55:55 +0800
Message-ID: <20190411105555.133551-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unexpected out-of-bound data will be read in erofs_read_raw_page
after commit 07173c3ec276 ("block: enable multipage bvecs") since
one iovec could have multiple pages.

Let's fix as what Ming's pointed out in the previous email.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

It should be fixed from linux-5.1-rc after multi-page bvec feature.

Thanks,
Gao Xiang

 drivers/staging/erofs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
index 0714061ba888..c64ec76643d4 100644
--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -304,7 +304,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 	*last_block = current_block;
 
 	/* shift in advance in case of it followed by too many gaps */
-	if (unlikely(bio->bi_vcnt >= bio->bi_max_vecs)) {
+	if (bio->bi_iter.bi_size >= bio->bi_max_vecs * PAGE_SIZE) {
 		/* err should reassign to 0 after submitting */
 		err = 0;
 		goto submit_bio_out;
-- 
2.17.1

