Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4BEC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD248227B6
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gocQCkAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388339AbfGWH0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:26:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35696 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbfGWH0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:26:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id s1so12656976pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 00:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZVZ61BiSzBKJ1JT8Cvz6WiCNSXWAXSUthPiD0rVVcPA=;
        b=gocQCkAYncRSzUUCtbO3BJahbIuaWTM4EaSrObCoPhrkQw8xDGMQMZtnJqNF++4NSd
         p5XrXrhWRrJjTwrm1fW8EoHMNTAd1OxsUwfU5HhSFQSfwFnBTKG0J6vjrwBvvTnFnLRR
         hlD0qD2vVrPxshPPpevMZa9cGTQ/nvrlla+U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZVZ61BiSzBKJ1JT8Cvz6WiCNSXWAXSUthPiD0rVVcPA=;
        b=OOgakfTJ+kc5aqn2iksD1NjlWQmyTsa/6MuQk+6axHRB6zqGVjMGZkhoyYTnJGWowI
         NlZqyKuXH3jehLuACYmQxk97HuP7nutwCAvNm5S0yvQnhS7RPQq6/rh/rX7TizQxcZU0
         5X+xfYQEdiRdQTPJx9rJ3WDEUg7Q5pOmltVS5+CPzrcOPBz3VnunH77eSqdvw7/m8Kwz
         bTNZ828nRiMy0ud2cVrbetRTQ3huLvRh3DHo4hdLxZF+SWY7Jh0rF93qHyZ02f5GEqfP
         dCZ9z7rnUp3b4adVXroqloRrwdxI7x3VzYi2grR7gtSvvM9fqpyPU9P/VKKZO8uWvRhX
         Sbsw==
X-Gm-Message-State: APjAAAXydnKHY+Vwgun8Npx1odruQJZ367RBGXOMM+K1sYVfK8oY6mLK
        Dt2xIJNPhfHKH33mNgp6Aef/8g==
X-Google-Smtp-Source: APXvYqzyCDsjrvVzBY798lFYumN96rIA5hEZN2RFZuvjjKJY7Q/o1g6WNkNqbbHd6FZcw+uSJ3gpXQ==
X-Received: by 2002:a63:ff20:: with SMTP id k32mr75509673pgi.445.1563866772783;
        Tue, 23 Jul 2019 00:26:12 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id o95sm36406676pjb.4.2019.07.23.00.26.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 00:26:12 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH] kmemleak: Increase maximum early log entries to 1000000
Date:   Tue, 23 Jul 2019 15:26:05 +0800
Message-Id: <20190723072605.103456-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When KASan is enabled, a lot of memory is allocated early on,
and kmemleak complains (this is on a 4GB RAM system):
kmemleak: Early log buffer exceeded (129846), please increase
  DEBUG_KMEMLEAK_EARLY_LOG_SIZE

Let's increase the upper limit to 1M entry. That would take up
160MB of RAM at init (each early_log entry is 160 bytes), but
the memory would later be freed (early_log is __initdata).

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f567875b87657de..1a197b8125768b9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -595,7 +595,7 @@ config DEBUG_KMEMLEAK
 config DEBUG_KMEMLEAK_EARLY_LOG_SIZE
 	int "Maximum kmemleak early log entries"
 	depends on DEBUG_KMEMLEAK
-	range 200 40000
+	range 200 1000000
 	default 400
 	help
 	  Kmemleak must track all the memory allocations to avoid
-- 
2.22.0.657.g960e92d24f-goog

