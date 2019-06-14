Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA3DC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4018F2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SdJx5Sno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfFNRRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:17:22 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:38378 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfFNRRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:17:18 -0400
Received: by mail-yb1-f201.google.com with SMTP id a13so3416883ybm.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 10:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PfqzR6OCJuShUbiIZxhM7dStAsUG2Yzxrzdg+ytHsmg=;
        b=SdJx5Sno739AYIvhyoAQWdwlLaTV0qZ/Z8oxt8cXTHYNWosTV5yjnKAP5MXP4Q7zp6
         DM7EC/z7zMR71UIi6pm2oe5mPZVGCApReiP2mmd22fHXYk8gpVinxY7T0/OewUrpRIP7
         5kTOlYELQyNI9ZrZDdZDStoQt5s+y87UCMlVAIpbv2o4DqZSg9JTMggBGK6+G3eoTxfr
         274X9YibUaw1b2NYWuRwMcE5v1cWAa3LQKWZ7GmBfipWWHTM54oKOKSaSxbBuYJn3nlx
         tcfUlgc+OohLEv6JHJMljgg9ICqHAlKxo9HRrmsEcCVDEZcmwqx6FJXMxkEfI4DYs9BX
         pIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PfqzR6OCJuShUbiIZxhM7dStAsUG2Yzxrzdg+ytHsmg=;
        b=AXZwRUtVlzWMr3Hbuvoztv8zrA+1go8Bcq327/uNibGlntLKKSP6VHhXzUeJx6oSFx
         vLzqTZuC5wXf3kNUQc/cECY9qkBeUfFTHAUdIyFiby5DZwr4wzYKc2k0CmSnAMV4XgKd
         oJHNPbzrDZBXbC2dD4M7sGPCJi1+ho6k3Hzk7Ff6bUMX1BUFy6UodepziiURetQviN8a
         UYOdpYovLbaZtZwG6lajoqy929F8rykLpESJZxrlDjZ7oVY9v1ATC/yg8PScKDWP0IQ8
         BVM3I1Eoj20gp47lS6ZBsU4iuhACHPnH1+LWKfyuNZHNOCVnIVS7TKTzei0kDGoT5GB3
         APZw==
X-Gm-Message-State: APjAAAX7oSVW0Cr6M1KPnvRHWsaHL29/DWZrwNmfYO4j0y8IBav080Gz
        2FC73jf5HRxAOd9yjq27iqMfGbo/wA==
X-Google-Smtp-Source: APXvYqwLFAxUgSeBg3lvZMfRSmKuSjWUy8qirfzUU6CTl88j+9AZEYIsfuCvJz9VcPkMGE1FsynuM3i3DQ==
X-Received: by 2002:a0d:da84:: with SMTP id c126mr11206949ywe.133.1560532637768;
 Fri, 14 Jun 2019 10:17:17 -0700 (PDT)
Date:   Fri, 14 Jun 2019 10:17:13 -0700
Message-Id: <20190614171713.89262-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH] wl18xx: Fix Wunused-const-variable
From:   Nathan Huckleberry <nhuck@google.com>
To:     kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang produces the following warning

drivers/net/wireless/ti/wl18xx/main.c:1850:43: warning: unused variable
'wl18xx_iface_ap_cl_limits' [-Wunused-const-variable] static const struct
ieee80211_iface_limit wl18xx_iface_ap_cl_limits[] = { ^
drivers/net/wireless/ti/wl18xx/main.c:1869:43: warning: unused variable
'wl18xx_iface_ap_go_limits' [-Wunused-const-variable] static const struct
ieee80211_iface_limit wl18xx_iface_ap_go_limits[] = { ^

The commit that added these variables never used them. Removing them.

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/530
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/net/wireless/ti/wl18xx/main.c | 38 ---------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/net/wireless/ti/wl18xx/main.c b/drivers/net/wireless/ti/wl18xx/main.c
index a5e0604d3009..0b3cf8477c6c 100644
--- a/drivers/net/wireless/ti/wl18xx/main.c
+++ b/drivers/net/wireless/ti/wl18xx/main.c
@@ -1847,44 +1847,6 @@ static const struct ieee80211_iface_limit wl18xx_iface_ap_limits[] = {
 	},
 };
 
-static const struct ieee80211_iface_limit wl18xx_iface_ap_cl_limits[] = {
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_STATION),
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_AP),
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_P2P_CLIENT),
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_P2P_DEVICE),
-	},
-};
-
-static const struct ieee80211_iface_limit wl18xx_iface_ap_go_limits[] = {
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_STATION),
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_AP),
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_P2P_GO),
-	},
-	{
-		.max = 1,
-		.types = BIT(NL80211_IFTYPE_P2P_DEVICE),
-	},
-};
-
 static const struct ieee80211_iface_combination
 wl18xx_iface_combinations[] = {
 	{
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

