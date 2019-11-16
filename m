Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211EFC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E147421845
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920319;
	bh=Cm8oqydL25NKOv9Ru7j+5HUTOOWMEduozul5gSK8JoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H9SKcRmJF2Cl/L4Jy0JJiK+02Y5JFmY/qKkI+JM7iQ+aubh0kmcObtlwDrv65gen6
	 gDUNvoNv7x3bCEmZCGoaCeKtwOvR+m4v1qx04t2FstQW8GF7yxskpjfG2Kh3uOJS6F
	 o6tyH+YG/EFCr0Wv4ITW79Nld27fCVg+L9xbgmec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfKPPvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:51:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730707AbfKPPvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:51:17 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AEF3208CE;
        Sat, 16 Nov 2019 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919476;
        bh=Cm8oqydL25NKOv9Ru7j+5HUTOOWMEduozul5gSK8JoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tiNOboaqMNlnHFR0qGu9SyfjnLr4lQ/twD6dBHlaau895Gk5fxjOB/vL+teX7RdIK
         20WiU6kRfGGJtNyrTZFHg17mq8Lj1C6SB3Lsvccs/rE1rvYkii65niTnf1PRieNs5Q
         jxv3zqHu9Y+T8FAz+JlTeDGjf3ubhBLJVr5+vJAo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 10/99] mmc: mediatek: fix cannot receive new request when msdc_cmd_is_ready fail
Date:   Sat, 16 Nov 2019 10:49:33 -0500
Message-Id: <20191116155103.10971-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155103.10971-1-sashal@kernel.org>
References: <20191116155103.10971-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chaotian Jing <chaotian.jing@mediatek.com>

[ Upstream commit f38a9774ddde9d79b3487dd888edd8b8623552af ]

when msdc_cmd_is_ready return fail, the req_timeout work has not been
inited and cancel_delayed_work() will return false, then, the request
return directly and never call mmc_request_done().

so need call mod_delayed_work() before msdc_cmd_is_ready()

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 6f9535e5e584b..7fc6ce3811421 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -870,6 +870,7 @@ static void msdc_start_command(struct msdc_host *host,
 	WARN_ON(host->cmd);
 	host->cmd = cmd;
 
+	mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
 	if (!msdc_cmd_is_ready(host, mrq, cmd))
 		return;
 
@@ -881,7 +882,6 @@ static void msdc_start_command(struct msdc_host *host,
 
 	cmd->error = 0;
 	rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
-	mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
 
 	sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
 	writel(cmd->arg, host->base + SDC_ARG);
-- 
2.20.1

