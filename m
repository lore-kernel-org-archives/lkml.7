Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D991C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42328206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D4M5SEhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbfG3Pkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:40:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41787 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732016AbfG3Pkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:40:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so30051951pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+TsaPv7btxKYET4XEO4VsIG1TF0FubECBVi69Yua3t8=;
        b=D4M5SEhWmgpdhlQENr0EWrj+Jd+ccJ6vkHVsl7sKWxgFLdT4SsinEcWlv3VCq/152U
         ZBIoPET0gRdd8KVbsZzlMcOdJsp3pfx5xij9VPh+lBpnbf5ptgFryW/LfOsws3JHfBHZ
         gWlcgg8LUglTD5JczuFzHHrhwaEKCdr9vXvmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+TsaPv7btxKYET4XEO4VsIG1TF0FubECBVi69Yua3t8=;
        b=Et88lRP8i0WTeSR2Obgd3c4kO5tZ6uXgjP72mCXHZJn/y4cl/wJNerqYs9roE8PFbn
         hL8Y+uOlNOB34hqP4YjK58b7TjhfPQbb+0ew6g8Nv01vTKSZ6IHMbAYtLM1DiDnkWzER
         LlL7p0qkhNWrSU2Pw3MrEp3P6IRwZLPPvmbZbvh9eThxONHwdXT0WQL35i6SvtWCtcbR
         Zycn6GAwLsTSuSbSGAD8K2dYW8pOXpcNWfj74ecNJ5Gdt22OGj/vhRTQL8Zk0FPKT+vl
         dusiIimHtPWKssEEH7Es2/uQlfAI8YwUvi8aC6ATYaJn4JX1GJjRATS6s2Og1IjSFIvj
         xEqA==
X-Gm-Message-State: APjAAAVjSuqP9mw6lwqByco7BcsI5JoaYK2hvskrUIiRCpnXvKO4riVl
        rxn+5x2pvIRLPvAcc+iOVzR7wQ==
X-Google-Smtp-Source: APXvYqx7seExCsc7ZPU8XmbNPmYq7yermARF2GGlNlxP6mJlo5st5LoyXJ+I4whknU/dqS7pRS2G5A==
X-Received: by 2002:a63:4404:: with SMTP id r4mr107857554pga.245.1564501244406;
        Tue, 30 Jul 2019 08:40:44 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id f197sm64641762pfa.161.2019.07.30.08.40.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 08:40:43 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH] kmemleak: Increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE default to 16K
Date:   Tue, 30 Jul 2019 23:40:27 +0800
Message-Id: <20190730154027.101525-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current default value (400) is too low on many systems (e.g.
some ARM64 platform takes up 1000+ entries).

syzbot uses 16000 as default value, and has proved to be enough
on beefy configurations, so let's pick that value.

This consumes more RAM on boot (each entry is 160 bytes, so
in total ~2.5MB of RAM), but the memory would later be freed
(early_log is __initdata).

Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f567875b87657de..b5a24045ab13310 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -596,7 +596,7 @@ config DEBUG_KMEMLEAK_EARLY_LOG_SIZE
 	int "Maximum kmemleak early log entries"
 	depends on DEBUG_KMEMLEAK
 	range 200 40000
-	default 400
+	default 16000
 	help
 	  Kmemleak must track all the memory allocations to avoid
 	  reporting false positives. Since memory may be allocated or
-- 
2.22.0.709.g102302147b-goog

