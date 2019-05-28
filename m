Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DEAC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E94208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H29+Scky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfE1JDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34541 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfE1JDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id p27so30685723eda.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jUOvUFjOZWrbnCxjvkZoRiQyUO6GhlMn91QUcJ72DHI=;
        b=H29+SckyvkTxRaOEF5mwVU3EMqX7rXNRfN87/DSt5U3WQU+ZAs7hRquIOi9RzLh0cq
         y26ULKv9eBX2/q3UjrfIHryBmDKjabYCAdBQgCihP1AxUIlusJP0cLTTa5KKbirFHQgt
         k/qMMmYucmNuqrA3kjZVBk6TSXZFe1MV/uXew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jUOvUFjOZWrbnCxjvkZoRiQyUO6GhlMn91QUcJ72DHI=;
        b=dQ9kWn3E75Z9fdlWlRR15RNaj/p9ysBYPt/VdVgIKrrSBoqP23m50PNZZw/1M3I2zW
         o5nFTm5fkGBZqP8f58mMgF26Yqxn6FRsLT4SYLDsLmC21Ov2gH4+Xsfvo4KPX7StqhtB
         Mi4hSV4TXKRFxlqIDEfu9D+Tm/LNaN4/UYUBu8SfjBiVlpEebLSGo0jdillDMapRcv0i
         AQWHQ2Q1mpuC4HmOqCll43+Jr3D5K6PWDFrH+bUDEveNaHoJ3V6Sw+cmWvdHKqHLAODX
         DW7sff5vfD5Df6kMMRH32dz4z8VeCcPuH6hvU4yk/j7H219aiBqAZepPIK6rm/p3dNts
         YqbA==
X-Gm-Message-State: APjAAAWZvddBqwovtormJfHFXOYQw3G9s8gieCWdUWTPaGaWZX21ozoL
        9Rhc4YWmMJPbcSgWEFaaEh6GPqbLcZ0=
X-Google-Smtp-Source: APXvYqx+3Wae09oYe6uZ+dqJBAuIjniRv4ny3Kk16p1SvfsNRiZK6GI4951/ZXDCJWQJ1C95ZStI+A==
X-Received: by 2002:aa7:dd03:: with SMTP id i3mr90704646edv.93.1559034195925;
        Tue, 28 May 2019 02:03:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:15 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Martin Hostettler <textshell@uchuujin.de>,
        Adam Borowski <kilobyte@angband.pl>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 04/33] vt: More locking checks
Date:   Tue, 28 May 2019 11:02:35 +0200
Message-Id: <20190528090304.9388-5-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
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
index bc9813b14c58..a8988a085138 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3815,6 +3815,8 @@ int con_is_bound(const struct consw *csw)
 {
 	int i, bound = 0;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		if (con_driver_map[i] == csw) {
 			bound = 1;
@@ -3826,6 +3828,20 @@ int con_is_bound(const struct consw *csw)
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

