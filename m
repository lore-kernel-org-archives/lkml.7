Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DB7C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B124420692
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgAGVmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:42:44 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:42271 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgAGVmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:42:44 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MT9zD-1jH9nj3H5D-00UYa3; Tue, 07 Jan 2020 22:42:16 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: fix uninitialized-variable warning
Date:   Tue,  7 Jan 2020 22:42:08 +0100
Message-Id: <20200107214215.935781-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:043HDHrfAGyhHtmaDtlYyEpE8s5+9wdoNLWS/8OShhwdhjC1qdo
 u12T7hghyb/GDuiHprzuItewQyd1Y+20xuo0WR23Bo3fe1Gb4pSuW/uQajaD6o/Fa9s5BBA
 KV+r5kSVBdMFuYdfaE1hYgO+ccrMa+DeAj635Y2khM1B2QUyjQ0obF6RE8C+MnY5oJFRUCC
 WWijyA4wlaN+VrzPVvRMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mPTXboQZzNY=:zErWC3Q6Kms29bP7mGKw6q
 V9R1VjmR7OQkMczbvn7qcMThBpaTIf+xW8jGazvJyHLKQUR1byi8VhQIUqPi/CItYnRywm277
 DBUH6+LDiOdEpujdIW01gZgNlpN7JWBbV5cc368RJE3IEa0uZXJWeG3otxpVgwSGJMb+JmrlV
 L2Dy8Fz1C8dO5mAQbt/Q/GRhJ8hjwetQMWzD3Huzla38VUVDvNQYjT49v2BK1J+pMK8Qlb8WH
 oKflABu13THng4yOJFRpKr9xH71RvhA4IXBPaSDsoBvzIbGUZElriyE1oDLsyFEJ9ImO3t50X
 CrIRFhl/yNj3U5RLaQUUcvryU5Ug9dPfXXmo0Oqk0uOqbt3uktQfdJcU98zMa6QndWi7t9NGK
 58lCY98ag6YF+Ci9S0LFf+8pemvNCP67AEUthYMW29Qbd0qPs6wWTb3zbc4Qw6etugckZuCyC
 xgu6MCn23i+FqKtwu7AhAaZ/u/2XlZZJIWDm8VoPKQLZk2IicnsW6PaMxM1AN+CycgHeMViw9
 4p4fDmjkUsn4m7MqZA1/YtZIIjvnYlh6T0LiaDmcpLbEuGP6AxY157XaG1biWVjTEmiZp4mbO
 v/b9tnieNvaAHh+VgobPyZpWqOgPpiALKmz1AX7CNXgvBsZRwJCE9mgQVvtNA414RrAWcKQ4L
 Ji4KGfEQJqZc4J3CymDrSkf+thWcM4+9aibGn2dCCgxWqvz3LLazPQYeQiKVg1Oj4+xXVppTq
 rijk6gzfiVtxZm1TLoJd0+MV5SJgLfQYhyOJ9vLlnjKw0DC3ybVLrEJKqxvE4yQ5cwddNNT0K
 J5T4QyLZHoPijiwVsfHRMg5DJ1DC449xXUrnyTTxBXHSnWAFAOWe+GKU+edJJcYT6zmzZLOKq
 5aImhuBfDYv+b0agZViQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -O3 adds a bogus warning in this file:

In file included from include/linux/compiler_types.h:68,
                 from <command-line>:
drivers/nvme/host/core.c: In function 'nvme_set_queue_count':
include/linux/compiler-gcc.h:71:45: error: 'res.u32' may be used uninitialized in this function [-Werror=maybe-uninitialized]
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                             ^~~~~~~~~~~~
drivers/nvme/host/core.c:1167:20: note: 'res.u32' was declared here
  union nvme_result res;
                    ^~~

Slightly rearrange the code, enough to let gcc understand
better what is going on and not warn about it.

Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/host/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 667f18f465be..6f0991e8c5cc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -825,14 +825,15 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	int ret;
 
 	req = nvme_alloc_request(q, cmd, flags, qid);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
+	ret = PTR_ERR_OR_ZERO(req);
+	if (ret < 0)
+		return ret;
 
 	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
-		if (ret)
+		if (ret < 0)
 			goto out;
 	}
 
-- 
2.20.0

