Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2EFC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA2C2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414676;
	bh=vJgGt+XVMnYKZoAG5h05kAuYMAWp/uN3IP2/FWjb6iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0uw8RIEONZ+t7ovyTt/qpDXkFwcpwPKCT9GIdPL3hd5kzVUjgssFMZt576w2DoUMp
	 PSLWnixzoaJ8nIEJ1PL+ymX+T5qtGkp9jT8ZINZ9PjJHQ6VUOuG1w2WGo0lhKCH7Vq
	 EzSV0Mo75tR1FPFXuhkl/lQQKSuvA6ycUxn10naU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfLCWlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:41:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbfLCWlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:41:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 001932080F;
        Tue,  3 Dec 2019 22:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412875;
        bh=vJgGt+XVMnYKZoAG5h05kAuYMAWp/uN3IP2/FWjb6iE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2P+itleDkb84vxJrA1s/Lz4e35yVEk10icMmFjNftSQLsZVTrgfBeA8G5gah+R5TX
         YXFDrn1aSi1xQxCpu0X4sm1r1P2dzPW3IvVHYWoM7dWCJi2waIGoUxAxXiggsvomlQ
         zhSfMQJj0Crwm8f7efG6hyMW4QX/H8PB4r73S4tU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 051/135] can: peak_usb: report bus recovery as well
Date:   Tue,  3 Dec 2019 23:34:51 +0100
Message-Id: <20191203213019.620878955@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
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
index 5a66c9f53aae6..d2539c95adb65 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -436,8 +436,8 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 		}
 		if ((n & PCAN_USB_ERROR_BUS_LIGHT) == 0) {
 			/* no error (back to active state) */
-			mc->pdev->dev.can.state = CAN_STATE_ERROR_ACTIVE;
-			return 0;
+			new_state = CAN_STATE_ERROR_ACTIVE;
+			break;
 		}
 		break;
 
@@ -460,9 +460,9 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
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
 
@@ -501,6 +501,11 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
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



