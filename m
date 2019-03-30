Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250F9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E3421773
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909609;
	bh=dJcTonHcE9ZfkthOewQkVw1x7Tcna61UTKy5RCwBDyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nkziP3ANIAPjF3OMkFRotVPqVCBWNtBkKWdylXA7YajfMHO6MQ2KEIYLCpJYwNjQL
	 /7qxI843LsNGrnX/mwiG34nPGxX1DqupFodLem/itsANH+b4rXMkRFGS7qIy+YgA5d
	 oj/wpfGVbdR9lYoA/691Gg9K6AdVQ/3SxfE2Zf04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbfC3Bd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732366AbfC3Bcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:32:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E0E7218E2;
        Sat, 30 Mar 2019 01:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909553;
        bh=dJcTonHcE9ZfkthOewQkVw1x7Tcna61UTKy5RCwBDyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zyhTx/gOA2rxp/JT3EM1XnMJJMuCWmOQtSSbzUNqD9YTRSroCPKu+PuTAZebL0t2I
         atLHhvBG2qMn6Z0kXSnbbfSAAs4W3Y591be07HHtmJVpBW24QCz8tSJqZnElPDVJZB
         5RNyd14ZYiwxnpm8zNRyZthQlYSc1P4Q9yX6268g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 04/10] serial: uartps: console_setup() can't be placed to init section
Date:   Fri, 29 Mar 2019 21:32:21 -0400
Message-Id: <20190330013227.1365-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013227.1365-1-sashal@kernel.org>
References: <20190330013227.1365-1-sashal@kernel.org>
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
index df28ef14382b..892446cc28fa 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1120,7 +1120,7 @@ static void cdns_uart_console_write(struct console *co, const char *s,
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

