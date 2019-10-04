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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC05C32792
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849C020865
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGvh8u7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbfJDBU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:20:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35482 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732736AbfJDBUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:20:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so4040369wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 18:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8iUxscWVzYKCJ6EmdYRKBXpJWznBbiucsnTojLR55Zo=;
        b=ZGvh8u7e/KG83ysu8hxkekIUxpluUZwj15OzFONVw0XKrxcv+tl3c8UiemHFgRJnvZ
         rsBZW91eazMr8vQx5EOeiKYXGYAZLr/4kqViUNb+fraquDg7VQOZQb6oBKcjzcXdDfEJ
         z5YJCE6ry1gAYcVTsnGA0H91EHD70ZkGXD6vKe0P6OBeSqJcSvOVX4oag/jzWNk9Q4jP
         f7HEmIJEadzI2vLzDvm4xfWQrf0mk/mpHeAbE/pIbycmakvaWWaePSjJB+5zjlI3wsMd
         llO4euW/CnMSNf6gmLCaxCi15A8s116vflnIgoIeHRtw4sYv2UDim2Cal/63C4gUEQ0N
         mlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8iUxscWVzYKCJ6EmdYRKBXpJWznBbiucsnTojLR55Zo=;
        b=Ook+YnCNJ5cCuy2m8EPkFyKKbCMLjufzY83jzIzJih6CctUPWjsSMeM+EFOp3coUBj
         lj5eFWu/Da6ejYMhVlCBYuMmhAcHzhrko2sDM9k/gZ3ZM4tfxm6cFXLlIGnkIi0o+XsE
         oppNIsi5LvaEahs68twsWR9RK4SEmr95kLPKSnNZH+vZgwHuBy30P8wK3Bmi5Ak4fTX+
         MQKMGZjKIfUzdRp79poR/yZiJnsTKvZ8TNxMVP38SHRhDiIPOotFBVkQB0VNm8dXgoAy
         1XmDtPtOHENhaN01/zMK9Jm44Tb8HVjQ2WT02yymybEapZlpdeYEIb5E9ox3W6Lmrpim
         s0rw==
X-Gm-Message-State: APjAAAWDsAfG5w5mYTKtDJTq1DW/OmM7LvqBk3SdnVDGFdXyjyXjNEtd
        j3eOIFUOdd4B5sC8J/CDs5/+ZP3deFQTKQ==
X-Google-Smtp-Source: APXvYqwUNSkOaE0y04oXXX0RtSS2KCx76xNBoIKY19qdCVF/c8gpH92t890vo4LQb09YyYMc0SqsSA==
X-Received: by 2002:a05:600c:2412:: with SMTP id 18mr8525376wmp.128.1570152052324;
        Thu, 03 Oct 2019 18:20:52 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id a4sm4097404wmm.10.2019.10.03.18.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 18:20:51 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [RESEND PATCH v3 7/9] hacking: Create a submenu for scheduler debugging options
Date:   Fri,  4 Oct 2019 09:20:08 +0800
Message-Id: <20191004012010.11287-8-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004012010.11287-1-changbin.du@gmail.com>
References: <20191004012010.11287-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a submenu 'Scheduler Debugging' for scheduler debugging options.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 lib/Kconfig.debug | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2cf52b3b5726..6db178071743 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -973,6 +973,8 @@ config WQ_WATCHDOG
 
 endmenu # "Debug lockups and hangs"
 
+menu "Scheduler Debugging"
+
 config SCHED_DEBUG
 	bool "Collect scheduler debugging info"
 	depends on DEBUG_KERNEL && PROC_FS
@@ -999,6 +1001,8 @@ config SCHEDSTATS
 	  application, you can say N to avoid the very slight overhead
 	  this adds.
 
+endmenu
+
 config DEBUG_TIMEKEEPING
 	bool "Enable extra timekeeping sanity checking"
 	help
-- 
2.20.1

