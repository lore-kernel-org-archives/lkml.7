Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F88C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BAC20880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Fw9kB5Jm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbfHER7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:59:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38808 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfHER7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:59:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so40038813pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0TBukq6GOU9Ut953LpgEGINSfK8DzjJGmk7Xe1SlRsE=;
        b=Fw9kB5Jmjo0fLSgVamIZ95tbhDlcNYYpURWM69JCH+wu0rhedko6m6zYIKj6O2Xjhr
         BelDDunPR7dtyqULvrdgxSwaFcsNBVSDW4ctXPcNwaTGKNGNMNmqhiH/iAKbISWi5mwf
         m+/oYPA0vLnz0w4basq8zGZsTWz6WegzsTvvRNvgesaHSuMYeyI/6qnGoJri4nDT0q+o
         EMhcRYNGqS7IvnPv5FyV3+brMSEU3rKkKAEG86k2ajqEjBk7YiYPLihp/Y0If7aVi8+w
         nVchrKAPljsWXerfW82jQ5coS64EC8xhS+7vPNek3JPVXM/qV16vJEd7UbCfimF8YiDM
         kPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0TBukq6GOU9Ut953LpgEGINSfK8DzjJGmk7Xe1SlRsE=;
        b=N/sYfLyK4Ri2tO+elx878E1Lnn9uB9kP9pvBVzPE4rplfcvyCaJgd0o7IxV1s+1Dj7
         wLkyI9036aYyrilR6bu2EDRRv5C4Ly5hlShuPBix/+NkJIksfaDMcHIdHJ6Yfu4DEKRi
         hDpCLg6HNA2OdSTr6oKAUHZ9UpjK7s/qA2U2ilHgM+hMJe0dDJgrIpwZMz0F53UQfuwl
         xQl7ydLELLOAqXvC+VfXkI9wOS85Qh9ci4i9fXDwKFHUKciZ0n346Sc8ML9pcmortgJs
         v0jV9SI/aGPrrq/F7gC9yAN+AAGWo10OUWAJ+H6RiHF3rwTheVDz5Tzmt0ISp1noPTlz
         5znw==
X-Gm-Message-State: APjAAAW4iNNxTWsAIMnXlMXZ6N80/u8NV8R3HnplSJz9H4pVc17BgEwd
        eVfSy8iqU8a0/yJdQDl71OI=
X-Google-Smtp-Source: APXvYqwOaJn3cTw6wOv0mbcJxbhgw4JJfUGi1NOH9O3pEitYpfagkxQb2gAeBi6d5kw23MYEDEMjjQ==
X-Received: by 2002:aa7:87d5:: with SMTP id i21mr73853140pfo.70.1565027981883;
        Mon, 05 Aug 2019 10:59:41 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:15c:211:0:469:982a:29da:f29b])
        by smtp.gmail.com with ESMTPSA id f19sm124403670pfk.180.2019.08.05.10.59.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 10:59:41 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        viresh.kumar@linaro.org
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>
Subject: [PATCH v7 1/3] PM / wakeup: Drop wakeup_source_init(), wakeup_source_prepare()
Date:   Mon,  5 Aug 2019 10:58:46 -0700
Message-Id: <20190805175848.163558-2-trong@android.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190805175848.163558-1-trong@android.com>
References: <20190805175848.163558-1-trong@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wakeup_source_init() has no users. Remove it.

As a result, wakeup_source_prepare() is only called from
wakeup_source_create(). Merge wakeup_source_prepare() into
wakeup_source_create() and remove it.

Signed-off-by: Tri Vo <trong@android.com>
---
 drivers/base/power/wakeup.c | 33 +++++++++++++--------------------
 include/linux/pm_wakeup.h   | 11 -----------
 2 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index ee31d4f8d856..3938892c8903 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -72,23 +72,6 @@ static struct wakeup_source deleted_ws = {
 	.lock =  __SPIN_LOCK_UNLOCKED(deleted_ws.lock),
 };
 
-/**
- * wakeup_source_prepare - Prepare a new wakeup source for initialization.
- * @ws: Wakeup source to prepare.
- * @name: Pointer to the name of the new wakeup source.
- *
- * Callers must ensure that the @name string won't be freed when @ws is still in
- * use.
- */
-void wakeup_source_prepare(struct wakeup_source *ws, const char *name)
-{
-	if (ws) {
-		memset(ws, 0, sizeof(*ws));
-		ws->name = name;
-	}
-}
-EXPORT_SYMBOL_GPL(wakeup_source_prepare);
-
 /**
  * wakeup_source_create - Create a struct wakeup_source object.
  * @name: Name of the new wakeup source.
@@ -96,13 +79,23 @@ EXPORT_SYMBOL_GPL(wakeup_source_prepare);
 struct wakeup_source *wakeup_source_create(const char *name)
 {
 	struct wakeup_source *ws;
+	const char *ws_name;
 
-	ws = kmalloc(sizeof(*ws), GFP_KERNEL);
+	ws = kzalloc(sizeof(*ws), GFP_KERNEL);
 	if (!ws)
-		return NULL;
+		goto err_ws;
+
+	ws_name = kstrdup_const(name, GFP_KERNEL);
+	if (!ws_name)
+		goto err_name;
+	ws->name = ws_name;
 
-	wakeup_source_prepare(ws, name ? kstrdup_const(name, GFP_KERNEL) : NULL);
 	return ws;
+
+err_name:
+	kfree(ws);
+err_ws:
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(wakeup_source_create);
 
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 91027602d137..c0cad2d8f800 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -81,7 +81,6 @@ static inline void device_set_wakeup_path(struct device *dev)
 }
 
 /* drivers/base/power/wakeup.c */
-extern void wakeup_source_prepare(struct wakeup_source *ws, const char *name);
 extern struct wakeup_source *wakeup_source_create(const char *name);
 extern void wakeup_source_destroy(struct wakeup_source *ws);
 extern void wakeup_source_add(struct wakeup_source *ws);
@@ -112,9 +111,6 @@ static inline bool device_can_wakeup(struct device *dev)
 	return dev->power.can_wakeup;
 }
 
-static inline void wakeup_source_prepare(struct wakeup_source *ws,
-					 const char *name) {}
-
 static inline struct wakeup_source *wakeup_source_create(const char *name)
 {
 	return NULL;
@@ -181,13 +177,6 @@ static inline void pm_wakeup_dev_event(struct device *dev, unsigned int msec,
 
 #endif /* !CONFIG_PM_SLEEP */
 
-static inline void wakeup_source_init(struct wakeup_source *ws,
-				      const char *name)
-{
-	wakeup_source_prepare(ws, name);
-	wakeup_source_add(ws);
-}
-
 static inline void __pm_wakeup_event(struct wakeup_source *ws, unsigned int msec)
 {
 	return pm_wakeup_ws_event(ws, msec, false);
-- 
2.22.0.770.g0f2c4a37fd-goog

