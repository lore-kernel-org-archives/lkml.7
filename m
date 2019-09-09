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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C32C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30101218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmaWxaOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbfIIOpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:45:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37557 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbfIIOpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:45:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so6553053pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkCN1rfxn0GvijT8v/3iWlL1If0T/0iY7m3TA87+hZk=;
        b=SmaWxaOheRds6jY4/n6Jl+EIe/ESld5kZ8OYWOyvgUAt4uuwUIWlN5itBbfeKDRrht
         OH7s7LPXrkNQDcUDqe7nl1HBmSlG5PZQ3taCTwifaQ9zDbre8FfAeMJwk7qDQKKUL0m1
         NvaIm6e8b4y78gK+ocOLPMl6CSpE34hKZPTX0w6wOdMFs0OOyAYWCbFO3k9eYdcZmdMM
         mkZ6UrKJoFgoDoWCjX/KpQaoJpAbuRXuulL7iAtX8uK4lQlqBHh8usMrEbQs0BnAujWW
         DyZSh7u0yTAIzKVxERy9UuHo0PoFceya1RdduSjVPBBEnzaD5xM8LNTvBt+3u6W5CF8K
         aa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkCN1rfxn0GvijT8v/3iWlL1If0T/0iY7m3TA87+hZk=;
        b=o1qgrxysr5vniDpYGITp5HoesdXP1FQIvy7zK6mfudOP9wPIPZ3E0Bu1IIF58e+Aqr
         AgjqSE/neYWTBu7mn8HwFCirVJrbHMfIZ6B/Nny/xVnyYhm8eL8xJFmOJR+Z9bhdouFW
         uov7wqL5VME2rV1Cu44xS/j5z1w6ujykjF0T5vskhukbMmZ3nTBDRZNPxOUjwxKFAAxY
         RiNIYik3ZCKSU7Z7sM3L71yp8Q+sJhX4c63oiT1spavuwCJwJAed6zg0FFsVbz2ik5gC
         zQ1RR1yZzq/QjF6NxEsO+e0chKmf/Z+1W7nSyImYCCTA33VXyyiymwP8ixWUaqi/7Crl
         V6Nw==
X-Gm-Message-State: APjAAAVsZaPKgylERMWHMFJdguYvQTWLgVEsT4ifnEce0PW3l4pRd6e5
        eWzQZwQTO8cfFEf24pEQ8CU=
X-Google-Smtp-Source: APXvYqyYr4zbh2mMpQEpY/GAyqtFEDCIYmVtzNOeAO4RuVLgLViOPin3dw0I+z5QDCyTiQnftshPVg==
X-Received: by 2002:a63:5b23:: with SMTP id p35mr21569791pgb.366.1568040337867;
        Mon, 09 Sep 2019 07:45:37 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id t9sm15334693pgj.89.2019.09.09.07.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:45:37 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 6/9] hacking: Move SCHED_STACK_END_CHECK after DEBUG_STACK_USAGE
Date:   Mon,  9 Sep 2019 22:44:50 +0800
Message-Id: <20190909144453.3520-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909144453.3520-1-changbin.du@gmail.com>
References: <20190909144453.3520-1-changbin.du@gmail.com>
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

