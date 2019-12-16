Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FD9C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00683206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520551;
	bh=vQ+eRiIY2UwYOBrhgsHle4m1zP2RSoGVKwaTLJoB/Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kYqjYzjUTGuRGCc5l6KioK1ZxaVfmZ5e8gP2pXTYIQsjyxfxnOEeZMfzdPZZfnc2H
	 yHtohgZ7iwJZjHnllF56EbLzsfTCEm0ipx+D9XduCaYzSC9F68gJDifEF10Z1XPe+7
	 2iomusqpNDGXgCCw+tcY4Un8KuVIRJeF4ptfdKYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbfLPSW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:22:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731929AbfLPSV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:21:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0891F206EC;
        Mon, 16 Dec 2019 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520487;
        bh=vQ+eRiIY2UwYOBrhgsHle4m1zP2RSoGVKwaTLJoB/Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pluYllTjwjjsfbES+a/aVpPvAXOmBQI/WgKu1Ym+Iyy2maNrgOGM/1gnr/VAt8Rcq
         T9BpR8t+2rjrGVNXvKKL4AvT5Gs2qxpybtrey1BTgc+YzpybPstuwAH0A7NQ9Pz7dd
         6SVe2MMQfBzAQmurN8WuHJqtCA5ddhOCx3vpLGlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5.4 135/177] pinctrl: samsung: Fix device node refcount leaks in S3C24xx wakeup controller init
Date:   Mon, 16 Dec 2019 18:49:51 +0100
Message-Id: <20191216174845.614615601@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

commit 6fbbcb050802d6ea109f387e961b1dbcc3a80c96 upstream.

In s3c24xx_eint_init() the for_each_child_of_node() loop is used with a
break to find a matching child node.  Although each iteration of
for_each_child_of_node puts the previous node, but early exit from loop
misses it.  This leads to leak of device node.

Cc: <stable@vger.kernel.org>
Fixes: af99a7507469 ("pinctrl: Add pinctrl-s3c24xx driver")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
@@ -490,8 +490,10 @@ static int s3c24xx_eint_init(struct sams
 		return -ENODEV;
 
 	eint_data = devm_kzalloc(dev, sizeof(*eint_data), GFP_KERNEL);
-	if (!eint_data)
+	if (!eint_data) {
+		of_node_put(eint_np);
 		return -ENOMEM;
+	}
 
 	eint_data->drvdata = d;
 
@@ -503,12 +505,14 @@ static int s3c24xx_eint_init(struct sams
 		irq = irq_of_parse_and_map(eint_np, i);
 		if (!irq) {
 			dev_err(dev, "failed to get wakeup EINT IRQ %d\n", i);
+			of_node_put(eint_np);
 			return -ENXIO;
 		}
 
 		eint_data->parents[i] = irq;
 		irq_set_chained_handler_and_data(irq, handlers[i], eint_data);
 	}
+	of_node_put(eint_np);
 
 	bank = d->pin_banks;
 	for (i = 0; i < d->nr_banks; ++i, ++bank) {


