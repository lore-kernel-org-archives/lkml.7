Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F01CC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D96E2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OiKmeGRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfHMXBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 19:01:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43020 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfHMXBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 19:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zMUtN7CmDAXW9uMH/sGSjpna+fgp+L5H+R+8MTcl8Oc=; b=OiKmeGRZOv4+HLAkUHlw0pYLaW
        xtOd9wjiE5P7H6VgnSbkjzyFskOccWO0UvzvsNOv1tUF0Vjc6FW210R/glXW6LzGvM0HR9+GOTSj2
        3UJdNAEDBSr1LHpaKrrSwuh52J2S6p4a1kGK2AJ378dQ+avvr2MJ5Gxg9MVhxTXzWhYOZS8JYOOj2
        iDK5lG4QsPqpl4sDvqDFExGu5cXE2EHDIgGEkVRY9HetiEYU4D+ArvhrlLvdSV9Y5IT0LZ1X3QJSj
        PxjIjha/28NLjV1+YA4tdWlwZOTIDkoqEECycidcCXBPvDVKeXPRZC+BeyTgzkJT1TWEicO72v9gx
        N3g3iaqw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxfnD-0007AH-Pt; Tue, 13 Aug 2019 23:01:32 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] misc: xilinx-sdfec: fix dependency and build error
Message-ID: <f9004be5-9925-327b-3ec2-6506e46fe565@infradead.org>
Date:   Tue, 13 Aug 2019 16:01:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

lib/devres.c, which implements devm_ioremap_resource(), is only built
when CONFIG_HAS_IOMEM is set/enabled, so XILINX_SDFEC should depend
on HAS_IOMEM.  Fixes this build error (as seen on UML builds):

ERROR: "devm_ioremap_resource" [drivers/misc/xilinx_sdfec.ko] undefined!

Fixes: 76d83e1c3233 ("misc: xilinx-sdfec: add core driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Derek Kiernan <derek.kiernan@xilinx.com>
Cc: Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- lnx-53-rc4.orig/drivers/misc/Kconfig
+++ lnx-53-rc4/drivers/misc/Kconfig
@@ -465,6 +465,7 @@ config PCI_ENDPOINT_TEST
 
 config XILINX_SDFEC
 	tristate "Xilinx SDFEC 16"
+	depends on HAS_IOMEM
 	help
 	  This option enables support for the Xilinx SDFEC (Soft Decision
 	  Forward Error Correction) driver. This enables a char driver


