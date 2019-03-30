Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4243C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771B6218D3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909433;
	bh=Xe+F8AMn/oMUKBuJALQBNrirq8eQsJho9L4iIQTQiSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mFgJU1b8MwuJD/D5jIGGr9jyuYsaRFCwVOsMH7/J0zJ0uR/ds4rlJtq1w2TaDfzJ/
	 jWT9kXZCuyEv/YgtX0Z3lpbSNR+BWCBERREoseNysG9gsTG189oTI6TL/vW3z03uSJ
	 kJhwp+ctD/R2DRUKe1Ks3QG9EFB6pyGOJPCjuaR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbfC3Bac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731648AbfC3Ba3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:30:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D7D218D3;
        Sat, 30 Mar 2019 01:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909429;
        bh=Xe+F8AMn/oMUKBuJALQBNrirq8eQsJho9L4iIQTQiSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VB2Srvqdg2kLNnquY/j3l3ujEwPqRztclMJzNSxtUJ38jKdYJ24W9vHN+Djhh0PRk
         ldgnVLn16sL7w5aduBRqqh19XdqfgQpzNb6idIMdQHQzgK80kLEZyj8nhVWQJOot/6
         vU/QJ/toiNktoz4M/VOmEedVemki/fKFOeaWNnRY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/37] serial: uartps: console_setup() can't be placed to init section
Date:   Fri, 29 Mar 2019 21:29:50 -0400
Message-Id: <20190330013020.379-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013020.379-1-sashal@kernel.org>
References: <20190330013020.379-1-sashal@kernel.org>
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
index f438a2158006..b0da63737aa1 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1270,7 +1270,7 @@ static void cdns_uart_console_write(struct console *co, const char *s,
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

