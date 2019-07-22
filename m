Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA3CC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D8521900
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZ2TAEP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbfGVV0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:26:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45225 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732605AbfGVV0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:26:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id x19so35965152eda.12;
        Mon, 22 Jul 2019 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9U7GzV8yeekKe6e4fBok/0l5M8KlRr66XHZl5JwGq/Q=;
        b=tZ2TAEP+CkDEOXvasanyS/2zbrqa0RGK8u1Kc839Sl5eo74fOrtqWSdroBOAnU7VTj
         o26jWX6ivyXOpssGLYZU9OkR2dSi2zpDAHmx8G82+P8LxqFnIAER0C3m34DqMI6Xfu2B
         IeqjlBNHXXxJmINZ4/irey8wXifWJAVQtwm+2bu3Ti9M1YJPgubwKrQwbY73RGeNDa/S
         7T4xY/7Xju8yVe648S2hKamOzaZ0TNlodCZyYK/BLkKG7XA+NWZ0AngyIFRJtl571CVA
         +Rui2fJo7r+UPQrKA0I2Q/W8odDNAnXBYqXxYTXmedkWbsT9wkMSXTzwc+lRwU75v6l4
         ImvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9U7GzV8yeekKe6e4fBok/0l5M8KlRr66XHZl5JwGq/Q=;
        b=DO9bZ85XPtY3x8S97r4NRR0bAyQaZqeL2bkgk4SscgfxCzGURqCYrMKd9aBwdmsaMs
         fd5xmey8RU6QEJAAJU218E9CooZ0gRB9SWQtt/jFsPP7qb+6wbTmMXtGndc37hxLpEbb
         qakYDfbX6Yl+6JNYkC0sC0vurmtSXGtviRz3GeP9sO6H90RJ1xiiqGkFgP77m19yeElh
         BfGtez4NG4ORgZ+fiFkibJncFEzV3K6R4Bu2fAs5qXkeuBYBbWRJ5k4Aj9Fax11xLZqh
         pQ0W7BJRQmzDA/9exg4GTzRQ8CfHYtTL3Myl0LPYu/Gz2tMIH8wpakEjiecRDNVJo95o
         Sjzw==
X-Gm-Message-State: APjAAAWSfqiEcjtIcIzXCEjUXpdnaCOs2S9MgvmGvqDCg1ehikxiGnjp
        dhDkfpmHYNzlqCi0YKYXTKo=
X-Google-Smtp-Source: APXvYqzXEcvH42kQi3NIePyl487sKAo26GXNb9jufG33ojSR7+epYt8y6kVomfFPBqEtSjGXYbKdKQ==
X-Received: by 2002:a17:906:4e95:: with SMTP id v21mr55052224eju.105.1563830792009;
        Mon, 22 Jul 2019 14:26:32 -0700 (PDT)
Received: from localhost.localdomain ([65.154.66.198])
        by smtp.gmail.com with ESMTPSA id a67sm11469524edf.6.2019.07.22.14.26.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 14:26:31 -0700 (PDT)
From:   stillcompiling@gmail.com
To:     Joe Perches <joe@perches.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org (open list:HID CORE LAYER),
        linux-kernel@vger.kernel.org (open list)
Cc:     Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH v2 2/3] HID: core: Add printk_once variants to hid_warn() etc
Date:   Mon, 22 Jul 2019 15:26:12 -0600
Message-Id: <20190722212613.24906-2-stillcompiling@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722212613.24906-1-stillcompiling@gmail.com>
References: <20190722163642.10417-2-stillcompiling@gmail.com>
 <20190722212613.24906-1-stillcompiling@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joshua Clayton <stillcompiling@gmail.com>

hid_warn_once() is needed, add the others as part of the block

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 include/linux/hid.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index b5e73331100e..306dde3760a4 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1171,4 +1171,15 @@ do {									\
 #define hid_dbg(hid, fmt, ...)				\
 	dev_dbg(&(hid)->dev, fmt, ##__VA_ARGS__)
 
+#define hid_err_once(hid, fmt, ...)			\
+	dev_err_once(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_notice_once(hid, fmt, ...)			\
+	dev_notice_once(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_warn_once(hid, fmt, ...)			\
+	dev_warn_once(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_info_once(hid, fmt, ...)			\
+	dev_info_once(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_dbg_once(hid, fmt, ...)			\
+	dev_dbg_once(&(hid)->dev, fmt, ##__VA_ARGS__)
+
 #endif
-- 
2.21.0

