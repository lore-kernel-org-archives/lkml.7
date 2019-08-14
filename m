Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E37FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CB120843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KdvB6r3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfHNAk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 20:40:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44381 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfHNAkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:40:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so49932307plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 17:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZegRusiqGixl7ULE1EVfSCo6wty0zljEyz/3njLSEWA=;
        b=KdvB6r3D6IKZUQzzdmhizmsoUjmnDloOmrt1wEsk6hweVdhif4+MM9MFNwNL37LQNN
         rcC5jQhBXUImbtXe3HHlSVeHWVXNEvxLoPVbtJQD5ZWfh7ewU6602nQjTu/zEgZcYGED
         N6oWRlFqN8fuG5neBunCbEm9nKAjFNHSVFRXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZegRusiqGixl7ULE1EVfSCo6wty0zljEyz/3njLSEWA=;
        b=h8mPxblyTiJB80CD806ky6nUZtljxXiN47AcJEAudpNeLhFagCI3sKJ/ZtyuLVoOGc
         yTIumhs88EycTuT0LbHo3XUzWlqTYrIDc8dABMEveUQuQrGHhTE/gfEbT/8P5fDZi5+c
         nyA003SBDZo8vZB3CIq9MAupyVMTEU4hCywW69MQBFoq4+xnBUXHr4B35wJZ2k4Wi5b6
         vxASRT7i/Ku7vWIg5TEblB2C8Pre4NanaOAmbTzB+DYikOmkfFG5lPvRe7HlsSXjblmN
         o7l9EXJOoDVfa2YgaSAnTKAKRRZG3j0u8y0yUM5a6yQNPf5Sr9aT/GvjUclzLyioTKb5
         ZY1Q==
X-Gm-Message-State: APjAAAUSU9a+omIA4ZXsvjUHtGqmZCl54X9Q8Nt8oPV4T+wvk6N1gPaa
        y4E4Kda2phxw9n9zaxiLiP1enw==
X-Google-Smtp-Source: APXvYqypLncBjZTiawDZwgQntm3bgscfNzYB+rZ7IHBEeChDvPvjD+yNoBEh16wYIUkelcl8AtFoLg==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr39854552plz.191.1565743255180;
        Tue, 13 Aug 2019 17:40:55 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x65sm111023402pfd.139.2019.08.13.17.40.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 17:40:54 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Tri Vo <trong@android.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] PM / wakeup: Fix sysfs registration error path
Date:   Tue, 13 Aug 2019 17:40:53 -0700
Message-Id: <20190814004053.23775-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't call wakeup_source_destroy() from the error path in
wakeup_source_register() because that calls __pm_relax() which takes a
lock that isn't initialized until wakeup_source_add() is called. Add a
new function, wakeup_source_free(), that just does the bare minimum to
free a wakeup source that was created but hasn't been added yet and use
it from the two places it's needed. This fixes the following problem
seen on various x86 server boxes:

 INFO: trying to register non-static key.
 the code is fine but needs lockdep annotation.
 turning off the locking correctness validator.
 CPU: 12 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc4-
 Hardware name: HP ProLiant XL420 Gen9/ProLiant XL420 Gen9, BIOS U19 12/27/2015
 Call Trace:
  dump_stack+0x62/0x9a
  register_lock_class+0x95a/0x960
  ? __platform_driver_probe+0xcd/0x230
  ? __platform_create_bundle+0xc0/0xe0
  ? i8042_init+0x4ec/0x578
  ? do_one_initcall+0xfe/0x45a
  ? kernel_init_freeable+0x614/0x6a7
  ? kernel_init+0x11/0x138
  ? ret_from_fork+0x35/0x40
  ? is_dynamic_key+0xf0/0xf0
  ? rwlock_bug.part.0+0x60/0x60
  ? __debug_check_no_obj_freed+0x8e/0x250
  __lock_acquire.isra.13+0x5f/0x830
  ? __debug_check_no_obj_freed+0x152/0x250
  lock_acquire+0x107/0x220
  ? __pm_relax.part.2+0x21/0xa0
  _raw_spin_lock_irqsave+0x35/0x50
  ? __pm_relax.part.2+0x21/0xa0
  __pm_relax.part.2+0x21/0xa0
  wakeup_source_destroy.part.3+0x18/0x190
  wakeup_source_register+0x43/0x50

Fixes: 986845e747af ("PM / wakeup: Show wakeup sources stats in sysfs")
Reported-by: Qian Cai <cai@lca.pw>
Cc: Qian Cai <cai@lca.pw>
Cc: Tri Vo <trong@android.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/power/wakeup.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 3a7f5803aa81..f7925820b5ca 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -137,6 +137,13 @@ static void wakeup_source_record(struct wakeup_source *ws)
 	spin_unlock_irqrestore(&deleted_ws.lock, flags);
 }
 
+static void wakeup_source_free(struct wakeup_source *ws)
+{
+	ida_free(&wakeup_ida, ws->id);
+	kfree_const(ws->name);
+	kfree(ws);
+}
+
 /**
  * wakeup_source_destroy - Destroy a struct wakeup_source object.
  * @ws: Wakeup source to destroy.
@@ -150,9 +157,7 @@ void wakeup_source_destroy(struct wakeup_source *ws)
 
 	__pm_relax(ws);
 	wakeup_source_record(ws);
-	ida_free(&wakeup_ida, ws->id);
-	kfree_const(ws->name);
-	kfree(ws);
+	wakeup_source_free(ws);
 }
 EXPORT_SYMBOL_GPL(wakeup_source_destroy);
 
@@ -217,7 +222,7 @@ struct wakeup_source *wakeup_source_register(struct device *dev,
 	if (ws) {
 		ret = wakeup_source_sysfs_add(dev, ws);
 		if (ret) {
-			wakeup_source_destroy(ws);
+			wakeup_source_free(ws);
 			return NULL;
 		}
 		wakeup_source_add(ws);
-- 
Sent by a computer through tubes

