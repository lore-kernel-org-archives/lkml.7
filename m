Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBFDC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BFB2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qa1GJuwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfEQWy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 18:54:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34400 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfEQWyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 18:54:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id w7so3996838plz.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6jogVf5BPxJTc3ZXoHGDLresQLt/JbLwM9eycPfoS3o=;
        b=Qa1GJuwqwAglIkeNyOpusN3NdcmHUvuM0nNrns5iap7kebn3FlnPFTrm4pnPBWTDBf
         S3DDSC7a1/SORoVdR1Pimjs8dAjlxKLxztLeReMYLVPhg7h318ZO6NR7ImdALSAisKqA
         +2QY0GnTUBXo+mKgtjYHABJmv8f6NjWK/LJjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6jogVf5BPxJTc3ZXoHGDLresQLt/JbLwM9eycPfoS3o=;
        b=PvWImxFvnEiFbxBiZlnKIUCXv5ILK3t8bXyD3VlMHTHKdwLnEw2yXem3GwrYRW4Yj1
         pFFM2M5a5CL2OTuDFxb1X/aYxmeRNQpmTnm3cdJ4SIyXZs3YaQ18S+dTxYoVOuWDndnR
         fybFxMsCNJi1+WmovdKL3Yex7eqjCpLNtNYuM6e3H1uWhfVWEfs31RqgDQXI6it/LfWr
         pRjU8CyEpnDuk4NEed8gAQu28jOVT2bMHrAQazLtkLoFTakqSsje/ohoL5fYbsuEPoXm
         poUQVl3Dy97v5GwjNGLiV1xpuD4yIU80a35q53DZFMIqLTiSyFkOS8DLU37gFBO0CxbV
         swzA==
X-Gm-Message-State: APjAAAUFQWtZ99MMgZlYHLWcFH73nbJDYWVPN26mOu5ZBhnoh3aSYGzM
        7HQCDfxT8+gDN3XFBJv69XDsxw==
X-Google-Smtp-Source: APXvYqx/EJhwNBEKzBHKq6XpsBXpCINxk/nuBPgJ44Zbut3f0ys3U3VoDOnt0ihvDZ99K2MxlIHqfA==
X-Received: by 2002:a17:902:8508:: with SMTP id bj8mr16502435plb.79.1558133685646;
        Fri, 17 May 2019 15:54:45 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id u11sm11174450pfh.130.2019.05.17.15.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 15:54:45 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-rockchip@lists.infradead.org,
        Double Lo <double.lo@cypress.com>, briannorris@chromium.org,
        Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org,
        Wright Feng <wright.feng@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jiong Wu <lohengrin1024@gmail.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>, Martin Hicks <mort@bork.org>
Subject: [PATCH 2/3] mmc: core: API for temporarily disabling auto-retuning due to errors
Date:   Fri, 17 May 2019 15:54:19 -0700
Message-Id: <20190517225420.176893-3-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190517225420.176893-1-dianders@chromium.org>
References: <20190517225420.176893-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally when the MMC core sees an "-EILSEQ" error returned by a host
controller then it will trigger a retuning of the card.  This is
generally a good idea.

However, if a command is expected to sometimes cause transfer errors
then these transfer errors shouldn't cause a re-tuning.  This
re-tuning will be a needless waste of time.  One example case where a
transfer is expected to cause errors is when transitioning between
sleep and active state on certain Broadcom WiFi cards.  Specifically
if the card was already transitioning between states when the command
was sent it could cause an error on the SDIO bus.

Let's add an API that the SDIO card drivers can call that will
temporarily disable the auto-tuning functionality.  Then we can add a
call to this in the Broadcom WiFi driver and any other driver that
might have similar needs.

Without this change on rk3288-veyron-minnie I periodically see this in
the logs of a machine just sitting there idle:
  dwmmc_rockchip ff0d0000.dwmmc: Successfully tuned phase to XYZ

Fixes: bd11e8bd03ca ("mmc: core: Flag re-tuning is needed on CRC errors")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Note that are are a whole boatload of different ways that we could
provide an API for the Broadcom WiFi SDIO driver.  This patch
illustrates one way but if maintainers feel strongly that this is too
ugly and have a better idea then I can give it a shot too.  From a
purist point of view I kinda felt that the "expect errors" really
belonged as part of the mmc_request structure, but getting it into
there meant changing a whole pile of core SD/MMC APIs.  Simply adding
it to the host seemed to match the current style better and was a less
intrusive change.

 drivers/mmc/core/core.c  | 27 +++++++++++++++++++++++++--
 include/linux/mmc/core.h |  2 ++
 include/linux/mmc/host.h |  1 +
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6db36dc870b5..ba4f71aa8cd9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -144,8 +144,9 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 	int err = cmd->error;
 
 	/* Flag re-tuning needed on CRC errors */
-	if ((cmd->opcode != MMC_SEND_TUNING_BLOCK &&
-	    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
+	if (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
+	    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200 &&
+	    !host->expect_errors &&
 	    (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
 	    (mrq->data && mrq->data->error == -EILSEQ) ||
 	    (mrq->stop && mrq->stop->error == -EILSEQ)))
@@ -2163,6 +2164,28 @@ int mmc_sw_reset(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_sw_reset);
 
+void mmc_expect_errors_begin(struct mmc_host *host)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	WARN_ON(host->expect_errors);
+	host->expect_errors = true;
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+EXPORT_SYMBOL_GPL(mmc_expect_errors_begin);
+
+void mmc_expect_errors_end(struct mmc_host *host)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	WARN_ON(!host->expect_errors);
+	host->expect_errors = false;
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+EXPORT_SYMBOL_GPL(mmc_expect_errors_end);
+
 static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 {
 	host->f_init = freq;
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 134a6483347a..02a13abf0cda 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -178,6 +178,8 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
 
 int mmc_hw_reset(struct mmc_host *host);
 int mmc_sw_reset(struct mmc_host *host);
+void mmc_expect_errors_begin(struct mmc_host *host);
+void mmc_expect_errors_end(struct mmc_host *host);
 void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
 
 #endif /* LINUX_MMC_CORE_H */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 43d0f0c496f6..8d553fb8c834 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -398,6 +398,7 @@ struct mmc_host {
 	unsigned int		retune_now:1;	/* do re-tuning at next req */
 	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
 	unsigned int		use_blk_mq:1;	/* use blk-mq */
+	unsigned int		expect_errors:1; /* don't trigger retune upon errors */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
-- 
2.21.0.1020.gf2820cf01a-goog

