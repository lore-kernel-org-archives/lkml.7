Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78769C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AF120CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380790;
	bh=HXjT9KLKnTA54QRu46r/yrS6+0bvH6TwPhV5Alirj4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0a14i3MmaNt/3km22ezWe/e2uadJMtiuhBO/6SlYu1OQ9zFjpf9Am57yC/VfH8Wbk
	 cPbBK2WClwRE+rCwIwxuSfmH/ULB3C1Ks6PjNyERY9LKiZPmY5UcO7M7YqicPoCkbi
	 ftTD/4omXVOf2oQi0y1OdBn28DITQ6zh9o/3DLyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389904AbfIMNTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730219AbfIMNTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:19:30 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0289214AF;
        Fri, 13 Sep 2019 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380770;
        bh=HXjT9KLKnTA54QRu46r/yrS6+0bvH6TwPhV5Alirj4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjkW8gNSOaAPBUEZHb1ic811WCyZ1lBq/BzhGBnNzDEgYKIkw9RWGvApzgsmR62pF
         7IrR2LtlyrGBttW39E458KTMfq3RT4fh03sP/YKlSiDUVGxnzDGqZa7gxaOxpBIelg
         Xz6CQj2uTMrq9wTSKqR8TzFvsX5gs7Um6Srr8Y8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 173/190] i2c: at91: fix clk_offset for sama5d2
Date:   Fri, 13 Sep 2019 14:07:08 +0100
Message-Id: <20190913130613.567583017@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b1ac6704493fa14b5dc19eb6b69a73932361a131 ]

In SAMA5D2 datasheet, TWIHS_CWGR register rescription mentions clock
offset of 3 cycles (compared to 4 in eg. SAMA5D3).

Cc: stable@vger.kernel.org # 5.2.x
[needs applying to i2c-at91.c instead for earlier kernels]
Fixes: 0ef6f3213dac ("i2c: at91: add support for new alternative command mode")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 0998a388d2ed5..d51bf536bdf75 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -914,7 +914,7 @@ static struct at91_twi_pdata sama5d4_config = {
 
 static struct at91_twi_pdata sama5d2_config = {
 	.clk_max_div = 7,
-	.clk_offset = 4,
+	.clk_offset = 3,
 	.has_unre_flag = true,
 	.has_alt_cmd = true,
 	.has_hold_field = true,
-- 
2.20.1



