Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E655C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DA42054F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121683;
	bh=qyqv8Nqt7qKDu6qQIfCQt4uEpeLcNcBWqRu86A9Xn1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Q16IL4dbYevfNaYZN8APpSIir6dDEJCLo1XT5o3wsS1Ze098Bh6+w1I9aE/GyFdJ
	 MknYF6cckgLpKp6LFz8IiQbkkDmlyXZZeXD6I1S+YZtBehjgGZRgXkpmFnhxqS4ifS
	 p4AcUkVsnjAanTx5/TTOhNWXU+3lErsXnq4FR4nA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405178AbfJCQxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403885AbfJCQxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:53:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ADC92133F;
        Thu,  3 Oct 2019 16:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121590;
        bh=qyqv8Nqt7qKDu6qQIfCQt4uEpeLcNcBWqRu86A9Xn1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DbEaw9xcs3a9DDbqe53RPiU+xZuGOi2CY+3h5j6qvTnlD7GZtWtTw6bWViKTroHnz
         sjl2oUp8qL4lwjG5Ww8zS8eAiHMjoXS6LNFFCc1MGMAS7RzqCYrZurUs1N9dJuEuFa
         XtP+ZWCZ9tyKR0MsPTtm9SiSM8AzM4tgROFISr/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chien Nguyen <chien.nguyen.eb@rvc.renesas.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5.3 334/344] i2c: riic: Clear NACK in tend isr
Date:   Thu,  3 Oct 2019 17:54:59 +0200
Message-Id: <20191003154611.614104438@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Brandt <chris.brandt@renesas.com>

commit a71e2ac1f32097fbb2beab098687a7a95c84543e upstream.

The NACKF flag should be cleared in INTRIICNAKI interrupt processing as
description in HW manual.

This issue shows up quickly when PREEMPT_RT is applied and a device is
probed that is not plugged in (like a touchscreen controller). The result
is endless interrupts that halt system boot.

Fixes: 310c18a41450 ("i2c: riic: add driver")
Cc: stable@vger.kernel.org
Reported-by: Chien Nguyen <chien.nguyen.eb@rvc.renesas.com>
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-riic.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -202,6 +202,7 @@ static irqreturn_t riic_tend_isr(int irq
 	if (readb(riic->base + RIIC_ICSR2) & ICSR2_NACKF) {
 		/* We got a NACKIE */
 		readb(riic->base + RIIC_ICDRR);	/* dummy read */
+		riic_clear_set_bit(riic, ICSR2_NACKF, 0, RIIC_ICSR2);
 		riic->err = -ENXIO;
 	} else if (riic->bytes_left) {
 		return IRQ_NONE;


