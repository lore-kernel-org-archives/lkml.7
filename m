Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126E8C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBECC2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="RI4rjwP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfGOMLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:11:03 -0400
Received: from sender-pp-o92.zoho.com ([135.84.80.237]:25405 "EHLO
        sender-pp-o92.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfGOMLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:11:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1563192628; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=ni8OCYMfZAomDqupCAj9hsr743z9OK67v016Lzjg8mW7nIDxdKGG8rpTEq55+bQ9apL68uOfbq8O9WpjpeiJY96FX4PKh+8HOi+V1CQ5Erym9O6KFkfr8t3ZvSERjcJXKiOcpAtJaGv9UAh6cF3IQbaiORPC0KGeD4RGqm5BtXo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1563192628; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=fnDCp6jZeeGfpDoN+SlMaHRmTzdDECyW5O1GnWepi/c=; 
        b=XC2Q+Q4yRBd5vrWCoijI7uWRJ8RiZAzfTg+MH/TFDnKBV5Un/woLie4OqtmBSi1SkXBpiOTXAA+YJSVM1MPByL1zpMhrYF3tQaFj7FZxRXgB2Lhyk9UbqR29xL2kR/qsXDMKmnsgi3UzLimLmCjpf4bAZhCZkyWHRRHKJKp+2VM=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=MeQ5ZZNKz8bfldSmEZSnioWUJx65MVdP5Zc3NVx24Pu5w7E1rIb5Z8TLzRV1+hMBaLLMKx6CqH96
    FpVuVnMuqP9D5URwcz7H93Ik5tdCHYz9hKSnYGTStO613XBHcJU3  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1563192628;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=895;
        bh=fnDCp6jZeeGfpDoN+SlMaHRmTzdDECyW5O1GnWepi/c=;
        b=RI4rjwP/ADitJ5S1b+2JgxjaxhZ+Sw3FpOkLsZHrsvefdzehbM6F3iWxi5wGEDHh
        rC5tXL5wJAmaKnfAtAsEpLfqGkisqIeH5zwYwtjDH58teVPMKAdU/O/0TKlL4UKE2vF
        rjgDdRG+hQvL1tzast5Gc5rLJvTd4lUFQs6HNBLw=
Received: from zhouyanjie-virtual-machine.localdomain (117.136.70.36 [117.136.70.36]) by mx.zohomail.com
        with SMTPS id 156319262626634.946585166771; Mon, 15 Jul 2019 05:10:26 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        paul.burton@mips.com, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, jason@lakedaemon.net, marc.zyngier@arm.com
Subject: [PATCH v3 3/8] dt-bindings: interrupt-controller: Add JZ4760 and JZ4760B bindings.
Date:   Mon, 15 Jul 2019 20:09:50 +0800
Message-Id: <1563192595-53546-4-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563192595-53546-1-git-send-email-zhouyanjie@zoho.com>
References: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
 <1563192595-53546-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the interrupt-controller bindings for the JZ4760 Soc and
the JZ4760B Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
index d4373d0..fa1ad54 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
@@ -5,6 +5,8 @@ Required properties:
 - compatible : should be "ingenic,<socname>-intc". Valid strings are:
     ingenic,jz4740-intc
     ingenic,jz4725b-intc
+    ingenic,jz4760-intc
+    ingenic,jz4760b-intc
     ingenic,jz4770-intc
     ingenic,jz4775-intc
     ingenic,jz4780-intc
-- 
2.7.4


