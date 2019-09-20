Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED36C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC5F20644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437316AbfITGJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:09:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57846 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437276AbfITGJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:09:05 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B9C70880603586B525DC;
        Fri, 20 Sep 2019 14:09:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:08:55 +0800
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
CC:     <wangkefeng.wang@huawei.com>
Subject: [PATCH 13/32] ide: Use pr_warn instead of pr_warning
Date:   Fri, 20 Sep 2019 14:25:25 +0800
Message-ID: <20190920062544.180997-14-wangkefeng.wang@huawei.com>
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

Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/ide/tx4938ide.c | 2 +-
 drivers/ide/tx4939ide.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
index 40a3f55b08dd..962eb92501b5 100644
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -46,7 +46,7 @@ static void tx4938ide_tune_ebusc(unsigned int ebus_ch,
 	while ((shwt * 4 + wt + (wt ? 2 : 3)) * cycle < t->cycle)
 		shwt++;
 	if (shwt > 7) {
-		pr_warning("tx4938ide: SHWT violation (%d)\n", shwt);
+		pr_warn("tx4938ide: SHWT violation (%d)\n", shwt);
 		shwt = 7;
 	}
 	pr_debug("tx4938ide: ebus %d, bus cycle %dns, WT %d, SHWT %d\n",
diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
index 88d132edc4e3..d5e871fe840d 100644
--- a/drivers/ide/tx4939ide.c
+++ b/drivers/ide/tx4939ide.c
@@ -363,9 +363,9 @@ static int tx4939ide_dma_test_irq(ide_drive_t *drive)
 	case TX4939IDE_INT_HOST | TX4939IDE_INT_XFEREND:
 		dma_stat = tx4939ide_readb(base, TX4939IDE_DMA_Stat);
 		if (!(dma_stat & ATA_DMA_INTR))
-			pr_warning("%s: weird interrupt status. "
-				   "DMA_Stat %#02x int_ctl %#04x\n",
-				   hwif->name, dma_stat, ctl);
+			pr_warn("%s: weird interrupt status. "
+				"DMA_Stat %#02x int_ctl %#04x\n",
+				hwif->name, dma_stat, ctl);
 		found = 1;
 		break;
 	}
-- 
2.20.1

