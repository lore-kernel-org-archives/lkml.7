Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD517C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF6E20657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369709;
	bh=CfroIvwfCu/73sEN/nJcOsDJ03czemFHEndbg7TPzk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ncT5fn7j3K82xNoJKBEpb6VKqs2MCK6dUZxIpNPS+s6zBAMUQTmlwqWDv0PPKvS2i
	 Wpv6XhWWe9oBiBbinjRSjpKRWklNop5xjZFikIuIL22+bor8/GjZ4Aev82Y4G0FyGw
	 V+uV0zDk9twTF5+4KBP0TDxQxuB8KWnp9Dwp0hdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388303AbfDDJVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388082AbfDDJQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E5A9214AF;
        Thu,  4 Apr 2019 09:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369397;
        bh=CfroIvwfCu/73sEN/nJcOsDJ03czemFHEndbg7TPzk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CutlSA1rNDfjzpleMNpy2xGFzYBrr6TmyHXs0a0IycqlaVOLR7trx8oAfcXCBaAUY
         C+2T4/ODP7thVW/aoIDkrh70XaiMPwTAYL+vCaVAw6X7pYb8lpwxjsa2jLqP44tTwB
         B2BQYbVhxW0Dfa/W+M/UmBOotr847Uv9gS1XdO5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 193/246] tty: increase the default flip buffer limit to 2*640K
Date:   Thu,  4 Apr 2019 10:48:13 +0200
Message-Id: <20190404084625.943479637@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 77070c2d1240..ec145a59f199 100644
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



