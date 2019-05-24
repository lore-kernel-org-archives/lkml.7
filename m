Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0707BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6412175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jdtIJI/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390425AbfEXI4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:56:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38504 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389778AbfEXIyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id w11so13355583edl.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KbIQNH506d7uyinFmR7MAZcUSMrKczG7pZJTMI8GyjU=;
        b=jdtIJI/b2i4YgJlmMYeyZ/qfpIKXC/shH7cE6v5onT6Vdj85CGpPp2AYk0ABglEbnL
         1WBMLJMU5Yhlzv5WzFLoLy7XvF4fUM/CPoMTxHwmeJED3X3GASPifwWYAdS3qIAvu44S
         EtOW0SCOZrzT039kR8G9ic8VrLzWELS/rmWds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KbIQNH506d7uyinFmR7MAZcUSMrKczG7pZJTMI8GyjU=;
        b=OW45UiSurP32AJdBRO38WlR4hkdIAAEU2d8cJ0JPBjgCNqGFEMISpzoH6QVqe6IwaV
         rxXqv/br916vHohhlfoVbFeqj975sMQBCX9f8WjggBhwAw4sObQyuPSm8jtQoa2sKhSM
         20TVtjpr5cOut4TGTR9di2QdE5qGlteI7Uy3u+x9iZQmt3upqTofp7VTJCF3Jhp/9NUX
         WPbZ679/UFjFBuI5TioI7LITXEFriOMlq+B46rchp+3wfYj9xeT2/iq8tqSyHytqJ3yI
         cc9M7M2xMzsqxK7PemOrympoly1+qKkr403oleXaBemWism2WPp33LtEgLw5/D75LSTZ
         kB0g==
X-Gm-Message-State: APjAAAWVaHLSdzsgAXrfmQiGzFYgh72Mk4xpzVcUQg+BBjMq0a3oUQcH
        +bVGt6cLHwdDIn+6w6wa5V5xbd75gkk=
X-Google-Smtp-Source: APXvYqyiRawT8vC+B4WJM0VQMmLh1LZxOrS19g4BugnYkWojWg1kQxzgMayUAw7FefR44KX3iH56PQ==
X-Received: by 2002:a50:e40f:: with SMTP id d15mr103662690edm.0.1558688045814;
        Fri, 24 May 2019 01:54:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:05 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Martin Hostettler <textshell@uchuujin.de>,
        Adam Borowski <kilobyte@angband.pl>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 04/33] vt: More locking checks
Date:   Fri, 24 May 2019 10:53:25 +0200
Message-Id: <20190524085354.27411-5-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
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

