Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C46C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C0321019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688430;
	bh=P+9Fco+ZYZrtBC+y/RN6QEdRgjtHFLcKr+wUmYHZJwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dTytx+Kx3vAK6ci6ND2fgl8JjYtkYPgsxPhGkbcxLyJdDmJJjCk48HhgbWWaZCYV6
	 iW4qj9YTS1AtZQktJfRxh6VO0gGBmoiX109Hdq8rSc1vQ4x01LvS+/U5nYyXtr+Cn+
	 Ez8PcY66czkGhNyOqWbtiygTD5TtsMAjpMPTCkgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfCDIdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbfCDIdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:33:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD85F20823;
        Mon,  4 Mar 2019 08:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688427;
        bh=P+9Fco+ZYZrtBC+y/RN6QEdRgjtHFLcKr+wUmYHZJwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fOmU0g4bSPYXHhIwrzQhqC4C7MIPiAzUDW5eRaq2zwMzJlXpn2cEfxnpwuPAiq6L8
         oeffP24fDeOoVk4sh99+mSh0AP8zPQNj4indmB+iOcM7QU7b7ME//d/QspZopo1Abn
         m/rMrXxapu1PZLTsBnonNCKiM70B5Dmv4Wq15dPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 40/88] tty: serial: qcom_geni_serial: Allow mctrl when flow control is disabled
Date:   Mon,  4 Mar 2019 09:22:23 +0100
Message-Id: <20190304081632.163670707@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e8a6ca808c5ed1e2b43ab25f1f2cbd43a7574f73 ]

The geni set/get_mctrl() functions currently do nothing unless
hardware flow control is enabled. Remove this arbitrary limitation.

Suggested-by: Johan Hovold <johan@kernel.org>
Fixes: 8a8a66a1a18a ("tty: serial: qcom_geni_serial: Add support for flow control")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d3b5261ee80af..76e0ad7251e1f 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -221,7 +221,7 @@ static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
 	unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
 	u32 geni_ios;
 
-	if (uart_console(uport) || !uart_cts_enabled(uport)) {
+	if (uart_console(uport)) {
 		mctrl |= TIOCM_CTS;
 	} else {
 		geni_ios = readl_relaxed(uport->membase + SE_GENI_IOS);
@@ -237,7 +237,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
 {
 	u32 uart_manual_rfr = 0;
 
-	if (uart_console(uport) || !uart_cts_enabled(uport))
+	if (uart_console(uport))
 		return;
 
 	if (!(mctrl & TIOCM_RTS))
-- 
2.19.1



