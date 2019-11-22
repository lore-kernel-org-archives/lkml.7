Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0313CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61B12068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403036;
	bh=1kQsmX0swMTAzM23lP+WYgI3kFE27ittERjogfKgQlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sXn0Ug2bLf965HotcG+c26s67LcvdgCxcbb18BoUuqWV0Ifwb91K0LzTzh6moTjj1
	 ST2ysG++AdZj3GygvPaAQf0SbYAX5IykRbDVnRQ2DTeQTFttwWtlf3hjSmwVpFNgPK
	 h32GNxhM+TXxh99clEADHN10PS4Gspc06RP+epz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfKVGKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:10:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728653AbfKVF4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:56:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2879A207FA;
        Fri, 22 Nov 2019 05:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402208;
        bh=1kQsmX0swMTAzM23lP+WYgI3kFE27ittERjogfKgQlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyFmQbY/EY4iSCweSscBFS0TkszOyuD7TFCe4O7nDwlVyRX/Sj0gE5ml2l1RlUerh
         HJacqICi/+IefxHctTe3SMeHRauPvcO1OdCNcUgmrMcC554QNCapZB9Qk1aZA8txDM
         3WfpSMTHXigq0L6153OkFfFy/q4yLUCXHPm7GYUM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Shiyan <shc_work@mail.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 057/127] serial: max310x: Fix tx_empty() callback
Date:   Fri, 22 Nov 2019 00:54:35 -0500
Message-Id: <20191122055544.3299-56-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shiyan <shc_work@mail.ru>

[ Upstream commit a8da3c7873ea57acb8f9cea58c0af477522965aa ]

Function max310x_tx_empty() accesses the IRQSTS register, which is
cleared by IC when reading, so if there is an interrupt status, we
will lose it. This patch implement the transmitter check only by
the current FIFO level.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 0969a0d97b2be..cec995ec11eab 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -769,12 +769,9 @@ static void max310x_start_tx(struct uart_port *port)
 
 static unsigned int max310x_tx_empty(struct uart_port *port)
 {
-	unsigned int lvl, sts;
+	u8 lvl = max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
 
-	lvl = max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
-	sts = max310x_port_read(port, MAX310X_IRQSTS_REG);
-
-	return ((sts & MAX310X_IRQ_TXEMPTY_BIT) && !lvl) ? TIOCSER_TEMT : 0;
+	return lvl ? 0 : TIOCSER_TEMT;
 }
 
 static unsigned int max310x_get_mctrl(struct uart_port *port)
-- 
2.20.1

