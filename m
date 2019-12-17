Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EB8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E602820717
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLQIfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:35:34 -0500
Received: from smtpbgeu1.qq.com ([52.59.177.22]:36628 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfLQIfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:35:33 -0500
X-QQ-mid: bizesmtp24t1576571691t7r7xrsr
Received: from wuxy.com (unknown [183.62.170.245])
        by esmtp10.qq.com (ESMTP) with 
        id ; Tue, 17 Dec 2019 16:34:43 +0800 (CST)
X-QQ-SSF: 01400000002000Z0WK40000A0000000
X-QQ-FEAT: mJep2VbaKxbBTqLacDfKO4WISokeKXELn+ZwA41XZ5LPjvf2S0xAsDt6KLAP3
        cxBadapbGqQa/Jn946ifkrkP/7DXr78G2L0SQEaUIWpuYdVN0hctJzdvnYuzfKRypk6uKI6
        Bw3hRrvlbggiQsERASLUvZqcYKi0HdtjT8xuU0gux19Sf5hEdvHQP4epm1YNcbUMP3g160s
        x8MBybLGCffV3bOd+NWyjIFYPM5QuTTZ8hVshxi5rOy02JuP9PNhKndlbRfm/+1wWd97vnR
        aw4YmK2SyAHKLccRJqNtWWP93oC6xYxl8oZfcmST2bnTnlbx/riiZ7f2g9GyItpKfIsTRqh
        M3UmuKpqbs1/hjhAmo=
X-QQ-GoodBg: 2
From:   wuxy@bitland.com.cn
To:     kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        evgreen@chromium.org, rajatja@google.com
Cc:     wuxy@bitland.com.cn, wuxy <wuxy@bitland.corp-partner.google.com>
Subject: [PATCH] nvme: Add quirk for "SAMSUNG MZALQ128HBHQ-000L2"
Date:   Tue, 17 Dec 2019 16:34:30 +0800
Message-Id: <20191217083430.3269-1-wuxy@bitland.com.cn>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bitland.com.cn:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wuxy <wuxy@bitland.corp-partner.google.com>

Samsung SSD with model number:SAMSUNG MZALQ128HBHQ-000L2 has no response
when doing the "suspend/resume" test.This patch applied
NVME_QUIRK_SIMPLE_SUSPEND to fix this issue.Run the 2500 cycles
"suspend/resume" test after applying this patch and the issue can not
be reproduced again.Co-work with Samsung,they will fix this issue
in future firmware.

BUG= https://partnerissuetracker.corp.google.com/issues/144257635
TEST= run 2500 cycles "suspend/resume" test,the result is passed.

Signed-off-by: Xingyu Wu <wuxy@bitland.corp-partner.google.com>
---
 drivers/nvme/host/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 667f18f465be..d16d12abec50 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2414,6 +2414,16 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
 		.vid = 0x14a4,
 		.fr = "22301111",
 		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
+	},
+	{
+		/*
+		 * This Samsung SSD encountered no repsonse issue when
+		 * running suspend to idle test.
+		 * Samsung will fix this issue in future firmware.
+		 */
+		.vid = 0x144d,
+		.mn = "SAMSUNG MZALQ128HBHQ-000L2",
+		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
 	}
 };
 
-- 
2.17.1



