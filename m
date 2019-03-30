Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6604C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDB721773
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909488;
	bh=udww7RXemPv7R1CZPT0Kdgugvg/AvV7F6UF4XyMTuoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f8UinigPsCJw844PyvuZhzNfDLqnSZxvG5uUPl8vGRBvyR8DnitKaaEUUmGOvY7fK
	 VfgYEIWg9Dn1WGnHvcX3xucTuMqO3vNHlS8NoWx2PFh74Dorj3KEr0dB6o3R9sg2Nh
	 MRgBSqB8ddC7AFAe2myrYyYyNq/dXo7VQz29AVro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbfC3Bb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732006AbfC3BbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:31:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58BB4218D9;
        Sat, 30 Mar 2019 01:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909480;
        bh=udww7RXemPv7R1CZPT0Kdgugvg/AvV7F6UF4XyMTuoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VGrU+WN1DUnwLuT9BP0YkwJSixna0bDn6mL3LhDvZrRhU66GuWbBWoi7a5P7fAamz
         54lAMmtVmPL12wsaXLITIKFON/N+a7DBgaQ4QHxwZGEA4dHhhrPmvQqj4kP/K3QKHP
         MfW/gxyxlTkOVPMhmRdaGRA+KQMasDLo9c3dua00=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 06/21] serial: uartps: console_setup() can't be placed to init section
Date:   Fri, 29 Mar 2019 21:30:57 -0400
Message-Id: <20190330013112.784-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013112.784-1-sashal@kernel.org>
References: <20190330013112.784-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>

[ Upstream commit 4bb1ce2350a598502b23088b169e16b43d4bc639 ]

When console device is rebinded, console_setup() is called again.
But marking it as __init means that function will be clear after boot is
complete. If console device is binded again console_setup() is not found
and error "Unable to handle kernel paging request at virtual address"
is reported.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index ffb474c49f0f..eb61a07fcbbc 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1261,7 +1261,7 @@ static void cdns_uart_console_write(struct console *co, const char *s,
  *
  * Return: 0 on success, negative errno otherwise.
  */
-static int __init cdns_uart_console_setup(struct console *co, char *options)
+static int cdns_uart_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port = &cdns_uart_port[co->index];
 	int baud = 9600;
-- 
2.19.1

