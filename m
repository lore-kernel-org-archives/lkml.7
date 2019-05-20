Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D448C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E0920815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="imk5KPXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbfETIYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:24:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41873 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbfETIW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so22529926edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eGgrLKE2df25ULz21985aqzcbzro9NwOlgEwwTc5Zzc=;
        b=imk5KPXbRHmyM+OGJsrvU50iu0pRYSH4CQqAEYUC50IR7Unb8WAmHx/5xDSKShl4Ms
         md2CbhXU/wCTBL9n61NPg+DXyNyuLx//HhKu7qBKwmA6U/dMwqcXtR/aG1FezRv5EDZk
         lLWq9pUMZUOD2LKJFQRnQCeul+IsxkHvQfMv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGgrLKE2df25ULz21985aqzcbzro9NwOlgEwwTc5Zzc=;
        b=r6Mc6mbSaU+Ly1T5Dzrzk0hKvI+lHVGYGDVIeQyh8JRhCpBEqYhzZn2nu4oL3IWkp5
         pQuzsH2Uz05Xr5tQ0banxteOACwmyC9bE7g1A4dyEsCA80kB/h6DK4RgSU4qJvSJatI5
         LCvF5t1NaDYbsZTwKt/qkEpUJAMuhBvoHEC8e3tb7ZPcgkyAhbdV8gYYhlLJhhv676SS
         tzqUttpeYj621SFayypYMK0FBXyJ8QpkiJClEgfQyTwRB2pJ2O/LskwIyGasaZ2TyUzr
         MZBEgZRCjFR/dE4wRc2vF5X4sI24FqpKgZB1jw4nEHjf1wvnNTTyHzBoben356ahrCzY
         FNaA==
X-Gm-Message-State: APjAAAXi3X0Q2uQDX3bKWXynspQhZk6KFKVvcno2s86PkUgD8RNwvhjC
        UunH2b7v23/+FRM974IBAvWHbQ==
X-Google-Smtp-Source: APXvYqx7YzC0MJ93NDDxrKOPv8V2UlfbQHlJo8bGF+j+Ew1CJ09B+PCH5y8spsqLQYD7mw+uuSgrTw==
X-Received: by 2002:a17:906:a950:: with SMTP id hh16mr20399701ejb.136.1558340547229;
        Mon, 20 May 2019 01:22:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:26 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Martin Hostettler <textshell@uchuujin.de>,
        Adam Borowski <kilobyte@angband.pl>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 04/33] vt: More locking checks
Date:   Mon, 20 May 2019 10:21:47 +0200
Message-Id: <20190520082216.26273-5-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I honestly have no idea what the subtle differences between
con_is_visible, con_is_fg (internal to vt.c) and con_is_bound are. But
it looks like both vc->vc_display_fg and con_driver_map are protected
by the console_lock, so probably better if we hold that when checking
this.

To do that I had to deinline the con_is_visible function.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Martin Hostettler <textshell@uchuujin.de>
Cc: Adam Borowski <kilobyte@angband.pl>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/tty/vt/vt.c            | 16 ++++++++++++++++
 include/linux/console_struct.h |  5 +----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8b4b3a49ec33..0ed234ac5a6b 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3814,6 +3814,8 @@ int con_is_bound(const struct consw *csw)
 {
 	int i, bound = 0;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		if (con_driver_map[i] == csw) {
 			bound = 1;
@@ -3825,6 +3827,20 @@ int con_is_bound(const struct consw *csw)
 }
 EXPORT_SYMBOL(con_is_bound);
 
+/**
+ * con_is_visible - checks whether the current console is visible
+ * @vc: virtual console
+ *
+ * RETURNS: zero if not visible, nonzero if visible
+ */
+bool con_is_visible(const struct vc_data *vc)
+{
+	WARN_CONSOLE_UNLOCKED();
+
+	return *vc->vc_display_fg == vc;
+}
+EXPORT_SYMBOL(con_is_visible);
+
 /**
  * con_debug_enter - prepare the console for the kernel debugger
  * @sw: console driver
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index ed798e114663..24d4c16e3ae0 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -168,9 +168,6 @@ extern void vc_SAK(struct work_struct *work);
 
 #define CUR_DEFAULT CUR_UNDERLINE
 
-static inline bool con_is_visible(const struct vc_data *vc)
-{
-	return *vc->vc_display_fg == vc;
-}
+bool con_is_visible(const struct vc_data *vc);
 
 #endif /* _LINUX_CONSOLE_STRUCT_H */
-- 
2.20.1

