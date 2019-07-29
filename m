Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BE1C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180D02182B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="gK7byqnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfG2V6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:58:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37849 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbfG2V6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so38383494wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GnwJnGDWcqQEa8ukjqPOjGYwDlsA8+VgoLza7ivYpuU=;
        b=gK7byqnvCZsRyAqDUYBeiSCrVa5couP/h+KwniMJqL09zy+rCaIohJDUe9fStHvTA7
         JREI0X/pNKAN9fxf+88hlyirEJ9wIXGnsEl6D/EYxWQrZgmKwBAq6YVPrI0NvKK/HSST
         vRkw03heGflDUvYPLv0ERzuLcjmO6Z27rLXyVa5bIxr+JPAo9aeFJ8TMCN9GbUvf5pHb
         lXuDk7nvS5RxVQmOKi9cvUiaOhvfs8mXLFEcfA01gTUBIaJ5xNQAxl21rTlfwXaQaZ5c
         CJdzPvW9rvFWZGB5G4dhYwg6TUHvXTmaHPd0g32TU2ECThWVKeKSm6SkQYDgnyiGMqND
         HOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GnwJnGDWcqQEa8ukjqPOjGYwDlsA8+VgoLza7ivYpuU=;
        b=VfJmS2oGni1QzITWM2K8LJGKdI364RMJXDyy5djJINx2oQjGD21KPv+E0aFmm78+9R
         dNtJL86NO98nrZIQkJvfnAMJZ8eO+eGZruKLAuUZqEBOjrJtajonz4uGYq7oSW8k07uE
         zDfjcz6i1nXELpG2sBpW2biIV6MGWxcBRFJtrKyDzv5GHlLZHrrT+z1utmwXPRBhImt9
         IA0zsY2IfP/nHXy5BQBYYLUC5QBkx80wlQRRYoOckDehQC+pfTNyPc6ZbO0kP9zNmLjL
         oi8rLjfKve7znEJhIZ+J4GVnOW6ML3MiXIlpTktAFA/FsIkdL6ytASVcYGrreqC4Bt01
         4E5w==
X-Gm-Message-State: APjAAAVFvp+25RHQzlNPz7/rU2V/kUwvuxomLA8gNDFooekmzc6CS/FZ
        wOm/hqXUf00FwmyunkiZK+4iIaLJPjZ9ojIbKPG4tiBUMIYJ+CA1jyVSvA2+BOtD3Ogzl5+Mwdk
        6a8jUGyqUAPrdze85EDiaXtfYraZdprHM2nt3wDw0NpvxWc4xtM0dGTiFzVZnCTJ7uwpellw1T+
        y3Yr97X8T528FAIhADRUpuw8K4T37YgbrQjT1d9OM=
X-Google-Smtp-Source: APXvYqyujkIL21jruIIVOjs8R1vGjVkFnG/AhEu3LLytd44H68v1bQ5N8nR+C3IOS4wZrjo9GetQ1Q==
X-Received: by 2002:adf:cf02:: with SMTP id o2mr103003683wrj.352.1564437520327;
        Mon, 29 Jul 2019 14:58:40 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:39 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv5 29/37] posix-clocks: Add align for timens_offsets
Date:   Mon, 29 Jul 2019 22:57:11 +0100
Message-Id: <20190729215758.28405-30-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align offsets so that time namespace will work for ia32 applications on
x86_64 host.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/timens_offsets.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index e93aabaa5e45..05da1b0563ce 100644
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
-	struct timespec64 monotonic;
-	struct timespec64 boottime;
+	struct timespec64 monotonic __aligned(8);
+	struct timespec64 boottime __aligned(8);
 };
 
 #endif
-- 
2.22.0

