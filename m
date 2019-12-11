Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1204C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9855720836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576080268;
	bh=RXr2DM/uQQoQ/6KUgA6s1XB/AQUmAh3cUi4wj6XWrR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m4gA9Rpal14T0BByrbCvKITpwn88fnPr6E+PHUnQAR2HaA9Dlf9ZgKbw6GwUKmVIA
	 uZ8YDqwN6zgukpIDU0Jt3Dms8fprtMHWJWKKfe79aLVO4oBcfc7e/BgwOR9d7lmDCv
	 ko94rhIH1Bzaee5Ll7TjJ1P1PscXQPmqL+nO0SRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbfLKQE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:04:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730267AbfLKPNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:13:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4E724684;
        Wed, 11 Dec 2019 15:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077181;
        bh=RXr2DM/uQQoQ/6KUgA6s1XB/AQUmAh3cUi4wj6XWrR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RODhA/T3t3d5Fo71QmKXa6i9RrZ6pAvcdWbBShXAPSo64RNdKvfNRF9Xl1s9C74XB
         yorHGhMC+TRXAh6WFFY6ygWwQAno8bIAB5JyOjOQmayJ7u1dgj99dri1UEXaHPxRpY
         9cj0TVZDOTQNNgv1NmtJTNGbn54SOgdcr1fnUYOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 5.3 012/105] serial: stm32: fix clearing interrupt error flags
Date:   Wed, 11 Dec 2019 16:05:01 +0100
Message-Id: <20191211150223.823667644@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
References: <20191211150221.153659747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

commit 1250ed7114a977cdc2a67a0c09d6cdda63970eb9 upstream.

The interrupt clear flag register is a "write 1 to clear" register.
So, only writing ones allows to clear flags:
- Replace buggy stm32_clr_bits() by a simple write to clear error flags
- Replace useless read/modify/write stm32_set_bits() routine by a
  simple write to clear TC (transfer complete) flag.

Fixes: 4f01d833fdcd ("serial: stm32: fix rx error handling")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/1574323849-1909-1-git-send-email-fabrice.gasnier@st.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/stm32-usart.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -239,8 +239,8 @@ static void stm32_receive_chars(struct u
 		 * cleared by the sequence [read SR - read DR].
 		 */
 		if ((sr & USART_SR_ERR_MASK) && ofs->icr != UNDEF_REG)
-			stm32_clr_bits(port, ofs->icr, USART_ICR_ORECF |
-				       USART_ICR_PECF | USART_ICR_FECF);
+			writel_relaxed(sr & USART_SR_ERR_MASK,
+				       port->membase + ofs->icr);
 
 		c = stm32_get_char(port, &sr, &stm32_port->last_res);
 		port->icount.rx++;
@@ -434,7 +434,7 @@ static void stm32_transmit_chars(struct
 	if (ofs->icr == UNDEF_REG)
 		stm32_clr_bits(port, ofs->isr, USART_SR_TC);
 	else
-		stm32_set_bits(port, ofs->icr, USART_ICR_TCCF);
+		writel_relaxed(USART_ICR_TCCF, port->membase + ofs->icr);
 
 	if (stm32_port->tx_ch)
 		stm32_transmit_chars_dma(port);


