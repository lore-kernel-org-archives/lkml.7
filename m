Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A773C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB94208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141432;
	bh=DgnMDlLLXfeQeKctRy7xaYZdYGgwE1jsdDjdNnqBmGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XHE892+w1lTcWX9SOKUsz+LSLmHUotzNGGkjyP/b3I/PSh8z6CNf+RhEmTBj+2QIL
	 81cSg2XIdMMlezc54eMTaNCGE1aaeXpB0Kb+5rUXsA8ufdSaicdRclFAfAX+lEfCwA
	 VhObU7hX9pZe8rkQ75dZxr1x5zmjIJ1ti1lgN+To=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfKSFaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729133AbfKSFaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:30:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41DB621783;
        Tue, 19 Nov 2019 05:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141424;
        bh=DgnMDlLLXfeQeKctRy7xaYZdYGgwE1jsdDjdNnqBmGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nsjkVuydpTLXijmDDaVclC3ZZZ4G+GadqTrRWmG4gavOzBycMp1PIqpo4wNT3mY+/
         8dEnoojsI5e+IWTwMiEaE6DS1CgIZn38aXHtNSgXZi9NTCHJ2IuEGN/5Y5PluLVJeb
         7YetozAnbsnl+N8UBM4PwtY6fQf3jRVdfyit9zpE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 157/422] rtc: pl030: fix possible race condition
Date:   Tue, 19 Nov 2019 06:15:54 +0100
Message-Id: <20191119051408.719261983@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit c778ec85825dc895936940072aea9fe9037db684 ]

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
before requesting the IRQ.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-pl030.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index f85a1a93e669f..343bb6ed17839 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -112,6 +112,13 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 		goto err_rtc;
 	}
 
+	rtc->rtc = devm_rtc_allocate_device(&dev->dev);
+	if (IS_ERR(rtc->rtc)) {
+		ret = PTR_ERR(rtc->rtc);
+		goto err_rtc;
+	}
+
+	rtc->rtc->ops = &pl030_ops;
 	rtc->base = ioremap(dev->res.start, resource_size(&dev->res));
 	if (!rtc->base) {
 		ret = -ENOMEM;
@@ -128,12 +135,9 @@ static int pl030_probe(struct amba_device *dev, const struct amba_id *id)
 	if (ret)
 		goto err_irq;
 
-	rtc->rtc = rtc_device_register("pl030", &dev->dev, &pl030_ops,
-				       THIS_MODULE);
-	if (IS_ERR(rtc->rtc)) {
-		ret = PTR_ERR(rtc->rtc);
+	ret = rtc_register_device(rtc->rtc);
+	if (ret)
 		goto err_reg;
-	}
 
 	return 0;
 
@@ -154,7 +158,6 @@ static int pl030_remove(struct amba_device *dev)
 	writel(0, rtc->base + RTC_CR);
 
 	free_irq(dev->irq[0], rtc);
-	rtc_device_unregister(rtc->rtc);
 	iounmap(rtc->base);
 	amba_release_regions(dev);
 
-- 
2.20.1



