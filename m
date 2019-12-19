Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB1EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC412218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfLSNPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:15:32 -0500
Received: from mail.loongson.cn ([114.242.206.163]:58724 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726701AbfLSNPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:15:32 -0500
Received: from linux.localdomain (unknown [123.138.236.242])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxjxTod_tdXZIMAA--.55S2;
        Thu, 19 Dec 2019 21:15:20 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix compile warning in afs_dynroot_lookup()
Date:   Thu, 19 Dec 2019 21:14:51 +0800
Message-Id: <1576761291-30121-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxjxTod_tdXZIMAA--.55S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4xuFW7ZrW3Jw4fXr1xuFg_yoWfJwcEyF
        47K3s5CrWUJr92yF4FgFWUtFs5Wws8GF4DurZxWr4DKayUAa15t3WDArZxJF47Gwnayr98
        Cw18KrsxJry7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7AYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6ry8MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0rgA7UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compile warning:

  CC      fs/afs/dynroot.o
fs/afs/dynroot.c: In function ‘afs_dynroot_lookup’:
fs/afs/dynroot.c:117:6: warning: ‘len’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  ret = lookup_one_len(name, dentry->d_parent, len);
      ^
fs/afs/dynroot.c:91:6: note: ‘len’ was declared here
  int len;
      ^

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 fs/afs/dynroot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 7503899..303f712 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -88,7 +88,7 @@ static struct dentry *afs_lookup_atcell(struct dentry *dentry)
 	struct dentry *ret;
 	unsigned int seq = 0;
 	char *name;
-	int len;
+	int len = 0;
 
 	if (!net->ws_cell)
 		return ERR_PTR(-ENOENT);
-- 
2.1.0

