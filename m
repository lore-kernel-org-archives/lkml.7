Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F6EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074092133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDKLEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:04:48 -0400
Received: from www.osadl.org ([62.245.132.105]:39967 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfDKLEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:04:48 -0400
Received: from localhost.localdomain (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3BB4Ikm015352;
        Thu, 11 Apr 2019 13:04:18 +0200
From:   Nicholas Mc Guire <hofrat@opentech.at>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@opentech.at>
Subject: [PATCH V2] clk: ux500: add range to usleep_range
Date:   Thu, 11 Apr 2019 13:04:11 +0200
Message-Id: <1554980651-54136-1-git-send-email-hofrat@opentech.at>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Providing a range for usleep_range() allows the hrtimer subsystem to
coalesce timers - the delay is runtime configurable so a factor 2
is taken to provide the range. With the expected range for
enable_delay_us being milliseconds, the range should lie in the 250us
range which is sufficient for hrtimer optimization.

Signed-off-by: Nicholas Mc Guire <hofrat@opentech.at>
---

Problem located with an experimental coccinelle script                                    
V2: As clarified by Ulf Hansson <ulf.hansson@linaro.org> the delays
    here are typically in the millisecond range - so as proposed
    replace the factor 2 by a 25% increase of max.

Patch was compile tested with: u8500_defconfig (implies COMMON_CLK=y)
(with some unrelated sparse warnings about not implemented system calls)                            
Patch is against 5.1-rc4 (localversion-next is next=20190410)

 drivers/clk/ux500/clk-sysctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysctrl.c
index 7c0403b..698306f 100644
--- a/drivers/clk/ux500/clk-sysctrl.c
+++ b/drivers/clk/ux500/clk-sysctrl.c
@@ -42,7 +42,8 @@ static int clk_sysctrl_prepare(struct clk_hw *hw)
 				clk->reg_bits[0]);
 
 	if (!ret && clk->enable_delay_us)
-		usleep_range(clk->enable_delay_us, clk->enable_delay_us);
+		usleep_range(clk->enable_delay_us, clk->enable_delay_us +
+			     (clk->enable_delay_us >> 2));
 
 	return ret;
 }
-- 
2.1.4

