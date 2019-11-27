Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09A8C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82EB2158C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888249;
	bh=AFXHZLOietu/5Qoi+Zd8KLI2EG/uE9+32R3/Z1FPs5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rsV7plj4CliUpsum09ybdbW1M5UgQcRs4U56o0sizXdeZ9jVhfJSkWFLcKeKiSLKL
	 PH76X6kARFN5C6nDuIY6M3vo4UJONPmZ1GzK3ABQImoCDe2yNZNPj+JarqGQRxE2MJ
	 QGEsyYgvFqp/rw/ypWzhYl+b9AXqNzc8Rew2BpcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfK0U52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:57:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731180AbfK0U5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:57:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 824C92084D;
        Wed, 27 Nov 2019 20:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888243;
        bh=AFXHZLOietu/5Qoi+Zd8KLI2EG/uE9+32R3/Z1FPs5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDEs2lkV9vkj5c89ZybgG8xseDMuBvCNTMLZLGC2EsrijOoa2ZuNVveAHMfS6M7zV
         NcyxGRPkVDrqn1EIxodFG4Lsti92xpONzjsKHqDJUoTKFimq7x/+MNdEiRrOv6MZkS
         4XDvjqekYWJVpZITWD2JZRGxrIof1Myp2nuhhiyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 060/306] pinctrl: sunxi: Fix a memory leak in sunxi_pinctrl_build_state()
Date:   Wed, 27 Nov 2019 21:28:30 +0100
Message-Id: <20191127203119.143994143@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit a93a676b079144009f55fff2ab0e34c3b7258c8a ]

If 'krealloc()' fails, 'pctl->functions' is set to NULL.
We should instead use a temp variable in order to be able to free the
previously allocated memeory, in case of OOM.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 26ebedc1f6d31..61aaaf58c5993 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1042,6 +1042,7 @@ static int sunxi_pinctrl_add_function(struct sunxi_pinctrl *pctl,
 static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 {
 	struct sunxi_pinctrl *pctl = platform_get_drvdata(pdev);
+	void *ptr;
 	int i;
 
 	/*
@@ -1108,13 +1109,15 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
 	}
 
 	/* And now allocated and fill the array for real */
-	pctl->functions = krealloc(pctl->functions,
-				   pctl->nfunctions * sizeof(*pctl->functions),
-				   GFP_KERNEL);
-	if (!pctl->functions) {
+	ptr = krealloc(pctl->functions,
+		       pctl->nfunctions * sizeof(*pctl->functions),
+		       GFP_KERNEL);
+	if (!ptr) {
 		kfree(pctl->functions);
+		pctl->functions = NULL;
 		return -ENOMEM;
 	}
+	pctl->functions = ptr;
 
 	for (i = 0; i < pctl->desc->npins; i++) {
 		const struct sunxi_desc_pin *pin = pctl->desc->pins + i;
-- 
2.20.1



