Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470B3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3C42146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfC0NQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:16:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44547 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbfC0NQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:16:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2RDG7f42869101
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Mar 2019 06:16:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2RDG6I22869098;
        Wed, 27 Mar 2019 06:16:06 -0700
Date:   Wed, 27 Mar 2019 06:16:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-0f02daed4e089c7a380a0ffdc9d93a5989043cf4@git.kernel.org>
Cc:     x86@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        thomas.lendacky@amd.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, bp@suse.de,
        mingo@kernel.org, fanc.fnst@cn.fujitsu.com, bhe@redhat.com,
        kirill.shutemov@linux.intel.com
Reply-To: thomas.lendacky@amd.com, jgross@suse.com,
          kirill.shutemov@linux.intel.com, mingo@kernel.org,
          mingo@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          tglx@linutronix.de, x86@kernel.org, bhe@redhat.com,
          fanc.fnst@cn.fujitsu.com, bp@suse.de
In-Reply-To: <20190304055546.18566-1-bhe@redhat.com>
References: <20190304055546.18566-1-bhe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot: Fix incorrect ifdeffery scope
Git-Commit-ID: 0f02daed4e089c7a380a0ffdc9d93a5989043cf4
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

Commit-ID:  0f02daed4e089c7a380a0ffdc9d93a5989043cf4
Gitweb:     https://git.kernel.org/tip/0f02daed4e089c7a380a0ffdc9d93a5989043cf4
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Mon, 4 Mar 2019 13:55:46 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 27 Mar 2019 14:00:51 +0100

x86/boot: Fix incorrect ifdeffery scope

The declarations related to immovable memory handling are out of the
BOOT_COMPRESSED_MISC_H #ifdef scope, wrap them inside.

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190304055546.18566-1-bhe@redhat.com
---
 arch/x86/boot/compressed/misc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index fd13655e0f9b..d2f184165934 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -120,8 +120,6 @@ static inline void console_init(void)
 
 void set_sev_encryption_mask(void);
 
-#endif
-
 /* acpi.c */
 #ifdef CONFIG_ACPI
 acpi_physical_address get_rsdp_addr(void);
@@ -135,3 +133,5 @@ int count_immovable_mem_regions(void);
 #else
 static inline int count_immovable_mem_regions(void) { return 0; }
 #endif
+
+#endif /* BOOT_COMPRESSED_MISC_H */
