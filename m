Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB5FC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BCC20878
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MbK1bl7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfKUAD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:03:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36049 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKUADM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:03:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so2124136wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 16:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iILqDiivRi8BjwupWA1etZi9HVAj+9a2PtQFD00PqHE=;
        b=MbK1bl7YJkp3/vdJhrEg3CI8GOjQmhwVc2X423eHVIUCovz8pqRBXuFIRniAvdK0ZP
         l0HQKajC9oTXwaP56P+6bdjbqyxTEVIhvK4v21SAU3v1nudd+89rzss8bIcVFrmKbNsD
         rtQwpe6mI5135UJhd6gYLC64cgQa4KF3b5rRdO/F6UJ4ZMK7XbEX8RL3GxAHpULMXoMG
         MH4OwxiNbOszQXwEFSEtwPz6x3spiiiLLrmvhVIqAVMc/COuMdrtb/xkYmUzOwCUVhG1
         Ij/aMz3kBkq0+o6Rdk/HpUk5jVuzDa59EjlzCb0HakzaW5HhAgJdz+57VYXTB9VQbmC/
         6VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iILqDiivRi8BjwupWA1etZi9HVAj+9a2PtQFD00PqHE=;
        b=NBpECdhr1DLoahfo28/H1oS7wNGsu7XUXT1f2UFOwa+DOWt6E5bBUpyqyL/fmnLqJP
         KEFRHgBnh3+eFWp4BjZAAdZ0i4EBI/Nefznou+UgJYhUzGNvepESQ7FOTYRWiUBtyBOI
         RwZx+L+NqNOXqKvZj/YS9hg0UJ9AhjLi0zVMl0MKSSBgt5JoiCugwYWa8r3fucI3SBvN
         5Ol1iqR1N/lb/nzyZNo4rLuOnV2KyuXn43pqYM48bjvO6Fo2JxkVaycEFZ5Xh4jiBaWa
         aX2tT54RCWGYQWNoGjA055aY4E+EOJ5yWrngAprGAKSyt9CqjaKnElE8V45YG5jxbg+H
         r1Xg==
X-Gm-Message-State: APjAAAX/S9F+NSrzeqEmLchVDQ8K95WVob0+DcIjzQUrElnF5denaojQ
        atuo5FCmEsxALDhmReVEm4ymazhP6dg=
X-Google-Smtp-Source: APXvYqyutfd/TDTPhcdy9nLeIRZoQyJ/7YXhGyry4x9pmPK1r39zEU9x1yFFqtERynEbCqt6WuM8MQ==
X-Received: by 2002:adf:ee92:: with SMTP id b18mr7224710wro.346.1574294590222;
        Wed, 20 Nov 2019 16:03:10 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 17sm949900wmg.19.2019.11.20.16.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:03:09 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, y2038@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH] time: Zerofy padding in __kernel_timespec on 32-bit
Date:   Thu, 21 Nov 2019 00:03:03 +0000
Message-Id: <20191121000303.126523-1-dima@arista.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On compat interfaces, the high order bits of nanoseconds should
be zeroed out. This is because the application code or the libc
do not guarantee zeroing of these. If used without zeroing,
kernel might be at risk of using timespec values incorrectly.

Originally it was handled correctly, but lost during is_compat_syscall()
cleanup. Revert the condition back to check CONFIG_64BIT.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Fixes: 98f76206b335 ("compat: Cleanup in_compat_syscall() callers")
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: y2038@lists.linaro.org
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 5c54ca632d08..1cb045c5c97e 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -881,7 +881,7 @@ int get_timespec64(struct timespec64 *ts,
 	ts->tv_sec = kts.tv_sec;
 
 	/* Zero out the padding for 32 bit systems or in compat mode */
-	if (IS_ENABLED(CONFIG_64BIT_TIME) && in_compat_syscall())
+	if (IS_ENABLED(CONFIG_64BIT_TIME) && (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()))
 		kts.tv_nsec &= 0xFFFFFFFFUL;
 
 	ts->tv_nsec = kts.tv_nsec;
-- 
2.24.0

