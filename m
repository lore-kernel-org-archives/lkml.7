Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEECC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ED72086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/fb9APg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387824AbfIIOTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:19:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40041 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfIIOTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:19:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so9247484pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkCN1rfxn0GvijT8v/3iWlL1If0T/0iY7m3TA87+hZk=;
        b=k/fb9APgpNF1Cxfqmh6BG7jswGs90KCYKKa3l7MODvWzCC0i29w1nUl3zwPBlLo8qh
         I2lgN7se0yAOU0wswPN9BFJPGh9u2rHuYuoC2gjD5l+fJtjurI9DSD5I6KqO4h/H+TMY
         ywoxb/VqxJyGzSQBksBAeOzeDCMOmaA+BInJH/HFcFM+9Mf88l385O/ae+A1MMCMbLVV
         S4EfLxmK1M2C5J8h6qutUZYoxGGgWlUlosouGx1gIDklzWs3iOfFZBSqVEd5YQpHFItq
         mhSahs5L0wVqdLiJXwcz8RVytuXxgrTnaedGk1vERFDkee33dBFJRN5k216rQk6JnUpi
         1e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkCN1rfxn0GvijT8v/3iWlL1If0T/0iY7m3TA87+hZk=;
        b=mtnIcDQeqZlGHuic+XKyrQzJD8w6Ts4Y1BHjiFnXEBScoEx+06J2S8CRZmP0uUEPi2
         CI9ZKQFrYYMLb95cCo7p21FlEESvB6VnyioyKlW7IoiIxJSeh42jNrDUe4fSP72jA+wr
         t6phBMtLUp22MuE5CcQ8CG6wUfbCuMpJJULFsYMq3u5TaDjyggHV6JCuxV7uKGh2bjhS
         /wJP6oGw6kkXZSxY5wSJBAFki/BVjDYjOOX+43RB7+Hk5pLJr8KzQjujHxxsenPYxm2y
         LVv6f9SjM43TJmiQbDOYt2DLso2BVw08hrSnO0p7DHsOIu4wYB83xgGyWyXqNIu+uFwB
         Fv0Q==
X-Gm-Message-State: APjAAAVEjh9RH4rghxEplYDMD4KmOFm7oK0fF0RAcDaame/2K/BrMgfS
        K67/0KjKnxgMky8uloecfgI=
X-Google-Smtp-Source: APXvYqymnLWaISyLDGw9e3VC4yEVPwGFGeOG/N3P4yZoxq5hJVj1A1HFELxcNjA7gkIEFMeqe5Hfhg==
X-Received: by 2002:a63:b10f:: with SMTP id r15mr21647735pgf.230.1568038750771;
        Mon, 09 Sep 2019 07:19:10 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id w6sm34574695pfw.84.2019.09.09.07.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:19:10 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 6/9] kconfig/hacking: Move SCHED_STACK_END_CHECK after DEBUG_STACK_USAGE
Date:   Mon,  9 Sep 2019 22:18:20 +0800
Message-Id: <20190909141823.8638-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909141823.8638-1-changbin.du@gmail.com>
References: <20190909141823.8638-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are both memory debug options to debug kernel stack issues.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1385e17122a1..ce545bb80ea2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -652,6 +652,18 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
+config SCHED_STACK_END_CHECK
+	bool "Detect stack corruption on calls to schedule()"
+	depends on DEBUG_KERNEL
+	default n
+	help
+	  This option checks for a stack overrun on calls to schedule().
+	  If the stack end location is found to be over written always panic as
+	  the content of the corrupted region can no longer be trusted.
+	  This is to ensure no erroneous behaviour occurs which could result in
+	  data corruption or a sporadic crash at a later stage once the region
+	  is examined. The runtime overhead introduced is minimal.
+
 config DEBUG_VM
 	bool "Debug VM"
 	depends on DEBUG_KERNEL
@@ -1005,18 +1017,6 @@ config SCHEDSTATS
 	  application, you can say N to avoid the very slight overhead
 	  this adds.
 
-config SCHED_STACK_END_CHECK
-	bool "Detect stack corruption on calls to schedule()"
-	depends on DEBUG_KERNEL
-	default n
-	help
-	  This option checks for a stack overrun on calls to schedule().
-	  If the stack end location is found to be over written always panic as
-	  the content of the corrupted region can no longer be trusted.
-	  This is to ensure no erroneous behaviour occurs which could result in
-	  data corruption or a sporadic crash at a later stage once the region
-	  is examined. The runtime overhead introduced is minimal.
-
 config DEBUG_TIMEKEEPING
 	bool "Enable extra timekeeping sanity checking"
 	help
-- 
2.20.1

