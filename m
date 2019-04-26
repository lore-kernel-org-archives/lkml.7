Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23240C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2B920652
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSz4BSmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfDZInX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:43:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41175 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfDZInX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:43:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so1280351pgs.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 01:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VcyoXgoqnT7ufO8oMNRmqsNu1lcBQ1VsTjYzbr+R8Lw=;
        b=oSz4BSmZ2EZmqB2uJp8zGOIBlGjGEI2RzHhdO3rjCAKJsplYBZBDVloPJ6cBGFR9na
         4QjNZjS4nqDaCj2mhW9eqbErIZo936JjrEhyHaZdtLoyWztmtYJP/9hQC/gbXlKkcwfp
         lhCz+wZ+o3Gu1nUjsSOZmBVU0P2CZRjHyI6G2ldBmM/rhSPm1+YHtLlpHXJPSv8n4VdO
         tfT6Il9ZO9zU7ROpcdsVzmBL7TvEsaXKs2yEnlUrh8oEKfh3KTEj3Laeb45Q5MBGvPJl
         WZyUkf8mnqAHVn991Z72RroIwOEgEhgvplXsK4ANwCskjr91xUQcXy+eURrbmNu11ykX
         uYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VcyoXgoqnT7ufO8oMNRmqsNu1lcBQ1VsTjYzbr+R8Lw=;
        b=LxXAOy8aC3kJ0n67SPAgBm3i0I81CiC1p7vtLUJdAIdlcbnhSW/8/yo7J+Ju0bX1I5
         yJb0ZpVZPmtR6k71Hijva2z+1fEP9w+NzhJp+VDgt6QppgioiUS6eiABI8TP7K4ZWCGv
         eKfoSMB58z4DK05aYOsZQ5yEXyA+FPhVsSHI2R/zP9nNcXDm47bdnKljJolnisMMwQyp
         0oSaliEI57dI+we1gpZncjhA4XC68IcFHmAmpcM3oTqkVN4Q+pf8hoBRdNZz3+SJSgSH
         NSiVWtitFDEU/E6yRNElv/CanXrp2jDB9wp8IRysc/KOiW0nUIIC0X3t7ZDMaUehjyJ5
         JhXw==
X-Gm-Message-State: APjAAAUYp2DK2R5K+/DK0yWPxGzgY3lOVNHPvcd9uw6LM2xVjRa5IhOZ
        XnU7z7+0bkGA2Wzn4nzs9NU=
X-Google-Smtp-Source: APXvYqwtjWMzfgRMtYH98Y0LlVGr0pwoaP4mP894SLdVr7UzwxU40GTySva1f72tU2HlUQg5fOTCZQ==
X-Received: by 2002:aa7:8b8b:: with SMTP id r11mr15224545pfd.130.1556268202334;
        Fri, 26 Apr 2019 01:43:22 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.142])
        by smtp.gmail.com with ESMTPSA id j32sm14154563pgi.73.2019.04.26.01.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 01:43:21 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Julia.Lawall@lip6.fr, Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH v2 2/2] staging: rtl8192u: ieee80211: Fix spelling mistake
Date:   Fri, 26 Apr 2019 14:13:03 +0530
Message-Id: <20190426084303.30646-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace explicitely with explicitly to get rid of checkpatch warning.

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
Changes in v2:
-added this patch to patchset to fix spelling mistake.

 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
index 2044ae27b973..9631331b79d5 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -396,7 +396,8 @@ int ieee80211_wx_set_encode(struct ieee80211_device *ieee,
 				       (*crypt)->priv);
 		sec.flags |= BIT(key);
 		/* This ensures a key will be activated if no key is
-		 * explicitely set */
+		 * explicitly set
+		 */
 		if (key == sec.active_key)
 			sec.flags |= SEC_ACTIVE_KEY;
 		ieee->tx_keyidx = key;
-- 
2.17.1

