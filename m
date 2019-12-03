Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D504C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2494F20881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413398;
	bh=niKuEWpHYMiGBDyVgEHosl+UrqPkEyiUFP+M5ijO2mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PiMczNnezulT8ChkH2NQ7ZyWYaUmof4Rhncjf28V3J3hY6Orpf9YkOZ4t/eOB0c+v
	 Zi12+7JnjvWCJ1QVa00wG/s36ocQPqW7ySVsofe+FS151IyFrSKMwfLlgLC4TcszMv
	 7FCX+HH6yrTHgkMPFtgkvZ1atRdI05hMx291zads=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfLCWt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:49:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbfLCWtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:49:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8903C2080F;
        Tue,  3 Dec 2019 22:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413389;
        bh=niKuEWpHYMiGBDyVgEHosl+UrqPkEyiUFP+M5ijO2mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=enNI0OstmkRUUFJsPYsieEj6Xhywj0PRBKjmyL9CUyz5FG4WxBywL2RRQAiSVs/PW
         QmuURvjZ308Ctr0ykyMuMT40SXD1AumpO11aUpicEmEcHZpVvkn+mj1khnOSPOLOBi
         Jg+jtCb0lf1Dg+caC0GgW8L3uySNrz6QnRzfKAb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 109/321] gpio: pca953x: Fix AI overflow on PCAL6524
Date:   Tue,  3 Dec 2019 23:32:55 +0100
Message-Id: <20191203223432.820984240@linuxfoundation.org>
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

From: Marek Vasut <marek.vasut@gmail.com>

[ Upstream commit 92f45ebe68181c2d7f76633ffae55bc9447d62cd ]

The PCAL_PINCTRL_MASK is too large. The extended register block on
PCAL6524, which is the largest chip with this block, has the block
limited to address range 0x40..0x7f. This is because the bit 7 in
the command register is used for the Address Increment functionality.

Trim the mask to 0x60 to match the datasheet and to prevent accidental
overwrite of the AI bit.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-pca953x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index e0657fc72d31f..0232c25a15864 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -58,7 +58,7 @@
 #define PCA_GPIO_MASK		0x00FF
 
 #define PCAL_GPIO_MASK		0x1f
-#define PCAL_PINCTRL_MASK	0xe0
+#define PCAL_PINCTRL_MASK	0x60
 
 #define PCA_INT			0x0100
 #define PCA_PCAL		0x0200
-- 
2.20.1



