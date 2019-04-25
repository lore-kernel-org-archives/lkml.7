Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B66AC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAE920651
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="I5Hf/GnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfDYQOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:14:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44311 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbfDYQOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id i13so359162edf.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kg1vIXJcDaXQqE99GxLpll2SxkO4DO1wv9x4BXi972A=;
        b=I5Hf/GnPQ3GCZO5kf4nci03qQ1sNxMQ9/X2pF6+hAeIPTpAL3HC/BhYSphRSElFnE3
         lv3fLfgwMRkaHrV5YKwXNTX/YwfltE9LnSoNWNg6IhUcg3xwkMaLunkAB7ZXPbHDLkJh
         aLq1HxIZPGC+D5lYgfANqy0jMQYWufEfX6zFztJ7p/+iJ8YuELAiTexh1HjsmEhLHrA1
         dZ23b2HWE8793NcgfM82zxtUXrelELKkxfEVitKmbu7eR5TCGe2GRHz+eUUu4TNDU6rI
         R1mzF1EgkOL30tfFs1gVBtFZzInXSyb2mHxyR9qGi76v658TFAFBsLSnFjxe9KLa7b0V
         tGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kg1vIXJcDaXQqE99GxLpll2SxkO4DO1wv9x4BXi972A=;
        b=OZP6j7fwWUtzEazrmvHaF06KFliWXKcNk5Iqq4GY3dOLsJhyR1HlX5DJbzHVh1C0ct
         mouDrveW46gO4cK8yaKDxSH8vxWszgANn5exvHDJxj+jwjk2MCjiLCt7r+KGreWkkvb8
         X9pTNH2ZhRCBA8Vo+9JINFdU44v0syEy1q+co2Ng37xBcQea9xoFR4o+TDOQCfRJuKyr
         Kd865iK9JV+U3Ioi0lI0U3PXatilCYJII+2dlC0O7xEcT+FQBJKk+EdHauZULPA7cEas
         3ki8dMNgZC/5eXaWoZthtdxaqxOFgYa0P2cD0yB5cszHG6Dy85lrQaLScoPowGvEBKgO
         wbsA==
X-Gm-Message-State: APjAAAXAC1uFl7e0aNuAhS/Ki3yrVFncfXJgHeXMveteaQ28TvXQF18A
        hq5DpjodE2cnVtgZiSFiUA+hAk2p7K0=
X-Google-Smtp-Source: APXvYqwXn4Mq1aWRI5piDLsyF1uH9ywLDlYJkIGVfq0TLeCzYCcA6u0LXfyRd82dKUGXpRzjSr51Vw==
X-Received: by 2002:a17:906:c45:: with SMTP id t5mr5846306ejf.207.1556208888381;
        Thu, 25 Apr 2019 09:14:48 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:47 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv3 18/27] timens: Add align for timens_offsets
Date:   Thu, 25 Apr 2019 17:14:07 +0100
Message-Id: <20190425161416.26600-19-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align offsets so that time namespace will work for ia32 applications on
x86_64 host.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/timens_offsets.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index 777530c46852..f2a03d4f7a91 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -2,9 +2,17 @@
 #ifndef _LINUX_TIME_OFFSETS_H
 #define _LINUX_TIME_OFFSETS_H
 
+/*
+ * Time offsets need align as they're placed on VVAR page,
+ * which is used by x86_64 and ia32 VDSO code.
+ * On ia32 offset::tv_sec (u64) has align(4), so re-align offsets
+ * to the same positions as 64-bit offsets.
+ * On 64-bit big-endian systems VDSO should convert to timespec64
+ * to timespec because of a padding occurring between the fields.
+ */
 struct timens_offsets {
-	struct timespec64  monotonic_time_offset;
-	struct timespec64  monotonic_boottime_offset;
+	struct timespec64  monotonic_time_offset __aligned(8);
+	struct timespec64  monotonic_boottime_offset __aligned(8);
 };
 
 #endif
-- 
2.21.0

