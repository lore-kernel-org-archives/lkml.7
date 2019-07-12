Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA53BC742C2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9F92080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 13:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfGLN5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 09:57:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:60098 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726254AbfGLN5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:57:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 262B9AFBD;
        Fri, 12 Jul 2019 13:57:45 +0000 (UTC)
Date:   Fri, 12 Jul 2019 15:57:44 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Krzysztof Halasa <khalasa@piap.pl>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3] soc: ixp4xx: Hide auto-selected drivers
Message-ID: <20190712155744.0771967c@endymion>
In-Reply-To: <20190712153722.3d1498be@endymion>
References: <20190712153722.3d1498be@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 2 IXP4xx SOC drivers qmgr and npe are selected automatically when
needed so they do not need to be presented to the user.

Furthermore these helper drivers are specific to the IXP4xx arch so
hide them completely on other architectures so as to not clutter the
config file.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
Note: Ultimately all I want is that non-ixp4xx users are not asked
about IXP4XX_QMGR and IXP4XX_NPE. If there is another preferred option
to achieve the same, that would work with me too, just let me know.

 drivers/soc/ixp4xx/Kconfig |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-5.2.orig/drivers/soc/ixp4xx/Kconfig	2019-07-08 00:41:56.000000000 +0200
+++ linux-5.2/drivers/soc/ixp4xx/Kconfig	2019-07-12 15:21:44.769229835 +0200
@@ -1,17 +1,19 @@
 # SPDX-License-Identifier: GPL-2.0-only
+if ARCH_IXP4XX
 menu "IXP4xx SoC drivers"
 
 config IXP4XX_QMGR
-	tristate "IXP4xx Queue Manager support"
+	tristate
 	help
 	  This driver supports IXP4xx built-in hardware queue manager
 	  and is automatically selected by Ethernet and HSS drivers.
 
 config IXP4XX_NPE
-	tristate "IXP4xx Network Processor Engine support"
+	tristate
 	select FW_LOADER
 	help
 	  This driver supports IXP4xx built-in network coprocessors
 	  and is automatically selected by Ethernet and HSS drivers.
 
 endmenu
+endif

-- 
Jean Delvare
SUSE L3 Support
