Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C56BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2B721852
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139862;
	bh=e7tM6KpXWVA7sxsm42uH/FbqIyOrc2da6vRWNVwmr80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gr6m910sqPPoXtZmcZRstv2mt3l9Vvq7o31pEBCLzkRhsyBROueY0XRExFy+LNpEg
	 jxe6EzeqGbj+hJKybRP+EiQqQM19Mk7FoM5VyNq2fNT+2bjG9w1gPgjHu7OCQy3NBQ
	 52ykle7YUNl4k2r7hvgLRr8c4/LEimUNL8pZcgQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733201AbfDARbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:31:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733181AbfDARa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7711120880;
        Mon,  1 Apr 2019 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139857;
        bh=e7tM6KpXWVA7sxsm42uH/FbqIyOrc2da6vRWNVwmr80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rskGYGVfccHNI/dTcBymmqWIBm2zULsqs13cNTRWjMaZfgCZmsmY4DUXbXZ+jMYkc
         ldfylI4ED6S5L32zoz1aTxpopaSWeru0s6NYL53i8B6om4XT/Q0sDevgT98WCS32ri
         Q2msKZ/HAuzsgi9lVvFa1cEjgnU23IKAVsGd2wvc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lanqing Liu <lanqing.liu@spreadtrum.com>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 033/131] serial: sprd: clear timeout interrupt only rather than all interrupts
Date:   Mon,  1 Apr 2019 19:01:43 +0200
Message-Id: <20190401170054.888536517@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lanqing Liu <lanqing.liu@spreadtrum.com>

commit 4350782570b919f254c1e083261a21c19fcaee90 upstream.

On Spreadtrum's serial device, nearly all of interrupts would be cleared
by hardware except timeout interrupt.  This patch removed the operation
of clearing all interrupt in irq handler, instead added an if statement
to check if the timeout interrupt is supposed to be cleared.

Wrongly clearing timeout interrupt would lead to uart data stay in rx
fifo, that means the driver cannot read them out anymore.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sprd_serial.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -63,6 +63,7 @@
 
 /* interrupt clear register */
 #define SPRD_ICLR		0x0014
+#define SPRD_ICLR_TIMEOUT	BIT(13)
 
 /* line control register */
 #define SPRD_LCR		0x0018
@@ -298,7 +299,8 @@ static irqreturn_t sprd_handle_irq(int i
 		return IRQ_NONE;
 	}
 
-	serial_out(port, SPRD_ICLR, ~0);
+	if (ims & SPRD_IMSR_TIMEOUT)
+		serial_out(port, SPRD_ICLR, SPRD_ICLR_TIMEOUT);
 
 	if (ims & (SPRD_IMSR_RX_FIFO_FULL |
 		SPRD_IMSR_BREAK_DETECT | SPRD_IMSR_TIMEOUT))


