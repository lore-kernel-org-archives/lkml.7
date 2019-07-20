Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21445C76196
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 04:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF12820873
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 04:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSc86vax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfGTEGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 00:06:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34698 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfGTEGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 00:06:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so9059402pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 21:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=neC3zaA6/SjW//JOmms70Lu5HwOzIZBuLfb866mHmIU=;
        b=ZSc86vaxfnhWiLJ1Hf8++d35zLhCzVjggsH3Oq/7mh3pJvRMu+bDvh79QMHfwaUzaH
         rScA1Au0eU759BXhYzcQfH91XYYCXVChYga5OzkxjC9bHApuaBTaPTahU0RjmI66VhjD
         BTpOHgFbYfR0E/pNPdG0MQBwtRTIGdAQi+OWgLMBtLV1ToqJnVhOLY17O0eqtizEbZyO
         Sp6sNZfNuBdzIp+JZJ1M3znKjBjdq+2oKMYB7oOaXwpTuMlPvUOByej2EZtW61b7qqKO
         IqDFtKBSFk7wVOZm4SgiONPbUQqpE5my2syp96Cos3tP8h6r8+MXdachKdkEL8UGnR3E
         nE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=neC3zaA6/SjW//JOmms70Lu5HwOzIZBuLfb866mHmIU=;
        b=HmPQr5EO6EwQ9Adajavjr4CzyoC6dB61Mi00d1qXsT+BhnElCEB7aXHnXEr+TKoIGF
         aRdkMgfq5VrC/oDJwwLqw4PTApJFK5ucnG5um18Ae9MDhb3qBGjhj8Agy5dswKt4Izrg
         t3xpN2xm8d8TncDtr8LkgTc/MrlZdMAqNY5tkBx4FQLDxtI84hqudtRRQE3MKeX20hmx
         J33J0ol8Uq7OaBRMSH7hSmpYjrHiFy3hhU44sn/PTYlRqILJccOvQsi/A/sP69Ms52fQ
         r0EX7ruv5Fj9UcgWgaOS0XZdC5GxI/iAweCu3es1cxirkv2s12TMEGi/c8JnB9YqyLkV
         b1yQ==
X-Gm-Message-State: APjAAAWLVZQhuePXYOR7JkYbSYjQk8GkoLZ7TW8o7/SzOli8ck2xJYFC
        bdUO3gk48zwf02IQcgfFRY0=
X-Google-Smtp-Source: APXvYqwUYFOL/TcGld7Rp1jjIRi5rUNxYovcaYjqYcnocQC0PeWaqupmaQT1SLQvnrRdS04EKuADCg==
X-Received: by 2002:a63:d23:: with SMTP id c35mr57533273pgl.376.1563595591261;
        Fri, 19 Jul 2019 21:06:31 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id z20sm53985638pfk.72.2019.07.19.21.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 21:06:30 -0700 (PDT)
Date:   Sat, 20 Jul 2019 09:36:24 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [Patch v2] irqchip/stm32: Remove unneeded call to kfree
Message-ID: <20190720040624.GA10625@hari-Inspiron-1545>
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
v2: correct the subject line

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

