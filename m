Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CD7C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A984820848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 07:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfEQHFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 03:05:36 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:42746 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfEQHFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:05:36 -0400
X-QQ-mid: bizesmtp6t1558076698tb2se918y
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 17 May 2019 15:04:48 +0800 (CST)
X-QQ-SSF: 01400000000000H0HG32B00A0000000
X-QQ-FEAT: cEiBA8c+CrMUAvBZUbu+tVgMV1D2i6pAvpNrRwu5R4jPcrEQw0qUY6lmMveSF
        IsHhRH6FnFK1Nl07GWmT31ZHiFHiJU2SpnMGQxJd4eb0qEobhwEtVxVwywCSz7wMUFr7pAm
        +lvQF4rQmRSIejTZvbrg/ojc0Qe+PyI582iZy3ikStEOtGKAwGpG447fFwCcbA1n5dY4sEn
        c6/0n45W5y8IDfe57AoQhRMz81+v31CNHshHM6nte/igmD7E1IxNTS38sWwVnOwcL/9/Vck
        x/MVgssj1sDQ7/+MNWuJLngKJ9yVvy/UG3NGg4qp8bHGyRcIKeutGZ+vA=
X-QQ-GoodBg: 2
From:   xiaolinkui <xiaolinkui@kylinos.cn>
To:     hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        xiaolinkui@kylinos.cn
Subject: [PATCH] nvme: target: use struct_size() in kmalloc()
Date:   Fri, 17 May 2019 15:03:35 +0800
Message-Id: <1558076615-8576-1-git-send-email-xiaolinkui@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct_size() to keep code sample.
One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

instance = kmalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);

Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
---
 drivers/nvme/target/admin-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 9f72d51..6f9f830 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -248,8 +248,8 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 	u16 status;
 
 	status = NVME_SC_INTERNAL;
-	desc = kmalloc(sizeof(struct nvme_ana_group_desc) +
-			NVMET_MAX_NAMESPACES * sizeof(__le32), GFP_KERNEL);
+	desc = kmalloc(struct_size(desc, nsids, NVMET_MAX_NAMESPACES),
+			GFP_KERNEL);
 	if (!desc)
 		goto out;
 
-- 
2.7.4



