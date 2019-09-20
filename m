Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE23CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98E820644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437337AbfITGJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:09:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437288AbfITGJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:09:05 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DE8A493773930587732F;
        Fri, 20 Sep 2019 14:09:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:08:52 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/32] gdrom: Use pr_warn instead of pr_warning
Date:   Fri, 20 Sep 2019 14:25:22 +0800
Message-ID: <20190920062544.180997-11-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/cdrom/gdrom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 6626c84f66d1..5b21dc421c94 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -742,7 +742,7 @@ static int probe_gdrom(struct platform_device *devptr)
 	int err;
 	/* Start the device */
 	if (gdrom_execute_diagnostic() != 1) {
-		pr_warning("ATA Probe for GDROM failed\n");
+		pr_warn("ATA Probe for GDROM failed\n");
 		return -ENODEV;
 	}
 	/* Print out firmware ID */
@@ -814,7 +814,7 @@ static int probe_gdrom(struct platform_device *devptr)
 probe_fail_no_mem:
 	unregister_blkdev(gdrom_major, GDROM_DEV_NAME);
 	gdrom_major = 0;
-	pr_warning("Probe failed - error is 0x%X\n", err);
+	pr_warn("Probe failed - error is 0x%X\n", err);
 	return err;
 }
 
-- 
2.20.1

