Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F7EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0B320835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbfDXSPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:15:49 -0400
Received: from gateway20.websitewelcome.com ([192.185.61.9]:31536 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733170AbfDXSPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:15:49 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 81CD0400CD6B0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:15:48 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id JMQuh06hC90onJMQuh9nW5; Wed, 24 Apr 2019 13:15:48 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.223] (port=44328 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hJMQt-004AKZ-Ew; Wed, 24 Apr 2019 13:15:47 -0500
Date:   Wed, 24 Apr 2019 13:15:44 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] platform/x86: thinkpad_acpi: Mark expected switch
 fall-throughs
Message-ID: <20190424181543.GA31200@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.223
X-Source-L: No
X-Exim-ID: 1hJMQt-004AKZ-Ew
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.223]:44328
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/platform/x86/thinkpad_acpi.c: In function ‘thermal_get_sensor’:
drivers/platform/x86/thinkpad_acpi.c:6316:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (idx >= 8 && idx <= 15) {
      ^
drivers/platform/x86/thinkpad_acpi.c:6322:2: note: here
  case TPACPI_THERMAL_TPEC_8:
  ^~~~
drivers/platform/x86/thinkpad_acpi.c: In function ‘hotkey_notify’:
drivers/platform/x86/thinkpad_acpi.c:4208:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (tp_features.hotkey_wlsw &&
       ^
drivers/platform/x86/thinkpad_acpi.c:4216:3: note: here
   default:
   ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comments are modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 57d9ae9d8e56..826e9a276818 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -4212,7 +4212,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 				known_ev = true;
 				break;
 			}
-			/* fallthrough to default */
+			/* fallthrough - to default */
 		default:
 			known_ev = false;
 		}
@@ -6317,8 +6317,8 @@ static int thermal_get_sensor(int idx, s32 *value)
 			t = TP_EC_THERMAL_TMP8;
 			idx -= 8;
 		}
-		/* fallthrough */
 #endif
+		/* fallthrough */
 	case TPACPI_THERMAL_TPEC_8:
 		if (idx <= 7) {
 			if (!acpi_ec_read(t + idx, &tmp))
-- 
2.21.0

