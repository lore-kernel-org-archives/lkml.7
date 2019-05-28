Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90CDC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCED2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7uKqwq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfE1Ebb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 00:31:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41216 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfE1Ebb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 00:31:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so5804398pfq.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 21:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9P09ET3lHKfQiCPrh2AxK6gKOQt7ghR7HUM0eo8OdI=;
        b=k7uKqwq9bZqFUKAqPtguHHw3HhdORsREe8G/3ZhMJQi3bmeegHUURhCZqRPruvTccs
         hr9CngPXacVjKJMb56+pubc0e9i26ao4jTtUtPjObfqCNBFtfeIWGyLNVsgJ2G7RsRk3
         zh7AMgzDOUwmWmyViBuqtY0Ggpmp2+iDiVuyNxAFbc2kg6MyZbRWSlXEzxJrcBzTGyv3
         jc7bu9zKObBQVV7B1dk4p4jY+koLgXbWC1dTdemtR911IJNVrJr+l/6RfdJ+iLe9EDen
         f+tsQe39mwr4lq96x7q8PZx4YdcL411CKP1GrrzlLqxSHAVQpE/vkt/3ioUSkn1PhcGJ
         uKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D9P09ET3lHKfQiCPrh2AxK6gKOQt7ghR7HUM0eo8OdI=;
        b=NwTijNCZLsuGXDG1e0J+8Rh2/qzwq8XuKH2VEPU8vU5UdUiTYrSNYuQ1S3ltLzor3c
         A+GJrGqhE0MclvJM3baFEB6ea0BxrwGRsCLWBt95k96scPDBzZL0CdCteiUGRGE5k1pX
         JhrrBSghmr8AgqJBsbropQVc8Jphi5dfpz55cPkGkEs4d6McIJpv/txTQ2K/vpRSsABe
         qpEPlnd4nBvRNi9dx1ZUG4Z7Wwc7RUgPE1mgsAww8CbHB1RKnzHbfX1ax8JSBlzqTk81
         Q+59qXrNcNR1Xk5+Lqg4U+OmvjQ32vAL8wHMW32tmwWFeC+c/wczoOdmQc5CAUomTpoV
         3lfg==
X-Gm-Message-State: APjAAAUkm6iIQTI+6ZjZo1LaGDqfLbv+CsWWqYZHmPJtD/+rH46P8kw6
        abZlEhg9uovmc67D9BrxiMk=
X-Google-Smtp-Source: APXvYqxXkWRZCb5ZO1h9FXtzO/gBcbF/dUKrpPNA/6gd/uJRgzrbox6YkKsm+JOH2Xqp4uHfdktybg==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr3081536pjq.46.1559017890382;
        Mon, 27 May 2019 21:31:30 -0700 (PDT)
Received: from bourget-gt.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id h5sm13575075pfk.163.2019.05.27.21.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 21:31:29 -0700 (PDT)
From:   Trevor Bourget <tgb.kernel@gmail.com>
To:     jslaby@suse.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] vt: configurable number of console devices
Date:   Mon, 27 May 2019 21:31:17 -0700
Message-Id: <20190528043117.169987-1-tgb.kernel@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having 63 vt devices for embedded systems might be overkill,
so provide a configuration MAX_NR_CONSOLES to allow this
consumption to be reduced.

Signed-off-by: Trevor Bourget <tgb.kernel@gmail.com>
---
 drivers/tty/Kconfig     | 9 +++++++++
 include/uapi/linux/vt.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 3b1d312bb175..98e21589f4af 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -42,6 +42,15 @@ config VT
 	  If unsure, say Y, or else you won't be able to do much with your new
 	  shiny Linux system :-)
 
+config MAX_NR_CONSOLES
+	int "Maximum number of consoles to permit"
+	depends on VT
+	range 1 63
+	default "63"
+	---help---
+	  The maximum number of consoles that can be used.
+	  The default is 63.
+
 config CONSOLE_TRANSLATIONS
 	depends on VT
 	default y
diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
index e9d39c48520a..3567dd239758 100644
--- a/include/uapi/linux/vt.h
+++ b/include/uapi/linux/vt.h
@@ -8,9 +8,13 @@
  * resizing).
  */
 #define MIN_NR_CONSOLES 1       /* must be at least 1 */
+#ifdef CONFIG_MAX_NR_CONSOLES
+#define MAX_NR_CONSOLES CONFIG_MAX_NR_CONSOLES
+#else
 #define MAX_NR_CONSOLES	63	/* serial lines start at 64 */
 		/* Note: the ioctl VT_GETSTATE does not work for
 		   consoles 16 and higher (since it returns a short) */
+#endif
 
 /* 0x56 is 'V', to avoid collision with termios and kd */
 
-- 
2.22.0.rc1.257.g3120a18244-goog

