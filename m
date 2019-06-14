Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20558C46477
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB2B21473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfFNF00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:26:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61337 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725767AbfFNF0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:26:25 -0400
X-UUID: e7243e1b967d415297b93d470f28f072-20190614
X-UUID: e7243e1b967d415297b93d470f28f072-20190614
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <jjian.zhou@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 390729238; Fri, 14 Jun 2019 13:26:17 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Jun 2019 13:26:16 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Jun 2019 13:26:15 +0800
From:   Jjian Zhou <jjian.zhou@mediatek.com>
To:     <ulf.hansson@linaro.org>, <chaotian.jing@mediatek.com>,
        <matthias.bgg@gmail.com>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yong.mao@mediatek.com>, <srv_heupstream@mediatek.com>,
        jjian zhou <jjian.zhou@mediatek.com>
Subject: [PATCH 2/2] mmc: mediatek: fix SDIO IRQ detection issue
Date:   Fri, 14 Jun 2019 13:26:10 +0800
Message-ID: <1560489970-30467-2-git-send-email-jjian.zhou@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560489970-30467-1-git-send-email-jjian.zhou@mediatek.com>
References: <1560489970-30467-1-git-send-email-jjian.zhou@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jjian zhou <jjian.zhou@mediatek.com>

If cmd19 timeout or response crcerr occurs during execute_tuning(),
it need invoke msdc_reset_hw(). Otherwise SDIO IRQ can't be detected.

Signed-off-by: jjian zhou <jjian.zhou@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Signed-off-by: Yong Mao <yong.mao@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 29992ae..df8f09d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1031,6 +1031,8 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
 	msdc_track_cmd_data(host, mrq->cmd, mrq->data);
 	if (mrq->data)
 		msdc_unprepare_data(host, mrq);
+	if (host->error)
+		msdc_reset_hw(host);
 	mmc_request_done(host->mmc, mrq);
 }

--
1.9.1

