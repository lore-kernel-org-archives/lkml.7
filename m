Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AC3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55022084B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413443;
	bh=5PXEbBylnnhAkoiwvd/bOD51FRWOQedouhurN35w0Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SY0Kau8QyTZCULnFuvClUrNrvWh+VIBAHrU08c7I392mp7uv+DewPJ4CfJBD8lZEc
	 qLvQ1mj95mwJu43EYe3brY7woraRVk9iphYITCqp/a4VQwwD95WudBSOtYDq0wfWBc
	 jI39qNIbwTKNfD2t0sQ++e6gFJ49wJ7rsuXi9kIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfLCWum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:50:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbfLCWue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:50:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6119E20863;
        Tue,  3 Dec 2019 22:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413433;
        bh=5PXEbBylnnhAkoiwvd/bOD51FRWOQedouhurN35w0Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XAiKIiacu/ZBGdLmh0phUyAWz8lhId12srbEfTPr9bsc5IQWR5PNgBYYNC5ZAvZRy
         dK50UCdJanSF9oZhZF08arFOPf/65YCUJiSi0nqgROVMrAGpFCAn7KLDTFP2jCuIvv
         iPEa+5z00zQEJcGTKGbvtuhtTodyer9AQA1XIuNU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 124/321] gpio: raspberrypi-exp: decrease refcount on firmware dt node
Date:   Tue,  3 Dec 2019 23:33:10 +0100
Message-Id: <20191203223433.605335029@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

[ Upstream commit 85af74c474b21940e88483fd48f6094145c89d97 ]

We're getting a reference RPi's firmware node in order to be able to
communicate with it's driver. We should decrease the reference count on
the dt node after being done with it.

Fixes: a98d90e7d588 ("gpio: raspberrypi-exp: Driver for RPi3 GPIO expander via mailbox service")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-raspberrypi-exp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-raspberrypi-exp.c b/drivers/gpio/gpio-raspberrypi-exp.c
index d6d36d537e373..b77ea16ffa031 100644
--- a/drivers/gpio/gpio-raspberrypi-exp.c
+++ b/drivers/gpio/gpio-raspberrypi-exp.c
@@ -206,6 +206,7 @@ static int rpi_exp_gpio_probe(struct platform_device *pdev)
 	}
 
 	fw = rpi_firmware_get(fw_node);
+	of_node_put(fw_node);
 	if (!fw)
 		return -EPROBE_DEFER;
 
-- 
2.20.1



