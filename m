Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D25C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A16221873
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYZUXT5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfGXIOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:14:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43897 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGXIOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:14:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so14712366pld.10;
        Wed, 24 Jul 2019 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u4jdANospx80Yco3qzr0MBrgUd3XcqTStgdGW4daQMA=;
        b=WYZUXT5zPfgf4El3/3CgdCjZ8MtOfieMBy3KQyormqyQf3F+3uKR8TGi27XOl4tauY
         vHAwp2cmNlHsWgRplz6kct3pd1EJ4O/hVQ/7wCUF1EGLdEd5ju3VSaW5MFtyQhx+ARyg
         OUQpPol75z3kqqzxlR3BR0PbcxlwWvam4F6EvWEYwrM2Hnm5VfB/C/t+GzuCDNR8cdXq
         P2rGdraFRddgIbHHAEwSXeJ8m5+V2PG+K++Out7Ssjzy5d2ToVwXvN6n/+tyWqvM5oOO
         JpybdgoCWCegLdc7Lh/jN+PczaaAfby2EmKLZgdGY9PLKbxv8gdMFCsAL5HBRrtrVgEK
         Dq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u4jdANospx80Yco3qzr0MBrgUd3XcqTStgdGW4daQMA=;
        b=WVZKIMXzOQf7Ym9QwY1418jFi3d9B8im9GNi7qUsH09MMCtipTvw9gISLNocjv7M/N
         haNMfJaXR21nBjoq9XsEEqeGFYd35nxWDu7EWBws8tWzUXaG3RZAlMhPcJa4JZg7El4p
         y9jDesjRpYIlKLyRwFmn2SF8eTWoCy0zaqpwRxZl1rjpajWujvr6hwzTXzcDl6BnESBo
         Xf6PUTCdeir8XCbazTHq//zHmMrXiReN9M6nGEykTSsC4VvvK7QKSvtH4K3k3iHvyZdK
         rjN/ZaK7RI1FFGZp1wYRAodtyHb4LzZqOebA8udD85UHfk1m+8QXU0Vm+gBvr2wWQ8Tu
         xnhA==
X-Gm-Message-State: APjAAAXz5PvaQ0Bxr967vDDMIng6Go+MZBKx/mnkQ91j5gkhOXTmulpO
        BKbUq6UGDVJc3B3vxYWZTO7YvhSW0w8=
X-Google-Smtp-Source: APXvYqx4OO3g4yeW54i9vzqJzowwjZI5wdSnLqcb0Lklfpw6g6EsSqOW05KWXiLmglbLuY4+xYphGQ==
X-Received: by 2002:a17:902:1003:: with SMTP id b3mr25011331pla.172.1563956088660;
        Wed, 24 Jul 2019 01:14:48 -0700 (PDT)
Received: from localhost.localdomain (180-150-79-77.b4964f.syd.nbn.aussiebb.net. [180.150.79.77])
        by smtp.gmail.com with ESMTPSA id q126sm1468146pfb.56.2019.07.24.01.14.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 01:14:48 -0700 (PDT)
From:   Rhys Kidd <rhyskidd@gmail.com>
To:     Matthew Garrett <mjg59@google.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rhys Kidd <rhyskidd@gmail.com>
Subject: [PATCH 3/3] platform/x86: dell-wmi: Use existing defined KBD_LED_* magic values
Date:   Wed, 24 Jul 2019 18:14:15 +1000
Message-Id: <20190724081415.8926-3-rhyskidd@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724081415.8926-1-rhyskidd@gmail.com>
References: <20190724081415.8926-1-rhyskidd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These values have already been defined in platform/x86/dell-smbios.h

Signed-off-by: Rhys Kidd <rhyskidd@gmail.com>
---
 drivers/platform/x86/dell-wmi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 68a8a4eba4e3..fc33c38f5f82 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -311,13 +311,13 @@ static const struct key_entry dell_wmi_keymap_type_0011[] = {
 	{ KE_IGNORE, 0xfff1, { KEY_RESERVED } },
 
 	/* Keyboard backlight level changed */
-	{ KE_IGNORE, 0x01e1, { KEY_RESERVED } },
-	{ KE_IGNORE, 0x01e2, { KEY_RESERVED } },
-	{ KE_IGNORE, 0x01e3, { KEY_RESERVED } },
-	{ KE_IGNORE, 0x02ea, { KEY_RESERVED } },
-	{ KE_IGNORE, 0x02eb, { KEY_RESERVED } },
-	{ KE_IGNORE, 0x02ec, { KEY_RESERVED } },
-	{ KE_IGNORE, 0x02f6, { KEY_RESERVED } },
+	{ KE_IGNORE, KBD_LED_OFF_TOKEN,      { KEY_RESERVED } },
+	{ KE_IGNORE, KBD_LED_ON_TOKEN,       { KEY_RESERVED } },
+	{ KE_IGNORE, KBD_LED_AUTO_TOKEN,     { KEY_RESERVED } },
+	{ KE_IGNORE, KBD_LED_AUTO_25_TOKEN,  { KEY_RESERVED } },
+	{ KE_IGNORE, KBD_LED_AUTO_50_TOKEN,  { KEY_RESERVED } },
+	{ KE_IGNORE, KBD_LED_AUTO_75_TOKEN,  { KEY_RESERVED } },
+	{ KE_IGNORE, KBD_LED_AUTO_100_TOKEN, { KEY_RESERVED } },
 };
 
 static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
-- 
2.20.1

