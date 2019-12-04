Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0124C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7815E20661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483849;
	bh=BlxeznEm3n30PyFcV4J0Ki0w3dhhBWFP5ESTOP+yQTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XAtMw2K8rfyxSq2iCy3R8hjxNnaJ/AVSUGPiIMK3asGJZllk44uxx6PlGm1Ah169v
	 d8f8m3vrfxFPCLTidFuj5RzANxbfM5jsCu+zECscCxTEc6u+PjfCTQwb4ziR5PqMYx
	 y5lcOxg2ZI01L06Y3l417TzgUwAjWZuIg8hLOj7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfLDSYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:24:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729960AbfLDSDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:03:04 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 435262073B;
        Wed,  4 Dec 2019 18:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482583;
        bh=BlxeznEm3n30PyFcV4J0Ki0w3dhhBWFP5ESTOP+yQTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nIUJ7UQj3TgQ+mnXtFTeuDub+zwis3GJWsH8NmLr53Fdj36C2/I26uSeoF3D207vV
         M6NQdhoYbyl2w4C7apC2+fi4e9V8uHJ0j6aZ4ngWsS9aQ7nXdzGyykHcPCzfzHM+1v
         GaBcvK0JCi04uDqittMTfZODakbX6DBPEiwsBPJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 055/209] gpiolib: Fix return value of gpio_to_desc() stub if !GPIOLIB
Date:   Wed,  4 Dec 2019 18:54:27 +0100
Message-Id: <20191204175325.153260665@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit c5510b8dafce5f3f5a039c9b262ebcae0092c462 ]

If CONFIG_GPOILIB is not set, the stub of gpio_to_desc() should return
the same type of error as regular version: NULL.  All the callers
compare the return value of gpio_to_desc() against NULL, so returned
ERR_PTR would be treated as non-error case leading to dereferencing of
error value.

Fixes: 79a9becda894 ("gpiolib: export descriptor-based GPIO interface")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/gpio/consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index c4a350d835788..79ad4f8b889dc 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -404,7 +404,7 @@ static inline int gpiod_to_irq(const struct gpio_desc *desc)
 
 static inline struct gpio_desc *gpio_to_desc(unsigned gpio)
 {
-	return ERR_PTR(-EINVAL);
+	return NULL;
 }
 
 static inline int desc_to_gpio(const struct gpio_desc *desc)
-- 
2.20.1



