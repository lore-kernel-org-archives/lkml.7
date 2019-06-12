Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E701C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7274B21721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TmXrcETE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfFLT1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:27:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34304 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbfFLT06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:26:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id e16so18166816wrn.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GnwJnGDWcqQEa8ukjqPOjGYwDlsA8+VgoLza7ivYpuU=;
        b=TmXrcETEyy3+sK8LfNnwGn++cLYf6PFNLYfj4yjREecckdlrBc5m2D9MfwSBeDdNPm
         g3NbKAsf9zd2oTcqD9rCnusrjSai0HTstUsoPUXx6LpuvYueOJemP7gcraNhCFQNYIae
         Ep9h0tZMg+MCsukd4UdvHhC4+E+Phg2YCnXqwMMUI+dMz3qEkNfBo90SVCIPBNPpKPpH
         A7A7G3+aGn5g/lRQBzOnLuED2x2u9GZwnBhmXVv/df+9dORL/IUwVRhs/TMW8NPeEmQT
         DVeCd+zSMeYkycSgeqYWVHQvm0RkEZtWF+/6iM9/e+EIylpnEqnIdurhFNXwzhrijjfY
         8xYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GnwJnGDWcqQEa8ukjqPOjGYwDlsA8+VgoLza7ivYpuU=;
        b=KQhtNfnry2CKkZXuICecHVjH7ZyLhNVfn9pAbZwwDhnMtoP0NHauOAjzZHCfZ6PHsz
         NiYt9U1i0TQMfuS0jqNhtJKmrqU+uhcYoHkzhODQpcRkS/ifw+zpme1lt4DUeWW3lsCp
         3bgWd99U9P0Iz2WOh3e46MffozTO0HcaqOBrfbkZvLtYeio4B3SZlWXAIoqab5FIk26l
         /pquScGhMKZaQEeEs/T+YPL4PS2M+pFqxQoSpFY4Uw2k3yAGYRDZRKVHYnFE/55dTfAg
         3YaMlVGh6lQgk74NQF0/5ue59sHu//VyczrhC4i5HMc/GuvXIDSeYuc8J9fsW2PB/NDS
         zm0Q==
X-Gm-Message-State: APjAAAUqzE3VWHJJMdHLe0DkhmQBiKsjTn1h9DyOCOTVx2b5kO7Jcx4U
        qJk6vjsIsopfK9Z4AnfrFUAlcgzbZec=
X-Google-Smtp-Source: APXvYqzk4aReSDfZmvcmlI8KjUcC/U+TRc5q/ppSGl3W/BAdcrzIhmwuQ/hZAWWU16yh+WUQZ7yXDA==
X-Received: by 2002:adf:e54b:: with SMTP id z11mr41279169wrm.198.1560367617451;
        Wed, 12 Jun 2019 12:26:57 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:56 -0700 (PDT)
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
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv4 19/28] timens: Add align for timens_offsets
Date:   Wed, 12 Jun 2019 20:26:18 +0100
Message-Id: <20190612192628.23797-20-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

