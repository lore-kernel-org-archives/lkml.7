Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91150C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6010B216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfEHQti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:49:38 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.209]:14153 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728093AbfEHQth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:49:37 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 4F407684AA2
        for <linux-kernel@vger.kernel.org>; Wed,  8 May 2019 11:49:36 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id OPlAhVyyC4FKpOPlAhv8OL; Wed, 08 May 2019 11:49:36 -0500
X-Authority-Reason: nr=8
Received: from [189.250.119.7] (port=40004 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hOPl9-00452E-AK; Wed, 08 May 2019 11:49:35 -0500
Date:   Wed, 8 May 2019 11:49:34 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] platform/x86: acer-wmi: Mark expected switch fall-throughs
Message-ID: <20190508164934.GA20064@embeddedor>
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
X-Source-IP: 189.250.119.7
X-Source-L: No
X-Exim-ID: 1hOPl9-00452E-AK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.7]:40004
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/platform/x86/acer-wmi.c: In function ‘set_u32’:
drivers/platform/x86/acer-wmi.c:1378:33: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (cap == ACER_CAP_WIRELESS ||
                                 ^
drivers/platform/x86/acer-wmi.c:1386:3: note: here
   case ACER_WMID:
   ^~~~
drivers/platform/x86/acer-wmi.c:1393:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
    else if (wmi_has_guid(WMID_GUID2))
            ^
drivers/platform/x86/acer-wmi.c:1395:3: note: here
   default:
   ^~~~~~~
drivers/platform/x86/acer-wmi.c: In function ‘get_u32’:
drivers/platform/x86/acer-wmi.c:1340:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (cap == ACER_CAP_MAILLED) {
      ^
drivers/platform/x86/acer-wmi.c:1344:2: note: here
  case ACER_WMID:
  ^~~~
drivers/platform/x86/acer-wmi.c: In function ‘WMID_get_u32’:
drivers/platform/x86/acer-wmi.c:1013:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (quirks->mailled == 1) {
      ^
drivers/platform/x86/acer-wmi.c:1018:2: note: here
  default:
  ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/platform/x86/acer-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index fcfeadd1301f..bd87f9037f95 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1015,6 +1015,7 @@ static acpi_status WMID_get_u32(u32 *value, u32 cap)
 			*value = tmp & 0x1;
 			return 0;
 		}
+		/* fall through */
 	default:
 		return AE_ERROR;
 	}
@@ -1341,6 +1342,7 @@ static acpi_status get_u32(u32 *value, u32 cap)
 			status = AMW0_get_u32(value, cap);
 			break;
 		}
+		/* fall through */
 	case ACER_WMID:
 		status = WMID_get_u32(value, cap);
 		break;
@@ -1383,6 +1385,7 @@ static acpi_status set_u32(u32 value, u32 cap)
 
 				return AMW0_set_u32(value, cap);
 			}
+			/* fall through */
 		case ACER_WMID:
 			return WMID_set_u32(value, cap);
 		case ACER_WMID_v2:
@@ -1392,6 +1395,7 @@ static acpi_status set_u32(u32 value, u32 cap)
 				return wmid_v2_set_u32(value, cap);
 			else if (wmi_has_guid(WMID_GUID2))
 				return WMID_set_u32(value, cap);
+			/* fall through */
 		default:
 			return AE_BAD_PARAMETER;
 		}
-- 
2.21.0

