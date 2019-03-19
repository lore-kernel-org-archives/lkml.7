Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FD5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A7520700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8yLW0HT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfCSCVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:21:19 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50545 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfCSCUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:20:39 -0400
Received: by mail-it1-f194.google.com with SMTP id m137so8135193ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wST5X8sn+l1CUbzPlEtKDryJVlrD+4XHz828Tny/hc=;
        b=K8yLW0HTBvS1VM9VK/1GVZ/hdoijHYAZJ1jHeO/YH6cko0CdI6ujeJIywLXwZ2G6UN
         dqM7MLvWONzoykipbwN5iGNfCjMv3GMlZtJkH7cJv0kcMBcAGI9KDAeBYH7c0PRvpmYr
         hpoJk+cuovulTZdu5rkqt/TdFoRB7Ddjc2d55cUnZ3upOynyU2x5QBLdbmmcE0hqeY+w
         vDdbvPdDKgQzBlb9b7amU7rUgMmlUz2JbXu8Y5kJ+2Q7LuvzfldqB1mt79UxRDp8067v
         xgtb20IWPMjTh3QuM2cQH101HyL6ZssZyab6Z6A8BMufL+lq0wra80njILp7QbjFaDt9
         qgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wST5X8sn+l1CUbzPlEtKDryJVlrD+4XHz828Tny/hc=;
        b=RFM+UgM3OWDFFKMEna5iSLmR9fl2cvhNlGXQSHqjshe0qJomHvM8aBrPzxNMyVqOAr
         BeTWJh1uIybi50MVBIYad5HPUSz13/W8qM7E6VHuCPWNSFBZTHG7JjKJUZ9ovx1Ev3B6
         cNa1a4K9FuU8/NFcTxSww8VwBm5IlV/lNvnznQhIuVuY9l5/lFONAuzkBfNPKU7n+MNr
         B3rX/e8de3PHbjwWxGAyLayCWXduX2lNlK3tXh6IJIBs5v1fJX09FOM+nmauKvRGjl++
         ue8ARu2JNWldXWpET5lfUwhfICA77L2HuB9BaUGeRtM7L9tuM3hKpP0/gFU+WDpn+jua
         hEvQ==
X-Gm-Message-State: APjAAAWrtGotRd5VDlC4mjCzQHDJlM2CiPlYPdMMX8Np38Bz03rlXAJA
        nn0tcy1oVSAoFeme2TJQG4I=
X-Google-Smtp-Source: APXvYqzsntVoozRVmCNQ59y0pMaycCgAPWvDTqBshZNtnSjlbzECgzHPyrmYiLtoc6vGuP/ePQKJ+Q==
X-Received: by 2002:a24:6752:: with SMTP id u79mr39139itc.65.1552962038502;
        Mon, 18 Mar 2019 19:20:38 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id l8sm673838itl.26.2019.03.18.19.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:20:38 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v2 05/11] staging: mt7621-mmc: Bill the caller for I/O time
Date:   Mon, 18 Mar 2019 20:20:06 -0600
Message-Id: <20190319022012.11051-6-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319022012.11051-1-thirtythreeforty@gmail.com>
References: <20190319022012.11051-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When waiting on completions, use the _io variant so the caller is
charged as using I/O.

This should have no effect on the module's functionality, only improve
CPU accounting.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 4380b321bc73..89fbc0a1dec7 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -493,7 +493,7 @@ static unsigned int msdc_command_resp(struct msdc_host   *host,
 	//sdr_set_bits(host->base + MSDC_INTEN, wints);
 
 	spin_unlock(&host->lock);
-	if (!wait_for_completion_timeout(&host->cmd_done, 10 * timeout)) {
+	if (!wait_for_completion_io_timeout(&host->cmd_done, 10 * timeout)) {
 		dev_err(mmc_dev(host->mmc),
 			"%d -> XXX CMD<%d> wait_for_completion timeout ARG<0x%.8x>\n",
 			host->id, opcode, cmd->arg);
@@ -696,7 +696,7 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		msdc_dma_start(host);
 
 		spin_unlock(&host->lock);
-		if (!wait_for_completion_timeout(&host->xfer_done, DAT_TIMEOUT)) {
+		if (!wait_for_completion_io_timeout(&host->xfer_done, DAT_TIMEOUT)) {
 			dev_err(mmc_dev(host->mmc),
 				"%d -> XXX CMD<%d> wait xfer_done<%d> timeout!!\n",
 				host->id, cmd->opcode,
-- 
2.21.0

