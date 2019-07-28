Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72541C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F5520854
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="W0wdNcHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfG1X7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 19:59:01 -0400
Received: from gateway30.websitewelcome.com ([192.185.148.2]:20671 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfG1X7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:59:00 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id E00B1103F
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 18:58:59 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id rt47h1mkKdnCert47hVIEh; Sun, 28 Jul 2019 18:58:59 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PnpOUz+ntdJPawVX2iaj0kEkJmhXCKqTbDBvO3kRWpo=; b=W0wdNcHdB5vA5TrmPC8kCcEa0o
        aLR8p+2Ta3Obw3CylGM5ig/eg9GzYkJGpClHeV8yMsE7WXKTqra27NGIywJTFNmVWCYGt4/n+fbYx
        NxaulxKYvUUZXeegrQuwKjlJCA3EoMTHUPILaHdyXAYPGTcZsBjQpPFgndfcxWFJH0DVcAMpfSZbP
        WfiS/AZqAw+f9G82dQX77HfCI+c+IPTSInqgj0jq4fCCxj+VvP8OKV9mMEjGP1mD2G/zIfG9m7hM1
        LRzQ+0WmV4xSCUZ4sJ1aDK/+ffzn5L3dHeO2L0TzSAGlsMWnyc+xz+8MEHAMpcl0JtMWmFB9tGtTQ
        l3/QQKsQ==;
Received: from [187.192.11.120] (port=39628 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hrt46-003mmd-Pj; Sun, 28 Jul 2019 18:58:58 -0500
Date:   Sun, 28 Jul 2019 18:58:58 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] mfd: omap-usb-host: Mark expected switch fall-throughs
Message-ID: <20190728235858.GA23755@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hrt46-003mmd-Pj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:39628
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 58
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/mfd/omap-usb-host.c: In function 'usbhs_runtime_resume':
drivers/mfd/omap-usb-host.c:303:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (!IS_ERR(omap->hsic480m_clk[i])) {
       ^
drivers/mfd/omap-usb-host.c:313:3: note: here
   case OMAP_EHCI_PORT_MODE_TLL:
   ^~~~
drivers/mfd/omap-usb-host.c: In function 'usbhs_runtime_suspend':
drivers/mfd/omap-usb-host.c:345:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (!IS_ERR(omap->hsic480m_clk[i]))
       ^
drivers/mfd/omap-usb-host.c:349:3: note: here
   case OMAP_EHCI_PORT_MODE_TLL:
   ^~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mfd/omap-usb-host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 792b855a9104..4798d9f3f9d5 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -308,7 +308,7 @@ static int usbhs_runtime_resume(struct device *dev)
 					 i, r);
 				}
 			}
-		/* Fall through as HSIC mode needs utmi_clk */
+		/* Fall through - as HSIC mode needs utmi_clk */
 
 		case OMAP_EHCI_PORT_MODE_TLL:
 			if (!IS_ERR(omap->utmi_clk[i])) {
@@ -344,7 +344,7 @@ static int usbhs_runtime_suspend(struct device *dev)
 
 			if (!IS_ERR(omap->hsic480m_clk[i]))
 				clk_disable_unprepare(omap->hsic480m_clk[i]);
-		/* Fall through as utmi_clks were used in HSIC mode */
+		/* Fall through - as utmi_clks were used in HSIC mode */
 
 		case OMAP_EHCI_PORT_MODE_TLL:
 			if (!IS_ERR(omap->utmi_clk[i]))
-- 
2.22.0

