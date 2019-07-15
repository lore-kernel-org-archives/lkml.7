Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63CBC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3162080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="eTxaMf4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfGOMLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:11:16 -0400
Received: from sender-pp-o92.zoho.com ([135.84.80.237]:25414 "EHLO
        sender-pp-o92.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfGOMLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:11:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1563192632; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=IYsAeFxlPFdlkJPV0ZPskWVISY5DtKhZ+HMSsv61yWcffWY414DEap76lyXMfP7VlEMwcj7NQa1K96gsLjRFLIH6ZgUarI26fu+w47v5VegE8uOPkVd/C/5xN4SYjpdDaHo5EIW+KCSxaEN+1um7mIFadBDEIbkAoqLMiY/8ZJ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1563192632; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=Hzh8npLbyj9UYav315RsD1TNIpTmD6WYf4bAiGCaWP4=; 
        b=N1oDycOELWsdSuOXoVXLFA/kV/4JdN6kJp91xLhyPFdc/tIKmYNT/yhEICZMKsrw70F1m5qe4voLxCryl2cihUq/GteKmTIc+VHJhU8uWcS7U20+DygpBnn0aU6jVeKvmnPWlFT9qOu3a7fG9uXuI3/lZTLUT3ueS5ap2P3Yajg=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=CR+ZID8h7fsm7FoTeWEitsAmlQ/8TXN6czVmAUl4pgaEwe9xVRaGNGK1yUqz5z20eracse+Z8k/n
    3Nfb/sEIXLiXFCA6gHtLL/ADSQJNOQ1ArLMogTxSkOfsV509fT0H  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1563192632;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=934;
        bh=Hzh8npLbyj9UYav315RsD1TNIpTmD6WYf4bAiGCaWP4=;
        b=eTxaMf4PDOZNKn0GZVl97FptI8JhRx7yr40jql7Cr8ws/+Ds6/dNWwvGqs/oCbJw
        5dqoHxYxoT/l2IQ2M77AsOJXQw7CXzXm1FRlrgcJakM85U1Px7S7QSBCdIkvOKr4kLj
        8iFvQqvx79/rI2Pxu0Bxb3SGoa4HiVMc8LqOBvds=
Received: from zhouyanjie-virtual-machine.localdomain (117.136.70.36 [117.136.70.36]) by mx.zohomail.com
        with SMTPS id 1563192630716855.4582344858023; Mon, 15 Jul 2019 05:10:30 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        paul.burton@mips.com, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, jason@lakedaemon.net, marc.zyngier@arm.com
Subject: [PATCH v3 4/8] irqchip: Ingenic: Add support for JZ4760 and JZ4760B.
Date:   Mon, 15 Jul 2019 20:09:51 +0800
Message-Id: <1563192595-53546-5-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563192595-53546-1-git-send-email-zhouyanjie@zoho.com>
References: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
 <1563192595-53546-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing the irq-ingenic driver on the JZ4760 Soc
and the JZ4760B Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/irqchip/irq-ingenic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 8430f5a..e9e959c 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -173,6 +173,8 @@ static int __init intc_2chip_of_init(struct device_node *node,
 {
 	return ingenic_intc_of_init(node, 2);
 }
+IRQCHIP_DECLARE(jz4760_intc, "ingenic,jz4760-intc", intc_2chip_of_init);
+IRQCHIP_DECLARE(jz4760b_intc, "ingenic,jz4760b-intc", intc_2chip_of_init);
 IRQCHIP_DECLARE(jz4770_intc, "ingenic,jz4770-intc", intc_2chip_of_init);
 IRQCHIP_DECLARE(jz4775_intc, "ingenic,jz4775-intc", intc_2chip_of_init);
 IRQCHIP_DECLARE(jz4780_intc, "ingenic,jz4780-intc", intc_2chip_of_init);
-- 
2.7.4


