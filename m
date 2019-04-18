Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A09AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417B0217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389209AbfDROTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:19:31 -0400
Received: from aliyun-cloud.icoremail.net ([47.90.73.12]:50417 "HELO
        aliyun-sdnproxy-4.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S2388344AbfDROTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:19:30 -0400
X-Greylist: delayed 715 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Apr 2019 10:19:29 EDT
Received: from localhost (unknown [111.202.192.5])
        by email2 (Coremail) with SMTP id AgBjCgBX9X3pgrhckM4CAg--.57193S2;
        Thu, 18 Apr 2019 22:00:14 +0800 (CST)
From:   Peng Wang <rocking@whu.edu.cn>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, Peng Wang <rocking@whu.edu.cn>
Subject: [PATCH] dm: initialize md->dax_dev only with CONFIG_DAX_DRIVER enabled
Date:   Thu, 18 Apr 2019 21:59:19 +0800
Message-Id: <20190418135919.10754-1-rocking@whu.edu.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AgBjCgBX9X3pgrhckM4CAg--.57193S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF48AF45WrWkKF45AF15twb_yoWxurgEkw
        15XFW3Xr4Skwnakr1Y9F4fZFy2yw1v9r4ruFnrKFnxJrZIvrsIgFyvvF1DX3ZxZFy5ury7
        ur12qw15Ar48KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbc8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW5XwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUe_M3DUUUU
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

md->dax_dev is NULL default and there is no need to process it
without CONFIG_DAX_DRIVER configured.

Signed-off-by: Peng Wang <rocking@whu.edu.cn>
---
 drivers/md/dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 043f0761e4a0..418a51cf194c 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1972,8 +1972,8 @@ static struct mapped_device *alloc_dev(int minor)
 		dax_dev = alloc_dax(md, md->disk->disk_name, &dm_dax_ops);
 		if (!dax_dev)
 			goto bad;
+		md->dax_dev = dax_dev;
 	}
-	md->dax_dev = dax_dev;
 
 	add_disk_no_queue_reg(md->disk);
 	format_dev_t(md->name, MKDEV(_major, minor));
-- 
2.19.1

