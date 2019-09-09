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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B2EC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430F9206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txgs9ojr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbfIIOTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:19:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42934 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfIIOTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:19:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id w22so9245326pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SLkwCl+YmpuBIlfaQTzGPq6Ho+2QR3zhJrCiroUra5k=;
        b=txgs9ojr9P5owVAhHlKESpWcIO60s8DwW5WWTBJPk/RCOmWJAqjgbC/jvgs1QRHiuV
         /cD51WrbWrM0h2dI2CYibOVK1C5ZZJwR0Va9PhqNXMlOR7Cew/ZPomcHrFPARTZW7eR7
         ntGK7VjgyvYdWb0awl1buYFMU026F53/6Bk+KlhSJ75reVXnGoY4Uy/f+ZDojuaDtZth
         cWu8Q3dJ1vmO62t4zM9v3VZGK9uBDCKR9XejkpNTZnp6YlfL8wtnLfUhyFywZRB3bz/T
         aMfqpz4Q28x4RqDAJnltpI0uveluPgS27aB6VGkfYFwfkXlyfLVEzRvKG5jPtdbQNqep
         cSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLkwCl+YmpuBIlfaQTzGPq6Ho+2QR3zhJrCiroUra5k=;
        b=gb4rZD9QeEaNezdR2jogD7kKgSizAnK41eGxTxquds1mZ6szQlv9T2UWNtXMjRMPSu
         F2A9TTxe6ejseIR6DSyTGBKTB4CoEcAHJsam76AgIsz8558B028ZkqdcvC9yAS9hQL31
         xa/cfomskQfH024Jq0j7Sn5sbi2tPAb4cosRToSIN3ZxTblbtVwEcVUXgfSnj+PxdUP2
         iZzcN2BIwBfoZX5AYrdDHtH44w+FTghs3oUqOQudxbeM9Vl6YmZox4y5IrRaiQE2Ck7/
         hdlxesm/DFDkf5aPKPc4rqWVLN86d+LKqiIu2bXmWyBWl6HgLN33ond2xndg3B3AEkGI
         70BA==
X-Gm-Message-State: APjAAAWl9QDvMGiAlnNg3dDSRi49jm/Gpn8dtRs2e+MhrHPK7rTexE3I
        4VO3R9V8obEJDcRaUL7rZhk=
X-Google-Smtp-Source: APXvYqxDQy3r56uB0kyZEMb5mEb7knYttk7BhjWU5PweRZCdGzzcfCt41kcHbB6BGXpjieTdRxso7A==
X-Received: by 2002:aa7:8bc2:: with SMTP id s2mr27073479pfd.13.1568038756398;
        Mon, 09 Sep 2019 07:19:16 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id w6sm34574695pfw.84.2019.09.09.07.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:19:16 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 7/9] kconfig/hacking: Create a submenu for scheduler debugging options
Date:   Mon,  9 Sep 2019 22:18:21 +0800
Message-Id: <20190909141823.8638-8-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909141823.8638-1-changbin.du@gmail.com>
References: <20190909141823.8638-1-changbin.du@gmail.com>
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

