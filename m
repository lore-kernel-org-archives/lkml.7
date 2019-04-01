Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F53C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C4F21925
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138750;
	bh=Tf2VrvhyR/oTnKy4NmaC7NBiB660Qn4CozKkMQMbhvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jDyV83wMUoyhco7HF2wDzKOgcNwd12wQx8Fawoc/0PNugRMCL9DLKe2QZATbgpS1Z
	 yWw8JH1c6tIYPsB/eydzrzeEA2kUBDCXLkfdcKEPaZBzkQd+xZDRg7DSZ37QfkF2/s
	 NqDddCk1Sr6mp/rkHvH0sOB8KOJ74XIAzU+bhKIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfDARM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729817AbfDARMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:12:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6742D21939;
        Mon,  1 Apr 2019 17:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138741;
        bh=Tf2VrvhyR/oTnKy4NmaC7NBiB660Qn4CozKkMQMbhvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jrRDbezSD4pqpqw8G4LICbl7lSqtxma0I+lMEut7nHeIAuKCPyf7Hrg79gTt/POaB
         VfU3jXVM+VYlwhcis3/6XjISrNmfUQiT0zPnBeDri4im88R8r6dy0m92qDdJkbjD13
         l1f4wdFakBw2SWzn28RQCDJC/qtupbXcC62zkGt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 5.0 124/146] usb: typec: Fix unchecked return value
Date:   Mon,  1 Apr 2019 19:02:16 +0200
Message-Id: <20190401170058.789474145@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit e82adc1074a7356f1158233551df9e86b7ebfb82 upstream.

Currently there is no check on platform_get_irq() return value
in case it fails, hence never actually reporting any errors and
causing unexpected behavior when using such value as argument
for function regmap_irq_get_virq().

Fix this by adding a proper check, a message error and return
*irq* in case platform_get_irq() fails.

Addresses-Coverity-ID: 1443899 ("Improper use of negative value")
Fixes: d2061f9cc32d ("usb: typec: add driver for Intel Whiskey Cove PMIC USB Type-C PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/tcpm/wcove.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/usb/typec/tcpm/wcove.c
+++ b/drivers/usb/typec/tcpm/wcove.c
@@ -615,8 +615,13 @@ static int wcove_typec_probe(struct plat
 	wcove->dev = &pdev->dev;
 	wcove->regmap = pmic->regmap;
 
-	irq = regmap_irq_get_virq(pmic->irq_chip_data_chgr,
-				  platform_get_irq(pdev, 0));
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
+		return irq;
+	}
+
+	irq = regmap_irq_get_virq(pmic->irq_chip_data_chgr, irq);
 	if (irq < 0)
 		return irq;
 


