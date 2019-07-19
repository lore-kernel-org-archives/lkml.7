Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBC1C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9511821849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 18:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtGE7qyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbfGSSqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 14:46:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42278 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbfGSSqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 14:46:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so14541847pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LgCwfeb0qUeGvteEDqnpqo5FEOvlxmkPiJSvQEyBpA4=;
        b=LtGE7qyzqvqQis+0QWaAc6EydmIRM2jL00m9b+Go8yQAU7Lt9OzQe2emBMW8bIJ5D6
         YHIGHKqaOCDJ36TRTari/GqdWkzG0KYvhYZ6PntA3qeQ5EIVPqsACyM1fcQPL8TcrUCR
         Y+r7tmV91mI67L1Is2NyEazqRwqS2xr+0GGD8+3PC/OzLtth1DC9mwH4R3oiGKj2k8HP
         4AMyHclQbhR2qTQYqNVAYYBJu+aiOq+rUzmMuGOSESv+55R94I6VbBbZqbkXW4CuaeVR
         b5pIhP6P58n83e/wWatxPwFjXc2PiFBBYFsPBccsetuOybLQETZMdtYJPwOXAoBIYXky
         KxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LgCwfeb0qUeGvteEDqnpqo5FEOvlxmkPiJSvQEyBpA4=;
        b=cMrklkrA5+FRYFR/+LMu6JGlimW8Gq/wlkxGqLFaz1Jy3qBTLaSSlHz/lAPTV6vDDI
         oH3ou99qfi0LMZbn9kL1AyaFjASHe2Hm9Q2EHRFGrdiZ6CVMzbOKrNFyX0RRRpF7gp22
         Pap8chabzuSyK4oaOw7HEZ8gVNx9+SWQsBgsEuGpLEqyo0l6aTU1vno+FFZ46GVOAZOO
         AATv9L4OUymFU9DBJ+x5+UcLi5eBMccO8MWCTKG3O3tDnQazxOdiP7S1Y9Kybbr7dJeJ
         72/NAbe9/fB3C87slGxHMcZXUjwSscEvel9u3oaRtdHHxEQWS1iWpw7cJfhCj4LKM6JB
         6q0w==
X-Gm-Message-State: APjAAAW2N/dshWOSC1IPJfFK0TFA9R8fGtsKN7PP+PRGZBki+wRnuOa6
        QIvNaibRwHl30jF7dsjKmJU=
X-Google-Smtp-Source: APXvYqxkdYNpO/9sbTcC3Gwdlyw8Fp+lp6d3baaiN8Qy+GZcZufOZdcjl3SXt9qBB2rqD7nWprPrHQ==
X-Received: by 2002:a63:188:: with SMTP id 130mr54815202pgb.231.1563561973341;
        Fri, 19 Jul 2019 11:46:13 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id g18sm55976033pgm.9.2019.07.19.11.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 11:46:12 -0700 (PDT)
Date:   Sat, 20 Jul 2019 00:16:06 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] rqchip/stm32: Remove unneeded call to kfree
Message-ID: <20190719184606.GA4701@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory allocated by devm_ alloc will be freed upon device detachment. So
we may not require free memory.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/irqchip/irq-stm32-exti.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index e00f2fa..46ec0af 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -779,8 +779,6 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	irq_domain_remove(domain);
 out_unmap:
 	iounmap(host_data->base);
-	kfree(host_data->chips_data);
-	kfree(host_data);
 	return ret;
 }
 
-- 
2.7.4

