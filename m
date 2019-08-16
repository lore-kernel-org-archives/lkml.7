Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7814C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E3321655
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfHPIi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:38:27 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:42029 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfHPIiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:38:24 -0400
IronPort-SDR: RJZm/sqCpAg/9VhwN7nFAbJLn6zQut+eBmzykLESb6oVm33d2okNSH4uQMqp13U+ppgCfd2f/Q
 HuU/ADWwk/YE1z4fenYxGdNmqVweUsWFAgrv/Q15CzvN/6xp+UMsgOcHSEqeSQFlFDLctkSZ5N
 bmd5tMbU4alooeyJ6H3J95QTjcrhddfZTg/TJIABJkq/wmj59UNmb99ttHAKRLXok2Ziyr2STM
 Ke31aMH2q+FTSeoHeViCibXC9hzDmcHHjznp3IezuHLwDHPd5CoQYEveahGkP8L3pbeahbs4Cc
 PZo=
X-IronPort-AV: E=Sophos;i="5.64,391,1559548800"; 
   d="scan'208";a="40507246"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 16 Aug 2019 00:38:24 -0800
IronPort-SDR: TwI2cGILNfUXPy7hIcq5ZgXVHAbdNuBgd6LTOssOO22f7jyC3P2uOeqUeU85sQ9H3WvkwduU1K
 vOKjizE8KbbV/Sgr33GE9jzjItMAYGgV17mEH4FK/UBG06KvAQRxNiRyE8zXf2BmtLrwaDtl1P
 WsiFyhZnDaW70d0BYsmgHrGM+OsQ56g6LywRGTrm4UhqotkgSUB2n0jWOpCje3HYGSmFTLglB7
 O5GUOY2MKNq35dhIxYvtwla2IIupSJq3m8sNgxk/MJOQRi9hVmWq6EdUwuDWPEvSYquYHmxqQE
 lcU=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <nick@shmanahar.org>, <dmitry.torokhov@gmail.com>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiada_wang@mentor.com>, <george_davis@mentor.com>
Subject: [PATCH v1 56/63] Input: atmel_mxt_ts: Use complete when in_bootloader true
Date:   Fri, 16 Aug 2019 17:38:23 +0900
Message-ID: <20190816083830.19553-2-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190816083830.19553-1-jiada_wang@mentor.com>
References: <20190816083830.19553-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dean Jenkins <Dean_Jenkins@mentor.com>

In mxt_interrupt(), complete(&data->chg_completion) was
called everytime mxt_interrupt() ran which is unnecessary.

mxt_regulator_enable() sets data->in_bootloader to true and
waits for the completion indication for data->chg_completion
to be set by mxt_interrupt().

mxt_interrupt() already has a test for data->in_bootloader
being true so move complete(&data->chg_completion) inside
that test.

Here is some analysis of some old commits relating to the
usage of complete(&data->chg_completion):

e6c4b6160d2 ("Input: atmel_mxt_ts - rename bl_completion to
chg_completion")

This old commit moved the "complete" statement from inside a
test for data->in_bootloader being true to run everytime
mxt_interrupt() executed. It is unclear why this was done.

This new commit reverses that modification back to the original
implementation.

4c814dd5c6ae ("Input: atmel_mxt_ts - make bootloader interrupt
driven")

This old commit modified mxt_load_fw() to no longer use the
data->chg_completion solution so only mxt_regulator_enable()
uses the data->chg_completion solution.

Therefore, only mxt_regulator_enable() now needs to be
supported by the data->chg_completion solution.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Sanjeev Chugh <sanjeev_chugh@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 40263ef79e8e..64a1a6815d56 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1631,9 +1631,9 @@ static irqreturn_t mxt_interrupt(int irq, void *dev_id)
 	struct mxt_data *data = dev_id;
 	int ret;
 
-	complete(&data->chg_completion);
-
 	if (data->in_bootloader) {
+		complete(&data->chg_completion);
+
 		if (data->flash && &data->flash->work)
 			cancel_delayed_work_sync(&data->flash->work);
 
-- 
2.19.2

