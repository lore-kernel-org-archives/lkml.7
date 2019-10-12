Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0ABC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EBF21850
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="U6szIocd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfJLFPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 01:15:50 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25412 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfJLFPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 01:15:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570857274; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=QeLsWy3lt0LjPqHfImMYFVVxd53Vsh1xflVauNzHcBq6NbV38SjwEd7fm6Fm5+SPGa6VjUIkhGPEKIYqT7FhCaKI/gV7m8fkTp74GUM4dTPwPBxzXN0oWdbTZqZXLVWUesg6F9reaJbbGOBJYAO4MfZkAcPV9x4+NhjiTgp6rtU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1570857274; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=as6/lLUVaBlu4heB6IDs3nZKYIfHPEdzxPDiM55f+iE=; 
        b=SeQ43zEeGWA0NMwUVPTUfBk79QQK4bhLVm/h1OGkFIevt9czYykYCj1zOkJ4J0Q/ntWtlHibpUmtRmMWglmYhhDjOTyYR6T+WrFAzAndtCrDmwWzyDSkOt1oU+Uk2CDbtyloQR0SKoSldEBHQYJbbue+milscV8zyL5kKC+UDzI=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=fRAKLVv8EtX/+wEP7ZpuVAcsL7911f5ip5Mj3dXlc4qbiQMeNNakOq4MYHj69p2l3vlqohH72Rru
    cqRzivWyx1vdg/rVxaHk9rDMhbMtJGmFOrdnfYf8+aZIh/AcTgcu  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1570857274;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=914;
        bh=as6/lLUVaBlu4heB6IDs3nZKYIfHPEdzxPDiM55f+iE=;
        b=U6szIocdkwc14BjeZeaND6xlAOyMeZzIo5eumUMiYramn/wSFRwB0JDeNlLF6yo1
        WOBG0CzINWbcOZm8WBP0r46ooEJoxBq4EcX+O5mK9wDxjZH1thGzb9zxmKu5BIPksN9
        ntgxPjOoXRT/08bUOuFOog8i13jpAHdFEpG6wQnA=
Received: from zhouyanjie-virtual-machine.localdomain (182.148.156.27 [182.148.156.27]) by mx.zohomail.com
        with SMTPS id 1570857273287174.23289133560195; Fri, 11 Oct 2019 22:14:33 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, mark.rutland@arm.com, syq@debian.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        armijn@tjaldur.nl, tglx@linutronix.de, yuehaibing@huawei.com,
        malat@debian.org, ezequiel@collabora.com, paul@crapouillou.net
Subject: [PATCH 2/6 v2] dt-bindings: MMC: Add JZ4760 bindings.
Date:   Sat, 12 Oct 2019 13:13:16 +0800
Message-Id: <1570857203-49192-3-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570857203-49192-1-git-send-email-zhouyanjie@zoho.com>
References: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
 <1570857203-49192-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the MMC bindings for the JZ4760 Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/jz4740.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/jz4740.txt b/Documentation/devicetree/bindings/mmc/jz4740.txt
index 8a6f87f..13796fe 100644
--- a/Documentation/devicetree/bindings/mmc/jz4740.txt
+++ b/Documentation/devicetree/bindings/mmc/jz4740.txt
@@ -8,6 +8,7 @@ Required properties:
 - compatible: Should be one of the following:
   - "ingenic,jz4740-mmc" for the JZ4740
   - "ingenic,jz4725b-mmc" for the JZ4725B
+  - "ingenic,jz4760-mmc" for the JZ4760
   - "ingenic,jz4780-mmc" for the JZ4780
 - reg: Should contain the MMC controller registers location and length.
 - interrupts: Should contain the interrupt specifier of the MMC controller.
-- 
2.7.4


