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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4E8C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFDD2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyeNYVIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387799AbfIIOp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:45:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42591 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfIIOpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:45:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id w22so9291780pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZjQZhq0VIl7AW/Jucj8979nUOERXvLfdaUdgqq8/W+c=;
        b=UyeNYVIFpnr/2cmDTnQsMbB3xwTEnmqg5DcFQkl6hx8l4IRBW1en9NJuNHUhsZUkj6
         gcfdBnw3gvRiQmj2RhjAlleYeyqBMfLK7neNwKe4L3IyAAy/hQnngFNZES79mlVYsq3G
         iQ1Tk2Z8MWk/nzHtEYtE/9THg7xmG9g6Cb/FiPizZfk5Ef3jEYMHFVEpo4Uqj1zniNpn
         Yi94loYZgNQ8/oF5/a3QGfrR1G0l0QxrlJo3K+l4RROQrSxZBUljJN1TX7S/FeHutREQ
         Scx4F7N6P/kD84P5QeV99NIyu7owaC4eUee6+XjMudA5FFEBxnEsLdhGSG7JAAq2JSeR
         ntdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZjQZhq0VIl7AW/Jucj8979nUOERXvLfdaUdgqq8/W+c=;
        b=F026ORrOdXhP6uI/vlK423hfLlmtmZc8Y21qFjfydXTcbMykyEF+XdJfXScPHeedo7
         6TDGMZy3o7m9WGSjscfELZ06QUbfo4jdhx1Ed5ifrHoP/v5NQF9SQjRpt1A67Nw/m/ul
         XAvvDZ4WqsI3CurDzG2UbQ6KY56kfXl0Y9ZYhBZzzDEK3tEJ8gyyxaKgm/mhBDhsIBhq
         6p5vIfbSrktWP60hb/Cv3Llr9+pMPmMLe0DEXosx6wZZLn/Jj/HlRTQDSgdnw9N75c35
         rRm3HQHcDFOQfi2htU03I3VOnisfoS3vyKXjH88Q/9mqoN4FYtSyBLuJGJUYUswCo5mS
         KWvA==
X-Gm-Message-State: APjAAAXSir0m4sf8YjCUClX1TRSTtGn2PJVDs9btITHzRi0YJIqeOmoN
        9khsRC19LsZYbRGir//Ypx0=
X-Google-Smtp-Source: APXvYqyg/itcZwCu6jhYtfOKMXiN5sjCar1KBU6sPrG3x9CekTzQp+CMOfHIT+OrmQ5LXKXkan2YxQ==
X-Received: by 2002:a62:4d41:: with SMTP id a62mr28156597pfb.155.1568040323219;
        Mon, 09 Sep 2019 07:45:23 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id t9sm15334693pgj.89.2019.09.09.07.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:45:22 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 3/9] hacking: Group kernel data structures debugging together
Date:   Mon,  9 Sep 2019 22:44:47 +0800
Message-Id: <20190909144453.3520-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909144453.3520-1-changbin.du@gmail.com>
References: <20190909144453.3520-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group these similar runtime data structures verification options together.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cc4d8e71ae81..92271898b029 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1375,6 +1375,8 @@ config DEBUG_BUGVERBOSE
 	  of the BUG call as well as the EIP and oops trace.  This aids
 	  debugging but costs about 70-100K of memory.
 
+menu "Debug kernel data structures"
+
 config DEBUG_LIST
 	bool "Debug linked list manipulation"
 	depends on DEBUG_KERNEL || BUG_ON_DATA_CORRUPTION
@@ -1414,6 +1416,18 @@ config DEBUG_NOTIFIERS
 	  This is a relatively cheap check but if you care about maximum
 	  performance, say N.
 
+config BUG_ON_DATA_CORRUPTION
+	bool "Trigger a BUG when data corruption is detected"
+	select DEBUG_LIST
+	help
+	  Select this option if the kernel should BUG when it encounters
+	  data corruption in kernel memory structures when they get checked
+	  for validity.
+
+	  If unsure, say N.
+
+endmenu
+
 config DEBUG_CREDENTIALS
 	bool "Debug credential management"
 	depends on DEBUG_KERNEL
@@ -2107,16 +2121,6 @@ config MEMTEST
 	        memtest=17, mean do 17 test patterns.
 	  If you are unsure how to answer this question, answer N.
 
-config BUG_ON_DATA_CORRUPTION
-	bool "Trigger a BUG when data corruption is detected"
-	select DEBUG_LIST
-	help
-	  Select this option if the kernel should BUG when it encounters
-	  data corruption in kernel memory structures when they get checked
-	  for validity.
-
-	  If unsure, say N.
-
 source "samples/Kconfig"
 
 config ARCH_HAS_DEVMEM_IS_ALLOWED
-- 
2.20.1

