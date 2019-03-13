Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1FBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A2720854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="YOGPmu3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfCMPtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:49:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36166 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfCMPtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:49:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id d18so1875966lfn.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UlAyafwoDWOEZg6jMds0rhcbFjBfyg8hnA1+xEC/Yao=;
        b=YOGPmu3m5Bp6qz4fmf4dWywAAm+zi5cuAe5w9KHTu8LLgIybdfIzOq9T9/7VVOLuqP
         YDahAC9TipHEzItLo3jYgwhMns3+u2OLuOpZ1dBM8AnaEiQSWJBymDyzyruVwBw/tIWX
         AZayR1mAspSnhGLTXfgDX4MlzdqeG7r3oEtC3hIzXD2pnkjOGAJzE03hhF5iORSlYB2h
         cAnqNjDRG2/JHFejd9NJaDBqZAMQq0E0CYBi3QC35WfB2xTOhUQeOOaXWqH02CW0QTEc
         52DJiu7I4Uie9J05UAMmXL4akWHWDWTkHv38V80PskwoR6H2tr04H0obwfF8JQA8+D+S
         9Ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UlAyafwoDWOEZg6jMds0rhcbFjBfyg8hnA1+xEC/Yao=;
        b=qd1aOVvjbZryvWYegZjiRji3C+KHlxt3bzKUQh25WBHtsw8nB3Y6luMObr6bB8tXBC
         3/21mnVfdZ8LdkeC0pXY8NffHbWWH/G51hS6gNq/AUFHoPYtr8BiXLdunb758VSTnRZ8
         Gj7yo8qbFvojmvFsNjmWQKEpxz0HvoKamgkwkALIqyzuOxE2q8dPmrxM+6JOrfcrBQWu
         ZUL5YsvXSX3ThQppLDb+bbCmgVG/SrO9g+C6+O7yGCx920wZTe4rwj+gQYUj6VjDB2Yc
         AhBdUwVEnB/QWQL1p6jKnfNLH2ZavefaE79r1T7237HBY1TZnghiop/MCcdP1CEatkjS
         psuw==
X-Gm-Message-State: APjAAAUMZqBfLB6QYYJHKWCAimrdfNjPPsFfcxrv0kpqZzNCI4V9+EdV
        h7CFIrsgk2Y/7OS9KBSzS6cWvg==
X-Google-Smtp-Source: APXvYqzVy+NIXG7pPNZwv1fJqPauGWFyKT6aHejNL/TfWIabwh4jiLtVQ3tJHivalRNa3dlAR+2wYQ==
X-Received: by 2002:ac2:529c:: with SMTP id q28mr21586238lfm.123.1552492188778;
        Wed, 13 Mar 2019 08:49:48 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id f141sm2132538lff.71.2019.03.13.08.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 08:49:47 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Artemi Ivanov <artemi.ivanov@cogentembedded.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] can: rcar_canfd: fix possible IRQ storm on high load
Date:   Wed, 13 Mar 2019 18:49:28 +0300
Message-Id: <20190313154928.24331-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have observed rcar_canfd driver entering IRQ storm under high load,
with following scenario:
- rcar_canfd_global_interrupt() in entered due to Rx available,
- napi_schedule_prep() is called, and sets NAPIF_STATE_SCHED in state
- Rx fifo interrupts are masked,
- rcar_canfd_global_interrupt() is entered again, this time due to
  error interrupt (e.g. due to overflow),
- since scheduled napi poller has not yet executed, condition for calling
  napi_schedule_prep() from rcar_canfd_global_interrupt() remains true,
  thus napi_schedule_prep() gets called and sets NAPIF_STATE_MISSED flag
  in state,
- later, napi poller function rcar_canfd_rx_poll() gets executed, and
  calls napi_complete_done(),
- due to NAPIF_STATE_MISSED flag in state, this call does not clear
  NAPIF_STATE_SCHED flag from state,
- on return from napi_complete_done(), rcar_canfd_rx_poll() unmasks Rx
  interrutps,
- Rx interrupt happens, rcar_canfd_global_interrupt() gets called
  and calls napi_schedule_prep(),
- since NAPIF_STATE_SCHED is set in state at this time, this call
  returns false,
- due to that false return, rcar_canfd_global_interrupt() returns
  without masking Rx interrupt
- and this results into IRQ storm: unmasked Rx interrupt happens again
  and again is misprocessed in the same way.

This patch fixes that scenario by unmasking Rx interrupts only when
napi_complete_done() returns true, which means it has cleared
NAPIF_STATE_SCHED in state.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 05410008aa6b..de34a4b82d4a 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1508,10 +1508,11 @@ static int rcar_canfd_rx_poll(struct napi_struct *napi, int quota)
 
 	/* All packets processed */
 	if (num_pkts < quota) {
-		napi_complete_done(napi, num_pkts);
-		/* Enable Rx FIFO interrupts */
-		rcar_canfd_set_bit(priv->base, RCANFD_RFCC(ridx),
-				   RCANFD_RFCC_RFIE);
+		if (napi_complete_done(napi, num_pkts)) {
+			/* Enable Rx FIFO interrupts */
+			rcar_canfd_set_bit(priv->base, RCANFD_RFCC(ridx),
+					   RCANFD_RFCC_RFIE);
+		}
 	}
 	return num_pkts;
 }
-- 
2.11.0

