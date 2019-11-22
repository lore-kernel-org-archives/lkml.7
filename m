Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736FAC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4379E2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="B7JQEyBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKVW6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:58:01 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45698 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVW6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 17:58:00 -0500
Received: by mail-io1-f67.google.com with SMTP id v17so9909496iol.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 14:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99kjuSaTfqi/O4G1kyhfKCZh2c7fOK6oatEBRmcILQ8=;
        b=B7JQEyBNYP1GfiTbFxMdlna/NrN43milA+eYIgVGqzaFgJaFpveYCXriOZYZleY7H6
         VDbr0mTRD/N42M7YlMymtYO6USoYJ7dFqsKjdw9+tgexKWfR3Lvnqp5UyBy6THWlOzMy
         WDSWxznb4l3auRftRXKogDP6R6azYkLTvkqtVSDLtrN1/j2tqWhdDKttoGV4qtDtwsRh
         108Gt3dTDkh/k5dG4tliY5bZtluAg/B5JbEEzZB30m/jinBhQNBM9B49A4EGsj9Axov2
         zpjHmv+2uIgcoDaH/RE0qXyZsEv+uCoAcq3MvTwHVX0R6NZwKJpc3EzumA245/PIkexZ
         +gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99kjuSaTfqi/O4G1kyhfKCZh2c7fOK6oatEBRmcILQ8=;
        b=GlfoSiD3coFfcPCjuaN8MmmMTYXah95G6XtiMQLWFn4IopUjah5INNaOLU14arAICh
         ZGhuxZuGpZguvp5O6y1Zku/vuYLk6PuEMqAFr5O5f4PtxoHsrh29a8cm0J1L5v1rX5T3
         0zbVLUlhV2iGmbNhN4bqEVH4qtgEaVthMCokAgjWBhjIMtUmWHYaUmpZHl61uzfiIrUQ
         Ip9rmGQKD8ye7VWbJntkWxZ9U12NdvU5LODhxgk56aBDL1/ntGY0B4mjVit63LdOoyEg
         Z4vgXfP3uGdwp+LVSnIYfOVR6xwkY3B1QzGtFHaN+X1pSUsFH3Pbo4C5Pjbg8YkX+ifa
         EzCQ==
X-Gm-Message-State: APjAAAXhgIvdhBUzSJkEEFeIw/9992M/QIlnKJh1vGTVF0o3wHMVfzPB
        GxSZ5V0OAUjrj9SFzjs8mrSSUvr4Qe8=
X-Google-Smtp-Source: APXvYqycb34XtfKRGUpVDlBDfOTeyet9l4IX6fAabGzR//Fr+CRZaoeKUT1/lzsQoErO4Ytb1jHG1A==
X-Received: by 2002:a02:a798:: with SMTP id e24mr660532jaj.77.1574463479845;
        Fri, 22 Nov 2019 14:57:59 -0800 (PST)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id x9sm3277098ilp.43.2019.11.22.14.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 14:57:56 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] riscv: defconfigs: enable more debugging options
Date:   Fri, 22 Nov 2019 14:56:59 -0800
Message-Id: <20191122225659.21876-3-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.24.0.rc0
In-Reply-To: <20191122225659.21876-1-paul.walmsley@sifive.com>
References: <20191122225659.21876-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable more debugging options in the RISC-V defconfigs to help kernel
developers catch problems with patches earlier in the development
cycle.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/configs/defconfig      | 23 +++++++++++++++++++++++
 arch/riscv/configs/rv32_defconfig | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index f0710d8f50cc..e2ff95cb3390 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -101,4 +101,27 @@ CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_PAGEALLOC=y
+CONFIG_DEBUG_VM=y
+CONFIG_DEBUG_VM_PGFLAGS=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_DEBUG_PER_CPU_MAPS=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_WQ_WATCHDOG=y
+CONFIG_SCHED_STACK_END_CHECK=y
+CONFIG_DEBUG_TIMEKEEPING=y
+CONFIG_DEBUG_RT_MUTEXES=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_MUTEXES=y
+CONFIG_DEBUG_RWSEMS=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_STACKTRACE=y
+CONFIG_DEBUG_LIST=y
+CONFIG_DEBUG_PLIST=y
+CONFIG_DEBUG_SG=y
 # CONFIG_RCU_TRACE is not set
+CONFIG_RCU_EQS_DEBUG=y
+CONFIG_DEBUG_BLOCK_EXT_DEVT=y
+# CONFIG_FTRACE is not set
+# CONFIG_RUNTIME_TESTING_MENU is not set
+CONFIG_MEMTEST=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index bdec58e6c5f7..eb519407c841 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -98,4 +98,27 @@ CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_PAGEALLOC=y
+CONFIG_DEBUG_VM=y
+CONFIG_DEBUG_VM_PGFLAGS=y
+CONFIG_DEBUG_MEMORY_INIT=y
+CONFIG_DEBUG_PER_CPU_MAPS=y
+CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_WQ_WATCHDOG=y
+CONFIG_SCHED_STACK_END_CHECK=y
+CONFIG_DEBUG_TIMEKEEPING=y
+CONFIG_DEBUG_RT_MUTEXES=y
+CONFIG_DEBUG_SPINLOCK=y
+CONFIG_DEBUG_MUTEXES=y
+CONFIG_DEBUG_RWSEMS=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_STACKTRACE=y
+CONFIG_DEBUG_LIST=y
+CONFIG_DEBUG_PLIST=y
+CONFIG_DEBUG_SG=y
 # CONFIG_RCU_TRACE is not set
+CONFIG_RCU_EQS_DEBUG=y
+CONFIG_DEBUG_BLOCK_EXT_DEVT=y
+# CONFIG_FTRACE is not set
+# CONFIG_RUNTIME_TESTING_MENU is not set
+CONFIG_MEMTEST=y
-- 
2.24.0.rc0

