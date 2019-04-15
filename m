Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707C4C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFC620848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5G6WiKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfDOU1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:27:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38310 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfDOU1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:27:18 -0400
Received: by mail-ot1-f67.google.com with SMTP id e80so15648790ote.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 13:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mOokSmPuLPbmNj8Z6X8SHG9ra1ogTS2SWovxwvyvlS4=;
        b=a5G6WiKDtQe8JwrRWk63LdsMgorcXRh5lzGUKFALiONpazXCU1TxFHlT7N0SzUMzYa
         6jCymerAvMUlzoFKviT2UqxducKFmXdIPK4YxpaMOohQ5tW3mdwEVXf9oRNqasa72KCH
         1Skeem9/iKYjrxV64YzifVbOWrGDeT4bDOMO0eAP7UFfVBNk7DohaSHnwHmF/7YiUpHq
         Q7Mc4QgTCEDDHhKhnfvBoQjeMT+5YFuFIgC4bwKM/I/fy3yPVFjkhkUvBIBLQmv2k74C
         Yy38hnOPsu+2xQ0IJvnCJlVazayF6+Mx8Ex3rurBvb0L84sQHKho3bi/9vFoZBnZN6fM
         BKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mOokSmPuLPbmNj8Z6X8SHG9ra1ogTS2SWovxwvyvlS4=;
        b=QyEwZw8jEK5OJDMutIW5QKfHo6nl7Lo0hV9cjtkrkB0vjW6XDgXlR2wHVJsTwn39Cv
         /6l+13fZp9pR5OSaebXRpiTmqtzQWuhbCr39TUakff22AEFR3iCfGGmMTmHDsfHc/tL+
         04uhVQ5YjbuUgRm5NSN6jFF2VhoysbcIDk0Q4QwzqpOiF1KKrcVrvcDmzqxpHHXIakco
         oZ7v9qqRsCsdYrtm99sM+Cq593whzJTt08ZQ58s+gj/SK+TDFPCbnZOTRmsQ6RlxFnAz
         AO4nmtFh5BzlQ9MegGhir7lQZaFH/PLs2kDr45d+XeGJ/2mcpa7JU3Xo74byI2WFz1f6
         8f9w==
X-Gm-Message-State: APjAAAU9kALW9pnhz95joJjJCmciUon7qqKyYS5Bs0/MEUW+a++O2LpG
        Tgj9L/jCEqkscz0KZGb5MqToAak9UIw=
X-Google-Smtp-Source: APXvYqxQFMyABYy37v9BBnL29pwXOC5gEjE3tEm1mXI/NtjxKbmoB4Kqt0JTpU3TW+Y3WwTOMof7Jg==
X-Received: by 2002:a9d:5f02:: with SMTP id f2mr49990245oti.271.1555360036468;
        Mon, 15 Apr 2019 13:27:16 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:95f5:9dbc:648:48d7])
        by smtp.gmail.com with ESMTPSA id m22sm13948747otq.47.2019.04.15.13.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 13:27:15 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH 3/3] Staging: rtl8723bs: Remove an unused struct tx_pending_t
Date:   Mon, 15 Apr 2019 15:27:04 -0500
Message-Id: <47fd1fe6c3ba9a6ade241305fe0e718b1eb13fc3.1555358247.git.madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1555358247.git.madhumithabiw@gmail.com>
References: <cover.1555358247.git.madhumithabiw@gmail.com>
In-Reply-To: <cover.1555358247.git.madhumithabiw@gmail.com>
References: <cover.1555358247.git.madhumithabiw@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unused struct tx_pending_t, as it is never used in
kernel tree.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 1327728e6dff..74c028fbe8f7 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -870,13 +870,6 @@ static inline int is_zero_mac_addr(const u8 *addr)
 #define CFG_IEEE80211_RESERVE_FCS (1<<0)
 #define CFG_IEEE80211_COMPUTE_FCS (1<<1)
 
-typedef struct tx_pending_t{
-	int frag;
-	struct ieee80211_txb *txb;
-}tx_pending_t;
-
-
-
 #define MAXTID	16
 
 #define IEEE_A            (1<<0)
-- 
2.17.1

