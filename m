Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7D6C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 04:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5AB27114
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 04:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbfFAEEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 00:04:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbfFAEEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 00:04:06 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8CF64136B7EF2269589D;
        Sat,  1 Jun 2019 12:04:03 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Sat, 1 Jun 2019 12:03:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Allison Randal" <allison@lohutok.net>
CC:     YueHaibing <yuehaibing@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ALSA: lx6464es - Remove set but not used variables 'orun_mask, urun_mask'
Date:   Sat, 1 Jun 2019 04:12:14 +0000
Message-ID: <20190601041214.99366-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

sound/pci/lx6464es/lx_core.c: In function 'lx_interrupt_handle_async_events':
sound/pci/lx6464es/lx_core.c:990:6: warning:
 variable 'urun_mask' set but not used [-Wunused-but-set-variable]
sound/pci/lx6464es/lx_core.c:989:6: warning:
 variable 'orun_mask' set but not used [-Wunused-but-set-variable]

They are never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/pci/lx6464es/lx_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 9236a1a8c49b..dd3a873777eb 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -986,8 +986,6 @@ static int lx_interrupt_handle_async_events(struct lx6464es *chip, u32 irqsrc,
 	 * Stat[8]	LSB overrun
 	 * */
 
-	u64 orun_mask;
-	u64 urun_mask;
 	int eb_pending_out = (irqsrc & MASK_SYS_STATUS_EOBO) ? 1 : 0;
 	int eb_pending_in  = (irqsrc & MASK_SYS_STATUS_EOBI) ? 1 : 0;
 
@@ -1010,9 +1008,6 @@ static int lx_interrupt_handle_async_events(struct lx6464es *chip, u32 irqsrc,
 			    *r_notified_out_pipe_mask);
 	}
 
-	orun_mask = ((u64)stat[7] << 32) + stat[8];
-	urun_mask = ((u64)stat[5] << 32) + stat[6];
-
 	/* todo: handle xrun notification */
 
 	return err;





