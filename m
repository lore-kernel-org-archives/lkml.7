Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB737C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADFA26B6E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfEaPPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:15:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51828 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbfEaPPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:15:33 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D5854712A6994FC3F9D2;
        Fri, 31 May 2019 23:15:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Fri, 31 May 2019 23:15:16 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] misc: mic: scif: fix double free of scif_dev
Date:   Fri, 31 May 2019 23:23:24 +0800
Message-ID: <20190531152324.20534-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_scif_init() free scif_dev in the free_sdev erro path,
but _scif_exit will free it again when module exit, it
cause BUG_ON issue,

  kernel BUG at mm/slub.c:3944!
  invalid opcode: 0000 [#1] SMP KASAN PTI

Set scif_dev to NULL in scif_destroy_scifdev() to fix it.

Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/misc/mic/scif/scif_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/mic/scif/scif_main.c b/drivers/misc/mic/scif/scif_main.c
index 36d847af1209..7f9ce0fe1e24 100644
--- a/drivers/misc/mic/scif/scif_main.c
+++ b/drivers/misc/mic/scif/scif_main.c
@@ -142,6 +142,7 @@ static int scif_setup_scifdev(void)
 static void scif_destroy_scifdev(void)
 {
 	kfree(scif_dev);
+	scif_dev = NULL;
 }
 
 static int scif_probe(struct scif_hw_dev *sdev)
-- 
2.20.1

