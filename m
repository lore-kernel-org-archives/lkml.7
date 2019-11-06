Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515FBC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECF0222C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hvKtCam4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbfKFDJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:09:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33139 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731100AbfKFDI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id u23so16141192pgo.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 19:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTJGC0hehufyDDpJLdIwX4sd+5PzEDd8462b9AsWsFc=;
        b=hvKtCam4oJJLynyWlpMbOP1ctt6jOY2teqQzdk50+u4uBIeZUhQgld0ISgeBlj7Zkv
         cdXdd8pXEOdL5e5LDb7EML7hMQXppl6ii0m4b3ekd9x02SzCTUKYLzEp3yMDwS6/NUHc
         p00bfqg+t6UrqfAr5ToW7eJX3C2ft+S0ggQKaPL5ZQ5gR3qvDk9GLy1DZe1XpJefmeZ5
         020l99AY72cjgIlmB5VbWVoDuYQ/HxTLyTVQB+CKsZRiP0u1N9yj3oDtM7oi+otKYAX9
         Z4JTQ+RZOpoKgY0M7t2XPr4dVh72s106ytrsF3Yoj/Qriq8dq4MhEKSL5vOvOXlpFGDs
         /V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTJGC0hehufyDDpJLdIwX4sd+5PzEDd8462b9AsWsFc=;
        b=kXtE5T4DWmC7cF7lrwNscasBLC6+4uQKhMD1zbM+ByjiCtyqGv9n48i2xAEwzbjCS8
         a9dw53Wvs8o27SNmvgdT+wDBjQNUmEL2jH79cxYkdhHZMslUkMn2AOVyhUWmCLCTIJAl
         DPBFS4VMMedejagUlg+VlKy8G8TFeLKZeROY8JjqEZWPMGuGJ+CM6YU4S8vCZdYwJ3zW
         v5frLqkLj+18A+xgas+yxkhcstmmasYIQ+A572KVyfe9aMM3+ClExBDku9zT5y7gjAUL
         myVTXnog/WWoCj8pacHcd4Fl+AUlzFfwijRO8TZ2vGoTT6dt+hYwZQZq9kLmacbCZzw0
         X8mA==
X-Gm-Message-State: APjAAAXAQaVrlb4+hCvQ/XneMGwuuhXw27wgMX7BDEE8BGdha9ppU8+U
        VEMV7/Ar+4qnqMv3j9SluQrDn1+OGYA=
X-Google-Smtp-Source: APXvYqx1029Zf1jFMc5t5qbu9Z49aYAcoYPxwzothKeaiV5/uBHIk0FsUPkqOgp0OAreuJ7lcxISKA==
X-Received: by 2002:aa7:82d7:: with SMTP id f23mr423039pfn.141.1573009738407;
        Tue, 05 Nov 2019 19:08:58 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k24sm19570487pgl.6.2019.11.05.19.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 19:08:57 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH 45/50] x86/amd_gart: Print stacktrace for a leak with KERN_ERR
Date:   Wed,  6 Nov 2019 03:05:36 +0000
Message-Id: <20191106030542.868541-46-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's under CONFIG_IOMMU_LEAK option which is enabled by debug config.
Likely the backtrace is worth to be seen - so aligning with log level of
error message in iommu_full().

Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/kernel/amd_gart_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index a6ac3712db8b..033503f394f7 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -159,7 +159,7 @@ static void dump_leak(void)
 		return;
 	dump = 1;
 
-	show_stack(NULL, NULL);
+	show_stack_loglvl(NULL, NULL, KERN_ERR);
 	debug_dma_dump_mappings(NULL);
 }
 #endif
-- 
2.23.0

