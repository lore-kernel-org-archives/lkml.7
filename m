Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AA7C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87592082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbfFMPgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:36:20 -0400
Received: from app2.whu.edu.cn ([202.114.64.89]:50524 "EHLO whu.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727379AbfFMKUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:20:09 -0400
Received: from localhost (unknown [111.202.192.3])
        by email2 (Coremail) with SMTP id AgBjCgBHTvZJIwJdy3VkAQ--.48697S2;
        Thu, 13 Jun 2019 18:19:59 +0800 (CST)
From:   Peng Wang <rocking@whu.edu.cn>
To:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, Peng Wang <rocking@whu.edu.cn>
Subject: [PATCH] locking/rwsem: save unnecessary rwsem_set_owner() after slow path
Date:   Thu, 13 Jun 2019 18:18:09 +0800
Message-Id: <20190613101809.16231-1-rocking@whu.edu.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AgBjCgBHTvZJIwJdy3VkAQ--.48697S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4ftr17GFWDCrWxJr4kCrg_yoW8JFy7pr
        1FkFyqkr9FqFy7WrZrJa10va15Aw10yr97GanxCrW8AFnxAF4xJFs8Wr17tFy8GFyIkrWY
        qF4fCFWF9ayxKrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Gw1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUboKZJUUUUU==
X-CM-SenderInfo: qsqrijaqrviiqqxyq4lkxovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rwsem_down_write_failed() and rwsem_down_write_failed_killable() return
with sem->owner set if acquire semaphore successfully, so we can skip
rwsem_set_owner() to keep pace with reading.

Signed-off-by: Peng Wang <rocking@whu.edu.cn>
---
 kernel/locking/rwsem.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 64877f5294e3..4fa21f737151 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -225,7 +225,8 @@ static inline void __down_write(struct rw_semaphore *sem)
 					     &sem->count);
 	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
 		rwsem_down_write_failed(sem);
-	rwsem_set_owner(sem);
+	else
+		rwsem_set_owner(sem);
 }
 
 static inline int __down_write_killable(struct rw_semaphore *sem)
@@ -234,10 +235,12 @@ static inline int __down_write_killable(struct rw_semaphore *sem)
 
 	tmp = atomic_long_add_return_acquire(RWSEM_ACTIVE_WRITE_BIAS,
 					     &sem->count);
-	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS))
+	if (unlikely(tmp != RWSEM_ACTIVE_WRITE_BIAS)) {
 		if (IS_ERR(rwsem_down_write_failed_killable(sem)))
 			return -EINTR;
-	rwsem_set_owner(sem);
+	} else {
+		rwsem_set_owner(sem);
+	}
 	return 0;
 }
 
-- 
2.19.1

