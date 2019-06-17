Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3670C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62E02084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfFQNRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:17:53 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:49307 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQNRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:17:52 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N0WsG-1iWsNR0BuO-00wVmv; Mon, 17 Jun 2019 15:17:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Joao Pinto <jpinto@synopsys.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: dw-edma: fix unnecessary stack usage
Date:   Mon, 17 Jun 2019 15:16:45 +0200
Message-Id: <20190617131733.2429469-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZUbTNmaSwGeDjg5kJAJ209+38Uz+s7zu07F40JOBcXULLKMY+Dd
 haG1wttL/sJEKM+I64egpZbGw5FwJ6nY8bW6UUy0IPvR87KHQr22ieap1nhW4ZmM5rYZtE2
 VV2zOVWSAaV9H3VPTPh1VAW2Fv5BwMQEsPdjWPtjpd1FgmlflschtXvaGBPacY2lNd2dMlQ
 zz1tOLegABzM8JG9aJKKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vmZ0xXJglrE=:FY7PReLUqHxSf9kdQMMDSo
 UIf61Ci9DrqVXzGnPSDo/5Ija5ZuZ6onG5xZSAMWQGwGu7KIcahkGJkKONYMYSJz/AQ4Ctm6Z
 BGyibEcw4eYYFMkUbzpRUVVWlPGncbTdpstY58iQ1BvvxAyHnvD5ebKY+m8R8ASdIIWeQH1fp
 iMbS0vWiOyjL1iIj1InaI49Nuchc40GXqlU+x68U+Hi91bx3Hmx5PLjCCfC8DQ9AwLTXnY6k2
 ycYD4tUXdfojDlLkLXkmxz0mbMl5YrJj5+ZYUz7oKtxfZ4/4U30uKE1vUTFMb+sxA4N0Flh5n
 HwB1/r9gTDURocON5gwF4t4r6WwjqzzkvCTRNy0JVzpAi8BXzM3EWfSRTU0SeDIF12Ey4THZ3
 kda5SsIHn5ItQqdImO53Ocb1mPZfB1MwS0550qJTVIuwN7G6DTFR9oqepwJ4MEQ/KIMUrocvu
 XrZds2EHJ6V2Ah4O21hzX7Id+yJfI8O/5SEvtFeeMkSvXFnZILKqeNSLuUr6wyJtUI3iKD8nV
 hu9+NJ3ypATY+HbkVeQ+7Uu0npV/pi8t43rT0VEL2E+44/M+yGtYvFAD00GCB+x05MX+kguVl
 qluVYJhzhry83NpOXM4f/342H2mxawbsQAlv2Z/3zGlG9JDt10faaldbVfehd1VMLcYatlfTD
 2WFWqYsU/v2uiUjldYbOrKXIxwwTohIfy9AGMKhAhvzinWB0Q5I3kvwvfa8FemC2n3smCdK0u
 KfVtF68AVmgtzareniap6++g6XSXddg800/M5A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Putting large constant data on the stack causes unnecessary overhead
and stack usage:

drivers/dma/dw-edma/dw-edma-v0-debugfs.c:285:6: error: stack frame size of 1376 bytes in function 'dw_edma_v0_debugfs_on' [-Werror,-Wframe-larger-than=]

Mark the variable 'static const' in order for the compiler to move it
into the .rodata section where it does no such harm.

Fixes: 305aebeff879 ("dmaengine: Add Synopsys eDMA IP version 0 debugfs support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index affa1ccaf7a0..42739508c0d8 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -48,7 +48,7 @@ static struct {
 } lim[2][EDMA_V0_MAX_NR_CH];
 
 struct debugfs_entries {
-	char					name[24];
+	const char				*name;
 	dma_addr_t				*reg;
 };
 
-- 
2.20.0

