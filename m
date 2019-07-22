Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7504C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8884121921
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jcb8f4kb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfGVNKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:10:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33136 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730264AbfGVNKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:10:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so17364371pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mpV9sMLf9/xjtpErFC1dOCeG+Wr6jt6mRJVLIFsCwso=;
        b=Jcb8f4kbGdWtCM+71SbE8WVDGhwE0iqJkaDP/FPTfohqgORzLGvFzTWAB2KVkr0gH8
         fVaStVpD6w4OWcHQvsXI6ju4Nr1SaF7thQHaacKDdkmLI9jOILeOci4K+vhY57cToh+R
         nfh/dUfh1k9NUxsLvYwpG+KlyoEJmCvVIUuBAchnpzxisLw+xtHkFseMkiaCRVEsNNN4
         IkUkO1kAh6k/d2qsCAAWI9v3pkFO+wVCj2Mo1Uql3alLP9vvuVmtPy9OSmPo+AFGN0w6
         ZDqg6lepl5oWl+wdGZwk16EPGA7Or2aVMuh9OfQn23tYjYJ+Bty14K5PaEhMCGdHurgz
         T/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mpV9sMLf9/xjtpErFC1dOCeG+Wr6jt6mRJVLIFsCwso=;
        b=Q2urEqSb3FJOmTdq7V2g9DcWx71SbLiqjvg01CTVwflUVP+m+l6YzofGgWtXyFK5I8
         LTJLCnvU9oXxx7+yfU7qo/UoS/Fxi2a5nScr8sS+faphXh1S13cQYKbVc3YOU9Cm4ZZV
         rk/lpcUglw+VGC1soXKnA+tQrjQ6AlNMg99clr1QNjQh9y2hMuS8rfuiTHfoBK8ZVDJl
         jwQ/9Ujvqww9hAznuIOOFu86Uk0UBMqsGIcRy7k2VkDx8n8znTXJJK1YQWuOO4eBcUZ9
         QPxND5LNl3pUr0R3jHfilcnVbc2D8eJQaLaZ+c/Rs6cFv5PjzvsDhD0n2x90an0gIWRQ
         RGbw==
X-Gm-Message-State: APjAAAUrpb/iq4ktUffR9ODfTZpaQnwO+4Biut4RCmIg7+TzYXWxbojv
        E2IFiVRyVkV7X4cAwvQ5k+GtkA==
X-Google-Smtp-Source: APXvYqzTrjk/lkHexHJCp1CEZbs0dzPdQ3rwVQKoH4tMSuMsFtbRikyrgk3QdukUYKjQ9F7Qzt9dcw==
X-Received: by 2002:a63:5402:: with SMTP id i2mr44468946pgb.414.1563801021977;
        Mon, 22 Jul 2019 06:10:21 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p19sm47013192pfn.99.2019.07.22.06.10.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 06:10:21 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     axboe@kernel.dk, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [RFC PATCH 4/7] mmc: host: sdhci: Factor out the command configuration
Date:   Mon, 22 Jul 2019 21:09:39 +0800
Message-Id: <63fb32f58cb11aafdd12c84126b191090af3a31a.1563782844.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the SD command configuration into one separate function to simplify
the sdhci_send_command(). Moreover this function can be used to support
ADMA3 transfer mode in following patches.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |   65 +++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e57a5b7..5760b7c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1339,9 +1339,43 @@ static void sdhci_finish_data(struct sdhci_host *host)
 	}
 }
 
-void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+static int sdhci_get_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int flags;
+
+	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
+		pr_err("%s: Unsupported response type!\n",
+			mmc_hostname(host->mmc));
+		cmd->error = -EINVAL;
+		sdhci_finish_mrq(host, cmd->mrq);
+		return -EINVAL;
+	}
+
+	if (!(cmd->flags & MMC_RSP_PRESENT))
+		flags = SDHCI_CMD_RESP_NONE;
+	else if (cmd->flags & MMC_RSP_136)
+		flags = SDHCI_CMD_RESP_LONG;
+	else if (cmd->flags & MMC_RSP_BUSY)
+		flags = SDHCI_CMD_RESP_SHORT_BUSY;
+	else
+		flags = SDHCI_CMD_RESP_SHORT;
+
+	if (cmd->flags & MMC_RSP_CRC)
+		flags |= SDHCI_CMD_CRC;
+	if (cmd->flags & MMC_RSP_OPCODE)
+		flags |= SDHCI_CMD_INDEX;
+
+	/* CMD19 is special in that the Data Present Select should be set */
+	if (cmd->data || cmd->opcode == MMC_SEND_TUNING_BLOCK ||
+	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
+		flags |= SDHCI_CMD_DATA;
+
+	return SDHCI_MAKE_CMD(cmd->opcode, flags);
+}
+
+void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	int command;
 	u32 mask;
 	unsigned long timeout;
 
@@ -1391,32 +1425,9 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	sdhci_set_transfer_mode(host, cmd);
 
-	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
-		pr_err("%s: Unsupported response type!\n",
-			mmc_hostname(host->mmc));
-		cmd->error = -EINVAL;
-		sdhci_finish_mrq(host, cmd->mrq);
+	command = sdhci_get_command(host, cmd);
+	if (command < 0)
 		return;
-	}
-
-	if (!(cmd->flags & MMC_RSP_PRESENT))
-		flags = SDHCI_CMD_RESP_NONE;
-	else if (cmd->flags & MMC_RSP_136)
-		flags = SDHCI_CMD_RESP_LONG;
-	else if (cmd->flags & MMC_RSP_BUSY)
-		flags = SDHCI_CMD_RESP_SHORT_BUSY;
-	else
-		flags = SDHCI_CMD_RESP_SHORT;
-
-	if (cmd->flags & MMC_RSP_CRC)
-		flags |= SDHCI_CMD_CRC;
-	if (cmd->flags & MMC_RSP_OPCODE)
-		flags |= SDHCI_CMD_INDEX;
-
-	/* CMD19 is special in that the Data Present Select should be set */
-	if (cmd->data || cmd->opcode == MMC_SEND_TUNING_BLOCK ||
-	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
-		flags |= SDHCI_CMD_DATA;
 
 	timeout = jiffies;
 	if (host->data_timeout)
@@ -1427,7 +1438,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		timeout += 10 * HZ;
 	sdhci_mod_timer(host, cmd->mrq, timeout);
 
-	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
+	sdhci_writew(host, command, SDHCI_COMMAND);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
 
-- 
1.7.9.5

