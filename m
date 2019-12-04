Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF189C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B822073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482283;
	bh=WbqjUggnJDh4A988fik+6/iGaJLlVSosFqW9yVNwscw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uEBMK5dpskU63iI+QN7/fDel+E8Qnw/p/7cB537qIKkdRKLW5VGxuuUtt/BAtdoHr
	 Q7HFRZgW21nqvpk48JEmL07hEQXLGcceJE16kHWtThcul7G68PoxZnyCqKu1WrSYpM
	 /EubO71PzOx+sIcS0WidKCWgCCe9QM1lk02aUQak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfLDR6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:59714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbfLDR56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:57:58 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C83820675;
        Wed,  4 Dec 2019 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482278;
        bh=WbqjUggnJDh4A988fik+6/iGaJLlVSosFqW9yVNwscw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2VIEOHNieQLJtSNAD1kcNnhRoHnwEhIbdXNfNwlvUfSFMjztikfci8anMi60prYwo
         eWhuWRxO3a4+CftekiMP4C2HepQnTpUHp+kjCSIXr/Blri4WaduzVGqvXkF53oyOKs
         RqHCuAcxWH2V4nB4mx/mGUxnxJE/VfRf/7t00rQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 05/92] can: peak_usb: report bus recovery as well
Date:   Wed,  4 Dec 2019 18:49:05 +0100
Message-Id: <20191204174328.702650875@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeroen Hofstee <jhofstee@victronenergy.com>

[ Upstream commit 128a1b87d3ceb2ba449d5aadb222fe22395adeb0 ]

While the state changes are reported when the error counters increase
and decrease, there is no event when the bus recovers and the error
counters decrease again. So add those as well.

Change the state going downward to be ERROR_PASSIVE -> ERROR_WARNING ->
ERROR_ACTIVE instead of directly to ERROR_ACTIVE again.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index e626c2afbbb11..0e1fc6c4360e7 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -441,8 +441,8 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 		}
 		if ((n & PCAN_USB_ERROR_BUS_LIGHT) == 0) {
 			/* no error (back to active state) */
-			mc->pdev->dev.can.state = CAN_STATE_ERROR_ACTIVE;
-			return 0;
+			new_state = CAN_STATE_ERROR_ACTIVE;
+			break;
 		}
 		break;
 
@@ -465,9 +465,9 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 		}
 
 		if ((n & PCAN_USB_ERROR_BUS_HEAVY) == 0) {
-			/* no error (back to active state) */
-			mc->pdev->dev.can.state = CAN_STATE_ERROR_ACTIVE;
-			return 0;
+			/* no error (back to warning state) */
+			new_state = CAN_STATE_ERROR_WARNING;
+			break;
 		}
 		break;
 
@@ -506,6 +506,11 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 		mc->pdev->dev.can.can_stats.error_warning++;
 		break;
 
+	case CAN_STATE_ERROR_ACTIVE:
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[1] = CAN_ERR_CRTL_ACTIVE;
+		break;
+
 	default:
 		/* CAN_STATE_MAX (trick to handle other errors) */
 		cf->can_id |= CAN_ERR_CRTL;
-- 
2.20.1



