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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933FBC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697B421479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJs3m3qd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394504AbfIHB3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 21:29:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36041 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394266AbfIHB2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 21:28:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so6935086pfr.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O2nzQoHy+l7jUofL0Y45RwKho+YZHgAAMDyAyNEBkMI=;
        b=UJs3m3qdIq4hj2qvX7b+Aw+JhGOE0CDpArDgCy+kmR8BZh5x6AekQaZMvl/8A3+xVZ
         pzU2Vx1RUzzDRAXQ0fQ6A25JFjkqomEIYCwxtJHSkLhglRSLyYAf8REwuH4DXBbOM6wH
         EFt6ZUnoflN0zVSaJ+vNmNBeDwCchsNzzATah+vJjHYMurTWbVbqD9wUGHp1b0pP2heK
         yxrTD6a+Bxa1+l1ArWkFNuIRZNJzYt72jsjP2LZnJ0Iquw34+aQLLq1Xn5UZfmOuWWtM
         ptVQJIQCAZplfFGiLSRX0xQEzAuY910+6QVu9Lhh2LdKKYZWyCQJ2S/y+Ko4ablVAhqG
         4QOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2nzQoHy+l7jUofL0Y45RwKho+YZHgAAMDyAyNEBkMI=;
        b=LILNMIjZMwnRFSbTBs03Ibd5g3r2Qr6dbw/NVGRfSxozPY8JIJZeqvlF/5puilyKLG
         6ea3CfqVu7PM6Q+bRyVAG1GM8uFdjOEz5TisRdE4GPtWBQO8wkJkzAn6IhhTTrABPYSH
         vaKFYh/7HQanW+wFuKa7eq7vQkV5MLF9gFSM6Z/5sudUvcRV52dT5z0+tX5VHDjCXC4l
         OGF5xtm4pnQqJBQbm+hZ+oFOpC9qLCKdN2jAU7dLfgAyXmUTmkwPHMyjGXxpu9BtqKY8
         MzwcUZ/a1/rnnyQxgMvzlWAayC2xoiJG6Pu74Fk3LxYTTN3uJ4R+FD+igsuWC/ABSYEu
         rcyA==
X-Gm-Message-State: APjAAAUcwpcGWG508pC9wPAvgK1/Hx9NqgomdpSmXv7IyZAcg3uw8aug
        ET/n+cOOwG9v/eYhe01/2qtVx8IlyVE=
X-Google-Smtp-Source: APXvYqwxZhJLuMsCrZHWaCfsiWzeon3pPKzLWpBCXehdiwuBm/OIo1MoL0nFi06XbeSR4OPaQH7Vow==
X-Received: by 2002:a65:5188:: with SMTP id h8mr14877536pgq.294.1567906133217;
        Sat, 07 Sep 2019 18:28:53 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id s1sm18367884pjs.31.2019.09.07.18.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 18:28:52 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 8/8] kconfig/hacking: Move DEBUG_BUGVERBOSE to 'printk and dmesg options'
Date:   Sun,  8 Sep 2019 09:28:00 +0800
Message-Id: <20190908012800.12979-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908012800.12979-1-changbin.du@gmail.com>
References: <20190908012800.12979-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think DEBUG_BUGVERBOSE is a dmesg option which gives more debug info
to dmesg.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 740ada6744f6..bb82a02f6172 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -164,6 +164,15 @@ config DYNAMIC_DEBUG
 	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
 	  information.
 
+config DEBUG_BUGVERBOSE
+	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EXPERT
+	depends on BUG && (GENERIC_BUG || HAVE_DEBUG_BUGVERBOSE)
+	default y
+	help
+	  Say Y here to make BUG() panics output the file name and line number
+	  of the BUG call as well as the EIP and oops trace.  This aids
+	  debugging but costs about 70-100K of memory.
+
 endmenu # "printk and dmesg options"
 
 menu "Compile-time checks and compiler options"
@@ -1322,15 +1331,6 @@ config DEBUG_KOBJECT_RELEASE
 config HAVE_DEBUG_BUGVERBOSE
 	bool
 
-config DEBUG_BUGVERBOSE
-	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EXPERT
-	depends on BUG && (GENERIC_BUG || HAVE_DEBUG_BUGVERBOSE)
-	default y
-	help
-	  Say Y here to make BUG() panics output the file name and line number
-	  of the BUG call as well as the EIP and oops trace.  This aids
-	  debugging but costs about 70-100K of memory.
-
 menu "Debug kernel data structures"
 
 config DEBUG_LIST
-- 
2.20.1

