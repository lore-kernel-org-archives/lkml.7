Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293A0CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9972086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVmqGkA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391411AbfJWT42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 15:56:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40141 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390336AbfJWT42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 15:56:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so194843wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=34YSYh+z8fKM6taIRyymQ72AtYlmDws/1nlNkhmJ8EU=;
        b=mVmqGkA8CkG805lgIQA1eGXuR/icmaYDoKoz4frOeu13p4puWFp6jZ51wco/hOUerw
         qrFwKPcrawjafP0vGwg9hfq3XiemcgTmLWQDBQfPC8a3jFViwzJb6a7+wVQW68M81oXu
         En0q2E1TCgHpMQR/gHiIQ5N6og3gnGZTEGNqHyS6DPSSPGDAydKedwcEHyx2hWGW2G+x
         5a77t2/HIDlOKevINFsdXalw4ip+PN/Mq82zEoqqVJ1hyxTBUQhp1vh1rV5OIqmar9Kq
         ZBSOELJtL7PNO3/dc/J64KDrmaTpfR1RoemqqbfSvGUgTSaFZXrW2So0jxk27BHtvz0N
         GF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=34YSYh+z8fKM6taIRyymQ72AtYlmDws/1nlNkhmJ8EU=;
        b=B871g5dhU/uofoQJ6LLmpRygG7pd7Znt8xQUpcGWq6uL94iA3vGm5onIivM7iUlJL9
         MFnTHzSRzSm2kAYR4eNVkCQRGZbKCtFAr7DzLQviA5RbnrrURuJZCserI3fYr6+GN7Lc
         ThwmKReYgG2YbY9P4mMOV19IfYKglLpDojRbe982w8uhHMTfdqGsgE9i1RWPElaBZnz3
         S5D/bsK3fMSX5u+Nb6VmSRDLvUuPGFaB3Ian63Whx5icXFlZXNqN4rcHmO0Iwp8g+Byi
         4RgmOw9HatmcWP+LQ1wlff3DlAdVRRDCBnKaAimip9/hloyYsBMc3LQ/xIsPyDCOnyZw
         FZnA==
X-Gm-Message-State: APjAAAUKCOg0F4OOaOr8CTlTY0tezx0fqRW67ydiCyiEGyoJXJGw6ICT
        hNQImaQQ2agBRJ9xQj4skmez5dLP
X-Google-Smtp-Source: APXvYqxkwDFwInLMhXBGKWKVSeU7hQMsTjaT92DxBLFTOaNhBftXmWodm7qB04zjXj0uTxbqLvJ9JQ==
X-Received: by 2002:a1c:2884:: with SMTP id o126mr1550354wmo.153.1571860586165;
        Wed, 23 Oct 2019 12:56:26 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s9sm292340wme.36.2019.10.23.12.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 12:56:25 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip/gic: Check interrupt type validity
Date:   Wed, 23 Oct 2019 12:56:19 -0700
Message-Id: <20191023195620.23415-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the interrupt property specifies a type parameter that is not
GIC_SPI (0) or GIC_PPIC (1), do not attempt to translate the interrupt
and return -EINVAL instead.

Fixes: f833f57ff254 ("irqchip: Convert all alloc/xlate users from of_node to fwnode")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Marc,

Regardless of whether my attempt to use SGI moves any further, this
seems appropriate to do since we should not be trying to translate
incorrectly specified interrupts. Thanks!

 drivers/irqchip/irq-gic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 30ab623343d3..fc47e655618d 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1005,6 +1005,9 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		if (fwspec->param_count < 3)
 			return -EINVAL;
 
+		if (fwspec->param[0] > 1)
+			return -EINVAL;
+
 		/* Get the interrupt number and add 16 to skip over SGIs */
 		*hwirq = fwspec->param[1] + 16;
 
-- 
2.17.1

