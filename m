Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB0FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7DE20644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390454AbfITGKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:10:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57872 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437280AbfITGJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:09:04 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C1A257DC74FEADF82FF1;
        Fri, 20 Sep 2019 14:09:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:08:51 +0800
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
CC:     <wangkefeng.wang@huawei.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, <drbd-dev@lists.linbit.com>
Subject: [PATCH 09/32] drbd: Use pr_warn instead of pr_warning
Date:   Fri, 20 Sep 2019 14:25:21 +0800
Message-ID: <20190920062544.180997-10-wangkefeng.wang@huawei.com>
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

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/block/drbd/drbd_nl.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 5d52a2d32155..de2f94d0103a 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -268,19 +268,18 @@ static int drbd_adm_prepare(struct drbd_config_context *adm_ctx,
 	/* some more paranoia, if the request was over-determined */
 	if (adm_ctx->device && adm_ctx->resource &&
 	    adm_ctx->device->resource != adm_ctx->resource) {
-		pr_warning("request: minor=%u, resource=%s; but that minor belongs to resource %s\n",
-				adm_ctx->minor, adm_ctx->resource->name,
-				adm_ctx->device->resource->name);
+		pr_warn("request: minor=%u, resource=%s; but that minor belongs to resource %s\n",
+			adm_ctx->minor, adm_ctx->resource->name,
+			adm_ctx->device->resource->name);
 		drbd_msg_put_info(adm_ctx->reply_skb, "minor exists in different resource");
 		return ERR_INVALID_REQUEST;
 	}
 	if (adm_ctx->device &&
 	    adm_ctx->volume != VOLUME_UNSPECIFIED &&
 	    adm_ctx->volume != adm_ctx->device->vnr) {
-		pr_warning("request: minor=%u, volume=%u; but that minor is volume %u in %s\n",
-				adm_ctx->minor, adm_ctx->volume,
-				adm_ctx->device->vnr,
-				adm_ctx->device->resource->name);
+		pr_warn("request: minor=%u, volume=%u; but that minor is volume %u in %s\n",
+			adm_ctx->minor, adm_ctx->volume,
+			adm_ctx->device->vnr, adm_ctx->device->resource->name);
 		drbd_msg_put_info(adm_ctx->reply_skb, "minor exists as different volume");
 		return ERR_INVALID_REQUEST;
 	}
-- 
2.20.1

