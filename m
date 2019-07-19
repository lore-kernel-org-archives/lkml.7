Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF89C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D7B2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510740;
	bh=dCMCrBXXrlPWsuWbPGNG1JXo6HFZCM3Qn+fUwg5WFGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zzp9FyHksc9K/9FWhrlWUKtU3Akj+Hkl9qpTam5xprnxwUM6BK4GQ2rv/Wr7qZ1MC
	 nIwanZl088vtXuybmP8wrQjpzYVCGIWudeuH41RKSQOMvhhHdrFSoptzzy3lqFn3XK
	 PcphUjTsGWBlHkT1DB1E3/+tOD99qX6weMXjhHKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbfGSEcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbfGSEEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:04:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DFAE218D0;
        Fri, 19 Jul 2019 04:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509039;
        bh=dCMCrBXXrlPWsuWbPGNG1JXo6HFZCM3Qn+fUwg5WFGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtz+wErhOBqebjzHTaaAPvqa7V3VLMCX530+EHxWt5d9IC7dAsq9kbQELhqSexN8p
         qgzMyZkGjWqKmjLqLa2Icx1wM4XOpVAtHX8kDXikLOLSXUSlrD0S+0K21jGnmgQaLo
         6EGBqZdWnzLXQe2OyXhjA6RwfkY9ywHkGWQjxxJQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 036/141] tty: serial: msm_serial: avoid system lockup condition
Date:   Fri, 19 Jul 2019 00:01:01 -0400
Message-Id: <20190719040246.15945-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

[ Upstream commit ba3684f99f1b25d2a30b6956d02d339d7acb9799 ]

The function msm_wait_for_xmitr can be taken with interrupts
disabled. In order to avoid a potential system lockup - demonstrated
under stress testing conditions on SoC QCS404/5 - make sure we wait
for a bounded amount of time.

Tested on SoC QCS404.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/msm_serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 23833ad952ba..3657a24913fc 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -383,10 +383,14 @@ static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
 
 static inline void msm_wait_for_xmitr(struct uart_port *port)
 {
+	unsigned int timeout = 500000;
+
 	while (!(msm_read(port, UART_SR) & UART_SR_TX_EMPTY)) {
 		if (msm_read(port, UART_ISR) & UART_ISR_TX_READY)
 			break;
 		udelay(1);
+		if (!timeout--)
+			break;
 	}
 	msm_write(port, UART_CR_CMD_RESET_TX_READY, UART_CR);
 }
-- 
2.20.1

