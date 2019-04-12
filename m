Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AB4C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9142077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfDLJyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:54:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54426 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726713AbfDLJyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:54:12 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 03FD0AF611B6F83335EB;
        Fri, 12 Apr 2019 17:54:09 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 12 Apr
 2019 17:53:57 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2] staging: erofs: fix unexpected out-of-bound data access
Date:   Fri, 12 Apr 2019 17:53:14 +0800
Message-ID: <20190412095314.224932-1-gaoxiang25@huawei.com>
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

Let's fix as what Ming's pointed out in the previous email [1].

[1] https://lore.kernel.org/lkml/20190411080953.GE421@ming.t460p/

Suggested-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
change log v2:
 - fix commit message to link the discussion thread
   as pointed out by Chao;

* It should be fixed from linux-5.1-rc after enabling
  multi-page bvec feature.

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

