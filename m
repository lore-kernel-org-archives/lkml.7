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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E394DC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6542086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw4j3wQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbfIIOpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:45:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44528 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731616AbfIIOpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:45:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so7946230pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SLkwCl+YmpuBIlfaQTzGPq6Ho+2QR3zhJrCiroUra5k=;
        b=lw4j3wQ7EWHM88rWj+ekEgwheEYvNKN0UmC9Cl5rVYO4bdj7N2WpkhFsCRe93bgA9/
         mJdOUaMqvANG9rXH/WSomPtjEc10f+BkjLEZBHN++kuQe4WO/7KFmsMLVy9HmIPIpRkn
         DlYuOt4t7pZ8E7DcfYEy5HIU62Yttbt2V0DQPl1mzoBSe5HJWT85uvod6wvmiEpvBZEZ
         Ubd19n2um2L/KfLnIPrul5ttcKSs0JGTQY5LHvSA3IEIakmqVFG7NOQGNBWxuqOcOfZt
         CBhNggqCG92++tVi48zb+EYMcBuXuNcKrtHJnjVR9rdyd0TWuuy4Rdqk1XQRAzv1yXD0
         ZBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLkwCl+YmpuBIlfaQTzGPq6Ho+2QR3zhJrCiroUra5k=;
        b=SKKfphxm7NsJNs7wRPcTQSgfls3pDfMe1jJdPV1PXtobgOUMxFAicLHwCSHjJVB+f+
         InAKgwZr/lkh/E8BvLRpdake1ZZ9N5GZgVD1y2Rrj9Ci3ixTVx4uzBPdOH7pGkamd6Ao
         g4W7TOb/7bu+yk/eDA4vXVb/0fZiI5mVt6r4wIsmbldMEr1jMTCSUyowqf4E9pQd55X1
         vX+7BhatHXbjFcOPmKHUPeEGjZLqjKrdbsuEBW1RLPyP/Phh3jMxN+4rc77bHYJ9XyZn
         /3/kqNGvFC74BolD7q65G9d/psb72+PteClmMoJXP2ef35uCHJWMmnWVeP2HFP7Ylaab
         GP7g==
X-Gm-Message-State: APjAAAV4iI5fFQjGAlirvLqRKNOr6p+XHqVpZn1Ivy6RGbilSnHnxQ6K
        +JLPWv0uuytz5PDrqdj4QzA=
X-Google-Smtp-Source: APXvYqwY9JAbqXjMF9ZzAhE1ZtBIFpsGYOCrK3PU1eScLdryNEtCLnVanEvQVBIQ/bnoYQjZyTZQag==
X-Received: by 2002:a17:90b:f0a:: with SMTP id br10mr15940809pjb.93.1568040342778;
        Mon, 09 Sep 2019 07:45:42 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id t9sm15334693pgj.89.2019.09.09.07.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:45:42 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 7/9] hacking: Create a submenu for scheduler debugging options
Date:   Mon,  9 Sep 2019 22:44:51 +0800
Message-Id: <20190909144453.3520-8-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909144453.3520-1-changbin.du@gmail.com>
References: <20190909144453.3520-1-changbin.du@gmail.com>
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
index ce545bb80ea2..ce891713c914 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -991,6 +991,8 @@ config WQ_WATCHDOG
 
 endmenu # "Debug lockups and hangs"
 
+menu "Scheduler Debugging"
+
 config SCHED_DEBUG
 	bool "Collect scheduler debugging info"
 	depends on DEBUG_KERNEL && PROC_FS
@@ -1017,6 +1019,8 @@ config SCHEDSTATS
 	  application, you can say N to avoid the very slight overhead
 	  this adds.
 
+endmenu
+
 config DEBUG_TIMEKEEPING
 	bool "Enable extra timekeeping sanity checking"
 	help
-- 
2.20.1

