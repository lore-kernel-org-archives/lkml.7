Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EABC32792
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDBB20865
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+uf9Arl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbfJDBUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:20:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37962 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731802AbfJDBUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:20:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id w12so4956349wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 18:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2nfCI4DA9wV2tIhjB1SRKPeFrhCgyxQKrnAmIfWbWUw=;
        b=R+uf9Arl5tqU6fFHps6Y7jzlnm+7fQTndOuE2GBLSWy2Ebd2EsiIw1mEvxuwFzX10w
         hsEjozzn5c6pA/0lsC2rWMQ1hwaJtCU+nbzggmVVhDfRSnYNqh8oBlhTgn45xROUDujZ
         5JQYjSkY/c3uHvxblvfQQHzl0ep2ppzweS6JAGOwp8dBl2JT8sJxKhnoFNiagQvHVq92
         RqXexJLZZgE56SmNBc1vyEb1vRPNNq9zr+ppGGdUp/V8GuhjoNcaTo0OeRTiUC1heP8J
         zM8EuMxrKHFZ6gVRhmIPet8WipZxYscuBlPt/CvuFSanv5gqWOrmEhDHgzg0Q8TwVZdo
         /ecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2nfCI4DA9wV2tIhjB1SRKPeFrhCgyxQKrnAmIfWbWUw=;
        b=e7m9EMmPPXAG+UpAbBbWO/wf6VQ4sUfF85h3/ClolUriNX/Y+ZNqNQVUA90DdjprhF
         ai19eVQQq+6DkbqRxtoHtMK1GOZlrqQSy87/U3UJYDwC48F8vqeIpgrMkjB68EYLrgQQ
         Ttfd7YG8DYudMCOUvfjS34EZT53mLtA6tNqWNoxlg0U5TcbtVOrluqkfUDs4JOlpqrxN
         UDGco9rnEB55WkpkPp2LJlluYldy78rCvZSySG9+YQB5XwoyHRjDomKYjFGVNsubP82f
         Lrwi4Y8yIzBM6uOixVFlbJ5VXlb+7I1AQAwTK+xAFKOMvA8h9FqT8sTv1lgGzWrxstUz
         r+bg==
X-Gm-Message-State: APjAAAWC+4LY06trC8X3WE/bdx4Na7I3EXrqeVXrcK5GgkguFfOJkVv/
        mlerVd+OxbpTqUKwTkjoz+U=
X-Google-Smtp-Source: APXvYqyHNGrP+Rf0/Kt3TU8drIvax02uJHo/CDAcFnyZ6eL1TaTv4Tv0Pt6Q02JzP93HovBM1NLkSw==
X-Received: by 2002:adf:e888:: with SMTP id d8mr8797221wrm.337.1570152036938;
        Thu, 03 Oct 2019 18:20:36 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id a4sm4097404wmm.10.2019.10.03.18.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 18:20:36 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [RESEND PATCH v3 3/9] hacking: Group kernel data structures debugging together
Date:   Fri,  4 Oct 2019 09:20:04 +0800
Message-Id: <20191004012010.11287-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004012010.11287-1-changbin.du@gmail.com>
References: <20191004012010.11287-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group these similar runtime data structures verification options together.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 lib/Kconfig.debug | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index b29a486db38b..f1de5e79573b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1357,6 +1357,8 @@ config DEBUG_BUGVERBOSE
 	  of the BUG call as well as the EIP and oops trace.  This aids
 	  debugging but costs about 70-100K of memory.
 
+menu "Debug kernel data structures"
+
 config DEBUG_LIST
 	bool "Debug linked list manipulation"
 	depends on DEBUG_KERNEL || BUG_ON_DATA_CORRUPTION
@@ -1396,6 +1398,18 @@ config DEBUG_NOTIFIERS
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
@@ -2091,16 +2105,6 @@ config MEMTEST
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

