Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9330C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AADC206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642260;
	bh=eoYpF+gRt/ew8hg1pPdt98QdDGY0mMZbkOyBmpex5Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z8/oWIuoaLzn6n78mp3HbvFC1eKAZ3uE93p2swJCuqjwjLkDD/yuK4Fle+22YwMsM
	 UZr0uIesBr9/0/8baNw+0Igrnv40OWaUr74Bw5UL3+cwPp93U/dkHuLqJI9TRNuH39
	 weDE5ExMXiyvzrEd3HwiM1mvCUlJKi/CbLBw6k34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733295AbfL2R5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:57:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733276AbfL2R5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:57:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A786F222C3;
        Sun, 29 Dec 2019 17:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642254;
        bh=eoYpF+gRt/ew8hg1pPdt98QdDGY0mMZbkOyBmpex5Cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOUE/8mKuKBVKxwcZLJXAS9WiHEZgL4aAhjsQWwp+EZdrn5MNQ3lwRRzJu8rhlV2E
         +b0bAZj56isUI+Whj3Lf2zk1ZUsTfIGGkRXr8dOflZ3qd6Cl+lchpUDkOHWESKMQ73
         a+n9bnJHIsICbZjk+dds/TJNPkemUgCaqTs4UKu4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonghan Ye <yonghan.ye@unisoc.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: [PATCH 5.4 405/434] serial: sprd: Add clearing break interrupt operation
Date:   Sun, 29 Dec 2019 18:27:38 +0100
Message-Id: <20191229172729.542673151@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonghan Ye <yonghan.ye@unisoc.com>

commit abeb2e9414d7e3a0d8417bc3b13d7172513ea8a0 upstream.

A break interrupt will be generated if the RX line was pulled low, which
means some abnomal behaviors occurred of the UART. In this case, we still
need to clear this break interrupt status, otherwise it will cause irq
storm to crash the whole system.

Fixes: b7396a38fb28 ("tty/serial: Add Spreadtrum sc9836-uart driver support")
Signed-off-by: Yonghan Ye <yonghan.ye@unisoc.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
Link: https://lore.kernel.org/r/925e51b73099c90158e080b8f5bed9b3b38c4548.1575460601.git.baolin.wang7@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sprd_serial.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -679,6 +679,9 @@ static irqreturn_t sprd_handle_irq(int i
 	if (ims & SPRD_IMSR_TIMEOUT)
 		serial_out(port, SPRD_ICLR, SPRD_ICLR_TIMEOUT);
 
+	if (ims & SPRD_IMSR_BREAK_DETECT)
+		serial_out(port, SPRD_ICLR, SPRD_IMSR_BREAK_DETECT);
+
 	if (ims & (SPRD_IMSR_RX_FIFO_FULL | SPRD_IMSR_BREAK_DETECT |
 		   SPRD_IMSR_TIMEOUT))
 		sprd_rx(port);


