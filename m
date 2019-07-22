Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACB8C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE7C216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fLXr6gDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbfGVTlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:41:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33685 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732261AbfGVTlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:41:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so17871908pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATbFy1aIdbWHFM03S3oai17NaO/neBJFfQYViTxrNMs=;
        b=fLXr6gDQl11kx/gfLPu/pKAYQ3oWpeGmz6q8QFeSzDdvzyBV3Jixq5ya13oHO5dqfo
         Nt5xcerqY4a9O3JWvuPb94Tyrayne1SI5T6+UGeut3CsFAKBfhZw9yU7Q5/RHukXvoYY
         cqcqRPZNeTl+YDf2PzrHdCfdrC3TgIUq6fJSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATbFy1aIdbWHFM03S3oai17NaO/neBJFfQYViTxrNMs=;
        b=gkxwjkBXNF+BKNPg0LQPU8xr11EbUs3a3Bq+drYX//0WpvCOXOiK8cYN3tScK3ck0v
         UqESA0gAnjMJQIZs+f3mwDLqATsq0JNcbwrgt3Tpjezieqd/Ur8DNICjCI6+FHhsn3/k
         k7NWhXGIIlFha+clbBOnjhe2MkAVPBMogRVJclgVy1BuOP4QmT4M8EFhW4reO6uZM0J/
         gCWLHKK49VhPNKP0sma4dPQewXupG/jzVZXun0T/Ms3Vr7r+BISabUAh/by0gCK7OV+Q
         4YfFfCCzf6FncgA9MGNqprffr47SN8FCNRI5lrGPZeMXjdyTLoXo5ceFY20mAXVuZxkO
         mGxw==
X-Gm-Message-State: APjAAAXqGcCXH1U2CocfdHjr4BdAepLoV5o2ayOJ54vqkF1yOD2GTkza
        b4muqLoqtCtRJJWCUSidA+uicQ==
X-Google-Smtp-Source: APXvYqxe3jk2Td0NZ3MiOAVs4zOozU2NCyEe4BhAwMABU222PrrTzeC4C4T+vjjW5dwEp508Pc+S0A==
X-Received: by 2002:a17:90a:ba93:: with SMTP id t19mr77532204pjr.139.1563824491627;
        Mon, 22 Jul 2019 12:41:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id z4sm29838803pgp.80.2019.07.22.12.41.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:41:31 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ganapathi Bhat <gbhat@marvell.com>, linux-wireless@vger.kernel.org,
        Andreas Fenkart <afenkart@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        netdev@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        linux-mmc@vger.kernel.org, davem@davemloft.net,
        Xinming Hu <huxinming820@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mwifiex: Make use of the new sdio_trigger_replug() API to reset
Date:   Mon, 22 Jul 2019 12:39:39 -0700
Message-Id: <20190722193939.125578-3-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722193939.125578-1-dianders@chromium.org>
References: <20190722193939.125578-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the patch ("mmc: core: Add sdio_trigger_replug()
API"), the current mwifiex_sdio_card_reset() is broken in the cases
where we're running Bluetooth on a second SDIO func on the same card
as WiFi.  The problem goes away if we just use the
sdio_trigger_replug() API call.

NOTE: Even though with this new solution there is less of a reason to
do our work from a workqueue (the unplug / plug mechanism we're using
is possible for a human to perform at any time so the stack is
supposed to handle it without it needing to be called from a special
context), we still need a workqueue because the Marvell reset function
could called from a context where sleeping is invalid and thus we
can't claim the host.  One example is Marvell's wakeup_timer_fn().

Cc: Andreas Fenkart <afenkart@gmail.com>
Cc: Brian Norris <briannorris@chromium.org>
Fixes: b4336a282db8 ("mwifiex: sdio: reset adapter using mmc_hw_reset")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
- Removed clear_bit() calls and old comment (Brian Norris).
- Explicit CC of Andreas Fenkart.
- Explicit CC of Brian Norris.
- Add "Fixes" pointing at the commit Brian talked about.
- Add Brian's Reviewed-by tag.

 drivers/net/wireless/marvell/mwifiex/sdio.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 24c041dad9f6..7ec5068f6ffd 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -2218,24 +2218,10 @@ static void mwifiex_sdio_card_reset_work(struct mwifiex_adapter *adapter)
 {
 	struct sdio_mmc_card *card = adapter->card;
 	struct sdio_func *func = card->func;
-	int ret;
-
-	mwifiex_shutdown_sw(adapter);
 
-	/* power cycle the adapter */
 	sdio_claim_host(func);
-	mmc_hw_reset(func->card->host);
+	sdio_trigger_replug(func);
 	sdio_release_host(func);
-
-	/* Previous save_adapter won't be valid after this. We will cancel
-	 * pending work requests.
-	 */
-	clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
-	clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);
-
-	ret = mwifiex_reinit_sw(adapter);
-	if (ret)
-		dev_err(&func->dev, "reinit failed: %d\n", ret);
 }
 
 /* This function read/write firmware */
-- 
2.22.0.657.g960e92d24f-goog

