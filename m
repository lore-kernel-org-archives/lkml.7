Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F03CC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFA22054F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0GBwz/E5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfHMXD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 19:03:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43044 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfHMXD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 19:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yX10QZC5JyqYP3DGZkKpoS4jwO5AlhcSiOXMZNp6/Bc=; b=0GBwz/E5mcU1mtaPloBgoq6N0v
        SVplbZMnG1hEHt72Cm7M9FrbNkOauzIRRiVUEgJPUReBZZD7aEH8rUbN3ZkxfMI0OnArjWG89qOU4
        0dvgGh46UWO4sBHJIgYe4Ibbc3mWzpFuBreMr44QZPCPPC0d5/3Q+gKKXxkO9vIjSE8abgv7wOKHn
        B2wtA16JktTw0HadJuWb4AdBgW84m0dPHch7qTRDDbQGT5CCnhrgcmv1b6w69+rcF5iVq9xWU4Qxs
        ED3VcNnUlQDBQ8Rn+5SnJwQrzDP1p75UZfbzTbNeSXnoKaPF6H2XFuasW8CA+pbiBgQPTrczPYYwA
        Hu2pkhQw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxfox-0007Az-AP; Tue, 13 Aug 2019 23:03:15 +0000
To:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] mtd: hyperbus: fix dependency and build error
Message-ID: <9b1b4ab1-681f-0ef9-7b5c-b6545f7464d2@infradead.org>
Date:   Tue, 13 Aug 2019 16:03:13 -0700
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
when CONFIG_HAS_IOMEM is set/enabled, so MTD_HYPERBUS should depend
on HAS_IOMEM.  Fixes a build error and a Kconfig warning (as seen on
UML builds):

WARNING: unmet direct dependencies detected for MTD_COMPLEX_MAPPINGS
  Depends on [n]: MTD [=m] && HAS_IOMEM [=n]
  Selected by [m]:
  - MTD_HYPERBUS [=m] && MTD [=m]

ERROR: "devm_ioremap_resource" [drivers/mtd/hyperbus/hyperbus-core.ko] undefined!

Fixes: dcc7d3446a0f ("mtd: Add support for HyperBus memory devices")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-mtd@lists.infradead.org
---
 drivers/mtd/hyperbus/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- lnx-53-rc4.orig/drivers/mtd/hyperbus/Kconfig
+++ lnx-53-rc4/drivers/mtd/hyperbus/Kconfig
@@ -1,5 +1,6 @@
 menuconfig MTD_HYPERBUS
 	tristate "HyperBus support"
+	depends on HAS_IOMEM
 	select MTD_CFI
 	select MTD_MAP_BANK_WIDTH_2
 	select MTD_CFI_AMDSTD


