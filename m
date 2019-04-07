Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C70C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 03:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE8220B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 03:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfDGDOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 23:14:34 -0400
Received: from www.osadl.org ([62.245.132.105]:39303 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfDGDOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 23:14:33 -0400
Received: from localhost.localdomain (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x373DS4n003372;
        Sun, 7 Apr 2019 05:13:28 +0200
From:   Nicholas Mc Guire <hofrat@opentech.at>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@opentech.at>
Subject: [PATCH RFC] clk: ux500: add range to usleep_range
Date:   Sun,  7 Apr 2019 05:13:24 +0200
Message-Id: <1554606804-29453-1-git-send-email-hofrat@opentech.at>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Providing a range for usleep_range() allows the hrtimer subsystem to
coalesce timers - the delay is runtime configurable so a factor 2
is taken to provide the range.

Signed-off-by: Nicholas Mc Guire <hofrat@opentech.at>
---

Problem located with an experimental coccinelle script                                       
                                                                                             
Q: Basically usleep_range() with min == max never makes much sense notably                      
   in non-atomic context. If the factor of 2 is tolerable or a fixed
   offset of e.g. 1000 would be more suitable is not clear to me - maybe
   someone familiar with that driver can clarify this.
                                                                                             
Patch was compile tested with: u8500_defconfig (implies COMMON_CLK=y)
(with some sparse warnings about not implemented system calls)                               
                                                                                             
Patch is against 5.1-rc3 (localversion-next is next=20190405)                                

 drivers/clk/ux500/clk-sysctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysctrl.c
index 7c0403b..a1fa3fb 100644
--- a/drivers/clk/ux500/clk-sysctrl.c
+++ b/drivers/clk/ux500/clk-sysctrl.c
@@ -42,7 +42,7 @@ static int clk_sysctrl_prepare(struct clk_hw *hw)
 				clk->reg_bits[0]);
 
 	if (!ret && clk->enable_delay_us)
-		usleep_range(clk->enable_delay_us, clk->enable_delay_us);
+		usleep_range(clk->enable_delay_us, clk->enable_delay_us*2);
 
 	return ret;
 }
-- 
2.1.4

