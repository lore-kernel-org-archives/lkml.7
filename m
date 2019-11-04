Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1920DCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D551E2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zaGsSIhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfKDQqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:46:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43895 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfKDQqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:46:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so17907061wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 08:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=yYqCq8KhOX1XfK+4my7gRFLEElNBe7VMFAXF/vowPJU=;
        b=zaGsSIhEQJNli0xTl6p2gaxhcRnC0CeRxYnx8/folWOcBW0KnPgmwxUa1sTvuv2+ml
         Tm+gwngevn4bGV3HFC0ftCV2eLmFgsOFhyKilnqEzUpM3cdPjFp5PfrYo7W3Wsyni+U0
         CzMKT53+/ymQi7GUFT2teuz42fm0IhuKz8Z3GHU1pvpLj88tckih7ne1f2CG40kpEbLJ
         6OhXbabxb7DZwroauWzVZwSnMjE1KoSMo16cNF1pzAqmfGg6m9NYvCtuNJeh/U4xRayA
         8wLLxpq+bs4udOGFWbsGZBo8HUsxfOYE2YovROhs13GBbKbIBXCbhkUKRgMQigvTaeBS
         JS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=yYqCq8KhOX1XfK+4my7gRFLEElNBe7VMFAXF/vowPJU=;
        b=H6YSwEbO0hD16G9VgyYqUeojJBiXppYKNUx70RVQ7N40yz9LU8dHJ/gyI4O+jGDCFV
         qo4Af4ZZW0FswXA67DClZ+IkF9fTKln2j2zpqSO8t6XhGkbY8VXk8g4DIHv1U5ma/mJH
         2cuCsf714eocZcnGdQ14yWRd7a1Chc2NcG+CzjJ0gXX5MG9+8mV2wOFSz/XdfC6D2Ksp
         RPYleqhZ7NY8ZWJja577FKM5bXXc7Y+bK7jGRmOvKtRvusL3QMrIi7K0GHAmGSEqhBwV
         pfSv0mC6YVwH9k3y3nHFwzxAHvmrMwt3NIwthKsiVLERMnRrMMO1idPWsRZR/HZqucJp
         zt2w==
X-Gm-Message-State: APjAAAUzd8vdtpyh7nL9z+NLS/wstWiNWBo6/s2jXrPfLb9AQBMnlnJT
        gcWcenFiiM5XAbch1Adc1oDHCQ==
X-Google-Smtp-Source: APXvYqwtTkntsyrCVChFM/qW78NBMKri8/Pi6x4pYvlGHeSR9ysRFCfTGUvMr3mLkX6O/kklkRqvpQ==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr24013158wrv.5.1572885991569;
        Mon, 04 Nov 2019 08:46:31 -0800 (PST)
Received: from localhost (uluru.liltaz.com. [163.172.81.188])
        by smtp.gmail.com with ESMTPSA id t5sm6411032wro.76.2019.11.04.08.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 08:46:30 -0800 (PST)
References: <1572868495-84816-1-git-send-email-jianxin.pan@amlogic.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Nan Li <nan.li@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Victor Wan <victor.wan@amlogic.com>
Subject: Re: [PATCH v2] mmc: meson-gx: fix mmc dma operation
In-reply-to: <1572868495-84816-1-git-send-email-jianxin.pan@amlogic.com>
Date:   Mon, 04 Nov 2019 17:46:29 +0100
Message-ID: <1ja79b4mje.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 04 Nov 2019 at 12:54, Jianxin Pan <jianxin.pan@amlogic.com> wrote:

> From: Nan Li <nan.li@amlogic.com>
>
> In MMC dma transfer, the region requested by dma_map_sg() may be released
> by dma_unmap_sg() before the transfer is completed.
>
> Put the unmap operation in front of mmc_request_done() to avoid this.

In the previous thread, you have described what was the issue you found.
It would be nice to have this information here

>
> Fixes: 79ed05e329c3 ("mmc: meson-gx: add support for descriptor chain mode")
> Signed-off-by: Nan Li <nan.li@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Based on Uffe comment I tried something else.

Basically, it enables chained mode in the driver only when the framework
calls pre/post_req callback. As far as understood, the framework calls
this when there is more than one request pending ... which seems to be
when chained mode actually make sense

----8<-----
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index e712315c7e8d..399604b4124d 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -126,8 +126,7 @@
 #define SD_EMMC_CFG_CMD_GAP 16 /* in clock cycles */
 #define SD_EMMC_DESC_BUF_LEN PAGE_SIZE
 
-#define SD_EMMC_PRE_REQ_DONE BIT(0)
-#define SD_EMMC_DESC_CHAIN_MODE BIT(1)
+#define SD_EMMC_DESC_CHAIN_MODE BIT(0)
 
 #define MUX_CLK_NUM_PARENTS 2
 
@@ -228,7 +227,6 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
 	struct mmc_data *data = mrq->data;
 	struct scatterlist *sg;
 	int i;
-	bool use_desc_chain_mode = true;
 
 	/*
 	 * When Controller DMA cannot directly access DDR memory, disable
@@ -251,12 +249,11 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
 		/* check for 8 byte alignment */
 		if (sg->offset & 7) {
 			WARN_ONCE(1, "unaligned scatterlist buffer\n");
-			use_desc_chain_mode = false;
-			break;
+			return;
 		}
 
-	if (use_desc_chain_mode)
-		data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
+	/* The planets are aligned, let's chain them up */
+	data->host_cookie |= SD_EMMC_DESC_CHAIN_MODE;
 }
 
 static inline bool meson_mmc_desc_chain_mode(const struct mmc_data *data)
@@ -278,7 +275,6 @@ static void meson_mmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 
 	meson_mmc_get_transfer_mode(mmc, mrq);
-	data->host_cookie |= SD_EMMC_PRE_REQ_DONE;
 
 	if (!meson_mmc_desc_chain_mode(data))
 		return;
@@ -803,25 +799,11 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct meson_host *host = mmc_priv(mmc);
-	bool needs_pre_post_req = mrq->data &&
-			!(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
-
-	if (needs_pre_post_req) {
-		meson_mmc_get_transfer_mode(mmc, mrq);
-		if (!meson_mmc_desc_chain_mode(mrq->data))
-			needs_pre_post_req = false;
-	}
-
-	if (needs_pre_post_req)
-		meson_mmc_pre_req(mmc, mrq);
 
 	/* Stop execution */
 	writel(0, host->regs + SD_EMMC_START);
 
 	meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
-
-	if (needs_pre_post_req)
-		meson_mmc_post_req(mmc, mrq, 0);
 }
 
 static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
---->8-----

No performance hit AFAICT.
From your description, it should address your problem too.

>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index e712315..7667e8a 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -173,6 +173,7 @@ struct meson_host {
>  	int irq;
>  
>  	bool vqmmc_enabled;
> +	bool needs_pre_post_req;
>  };
>  
>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
> @@ -654,6 +655,8 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
>  	struct meson_host *host = mmc_priv(mmc);
>  
>  	host->cmd = NULL;
> +	if (host->needs_pre_post_req)
> +		meson_mmc_post_req(mmc, mrq, 0);
>  	mmc_request_done(host->mmc, mrq);
>  }
>  
> @@ -803,25 +806,23 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>  	struct meson_host *host = mmc_priv(mmc);
> -	bool needs_pre_post_req = mrq->data &&
> +
> +	host->needs_pre_post_req = mrq->data &&
>  			!(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
>  
> -	if (needs_pre_post_req) {
> +	if (host->needs_pre_post_req) {
>  		meson_mmc_get_transfer_mode(mmc, mrq);
>  		if (!meson_mmc_desc_chain_mode(mrq->data))
> -			needs_pre_post_req = false;
> +			host->needs_pre_post_req = false;
>  	}
>  
> -	if (needs_pre_post_req)
> +	if (host->needs_pre_post_req)
>  		meson_mmc_pre_req(mmc, mrq);
>  
>  	/* Stop execution */
>  	writel(0, host->regs + SD_EMMC_START);
>  
>  	meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
> -
> -	if (needs_pre_post_req)
> -		meson_mmc_post_req(mmc, mrq, 0);
>  }
>  
>  static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)

