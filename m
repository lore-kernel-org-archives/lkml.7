Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B84C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE6E20665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803310;
	bh=ZOosVN0Ic6Q88AcFPeEupioIcmxpjRiFLM8kbGNB5nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n9pUgwB3GX72Xla2D7F26+s8iKSsNLWPsHB4ZzQhjUSTXTK975luiOFPXdleggKIY
	 Ro/z7/P4u9b+JHKLTkDpIN76/tiEYnFL8d9rf8uEeV6Kl+ANjoh3J6jt13FzdBCxKs
	 jRehQmM7da58RC2o+KXX7Mv5k6hB54YOtllnF8to=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfHNRVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730314AbfHNRJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:09:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 869CA2133F;
        Wed, 14 Aug 2019 17:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802567;
        bh=ZOosVN0Ic6Q88AcFPeEupioIcmxpjRiFLM8kbGNB5nU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c5fWbNoCc7gP+hGtJCYc0+HIEoZ6aCWYK4NqznkGPOwThydJUa9sxDI3j5SbFpT79
         G80MPgWAs3sBULuMAl59Yzz1ZrJrthSme+5zizqV8xxDmRWfV2YoKn/MYYjXILXcd0
         ugk2vxGqr2w1qkNCVPy76L6fINuV1lDmxRti+IBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 31/91] can: rcar_canfd: fix possible IRQ storm on high load
Date:   Wed, 14 Aug 2019 19:00:54 +0200
Message-Id: <20190814165751.018391194@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
References: <20190814165748.991235624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

commit d4b890aec4bea7334ca2ca56fd3b12fb48a00cd1 upstream.

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

Fixes: dd3bd23eb438 ("can: rcar_canfd: Add Renesas R-Car CAN FD driver")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/rcar/rcar_canfd.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1512,10 +1512,11 @@ static int rcar_canfd_rx_poll(struct nap
 
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


