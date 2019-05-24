Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507D0C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B9F21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EVlS01Zr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390570AbfEXKgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:36:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54838 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389448AbfEXKgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:36:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id i3so8822645wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 03:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2QncBY+O8HWHusWpmG3TvATwMEVVOER+jDNcjQdf6X8=;
        b=EVlS01ZrOUW4y5TgcO5PW42Ys40ozEuuGxT/VlB+ZHdDPVKs4LX29n9Jkr/8Z6PNse
         UOegy/cIjxDtwK5VzIY7E10zeWFGG8tTsr5lP2bUds+aMR5zF6msMBfDOuzwMsAVKFkQ
         gU27fdfkz+KNgVoLDEVbPC0ybAaS2opAbZtLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2QncBY+O8HWHusWpmG3TvATwMEVVOER+jDNcjQdf6X8=;
        b=NWTkUBCAqfnj5kNwlchrZsE4Wl4cU9tW4LbT8XcDldMFALweDnnrYAUkTA1GfSojFf
         GzQvcc1JyNOtUUlhu1wlDg29USc+kmZG7DOIXOIrA5ELKq9dswjZ2kAaRcUbql/CrXzw
         qbCKRyL02ky7gfS0iFWGQICQrSJpL4W1/ATO3q+l4OOsRETfFxn6JmtqdJ1qiUyv0rlA
         4fthaNZaX8ll3pYhibm5vxf30xehLBxu881dmYfmJRN/2w9SxCjdFzvrIp9KF/WwWXnu
         YKHhJrWFLcqsHNPmBrX/P8N0+egqdRYZCzfuUWCDtlD/DjlOuzp1E8kRVhyxsnBcJHHo
         9kLA==
X-Gm-Message-State: APjAAAXFgtSOqrl2sV9NHJnjzMK/VLAeX0g0hPJzlMmDaVbwmgtxgtlW
        hv+xUYy5woqqOGMYZLamz0msUEJuvpxIog==
X-Google-Smtp-Source: APXvYqws0A2pqR2pfzJ8O/T2RqNMUG9rXolT5X554i6CeJ//OGuyEyIYbdY/Bl3oqqrJuBL1+d3ltQ==
X-Received: by 2002:a1c:f909:: with SMTP id x9mr16477369wmh.12.1558694177408;
        Fri, 24 May 2019 03:36:17 -0700 (PDT)
Received: from localhost.localdomain (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id n4sm2111272wrp.61.2019.05.24.03.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 03:36:16 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 2/2] compiler: Prevent evaluation of WRITE_ONCE()
Date:   Fri, 24 May 2019 12:35:36 +0200
Message-Id: <1558694136-19226-3-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558694136-19226-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1558694136-19226-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there's no single use of the value of WRITE_ONCE(), change
the implementation to eliminate it.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jorgen Hansen <jhansen@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
---
 include/linux/compiler.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 8aaf7cd026b06..4024c809a6c63 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -277,12 +277,11 @@ unsigned long read_word_at_a_time(const void *addr)
 }
 
 #define WRITE_ONCE(x, val) \
-({							\
+do {							\
 	union { typeof(x) __val; char __c[1]; } __u =	\
 		{ .__val = (__force typeof(x)) (val) }; \
 	__write_once_size(&(x), __u.__c, sizeof(x));	\
-	__u.__val;					\
-})
+} while (0)
 
 #endif /* __KERNEL__ */
 
-- 
2.7.4

