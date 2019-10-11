Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE18ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2D821D71
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ylwFiyxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfJKNPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:15:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21984 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728474AbfJKNPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:15:43 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9BD1K0F020165;
        Fri, 11 Oct 2019 15:15:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=A5UXOhJp6r9IM2P0mkSRaA0Nf52Snwi5w58uXQyn4sk=;
 b=ylwFiyxeVMzap6mmE2S6yfwfiNzqJ65gJdfrZ0WfuK4y25EevPEkCBzia9BYgJrUe2ye
 LEhb0Jt9RXLXEvtzH+BT7NbSxFoVO1Ci0cSQHcRrBUKls8lLtJYOoR8jW1lY5QUpvVje
 aWsZgFPVoEYjEdO7xB1fxPsV9+naCzmJ2GlNd3suLee6+jFXRQ2P0rISUVuYM5Ybn/Nt
 rWpXYUgLyBiRxNC49jPpvjhwoIQXMJF3tM84n1dax5nlpA4dy4mVNCu/UWVIWg3HEGl7
 PcroVnvLpX4l2I4AOUV/uyf1Zcl7m6Us+Nq8cTtCFZbrhmBSuRR9crWsBWYjweelWYP9 AA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegn1a0kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 15:15:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 26B6910002A;
        Fri, 11 Oct 2019 15:15:31 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 10CB12BEC72;
        Fri, 11 Oct 2019 15:15:31 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 11 Oct
 2019 15:15:30 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 11 Oct
 2019 15:15:30 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 1/2] mmc: add unstuck function if host is in deadlock state
Date:   Fri, 11 Oct 2019 15:15:01 +0200
Message-ID: <20191011131502.29579-2-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011131502.29579-1-ludovic.Barre@st.com>
References: <20191011131502.29579-1-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-11_08:2019-10-10,2019-10-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

After a request a host may be in deadlock state, and wait
a specific action to unstuck the hardware block before
re-sending a new command.

This patch adds an optional callback mmc_hw_unstuck which
allows the host to unstuck the controller. In order to avoid
a critical context, this callback must be called when the
request is completed. Depending the mmc request, the completion
function is defined by mrq->done and could be in block.c or core.c.

mmc_hw_unstuck is called if the host returns an cmd/sbc/stop/data
DEADLK error.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/core/block.c | 11 +++++++++++
 drivers/mmc/core/core.c  | 35 +++++++++++++++++++++++++++++++++--
 include/linux/mmc/core.h |  1 +
 include/linux/mmc/host.h |  7 +++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2c71a434c915..2f723e2f5fde 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1799,6 +1799,17 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
 	u32 blocks;
 	int err;
 
+	/*
+	 * if the host return a deadlock, it needs to be unstuck
+	 * before to send a new command.
+	 */
+	if (brq->sbc.error == -EDEADLK || brq->cmd.error == -EDEADLK ||
+	    brq->stop.error == -EDEADLK || brq->data.error == -EDEADLK) {
+		pr_err("%s: host is in bad state, must be unstuck\n",
+		       req->rq_disk->disk_name);
+		mmc_hw_unstuck(card->host);
+	}
+
 	/*
 	 * Some errors the host driver might not have seen. Set the number of
 	 * bytes transferred to zero in that case.
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 221127324709..43fe59a7403b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -397,6 +397,7 @@ static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 {
 	struct mmc_command *cmd;
+	int sbc_err, stop_err, data_err;
 
 	while (1) {
 		wait_for_completion(&mrq->completion);
@@ -420,8 +421,24 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 				       mmc_hostname(host), __func__);
 			}
 		}
-		if (!cmd->error || !cmd->retries ||
-		    mmc_card_removed(host->card))
+
+		sbc_err =  mrq->sbc ? mrq->sbc->error : 0;
+		stop_err = mrq->stop ? mrq->stop->error : 0;
+		data_err =  mrq->data ? mrq->data->error : 0;
+
+		/*
+		 * if the host return a deadlock, it needs to be unstuck
+		 * before to send a new command.
+		 */
+		if (cmd->error == -EDEADLK || sbc_err == -EDEADLK ||
+		    stop_err == -EDEADLK || data_err == -EDEADLK) {
+			pr_debug("%s: host is in bad state, must be unstuck\n",
+				 mmc_hostname(host));
+			mmc_hw_unstuck(host);
+		}
+
+		if ((!cmd->error && !sbc_err && !stop_err && !data_err) ||
+		    !cmd->retries || mmc_card_removed(host->card))
 			break;
 
 		mmc_retune_recheck(host);
@@ -430,6 +447,12 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
 			 mmc_hostname(host), cmd->opcode, cmd->error);
 		cmd->retries--;
 		cmd->error = 0;
+		if (mrq->sbc)
+			mrq->sbc->error = 0;
+		if (mrq->stop)
+			mrq->stop->error = 0;
+		if (mrq->data)
+			mrq->data->error = 0;
 		__mmc_start_request(host, mrq);
 	}
 
@@ -2161,6 +2184,14 @@ int mmc_sw_reset(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_sw_reset);
 
+void mmc_hw_unstuck(struct mmc_host *host)
+{
+	if (!host->ops->hw_unstuck)
+		return;
+	host->ops->hw_unstuck(host);
+}
+EXPORT_SYMBOL(mmc_hw_unstuck);
+
 static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 {
 	host->f_init = freq;
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b7ba8810a3b5..eb10b8194073 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -173,6 +173,7 @@ void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq);
 int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
 		int retries);
 
+void mmc_hw_unstuck(struct mmc_host *host);
 int mmc_hw_reset(struct mmc_host *host);
 int mmc_sw_reset(struct mmc_host *host);
 void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba703384bea0..8b52cafcd1eb 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -163,6 +163,13 @@ struct mmc_host_ops {
 	void	(*hw_reset)(struct mmc_host *host);
 	void	(*card_event)(struct mmc_host *host);
 
+	/*
+	 * Optional callback, if your host could be in deadlock after a command
+	 * and need a specific action to unstuck the controller before sending
+	 * new command.
+	 */
+	void	(*hw_unstuck)(struct mmc_host *host);
+
 	/*
 	 * Optional callback to support controllers with HW issues for multiple
 	 * I/O. Returns the number of supported blocks for the request.
-- 
2.17.1

