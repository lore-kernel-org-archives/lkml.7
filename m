Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A675C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43A620850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfDAKZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:25:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42475 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfDAKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:25:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so11247007wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 03:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ytkDSX0hUQw8yoTuJsx11zHuPM+//NwD90uPWmbtSBU=;
        b=nP2Pxcc/j3qHueQQFVvhibWlqcJv9Zp3hlWg6auURcVrl3hLyZPwpCU3HRKsQp6Sv4
         pKbLQQRVPTYUxCPvjCl18MWONmtm8uPmHuBZA2IhPZudz+5vxKD+PPuJsYk+70T3TvP/
         z8b9uP4Zzz34SfNs+o00buGBl6INFFnC5iNs/FAGixm4BQhce/34EmlRpe2x9jIx5pWO
         8+03YBUikva7zSvi/jI/NQP10FCNA1JAoJHPoUWUgRCnNZTgdpu+/dqLT6se75S3PwXF
         R+7MOh4RML39oJljOUiXGc8UKyGDNKnLH0+qv4QZYaR3C8n7I4H+W88uMkNeX1ziOMFq
         ILzA==
X-Gm-Message-State: APjAAAUCBL7GMPOQAAFD6+d5Y1SnVruxurW8kebsWjivcFwA87eMwO08
        idtkG8yr8oQ1dWh+9NqCCK3Nxg==
X-Google-Smtp-Source: APXvYqxrcH7nCE/ebT8nRixV6KB6TtvNrCOKN/g8sQuO+mLdeARqLN/EvY47/23qyZPCf5onyP14qw==
X-Received: by 2002:a5d:6a8a:: with SMTP id s10mr41972580wru.66.1554114332464;
        Mon, 01 Apr 2019 03:25:32 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-70-69-135.cust.vodafonedsl.it. [93.70.69.135])
        by smtp.gmail.com with ESMTPSA id r6sm8088496wrt.38.2019.04.01.03.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:25:31 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-sound@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/4] bug: use the aural error reporting framework to report warnings
Date:   Mon,  1 Apr 2019 12:24:54 +0200
Message-Id: <20190401102456.11162-4-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401102456.11162-1-mcroce@redhat.com>
References: <20190401102456.11162-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new aural error reporting framework to signal kernel bugs. Emit the
sound at the end of the __warn(), so the WARN_* are all covered.
If panic_on_warn is set, panic() will play its sound and never return,
so there is no risk to emit two sounds or the wrong one.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 kernel/panic.c    | 18 ++++++++++++++++++
 lib/Kconfig.debug | 10 ++++++++++
 2 files changed, 28 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 360578e092e7..b87c4403924d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -81,6 +81,22 @@ static struct note panic_sound[] = {
 };
 #endif
 
+#ifdef CONFIG_AUDIBLE_WARN
+static struct note warn_sound[] = {
+	{ 440, 400 },
+	{ 440, 300 },
+	{ 440, 100 },
+	{ 440, 400 },
+	{ 523, 300 },
+	{ 494, 100 },
+	{ 494, 300 },
+	{ 440, 100 },
+	{ 440, 300 },
+	{ 440, 100 },
+	{ 440, 800 },
+};
+#endif
+
 static long no_blink(int state)
 {
 	return 0;
@@ -609,6 +625,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
+
+	play(warn_sound, ARRAY_SIZE(warn_sound));
 }
 
 #ifdef WANT_WARN_ON_SLOWPATH
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e5d187dfc74a..909c271d283b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1007,6 +1007,16 @@ config AUDIBLE_PANIC
 	  the system buzzer and not via any soundcard.
 	  Not available on all platforms.
 
+config AUDIBLE_WARN
+	bool "Aural warning"
+	select PLAY_LIB
+	default n
+	help
+	  If you say Y here, warnings will play a sound just
+	  after the stacktrace and registers dump. The sound is played via
+	  the system buzzer and not via any soundcard.
+	  Not available on all platforms.
+
 config SCHED_DEBUG
 	bool "Collect scheduler debugging info"
 	depends on DEBUG_KERNEL && PROC_FS
-- 
2.20.1

