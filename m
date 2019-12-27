Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B261AC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3A520882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfL0JUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 04:20:49 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:58568 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfL0JUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 04:20:49 -0500
Received: from localhost.localdomain (unknown [159.226.5.100])
        by APP-01 (Coremail) with SMTP id qwCowAAnF5TkzAVeUKFLCg--.7S3;
        Fri, 27 Dec 2019 17:20:37 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: core: Fix a potential use after free
Date:   Fri, 27 Dec 2019 09:20:34 +0000
Message-Id: <1577438434-9945-1-git-send-email-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowAAnF5TkzAVeUKFLCg--.7S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZr4kWF15Cr4Utr1DXr4fZrb_yoW3Jrb_Z3
        WjgrsxuF18A3Wvkr15GF13Z3y0kFs0qrsYyF10qr95t390qr9rZ3yvv3sxXw1agr4fZF9r
        XF1qqrsxW345ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbFAYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I
        3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
        WUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
        k0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
        Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8v_M3UUUUU==
X-Originating-IP: [159.226.5.100]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCwIRA1z4i9UIOwAAsS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free the nvmem structure only after we are done using it.
This patch just moves the put_device() down a bit to avoid the
use after free.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9f1ee9c..7051d34 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -535,8 +535,8 @@ static struct nvmem_device *__nvmem_device_get(void *data,
 
 static void __nvmem_device_put(struct nvmem_device *nvmem)
 {
-	put_device(&nvmem->dev);
 	module_put(nvmem->owner);
+	put_device(&nvmem->dev);
 	kref_put(&nvmem->refcnt, nvmem_device_release);
 }
 
-- 
2.7.4

