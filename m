Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8CFC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7F52073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482346;
	bh=jzremZJt9uCCXqYmgSJYucLdl1Qtl9dFmP4sQefk5tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pTgku/3oxE4QKBEd6aGtC5aIi8vyWDPfa4y+zH+VswMsSDHWvjUrzHgvuXjl8X63M
	 cfmk6hFFVtXAXXKFjodsPsQp5HeVwc6Wu7tHfY9bGw8qyVV3LyNPMj2CK92hNg6ZuE
	 8XC+jkfDZ+xZ1+gD0rjpo4JL6QqWNnA8aN882SeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfLDR7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:59:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbfLDR7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:59:01 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAD092073B;
        Wed,  4 Dec 2019 17:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482341;
        bh=jzremZJt9uCCXqYmgSJYucLdl1Qtl9dFmP4sQefk5tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YqO8vHEYdvJ8TmGXkoiktfXAKv6UvNknJjRZg82CvYyQf/jyx0KSRFtNNmTc9GRFr
         FLa5zAo0lk7E1MWxdjgyG62L2xamtWd4pE+nad7aPaa1ktQgkgISwnXaa2z87UKXeC
         exQlOb3JthV8Gf81ZZWd4kjXfTaWXXpIPN1P+afU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 41/92] serial: max310x: Fix tx_empty() callback
Date:   Wed,  4 Dec 2019 18:49:41 +0100
Message-Id: <20191204174333.005303985@linuxfoundation.org>
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
index a66fb7afecc71..e13e95733fa3c 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -763,12 +763,9 @@ static void max310x_start_tx(struct uart_port *port)
 
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



