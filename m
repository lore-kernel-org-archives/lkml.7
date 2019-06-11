Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A421EC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F7C2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgF3oK2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404177AbfFKG5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 02:57:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40791 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403964AbfFKG5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 02:57:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so1537977wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 23:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KJ/d5w9c/HXeeYUZHkN6hWB+RneeD4rivtNwjYdhiiI=;
        b=YgF3oK2tbFls1fnPASO0AsGvoJZ6/XzrKZQQcuvr1tooHq99ncAIRahhvKbhEhSJ+s
         ZNI5gK5QRnrRNwln9+9pJAOWuGaqk1koj37fyt5Wn2oxz/eRcbvjUf7H7r9+47sTwCVG
         jvBU/W0lWNk7hSN6lNQfgJvn3Cmv2Rw0UPpMdSYMVl1jaRM6GMuFDIdLsb1sscpZTT04
         cGpGeQKFDRzbHC1w4h/jBABPsGDY7ExQQhFwbWPbZ4Ho1nMPrgp+48UxHtMJcwntdPG/
         ZNwYS209DEAWLeowNeaLDF49AyNZxOGPq1fACm8xalrvbzNEZ2sn8jYhmgnyqCg6a3Mk
         MqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KJ/d5w9c/HXeeYUZHkN6hWB+RneeD4rivtNwjYdhiiI=;
        b=m9Aba/pO/6a6CqYCVHTWXM/Hw4SOCty3FIcnpY4+FRXhe2NlojZIJswhQENBp4pkL8
         /XG5ZlPb79Wulcn3qgbGyXSzj5aYoLuA8iIiJVoC56Rs8xs6/frJOTxhmHOwHKiqXzpC
         03NM/T/nhkQoOTC6ou63jDopa/2eUoFsLAiWjYMSEOIO4gkAFrk5yXBoKpNBR/CsAZ2k
         V+m5kjoOC74WtMsT5y/bOk2IVnX5iU/9RCBLC627gMLFDKBucXV3ywiALbp8dy3859zJ
         cCUMw0b4Rv80D33ZLQbBq2qHkqkGTWD4AYZL/kl4CiGxBz+KTBbtUdjQArJH1t/cnz5Q
         HTnA==
X-Gm-Message-State: APjAAAX/ji40/kWzqp7/XWPZYDJ8rUhn2zx8UBD03DZxmpqwZrtUXkS8
        J1G0moByqnKbES2pZjW1i2JhVmL7
X-Google-Smtp-Source: APXvYqxAcg2C5KvGZp1y+sWdt0YDMenF1gjiiZ1jb+Z9Gks/VABBlPnMntLZgLkYBilYx0JW+amngQ==
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr16676335wmk.84.1560236270227;
        Mon, 10 Jun 2019 23:57:50 -0700 (PDT)
Received: from localhost.localdomain ([86.121.174.24])
        by smtp.gmail.com with ESMTPSA id r3sm16566696wrr.61.2019.06.10.23.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 23:57:49 -0700 (PDT)
From:   Daniel Baluta <daniel.baluta@gmail.com>
X-Google-Original-From: Daniel Baluta <daniel.baluta@nxp.com>
To:     jassisinghbrar@gmail.com, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shengjiu.wang@nxp.com,
        o.rempel@pengutronix.de, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2] mailbox: imx: Clear GIEn bit at shutdown
Date:   Tue, 11 Jun 2019 09:57:31 +0300
Message-Id: <20190611065731.5581-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GIEn is enabled at startup for RX doorbell mailboxes so
we need to clear the bit at shutdown in order to avoid
leaving the interrupt line enabled.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes since v1:
	- no changes since v1 just sent it as a separate patch from RFC 
	series https://lkml.org/lkml/2019/6/10/465

 drivers/mailbox/imx-mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 25be8bb5e371..9f74dee1a58c 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -217,8 +217,8 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 	if (cp->type == IMX_MU_TYPE_TXDB)
 		tasklet_kill(&cp->txdb_tasklet);
 
-	imx_mu_xcr_rmw(priv, 0,
-		   IMX_MU_xCR_TIEn(cp->idx) | IMX_MU_xCR_RIEn(cp->idx));
+	imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx) |
+		       IMX_MU_xCR_RIEn(cp->idx) | IMX_MU_xCR_GIEn(cp->idx));
 
 	free_irq(priv->irq, chan);
 }
-- 
2.17.1

