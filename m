Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C140CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B22B206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxl/JVOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfEGTx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:53:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39057 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEGTx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:53:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so7524286pgi.6;
        Tue, 07 May 2019 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Cj+ea2ryBJNh6qXEQ4f5WItA9NMUT7wCyvk5yPZ6xUA=;
        b=hxl/JVOfbduSun1MHcThyx5YHh0l4V/VxmVCB0Eb6/e+P5FgJINp7Sd0VHSbt8uEy/
         1i5vH1wFXUOJ0OFZz25Ztd1ce2FT3fU3wFHhjVACD5TUf+jBebsN32sx71OvF9yF2T14
         7+xlw4ZDTxTuh1OQAeCGmW1pbeDDdp2GfV854ndaWTcSo2r0+xIiHTJezTYt73etHzhK
         j35jsrv0DBmwHt0YwOBwzq2rNeQM+ad4RyFRuiu87L9txCJ4EofshXlQkOaBrBqIVJjP
         VZfyx8AwIrOo8K/jkyF1eX1iW5roWSREG3I91Ph6IT95GpS6Ul1fSAoVoPWDuRl5AA3C
         mIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Cj+ea2ryBJNh6qXEQ4f5WItA9NMUT7wCyvk5yPZ6xUA=;
        b=GbCg7NaviqtBodwnq2bhQeKFCpQ/+zaQIR9w3QfxsM2bOHUw2PUsxFwMPNPqljjywv
         pn58Cf98QMatNqk67wyvIJVZRLL6qcOg788yJjvhT2nfGPTiZT5Cs52wN8fPvKkbBMXH
         z7UF3FV7ihP9RNp3F6eMG4JvFu8S2uzAxOU/JGClanM5Pxn9i9v7xslRtBRXR/a5vB46
         c8xFCf0zIz9W8Kuu95G7LeLzlQZOjc6Qhv05wXMzVpkQ7MSaJNlIKoRTnDYbz8hNR0CU
         ydX2TAzMacRDkS0NeiN4gbfYyCI+pQN+ntmxyMkyRaEtTWMJt1OUZ8xTEp9qOgqF0/OD
         u1tw==
X-Gm-Message-State: APjAAAVf13YUGkmjI/TmQ21dTVn3i4yc1R51y5wWCJDRMkMpqebDyzSI
        UE/Yy8x2V1u5IKKzkIR/nWU=
X-Google-Smtp-Source: APXvYqxP40uxXfgsZAfE0SOl6Epsu7U43qMRlPsIMxBInAI/t4RsjFn8hUwZvCaxtzS4v2iN7P1SoQ==
X-Received: by 2002:a63:8a4a:: with SMTP id y71mr42195505pgd.270.1557258837219;
        Tue, 07 May 2019 12:53:57 -0700 (PDT)
Received: from localhost.localdomain ([203.192.210.149])
        by smtp.gmail.com with ESMTPSA id i15sm19756130pfr.8.2019.05.07.12.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 12:53:56 -0700 (PDT)
From:   Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Lockwood <lockwood@android.com>,
        Christoph Hellwig <hch@lst.de>,
        "Gustavo A . R . Silva" <garsilva@embeddedor.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
Subject: [PATCH] mmc: android-goldfish: Drop pointer to mmc_host from goldfish_mmc_host
Date:   Wed,  8 May 2019 01:22:29 +0530
Message-Id: <1557258749-29009-1-git-send-email-kamlesh.gurudasani@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver for android-goldfish uses a pointer to get from the private
goldfish_mmc_host structure to the generic mmc_host structure.
However the latter is always immediately preceding the former in
memory, so compute its address with a subtraction (which is cheaper than a
dereference) and drop the superfluous pointer.

No functional change intended.

Signed-off-by: Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
---
 drivers/mmc/host/android-goldfish.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
index 61e4e2a..f6334c2 100644
--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -113,7 +113,6 @@ struct goldfish_mmc_host {
 	struct mmc_request	*mrq;
 	struct mmc_command	*cmd;
 	struct mmc_data		*data;
-	struct mmc_host		*mmc;
 	struct device		*dev;
 	unsigned char		id; /* 16xx chips have 2 MMC blocks */
 	void			*virt_base;
@@ -175,7 +174,7 @@ goldfish_mmc_start_command(struct goldfish_mmc_host *host, struct mmc_command *c
 		resptype = 3;
 		break;
 	default:
-		dev_err(mmc_dev(host->mmc),
+		dev_err(mmc_dev(mmc_from_priv(host)),
 			"Invalid response type: %04x\n", mmc_resp_type(cmd));
 		break;
 	}
@@ -221,8 +220,8 @@ static void goldfish_mmc_xfer_done(struct goldfish_mmc_host *host,
 					data->sg->length);
 		}
 		host->data->bytes_xfered += data->sg->length;
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_len,
-			     dma_data_dir);
+		dma_unmap_sg(mmc_dev(mmc_from_priv(host)), data->sg,
+			     host->sg_len, dma_data_dir);
 	}
 
 	host->data = NULL;
@@ -236,7 +235,7 @@ static void goldfish_mmc_xfer_done(struct goldfish_mmc_host *host,
 
 	if (!data->stop) {
 		host->mrq = NULL;
-		mmc_request_done(host->mmc, data->mrq);
+		mmc_request_done(mmc_from_priv(host), data->mrq);
 		return;
 	}
 
@@ -278,7 +277,7 @@ static void goldfish_mmc_cmd_done(struct goldfish_mmc_host *host,
 
 	if (host->data == NULL || cmd->error) {
 		host->mrq = NULL;
-		mmc_request_done(host->mmc, cmd->mrq);
+		mmc_request_done(mmc_from_priv(host), cmd->mrq);
 	}
 }
 
@@ -313,7 +312,7 @@ static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
 		struct mmc_request *mrq = host->mrq;
 		mrq->cmd->error = -ETIMEDOUT;
 		host->mrq = NULL;
-		mmc_request_done(host->mmc, mrq);
+		mmc_request_done(mmc_from_priv(host), mrq);
 	}
 
 	if (end_command)
@@ -339,12 +338,13 @@ static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
 		u32 state = GOLDFISH_MMC_READ(host, MMC_STATE);
 		pr_info("%s: Card detect now %d\n", __func__,
 			(state & MMC_STATE_INSERTED));
-		mmc_detect_change(host->mmc, 0);
+		mmc_detect_change(mmc_from_priv(host), 0);
 	}
 
 	if (!end_command && !end_transfer && !state_changed && !cmd_timeout) {
 		status = GOLDFISH_MMC_READ(host, MMC_INT_STATUS);
-		dev_info(mmc_dev(host->mmc),"spurious irq 0x%04x\n", status);
+		dev_info(mmc_dev(mmc_from_priv(host)), "spurious irq 0x%04x\n",
+			 status);
 		if (status != 0) {
 			GOLDFISH_MMC_WRITE(host, MMC_INT_STATUS, status);
 			GOLDFISH_MMC_WRITE(host, MMC_INT_ENABLE, 0);
@@ -383,7 +383,7 @@ static void goldfish_mmc_prepare_data(struct goldfish_mmc_host *host,
 
 	dma_data_dir = mmc_get_dma_dir(data);
 
-	host->sg_len = dma_map_sg(mmc_dev(host->mmc), data->sg,
+	host->sg_len = dma_map_sg(mmc_dev(mmc_from_priv(host)), data->sg,
 				  sg_len, dma_data_dir);
 	host->dma_done = 0;
 	host->dma_in_use = 1;
@@ -461,7 +461,6 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
 	}
 
 	host = mmc_priv(mmc);
-	host->mmc = mmc;
 
 	pr_err("mmc: Mapping %lX to %lX\n", (long)res->start, (long)res->end);
 	host->reg_base = ioremap(res->start, resource_size(res));
@@ -508,8 +507,7 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
 
 	ret = device_create_file(&pdev->dev, &dev_attr_cover_switch);
 	if (ret)
-		dev_warn(mmc_dev(host->mmc),
-			 "Unable to create sysfs attributes\n");
+		dev_warn(mmc_dev(mmc), "Unable to create sysfs attributes\n");
 
 	GOLDFISH_MMC_WRITE(host, MMC_SET_BUFFER, host->phys_base);
 	GOLDFISH_MMC_WRITE(host, MMC_INT_ENABLE,
@@ -525,7 +523,7 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
 dma_alloc_failed:
 	iounmap(host->reg_base);
 ioremap_failed:
-	mmc_free_host(host->mmc);
+	mmc_free_host(mmc);
 err_alloc_host_failed:
 	return ret;
 }
@@ -533,14 +531,15 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
 static int goldfish_mmc_remove(struct platform_device *pdev)
 {
 	struct goldfish_mmc_host *host = platform_get_drvdata(pdev);
+	struct mmc_host *mmc = mmc_from_priv(host);
 
 	BUG_ON(host == NULL);
 
-	mmc_remove_host(host->mmc);
+	mmc_remove_host(mmc);
 	free_irq(host->irq, host);
 	dma_free_coherent(&pdev->dev, BUFFER_SIZE, host->virt_base, host->phys_base);
 	iounmap(host->reg_base);
-	mmc_free_host(host->mmc);
+	mmc_free_host(mmc);
 	return 0;
 }
 
-- 
2.7.4

