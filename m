Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D3BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD47218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126083;
	bh=/SOrtXNBHLSkG+/N7ZeLAWI9sfZ/iI/hZ4E73ywJWQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=exOepQNUEKN+vOMexoR7W5yB/Wn60rCmL7jK/nM5Gj/5QEowCa3bD2xORmjUUIQip
	 S+lA+AnxfZHW0mLEOSUloY1SG/w7i4C29aUHOc11VICx01D/ejOjNCgParkrn6FPEw
	 DShKsdp8enhH5yXlnbRT2/O7P9DAsCkS8pwizIic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbfDXROm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388079AbfDXROi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:14:38 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9608C206BA;
        Wed, 24 Apr 2019 17:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126078;
        bh=/SOrtXNBHLSkG+/N7ZeLAWI9sfZ/iI/hZ4E73ywJWQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMxqB6hrjfrnUfCBrIk4hKZCDASjA1uJjSRNBI2aoBkhLRZEmU110GqhZzyfUyeqo
         jICED5BBvl+J6Butp4qvueDOusoSLYGdat0XuhD2uY3EFpkN0H889yl7R4ECmHCroT
         Cl3gv+FdsSFjWIftRIcEpEdF4KFQkw67sgmY0Ktk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 079/104] serial: uartps: console_setup() cant be placed to init section
Date:   Wed, 24 Apr 2019 19:09:36 +0200
Message-Id: <20190424170907.027804591@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



