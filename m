Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54614C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2761F2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155159;
	bh=l+vwBq8B0iCqSp7zzsk2DETMYixOA5pWhzYBakqzhJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V2N4Ba3TIQz6+gi4JAowIZ0FhntoAvzTcyFV2XTVZYJ1ohMx0g+JDSU0zzmcaXmT1
	 8LFnCNieQnw3+Zg7LBcFYv5X414DxrJ3sNcnDVdAFPuUZLWFp8OBAZ/kITwyHbKind
	 8QTMmDTgOgdce4A2bWCTBwRw2MQVj+gAh8lrZiq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfEFPF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbfEFOiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:38:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1A1920449;
        Mon,  6 May 2019 14:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153495;
        bh=l+vwBq8B0iCqSp7zzsk2DETMYixOA5pWhzYBakqzhJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fx15v/a2L1xN4Da0l14LrWpD9CtQyRz4Twb3j883wqaOp5KnZgHTNd/pLOzMlO0gJ
         ZcMVCzxUu1SKX5Zcn71V+TGwwlV1rJWwZpSasXu+8uqEMWWHF+t9Kg51/YymHXWmV+
         Homu4gM4cql0m6PqqKrQgYOyVZQlOs81YooPHfmE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.0 111/122] gpio: mxc: add check to return defer probe if clock tree NOT ready
Date:   Mon,  6 May 2019 16:32:49 +0200
Message-Id: <20190506143104.441736734@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

commit a329bbe707cee2cf8c660890ef2ad0d00ec7e8a3 upstream.

On i.MX8MQ platform, clock driver uses platform driver
model and it is probed after GPIO driver, so when GPIO
driver fails to get clock, it should check the error type
to decide whether to return defer probe or just ignore
the clock operation.

Fixes: 2808801aab8a ("gpio: mxc: add clock operation")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-mxc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -438,8 +438,11 @@ static int mxc_gpio_probe(struct platfor
 
 	/* the controller clock is optional */
 	port->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(port->clk))
+	if (IS_ERR(port->clk)) {
+		if (PTR_ERR(port->clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		port->clk = NULL;
+	}
 
 	err = clk_prepare_enable(port->clk);
 	if (err) {


