Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC37C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F0F21744
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCPUEUcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394414AbfIHB2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 21:28:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44725 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394060AbfIHB2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 21:28:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so6898272pfn.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 18:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OhHba7L39wIQzRO0F9hHiD5ovPOWn11epb1n13H1/3A=;
        b=hCPUEUcR7UE2updgCr6ylGPvN8vEmMacVAzDaWa7yO39fjmtiEyN/xy1ykmyH9UThy
         mJ2lN04eC3mtBh/IByRfoT99jmeFaaAsxXmWdpujXrwXaJaaPKHfcprsPRwCkpj+Wkzh
         2BlNxGneZo4BBcGq0M3xqNmt7JlRTn77zdgCdPkIMrMmvUuoXwwEbp51F8VH3vVSK7uf
         wDebogfrWbsDbmud+/ZhTcYv1hyyVGC6RALkZPHp1mCF9+dZO1xv++u5Zxf7o1of5jaJ
         bVBg8/kJPnJ52TyuS7AswLG5t2VeToE3nUhMUI2F2l3RQ+m9TOn3JrANwOb0Raq08TMW
         nXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OhHba7L39wIQzRO0F9hHiD5ovPOWn11epb1n13H1/3A=;
        b=FKhQswmJyy8sXt+/bO7Ub7aXaZoxkHodSMlU9cHvFeZxJDRwoyUGP1kN6GClvFlvOE
         /1lxkHpxIP3MADiwuuDWK6I2Tw09Y4T3qikNGXBghNl4H00j7D08jGJaz2Sn0bgi2hbu
         qQxqkoXjxH6rqLg2kTxt9nG8A530wJCzlYnT/qv2uWSytQum/jS3Lv4/JtzeQ4P+7Ahl
         LRKVWVHNLctgMYK35fBgVTaVEIrnF3Mr3fnyQWu/Y/jppYg/cftRdutaqMtwCuoP4Kga
         3Q+gb+gv3oPRt2aTCMZGV6FKhgMT/4Tdoje7i8r9+zd89x6mMcxuspyECX51X3jAtC0C
         o99A==
X-Gm-Message-State: APjAAAXFUKhqjTb51QgU31abDW5HJnQykhNN9/gBBNWTwkGQljh5yJPH
        KvJqPyNiOccN6lzd4WgheE4=
X-Google-Smtp-Source: APXvYqx6J5TUe9vxDpqHgoQBDrzA/4bD+yb1nP2jnnK9EkuT32LEeFltTvH9J/NvONSwCVqeEhIp7A==
X-Received: by 2002:aa7:9735:: with SMTP id k21mr20085064pfg.174.1567906125341;
        Sat, 07 Sep 2019 18:28:45 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id s1sm18367884pjs.31.2019.09.07.18.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 18:28:44 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 6/8] kconfig/hacking: Move SCHED_STACK_END_CHECK after DEBUG_STACK_USAGE
Date:   Sun,  8 Sep 2019 09:27:58 +0800
Message-Id: <20190908012800.12979-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908012800.12979-1-changbin.du@gmail.com>
References: <20190908012800.12979-1-changbin.du@gmail.com>
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
index 99c6dbd64ce7..458d2a4435a4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -651,6 +651,18 @@ config DEBUG_STACK_USAGE
 
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
@@ -1004,18 +1016,6 @@ config SCHEDSTATS
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

