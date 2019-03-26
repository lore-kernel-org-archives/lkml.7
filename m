Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A64C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06BC20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553581919;
	bh=2b+COi1Be/8DesjcBZSZEjv9DzOv+LL10rhyBuaqpKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2DOQEk/xcovD4jblbNEwmShYXpXHY7t51qX4QYptXelxW+jcD/I9EART6RQj9s23l
	 VePciDpemltBARFNDJr1+WK4pmtnWYcYAtHaLUu0jTwnQgwSonTggb0ltg+7Qex66h
	 p3ih1StGd0O+0/S0dyZmvc36pRlu9tepjx4u0f1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfCZGb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731215AbfCZGbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:31:55 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63BEF20823;
        Tue, 26 Mar 2019 06:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581914;
        bh=2b+COi1Be/8DesjcBZSZEjv9DzOv+LL10rhyBuaqpKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OpCAqUgmJnsP7baI/ZVY9xcT3m49gCGa66E1R2NsVaUeIovWntoW3LncYP077fBIx
         f9hm6KRLVsoz5EzFtRHhal8Fedbs5PcJN3Oo88Xpc7bq4rpHDZfECwLpSQ0BQg0J32
         3QybWaF4/U33QYS1TmFFbMoKRBQz6RMLRnD41d70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lanqing Liu <lanqing.liu@spreadtrum.com>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 23/30] serial: sprd: clear timeout interrupt only rather than all interrupts
Date:   Tue, 26 Mar 2019 15:30:02 +0900
Message-Id: <20190326042608.349539737@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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


