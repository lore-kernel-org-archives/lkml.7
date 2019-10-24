Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29866CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03D5205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R+5n4yKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439730AbfJXQMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:12:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39842 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389313AbfJXQMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:12:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so15442070pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Kvxk5KC3Dqb5lgTjDo57yr/xEDMjrRE7fLEnQ6dQl70=;
        b=R+5n4yKD3e2J1JdxbZIFeCJu8Bhn6q+m2pYrFkHj1HmxX9k5ZHHjupwuHdUMQ1tnHe
         0HTHUX1LvXUci5ClcRuPF3YsXWvr+zTUrHCYElaUBEcSPRdzlspjYuyPum5WkMq+SQEI
         13pYAPoFz7dZJ6YdrFj5hdAX0fuveeYVxVwf7eFWyjuEvdXSBUZEYsalLJo26jfGDr+r
         QCww8r4AhRTIyM5ZUyS7k584o3UnS9nkkgOjrPVTsu8TnDc713JXuP98tCV75flQhTX9
         gwVJU9pWsIXGU0vmgKmwM+0iDk27g9YYDqvkX5MV9+hFnAjKTkDaeuPTxThjk9+/2u8m
         vVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kvxk5KC3Dqb5lgTjDo57yr/xEDMjrRE7fLEnQ6dQl70=;
        b=cqx+urKEvqi9QhIhLs/eZ+F/+qjIblyQEOAO2wvLiRaELODk6/Wdbt2v2ivDGt1DxK
         gZ72v9wQ5xcieN6vMvfoV2W/VyAleNAkLehqbEoAN2+UpiQ81eDVY0AVkjDJyvGdcPD7
         0abMeRZVQbc5/08WJBX30Ftwv3LAu2KWyt/9ZC/Hi2c2VIqjFUhGj4c3qFRFfvJ+YPHG
         K5UOzgod1J3KKXQQ5ijkufu5AFPY1fAaW+2xySVF0Yk6PKKmr/Rf/TDK0BdD6j45lq0h
         euOVAGfl2G80cbqYDSoTuK4t6ORIqeuEv1Uyjx3NZtdOaVngfceokJVmiqcyVe9Ptm0s
         Z+Ww==
X-Gm-Message-State: APjAAAUEnKxQ6YjbN//OswuElL8dhS7QWpO9Cn2ecAq2hwmgDqeQXR/m
        sjzqFJ6J1RxbuCh9AVM1XNJjTaW64ek=
X-Google-Smtp-Source: APXvYqyabEVgqyZVi9GTMZTnXIr9e0eUAxWS3LAwL+rvLuLkD5+o4Mr6MQSz/KGne8tWHS4GNZnf3A==
X-Received: by 2002:a17:90a:25aa:: with SMTP id k39mr8077780pje.123.1571933521310;
        Thu, 24 Oct 2019 09:12:01 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id i187sm32061251pfc.177.2019.10.24.09.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Oct 2019 09:12:00 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH v2] irqchip: Skip contexts except supervisor in plic_init()
Date:   Thu, 24 Oct 2019 09:11:43 -0700
Message-Id: <1571933503-21504-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Modify plic_init() to skip .dts interrupt contexts other
than supervisor external interrupt.

The .dts entry for plic may specify multiple interrupt contexts.
For example, it may assign two entries IRQ_M_EXT and IRQ_S_EXT,
in that order, to the same interrupt controller. This patch
modifies plic_init() to skip the IRQ_M_EXT context since
IRQ_S_EXT is currently the only supported context.

If IRQ_M_EXT is not skipped, plic_init() will report "handler
already present for context" when it comes across the IRQ_S_EXT
context in the next iteration of its loop.

Without this patch, .dts would have to be edited to replace the
value of IRQ_M_EXT with -1 for it to be skipped.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # arch/riscv
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/irqchip/irq-sifive-plic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index c72c036aea76..5f2a773d5669 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -251,8 +251,8 @@ static int __init plic_init(struct device_node *node,
 			continue;
 		}
 
-		/* skip context holes */
-		if (parent.args[0] == -1)
+		/* skip contexts other than supervisor external interrupt */
+		if (parent.args[0] != IRQ_S_EXT)
 			continue;
 
 		hartid = plic_find_hart_id(parent.np);
-- 
2.7.4

