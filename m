Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421C4C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B05E2068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YRy3Zf6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfK0ByO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:54:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfK0ByN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2hokKrX4e87LQqiRatVJDMxEpK+XnJXNvRF/iW+S+Ao=; b=YRy3Zf6LPXccXIWi7tsy+qtuY
        TI2FVU/o/f7al/uadzKhcTxR6GmGOxgMj1DLUqFieMVWf3KJ06P6qDwaW7JuxQkITH0Zh3DwbGz0E
        AvaMnl9eWrAa0HZjHNRyJc07t06XyO7wmwsO5kGHVkz5BoFc1D6CQ5LmKoo8eEsXS4/duyrDbQpif
        ogwyFytyZprOVlBVpz23bwiEbA3vI2jnB4QlSs4t04T52D31GoOulUEDs1mELt61sTnDGoq8o04wC
        BqHBOZvXv33y8vpL+8wtvL8Z32GJAs8OPBZG+inmxgVtqsJpPopt9A8gZ+MPe0vHcnEnz54/lzt97
        k7E6WfMlw==;
Received: from [2603:3004:32:9a00::f45c]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZmWw-0002I0-BT; Wed, 27 Nov 2019 01:54:10 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org
Cc:     Vineet Gupta <vgupta@synopsys.com>, Ofer Levi <oferle@mellanox.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arc: eznps: fix allmodconfig kconfig warning
Message-ID: <7f2e6690-f377-86e7-6f56-e85d8d4d22a0@infradead.org>
Date:   Tue, 26 Nov 2019 17:54:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kconfig warning for arch/arc/plat-eznps/Kconfig allmodconfig:

WARNING: unmet direct dependencies detected for CLKSRC_NPS
  Depends on [n]: GENERIC_CLOCKEVENTS [=y] && !PHYS_ADDR_T_64BIT [=y]
  Selected by [y]:
  - ARC_PLAT_EZNPS [=y]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Ofer Levi <oferle@mellanox.com>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/plat-eznps/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-54.orig/arch/arc/plat-eznps/Kconfig
+++ lnx-54/arch/arc/plat-eznps/Kconfig
@@ -7,7 +7,7 @@
 menuconfig ARC_PLAT_EZNPS
 	bool "\"EZchip\" ARC dev platform"
 	select CPU_BIG_ENDIAN
-	select CLKSRC_NPS
+	select CLKSRC_NPS if !PHYS_ADDR_T_64BIT
 	select EZNPS_GIC
 	select EZCHIP_NPS_MANAGEMENT_ENET if ETHERNET
 	help

