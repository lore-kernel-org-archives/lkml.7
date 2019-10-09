Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C576ECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA9D21929
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbfJIO7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:59:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3287 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728019AbfJIO7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:59:15 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2A3E64E2F09D693439AE;
        Wed,  9 Oct 2019 22:59:11 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Wed, 9 Oct 2019 22:59:04 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mchehab@kernel.org>, <sean@mess.org>, <hansverk@cisco.com>,
        <daniel.vetter@ffwll.ch>
CC:     <linux-media@vger.kernel.org>, <zhongjiang@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] media: tuners/qm1d1c0042: Use DIV_ROUND_CLOSEST directly to make it readable
Date:   Wed, 9 Oct 2019 22:55:23 +0800
Message-ID: <1570632925-14926-3-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1570632925-14926-1-git-send-email-zhongjiang@huawei.com>
References: <1570632925-14926-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel.h macro DIV_ROUND_CLOSEST performs the computation (x + d/2)/d
but is perhaps more readable.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/media/tuners/qm1d1c0042.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/tuners/qm1d1c0042.c b/drivers/media/tuners/qm1d1c0042.c
index 83ca5dc..0e26d22 100644
--- a/drivers/media/tuners/qm1d1c0042.c
+++ b/drivers/media/tuners/qm1d1c0042.c
@@ -206,7 +206,7 @@ static int qm1d1c0042_set_params(struct dvb_frontend *fe)
 	if (ret < 0)
 		return ret;
 
-	a = (freq + state->cfg.xtal_freq / 2) / state->cfg.xtal_freq;
+	a = DIV_ROUND_CLOSEST(freq, state->cfg.xtal_freq);
 
 	state->regs[0x06] &= 0x40;
 	state->regs[0x06] |= (a - 12) / 4;
-- 
1.7.12.4

