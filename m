Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F1AC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E872220656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfF1EQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:16:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37082 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbfF1EQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:16:38 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 37F383B7DBA811E7F22C;
        Fri, 28 Jun 2019 12:16:36 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Fri, 28 Jun 2019
 12:16:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tony@atomide.com>, <rogerq@ti.com>, <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] bus: ti-sysc: remove set but not used variable 'quirks'
Date:   Fri, 28 Jun 2019 12:10:54 +0800
Message-ID: <20190628041054.46216-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/bus/ti-sysc.c: In function sysc_reset:
drivers/bus/ti-sysc.c:1452:50: warning: variable quirks set but not used [-Wunused-but-set-variable]

It is never used since commit e0db94fe87da ("bus: ti-sysc: Make
OCP reset work for sysstatus and sysconfig reset bits")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/bus/ti-sysc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index e6deabd..8cb5351 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1558,12 +1558,11 @@ static int sysc_rstctrl_reset_deassert(struct sysc *ddata, bool reset)
  */
 static int sysc_reset(struct sysc *ddata)
 {
-	int sysc_offset, syss_offset, sysc_val, rstval, quirks, error = 0;
+	int sysc_offset, syss_offset, sysc_val, rstval, error = 0;
 	u32 sysc_mask, syss_done;
 
 	sysc_offset = ddata->offsets[SYSC_SYSCONFIG];
 	syss_offset = ddata->offsets[SYSC_SYSSTATUS];
-	quirks = ddata->cfg.quirks;
 
 	if (ddata->legacy_mode || sysc_offset < 0 ||
 	    ddata->cap->regbits->srst_shift < 0 ||
-- 
2.7.4


