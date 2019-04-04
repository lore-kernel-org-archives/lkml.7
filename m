Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859DBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497E021738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368306;
	bh=0inoD4sMunmJFLcNmu9pHM6tNu4FBjqx16HI2ibw1Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Md4cBv6kly42nxG96YEqYLwNHrsAaNbrlwI6vbeTb23jVKpBBevTMdTPWms+LH6QC
	 41pnU/nAJOSe2fTyXQP+nAUO1JiYxn8DlVF4bFQOzsD5UwuEGgjcWsQd2paiGWCmDG
	 p8Cf4sBQTq2vy4Pk53hNexfjSBoG41HI7btvt35I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfDDI6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730228AbfDDI6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:58:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04C31217D9;
        Thu,  4 Apr 2019 08:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368302;
        bh=0inoD4sMunmJFLcNmu9pHM6tNu4FBjqx16HI2ibw1Eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yPhmO/+AVm0uwedBgwNHBuIRKBpfvCy3h+ef/3Wecj0oZw5ukvaHL/T1K3VPDBY+E
         ITbgaw1smyi1esO/nXKJvVQYWJP24u3bgsbYedWtExr4Ofvs2gF+VYrRqWqJhM69gt
         9iVRORUEBmqKbp1iv00Tpiyr3VCJzGDNvMZzZyOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 097/121] tty: increase the default flip buffer limit to 2*640K
Date:   Thu,  4 Apr 2019 10:48:05 +0200
Message-Id: <20190404084550.580608669@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 217114227f8d..cf11882d2602 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -25,7 +25,7 @@
  * Byte threshold to limit memory consumption for flip buffers.
  * The actual memory limit is > 2x this amount.
  */
-#define TTYB_DEFAULT_MEM_LIMIT	65536
+#define TTYB_DEFAULT_MEM_LIMIT	(640 * 1024UL)
 
 /*
  * We default to dicing tty buffer allocations to this many characters
-- 
2.19.1



