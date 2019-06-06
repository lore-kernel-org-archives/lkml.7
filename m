Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B7BC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CE32083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfFFOze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:55:34 -0400
Received: from gateway30.websitewelcome.com ([192.185.168.15]:21560 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728792AbfFFOze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:55:34 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jun 2019 10:55:33 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id DE57346E1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2019 09:07:04 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Yt2mhXeppdnCeYt2mhAy9m; Thu, 06 Jun 2019 09:07:04 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.120] (port=40832 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hYt2i-004Dw7-8a; Thu, 06 Jun 2019 09:07:01 -0500
Date:   Thu, 6 Jun 2019 09:06:59 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "amy.shih" <amy.shih@advantech.com.tw>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] hwmon: (nct7904) Avoid fall-through warnings
Message-ID: <20190606140659.GA2970@embeddedor>
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
X-Source-IP: 189.250.127.120
X-Source-L: No
X-Exim-ID: 1hYt2i-004Dw7-8a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.120]:40832
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, this patch silences
the following warnings:

drivers/hwmon/nct7904.c: In function 'nct7904_in_is_visible':
drivers/hwmon/nct7904.c:313:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (channel > 0 && (data->vsen_mask & BIT(index)))
      ^
drivers/hwmon/nct7904.c:315:2: note: here
  case hwmon_in_min:
  ^~~~
drivers/hwmon/nct7904.c: In function 'nct7904_fan_is_visible':
drivers/hwmon/nct7904.c:230:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (data->fanin_mask & (1 << channel))
      ^
drivers/hwmon/nct7904.c:232:2: note: here
  case hwmon_fan_min:
  ^~~~
drivers/hwmon/nct7904.c: In function 'nct7904_temp_is_visible':
drivers/hwmon/nct7904.c:443:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (channel < 5) {
      ^
drivers/hwmon/nct7904.c:450:2: note: here
  case hwmon_temp_max:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/hwmon/nct7904.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index dd450dd29ac7..bf35dfd2d3a7 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -229,6 +229,7 @@ static umode_t nct7904_fan_is_visible(const void *_data, u32 attr, int channel)
 	case hwmon_fan_alarm:
 		if (data->fanin_mask & (1 << channel))
 			return 0444;
+		break;
 	case hwmon_fan_min:
 		if (data->fanin_mask & (1 << channel))
 			return 0644;
@@ -312,6 +313,7 @@ static umode_t nct7904_in_is_visible(const void *_data, u32 attr, int channel)
 	case hwmon_in_alarm:
 		if (channel > 0 && (data->vsen_mask & BIT(index)))
 			return 0444;
+		break;
 	case hwmon_in_min:
 	case hwmon_in_max:
 		if (channel > 0 && (data->vsen_mask & BIT(index)))
@@ -447,6 +449,7 @@ static umode_t nct7904_temp_is_visible(const void *_data, u32 attr, int channel)
 			if (data->has_dts & BIT(channel - 5))
 				return 0444;
 		}
+		break;
 	case hwmon_temp_max:
 	case hwmon_temp_max_hyst:
 	case hwmon_temp_emergency:
-- 
2.21.0

