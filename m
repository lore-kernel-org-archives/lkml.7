Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88852CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE5F21906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cChmRdzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503665AbfJXQjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:39:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44749 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503655AbfJXQjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:39:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id z22so18269402qtq.11;
        Thu, 24 Oct 2019 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qxEej9ZhTTEroEC+KQyp8Bt7h8gyIv3VgjtcTdAbGc=;
        b=cChmRdzX28Kw1sZcn+RGsEflTdu+W0jowQ985PnjZ9JMREt9BwXphzbCAZw7enPVRO
         FK3gUvfSYrD5tWP9/Xzr9PX7cpuu7ymqz6odOX8F4rK1198PnxVJ0rnX+6/UdzGP/sms
         VXbz+zNUgnuMB11mVCofXcA3L1BGMVeXGx41c1C9ItAgdMzJ/jZbmyVj6+081eI4A8PW
         ySnhjBu1TgDfl2QSn9S1KjUnMcbRvi9x6QpHUORPLiWZBgtnqTS8mwyZDCznUiEDFJdW
         PDRnNI2VZ3f2RR0CqGFo2bCFtka+FIkrrKZine4AAuMzOqykTtuqDrYKTLrCDuuqnBgh
         9J4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qxEej9ZhTTEroEC+KQyp8Bt7h8gyIv3VgjtcTdAbGc=;
        b=BT1TNt6aLAJhRYbOpxalS7aHdaTGP2vhQEhNiBiXXcGfysIIxkMERg9JdsaxtaOcbl
         dJjyfM/Ua1/QhlXRLNul5QR3KOMkZxG2iv9//TX5NeWakqhun3I6cba7PMiqgPtB0wxC
         6v3ODynnXNTZ5UAkPe1Sw7gzyIynBsELqCF+Cs4fcjOX4nCAO9qLoH3oj74SSI3+a9pl
         F2KPJ0zuClpytLEr2VEoRMauoqoUW/i890uGpR1vqWlRIaLQ6hfXaBoHv1U+/wet4hOe
         r34Z3jz0bLit1bokVfDxaMjqa4zhDqGcFNWW2916J0dJSXoU8juNxVoNZpqY2N0KaVu7
         A8Pg==
X-Gm-Message-State: APjAAAWJ7jSIT8KAYWT3j0OYATeaQWfYYIURWQma9ctyGWyf/TegG2jS
        7hFvIWV6HNGF1nc7feN/vNM=
X-Google-Smtp-Source: APXvYqx5wkL3B+B9EVLQiK3NwD0XfT33+WW76uAeEeNoCepjIHPbYXy9SGJ7HSpve1JTxF1pjnaCwA==
X-Received: by 2002:a0c:fe45:: with SMTP id u5mr15592957qvs.17.1571935157520;
        Thu, 24 Oct 2019 09:39:17 -0700 (PDT)
Received: from localhost.localdomain ([201.53.210.37])
        by smtp.gmail.com with ESMTPSA id l15sm14660121qkj.16.2019.10.24.09.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:39:16 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 3/3] staging: sm750fb: align arguments with open parenthesis in file sm750_cursor.h
Date:   Thu, 24 Oct 2019 13:38:22 -0300
Message-Id: <20191024163822.7157-4-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024163822.7157-1-gabrielabittencourt00@gmail.com>
References: <20191024163822.7157-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Alignment should match open parenthesis"
in file sm750_cursor.h

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/sm750fb/sm750_cursor.h | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index 16ac07eb58d6..b59643dd61ed 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -5,14 +5,11 @@
 /* hw_cursor_xxx works for voyager,718 and 750 */
 void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
-void sm750_hw_cursor_setSize(struct lynx_cursor *cursor,
-						int w, int h);
-void sm750_hw_cursor_setPos(struct lynx_cursor *cursor,
-						int x, int y);
-void sm750_hw_cursor_setColor(struct lynx_cursor *cursor,
-						u32 fg, u32 bg);
-void sm750_hw_cursor_setData(struct lynx_cursor *cursor,
-			u16 rop, const u8 *data, const u8 *mask);
-void sm750_hw_cursor_setData2(struct lynx_cursor *cursor,
-			u16 rop, const u8 *data, const u8 *mask);
+void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h);
+void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y);
+void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg);
+void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
+			     const u8 *data, const u8 *mask);
+void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
+			      const u8 *data, const u8 *mask);
 #endif
-- 
2.20.1

