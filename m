Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746FCC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E30E216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfGHPTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:19:01 -0400
Received: from app1.whu.edu.cn ([202.114.64.88]:40278 "EHLO whu.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733117AbfGHPSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:18:54 -0400
Received: from localhost (unknown [111.202.192.5])
        by email1 (Coremail) with SMTP id AQBjCgAnCTrQXiNdSDViAA--.46705S2;
        Mon, 08 Jul 2019 23:18:46 +0800 (CST)
From:   Peng Wang <rocking@whu.edu.cn>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peng Wang <rocking@whu.edu.cn>
Subject: [PATCH v2] kernfs: fix potential null pointer dereference
Date:   Mon,  8 Jul 2019 23:16:11 +0800
Message-Id: <20190708151611.13242-1-rocking@whu.edu.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQBjCgAnCTrQXiNdSDViAA--.46705S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW3JF1DtrW5Jr1DXr4xJFb_yoW3AFX_Cr
        18C3s09FW7Wrs7Wr13G3ySqryF9a1qv3W0vF4fta98tFZxta1DArn3Jw1vyrn7Gry8Wr9F
        yFn0yryqkrWxXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
        1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
        cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
        ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ryrMxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUz6wAUUUUU=
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get root safely after kn is ensureed to be not null.

Signed-off-by: Peng Wang <rocking@whu.edu.cn>
---
 fs/kernfs/dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index a387534c9577..ddf537923a0a 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -430,7 +430,6 @@ struct kernfs_node *kernfs_get_active(struct kernfs_node *kn)
  */
 void kernfs_put_active(struct kernfs_node *kn)
 {
-	struct kernfs_root *root = kernfs_root(kn);
 	int v;
 
 	if (unlikely(!kn))
@@ -442,7 +441,7 @@ void kernfs_put_active(struct kernfs_node *kn)
 	if (likely(v != KN_DEACTIVATED_BIAS))
 		return;
 
-	wake_up_all(&root->deactivate_waitq);
+	wake_up_all(&kernfs_root(kn)->deactivate_waitq);
 }
 
 /**
-- 
2.19.1

