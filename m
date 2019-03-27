Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB4EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CB92147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710514;
	bh=41dify9q1NKwIhdbNUZMLhV89COXe+eijwqW6kA8Hb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fqfoupNg+7EZQfUhukuPycvedg6SUZnnJw4A1MRLS8HHYpqV72h6bIyQ7s8phWnzj
	 9RE5GNG5BdTLMr0s+sENGSrkOnImVa7l7SRUrmSzKPKZ8YZi9mXQvDxtX0pT5LPTyt
	 DmxXzqYDXpaD/habp9ONAnG+jZkIYbIPpu3hu5Us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389797AbfC0SPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388996AbfC0SPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:15:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426502082F;
        Wed, 27 Mar 2019 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710508;
        bh=41dify9q1NKwIhdbNUZMLhV89COXe+eijwqW6kA8Hb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H8axxG8E2iAKNiXNFB67/DQHn9IbcB2146EKLgxFUzbKc6qeBydqjxeVF38mf8JiH
         k/HjgNNhRGeh4e+thr9KPHyIIO3BSJpd7jjoBc02OsBJKaYbmIyXxE67YOcz6FZtKS
         ZSwUr3W77tnexl6hvPNP36cFmLxT3DIe1DGrgbkY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 151/192] tty: increase the default flip buffer limit to 2*640K
Date:   Wed, 27 Mar 2019 14:09:43 -0400
Message-Id: <20190327181025.13507-151-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

[ Upstream commit 7ab57b76ebf632bf2231ccabe26bea33868118c6 ]

We increase the default limit for buffer memory allocation by a factor of
10 to 640K to prevent data loss when using fast serial interfaces.

For example when using RS485 without flow-control at speeds of 1Mbit/s
an upwards we've run into problems such as applications being too slow
to read out this buffer (on embedded devices based on imx53 or imx6).

If you want to write transmitted data to a slow SD card and thus have
realtime requirements, this limit can become a problem.

That shouldn't be the case and 640K buffers fix such problems for us.

This value is a maximum limit for allocation only. It has no effect
on systems that currently run fine. When transmission is slow enough
applications and hardware can keep up and increasing this limit
doesn't change anything.

It only _allows_ to allocate more than 2*64K in cases we currently fail to
allocate memory despite having some.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index ae3ce330200e..ee3aa57bc0e7 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -26,7 +26,7 @@
  * Byte threshold to limit memory consumption for flip buffers.
  * The actual memory limit is > 2x this amount.
  */
-#define TTYB_DEFAULT_MEM_LIMIT	65536
+#define TTYB_DEFAULT_MEM_LIMIT	(640 * 1024UL)
 
 /*
  * We default to dicing tty buffer allocations to this many characters
-- 
2.19.1

