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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36955C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5FD21744
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGEx47XW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394455AbfIHB2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 21:28:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44731 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394082AbfIHB2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 21:28:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so6898330pfn.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 18:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ar86Cyz5SwUw+B8doHknhwxtbVf42vWWmGm4XzgCe58=;
        b=TGEx47XWWVjXTfsTvIQFa/BjQlAOqojw26Yiy5aRdaTijkJvPMe2fIUgvW7Q+9/dF4
         +zYrdr2HpPoarmFOOp7xTW6PlcCLg4o6ILEi4+Pmij+4NEs82/pgZMBWyuTJSWzOVbrf
         M7SOiy1dd4KAvB1hhuIltouoMmsekfPb5Lf1mdoO5OA6vx42/I//6hrO84Myd1+SlGz6
         ISRueC/LpoPVyI+conB2ZfVbC12khxSvLxrnRc+o+fK1syUbMEQnylnPMeO0mv8NmJ9R
         co3sfIPvjoCQQWvFohIXVjJFVIsURN9/y+ZmzJbYut8ozu/lvqv2NzMnyHBBkoQqvpDD
         dgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ar86Cyz5SwUw+B8doHknhwxtbVf42vWWmGm4XzgCe58=;
        b=TdiuGIlVHixIgQuzEWyx3aJ4MYhUNGmTLvcVqv+1+z/R/3aCoGXkkRYlEY6DMS5Awg
         UFRdE2Ub6h8ZVYOcuk1O77nRiSObpBe5oujfIWrK+WpU0v0dzAduNUCeYAtek1/EclXM
         b1XFHHDka0sVIdRYTMv62MW8ZUWJEab0Mg99Z3xF40TdhJiBFqTO0YYtPOIr0DIw35RZ
         tc4GyTBPfZly54HY55uJyzZkjxDsQOXNaIWJ7bhNQ10Unm0WNE3IcLCnEhYECPb3+Sf9
         nuTbO8YEPVeLFZeX58pdDUPBjINq1LWvtWLSxfWJtMblabpGPcqOsDAYvX+M0wtNp3B1
         5ELw==
X-Gm-Message-State: APjAAAXB139ya3qmYjogUhWC11TtzrMD3jTtUpxGHk7pjEqlJ/kRwURQ
        bl00hzF5BiE+YymY/ykItH8=
X-Google-Smtp-Source: APXvYqxkCmI1RFXMXCQZ+ZBx2JLNWDVN5p9K09vAznLtIMmJhOGNOd2akSxxMPNb+97QbrIkxHefYg==
X-Received: by 2002:a65:6401:: with SMTP id a1mr14943446pgv.42.1567906129208;
        Sat, 07 Sep 2019 18:28:49 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id s1sm18367884pjs.31.2019.09.07.18.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 18:28:48 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 7/8] kconfig/hacking: Create a submenu for scheduler debugging options
Date:   Sun,  8 Sep 2019 09:27:59 +0800
Message-Id: <20190908012800.12979-8-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908012800.12979-1-changbin.du@gmail.com>
References: <20190908012800.12979-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a submenu 'Scheduler Debugging' for scheduler debugging options.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 458d2a4435a4..740ada6744f6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -990,6 +990,8 @@ config WQ_WATCHDOG
 
 endmenu # "Debug lockups and hangs"
 
+menu "Scheduler Debugging"
+
 config SCHED_DEBUG
 	bool "Collect scheduler debugging info"
 	depends on DEBUG_KERNEL && PROC_FS
@@ -1016,6 +1018,8 @@ config SCHEDSTATS
 	  application, you can say N to avoid the very slight overhead
 	  this adds.
 
+endmenu
+
 config DEBUG_TIMEKEEPING
 	bool "Enable extra timekeeping sanity checking"
 	help
-- 
2.20.1

