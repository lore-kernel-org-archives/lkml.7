Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1C0C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216FD206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 00:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dep0PvRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLJAjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:39:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35669 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLJAjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 19:39:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so6530559plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 16:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQ8jRWchMU/pCJrgAWxeTEB4f5607iPubBgJHWYT3M0=;
        b=dep0PvRaGygfo0EgfIfOWbAnYsDki/VXzduGalZrmePdP/m7sNZWdv1qw71qSj1F6u
         PTQmfeO+0bSywZM+DdI3KP/08oSgSCLBmMK6zsbWiiyPp8F+W3SqbxTwuHr2FG2OOOu3
         Po9FOeAMHcQN5VeO5iKHkWTK0LM/S7KnJKHTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQ8jRWchMU/pCJrgAWxeTEB4f5607iPubBgJHWYT3M0=;
        b=CqaQX4EIpuJGyMQa6dz9adbeWqje6273Gqi7THutyJgEmNUY3uhHLZIO8aN83CEbMv
         Unh4CRkqJuFhYoLKcv986OFT4yZZOQDpVuxiF9LeWLqTU9RHRQKlwOyNI8GJ335JiGcR
         EYT2crPFukwNYVt1jAGnNiyBGNuyZglMHnd76sfN3ZsIWSdT4wIkUiCWsO24l+hUefxP
         EMgT3chXLBX6LABNVGjzrrLpnHNAuQ9D98HW3tDxb6Il9RvFFHLNt4s2aajq15jx3eEg
         n6PqTLO0N4x+10gx7uzCH0PC6Sg0/Y0C57/OL4biOQCQt4pueGsOcHIUZ+g9PiMgvGS+
         tNvQ==
X-Gm-Message-State: APjAAAUpMW4jSCo2CBaifHktwnYDEC5sbfpoV/1kCa8M2bvexT2KOoj5
        tSluh45xI8eveFt1PvlNFz+4iA==
X-Google-Smtp-Source: APXvYqz6I1xzAJjLryfai5wDR7NXlIFVTUtpTz0Qtpn4nx49m5pqdDnECFgGHywphMX7hn1x65m0zw==
X-Received: by 2002:a17:90a:a44:: with SMTP id o62mr2161760pjo.80.1575938363085;
        Mon, 09 Dec 2019 16:39:23 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id p28sm654515pgb.93.2019.12.09.16.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 16:39:22 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     linux-wireless@vger.kernel.org
Cc:     <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Sharvari Harisangam <sharvari@marvell.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mwifiex: delete unused mwifiex_get_intf_num()
Date:   Mon,  9 Dec 2019 16:39:11 -0800
Message-Id: <20191210003911.28066-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7afb94da3cd8 ("mwifiex: update set_mac_address logic") fixed the
only user of this function, partly because the author seems to have
noticed that, as written, it's on the borderline between highly
misleading and buggy.

Anyway, no sense in keeping dead code around: let's drop it.

Fixes: 7afb94da3cd8 ("mwifiex: update set_mac_address logic")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/main.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 095837fba300..56a18a7f6853 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1294,19 +1294,6 @@ mwifiex_copy_rates(u8 *dest, u32 pos, u8 *src, int len)
 	return pos;
 }
 
-/* This function return interface number with the same bss_type.
- */
-static inline u8
-mwifiex_get_intf_num(struct mwifiex_adapter *adapter, u8 bss_type)
-{
-	u8 i, num = 0;
-
-	for (i = 0; i < adapter->priv_num; i++)
-		if (adapter->priv[i] && adapter->priv[i]->bss_type == bss_type)
-			num++;
-	return num;
-}
-
 /*
  * This function returns the correct private structure pointer based
  * upon the BSS type and BSS number.
-- 
2.24.0.393.g34dc348eaf-goog

