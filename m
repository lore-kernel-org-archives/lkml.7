Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897BEC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D6420693
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9aDpb17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfDYQix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:38:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46766 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDYQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:38:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id j11so161448pff.13;
        Thu, 25 Apr 2019 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AiihT23zrdWbLxtOhD2zbMQi6WAGbAToxZ3mdyPDSlg=;
        b=r9aDpb17lhE+Me7t3jhKPyYKwgQgmA9MyZaHuZ3swOmntC2qxh6EiL+sYXxf4gUVdg
         rkSXZxbSNyQrT3flDP2QpBBugkHxsCsXkzsISY8nwWvRVLpNvYpE9XOnk6qWrFSYOAdp
         FQE8pI3S1zJHsHPjnuhJbptmAvVz0VdVjnwHmgV0YQBuaeuvrL0NtT57KdUx2yESS1gU
         2ZY5AYSQ6dez7RlXEXRokIqDOLVw/YPYfl2L3Jez+fEsdHbiw+0QrGwcbK7El8ugwzUg
         LV/WyjNLQ9auqvMfMHnUbWTDBX+UTEjoc/e3i06iYDIS6HyrCWpFHdsIt9KP7iuM+JKj
         zIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AiihT23zrdWbLxtOhD2zbMQi6WAGbAToxZ3mdyPDSlg=;
        b=dKqA4j28ShINGDzWQo9eS52jjqdB8x5kNAvIg9o5ekmkzml5G1P7xFLoonn63BLrce
         2R5B7GiiVtx3qrQcE3j6VuAhnjkAmxgfMvQ51zi8uzUHS1ygM9B35+zc81bGJzUyBOUf
         rUvU3iVN95kBcujEqrng9IAjk+OJIIDRa/n2YHwgBf3ZQ9VRRJoTVfcls12oz90gfWUV
         R6ZNf5xZMTf72ySXbSoLl7hjraD5FMmsuyIMH2VMcFnYGUGmdDElReJ/xEirfsVpysms
         ylLacXEytvHF0yNj5LLalnhnpx3eDrxPpudkF9sPw40FPEUNLHQltl+pf9LxcdUb9GG2
         mmRw==
X-Gm-Message-State: APjAAAVvhQH3YqQSnSIByOsyP5WCDsHxOfAmv+fDq7oit8cdC8fzGXSr
        9q+EW983AiFBrdjgcCs4/14=
X-Google-Smtp-Source: APXvYqza05uZ5mX33BSzQt/7WKwFR/uljCuiM7elW4pTsMT/SY/DGUMeVz0kjHUPhg1+tS37gIZ7kg==
X-Received: by 2002:a63:ee15:: with SMTP id e21mr9189831pgi.180.1556210330178;
        Thu, 25 Apr 2019 09:38:50 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id k186sm42003053pfc.137.2019.04.25.09.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 09:38:49 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        gwink@chromium.org
Subject: [PATCH 1/2] Input: add KEY_KBD_LAYOUT_NEXT
Date:   Thu, 25 Apr 2019 09:38:45 -0700
Message-Id: <20190425163846.51730-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HID usage tables define a key to cycle through a set of keyboard
layouts, let's add corresponding keycode.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/uapi/linux/input-event-codes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 64cee116928e..85387c76c24f 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -606,6 +606,7 @@
 #define KEY_SCREENSAVER		0x245	/* AL Screen Saver */
 #define KEY_VOICECOMMAND		0x246	/* Listening Voice Command */
 #define KEY_ASSISTANT		0x247	/* AL Context-aware desktop assistant */
+#define KEY_KBD_LAYOUT_NEXT	0x248	/* AC Next Keyboard Layout Select */
 
 #define KEY_BRIGHTNESS_MIN		0x250	/* Set Brightness to Minimum */
 #define KEY_BRIGHTNESS_MAX		0x251	/* Set Brightness to Maximum */
-- 
2.21.0.593.g511ec345e18-goog

