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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3BFC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99AF206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDgCrBJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfIIOT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:19:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40058 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732116AbfIIOTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:19:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so9247815pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=26Wst1tOghrDUnY62Gv01qINYsQrhb3q0IbTkiTmqqM=;
        b=uDgCrBJ8MVKrIJnLVcX6OI2xCnSlaOKwBS0DSWEhI6CUBa93RmqQTvPt7XgnLSveB3
         7oLwbehofSn81Eqmdkn69+iqm8nxTQ/fh6mDVvWzlmNnqkx3Kyn/g3Xo9SGRD51zWJYu
         8+DfMUGX3DN0jRMSzeAqntZ/HCCH1mOOZACEsbT1kibLUXi6qbNaDoyI8Oyke2h00GeE
         cJYn9BNcRKNUJ4ktDjoajQAXj3zexp3l44Sx0hJ00zRb/4ihTYszssdJf/F28XtCbp2v
         EZtMO49bblr+anhM8nYxPoWfGV4UC6Vha1MjwFzb/O5z8e5yeYGaHYzBQvR9FSAVGGnA
         fmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26Wst1tOghrDUnY62Gv01qINYsQrhb3q0IbTkiTmqqM=;
        b=GCiukuPBMMCumFjvb1Xvjcx/knzds5y7qWGsNw8IfC9i6GTSXGqitUrVqFaTRPq0L3
         0AAYTRmLmcCrLxayMua5RdcW3kbM3x2ZWspGtTADB5+stEChqlKZj8WxXTqOEnd0nz7f
         6XCPtBdLSdlAjVOnJw9BjzcqV8hmq3AndbqNyIX/+48G27bBU9EFKS/q4UJbXfwMVJZv
         RmKKENBG1MScdw2RGmBisoGtQpW3143wfLzs1BlrT480eu52MAQK/KD95s6VALIl0/zR
         O9t526JL165o342i7TyJys3jNHoVUqmpSgwuexE5MV+H7BxmIbdb1/QqsW+m8bgPiatk
         042g==
X-Gm-Message-State: APjAAAW8+ZEzC4RYW7nlf1Ca4FL6IjV2nL6VE/uhUGMi++a2GCD+ch/C
        aSnOaIjgYJEPcL1iQKh226k=
X-Google-Smtp-Source: APXvYqzZVjw/bj3xu3E4R9KuJmmaHaRN5jsb+5yhdPs2IhUNbwNVcPJYnTMhEKaKM/jfzKb67DLD9A==
X-Received: by 2002:aa7:82d9:: with SMTP id f25mr17667823pfn.117.1568038761846;
        Mon, 09 Sep 2019 07:19:21 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id w6sm34574695pfw.84.2019.09.09.07.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:19:21 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 8/9] kconfig/hacking: Move DEBUG_BUGVERBOSE to 'printk and dmesg options'
Date:   Mon,  9 Sep 2019 22:18:22 +0800
Message-Id: <20190909141823.8638-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909141823.8638-1-changbin.du@gmail.com>
References: <20190909141823.8638-1-changbin.du@gmail.com>
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
index ce891713c914..ceefe0c1e78b 100644
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
@@ -1323,15 +1332,6 @@ config DEBUG_KOBJECT_RELEASE
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

