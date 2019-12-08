Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5321CC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2602920692
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfLHQNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 11:13:32 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49500 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726453AbfLHQNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 11:13:31 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 2152224153E;
        Sun,  8 Dec 2019 17:13:30 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 17F21C20BCE; Sun,  8 Dec 2019 17:13:30 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH 12/12] PCMCIA: remove ifdef 0 block
Date:   Sun,  8 Dec 2019 17:09:47 +0100
Message-Id: <20191208160947.20694-13-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191208160947.20694-2-simon.geis@fau.de>
References: <20191208160947.20694-2-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

indirect_read16 is similar to indirect_read with the exception that 
it reads 16 instead of 8 bit.

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index a2d1e457d931..9024d1d9478e 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -213,26 +213,6 @@ static unsigned char indirect_read(int socket, unsigned short reg)
 	return val;
 }
 
-#if 0
-static unsigned short indirect_read16(int socket, unsigned short reg)
-{
-	unsigned short int port;
-	unsigned short tmp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&port_lock, flags);
-	reg  = reg + socket * 0x40;
-	port = sockets[socket].io_base;
-	outb(reg, port);
-	tmp = inb(port+1);
-	reg++;
-	outb(reg, port);
-	tmp = tmp | (inb(port+1)<<8);
-	spin_unlock_irqrestore(&port_lock, flags);
-	return tmp;
-}
-#endif
-
 static void indirect_write(int socket, unsigned short reg, unsigned char value)
 {
 	unsigned short int port;
-- 
2.20.1

