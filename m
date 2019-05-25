Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6428C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB122085A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XxUXDopv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfEYLxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 07:53:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38857 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfEYLxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 07:53:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4PBr6ZV669446
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 25 May 2019 04:53:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4PBr6ZV669446
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558785187;
        bh=KiMKmTiAuhosDMsfX0eRtwIsbNvqHBTWySDbVzObIsw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XxUXDopvTJ2/NYyhD1BhhOgJXiDoi07O8P7JDF8UW4egCO5ng3l2EB9bY83U3X4kx
         P1jmwOuM0rWcqLaK8vkYvM2Viy+9/b3gDqaO9fODpAGDLmBegZ6DHX63ZizhIwysMN
         GRNbBTwjMY7eZQ6hrywQ186iVJZmcxOwIFQmOnP89VJGkoCgvpEGDiPmaQVVJJHyo/
         L15/1jTEEv7zeSM5vj97iBP/8r2z1yRkKcbnRS5Z2L85xB3ps9FznliJD4nmZ47TUg
         J3BaLLGkO+kUZUZPUNvrAziLpQueHzdYAnDImTq6jm5tArUVC25LVtLT4vlEeydShj
         f84+vlfs0y0jg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4PBr504669443;
        Sat, 25 May 2019 04:53:05 -0700
Date:   Sat, 25 May 2019 04:53:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rob Bradford <tipbot@zytor.com>
Message-ID: <tip-88447c5b93d98be847f428c39ba589779a59eb83@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org,
        blackgod016574@gmail.com, peterz@infradead.org, mingo@kernel.org,
        ard.biesheuvel@linaro.org, torvalds@linux-foundation.org,
        robert.bradford@intel.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, robert.bradford@intel.com,
          torvalds@linux-foundation.org, peterz@infradead.org,
          ard.biesheuvel@linaro.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, blackgod016574@gmail.com,
          hpa@zytor.com
In-Reply-To: <20190525112559.7917-3-ard.biesheuvel@linaro.org>
References: <20190525112559.7917-3-ard.biesheuvel@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi: Allow the number of EFI configuration tables
 entries to be zero
Git-Commit-ID: 88447c5b93d98be847f428c39ba589779a59eb83
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  88447c5b93d98be847f428c39ba589779a59eb83
Gitweb:     https://git.kernel.org/tip/88447c5b93d98be847f428c39ba589779a59eb83
Author:     Rob Bradford <robert.bradford@intel.com>
AuthorDate: Sat, 25 May 2019 13:25:59 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 25 May 2019 13:48:17 +0200

efi: Allow the number of EFI configuration tables entries to be zero

Only try and access the EFI configuration tables if there there are any
reported. This allows EFI to be continued to used on systems where there
are no configuration table entries.

Signed-off-by: Rob Bradford <robert.bradford@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Gen Zhang <blackgod016574@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20190525112559.7917-3-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/efi/quirks.c | 3 +++
 drivers/firmware/efi/efi.c     | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index feb77777c8b8..632b83885867 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -513,6 +513,9 @@ int __init efi_reuse_config(u64 tables, int nr_tables)
 	void *p, *tablep;
 	struct efi_setup_data *data;
 
+	if (nr_tables == 0)
+		return 0;
+
 	if (!efi_setup)
 		return 0;
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 55b77c576c42..521a541d02ad 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -636,6 +636,9 @@ int __init efi_config_init(efi_config_table_type_t *arch_tables)
 	void *config_tables;
 	int sz, ret;
 
+	if (efi.systab->nr_tables == 0)
+		return 0;
+
 	if (efi_enabled(EFI_64BIT))
 		sz = sizeof(efi_config_table_64_t);
 	else
