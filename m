Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300CAC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F7821670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="D9jj2u8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfFZNJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:09:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53324 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfFZNI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:08:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so2041694wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 06:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UlAyafwoDWOEZg6jMds0rhcbFjBfyg8hnA1+xEC/Yao=;
        b=D9jj2u8GMuzxKU98G6kRXnbV9c+RQt++kXvN4FEFtgycPae8cdS/Aq6nD+2tCgJ6Sz
         o42/OZOTQwjC+l7lSrgOJhdXQSQQzfMcEeCtJzNRik/ohayCwPAInW9bH/yq1KFnnNj8
         JHOT/9wbnneNrrt67ZxJho/0B6j/eW1ng2C6MzdOTX+jGRVYoNKUSlsK7onoPoT1FH2N
         lw1wqztnx5cWqz2pl1ReVLa7b6vnHVO7zH8c27WNUzw4pribsjpFa53DFIQ8Ri2/CAp/
         C91LYRzikIJlV+WC4SyaHKNhya/JXfsRH1sq+uNVUhPCfQiyAacRTPrFaDD+uNm7dt6y
         tZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UlAyafwoDWOEZg6jMds0rhcbFjBfyg8hnA1+xEC/Yao=;
        b=hAgz1XEIMkuApiHTlFyQo8wA86LgxcbrPqzwCccvumWgrzaX9vlU6XbOUmm34W3qm6
         B8ze9hlPqURSUwEXLfEgxngKpNpan93KJqFzR6llsPQO1Drj6k/GIMPjhFH4RQ7vakVQ
         mzSceJ5fe29Ex4oANWVPqq0812n9GUO4YnSMUaTrwWqw9Ld8+g7/WSBqZXIFcgbsS2bL
         TSPI43FV+wncQKLg951b1t3AcjY+e65cWF8uL5n1VE5HCNdOXNsvsuYv4Oz1KxHL7/XA
         K+95wCDuhPNHbMOirxHMixY4bGHxbIxPxZg0Bi2FC1ZsllrjcDGMAh+nq9JbGLIvWGMq
         xgJQ==
X-Gm-Message-State: APjAAAU6cP21lBEc2gVuFI3lULGlplNu2E862z8gGiC/LqQray4yDoyH
        Pq/yHKUL7Td/H7hr63GhL37Q7Q==
X-Google-Smtp-Source: APXvYqwKysgktY1GpqtaQ+PYDOj5SUC1kpqiac/ggfHtzlyx9cDcNQ/sdW+AT8RFtOuz94FidUEZgg==
X-Received: by 2002:a1c:b706:: with SMTP id h6mr2640507wmf.119.1561554537502;
        Wed, 26 Jun 2019 06:08:57 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id n5sm1832855wmi.21.2019.06.26.06.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 06:08:56 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Artemi Ivanov <artemi.ivanov@cogentembedded.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH resend] can: rcar_canfd: fix possible IRQ storm on high load
Date:   Wed, 26 Jun 2019 16:08:48 +0300
Message-Id: <20190626130848.6671-1-nikita.yoush@cogentembedded.com>
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

