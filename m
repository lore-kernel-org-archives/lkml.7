Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A52C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BAD25B8E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191632;
	bh=pCUgabiJxyEEir2AOb6uigqyGlGTVW+KEemkN6+uvnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0iaXPjaC6OyCszUHADLvcrFPWF+exoyIwF5MwCu+Cv3qrPhxchS1Gx8zLYDvqjMSg
	 2VjLW19vdnnErhG2oMoJKhirsd6KRj6UA8AK1Q66irxtZcEOs1LHSp7Mbg0nS7lchZ
	 qXXJlNbwISvrcgY9m2qgTuSvA5w0BGP60ZknHNpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388698AbfE3ErL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:47:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbfE3DLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:34 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 866F8244D1;
        Thu, 30 May 2019 03:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185893;
        bh=pCUgabiJxyEEir2AOb6uigqyGlGTVW+KEemkN6+uvnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fMESX/aLQgFEXc0bJJHw2wgLLL2dLVlUXUJwA+4/ctzW4dXWi6tj4CnpSbteKJmKT
         WUvzZ2q1MseGgOeKg9HfMbdpA1fZTGkQB91qz4aVcvL/+cmTIu0EKJMotRWGFcC1/v
         TMw3IWy6r56/Xdb0I4RwBQXSZWHPA+2pYOp6F3e8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 256/405] spi: Add missing error handling for CS GPIOs
Date:   Wed, 29 May 2019 20:04:14 -0700
Message-Id: <20190530030553.929604019@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1723fdec5fcbc4de3d26bbb23a9e1704ee258955 ]

While devm_gpiod_get_index_optional() returns NULL if the GPIO is not
present (i.e. -ENOENT), it may still return other error codes, like
-EPROBE_DEFER.  Currently these are not handled, leading to
unrecoverable failures later in case of probe deferral:

    gpiod_set_consumer_name: invalid GPIO (errorpointer)
    gpiod_direction_output: invalid GPIO (errorpointer)
    gpiod_set_value_cansleep: invalid GPIO (errorpointer)
    gpiod_set_value_cansleep: invalid GPIO (errorpointer)
    gpiod_set_value_cansleep: invalid GPIO (errorpointer)

Detect and propagate errors to fix this.

Fixes: f3186dd876697e69 ("spi: Optionally use GPIO descriptors for CS GPIOs")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d17f68775a4bb..e3f2e15b75ad4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2195,6 +2195,8 @@ static int spi_get_gpio_descs(struct spi_controller *ctlr)
 		 */
 		cs[i] = devm_gpiod_get_index_optional(dev, "cs", i,
 						      GPIOD_OUT_LOW);
+		if (IS_ERR(cs[i]))
+			return PTR_ERR(cs[i]);
 
 		if (cs[i]) {
 			/*
-- 
2.20.1



