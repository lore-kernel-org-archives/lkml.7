Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD61C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF7A20815
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="yOPKf6xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfF0JCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:02:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38529 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0JCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:02:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5R916VP204146
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 02:01:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5R916VP204146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561626067;
        bh=HpbNo9Qe7lPUyV2D2rP07ZTdrh3ANbJinCRhdfyfJ/0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=yOPKf6xwbptWGtvZzlBxWdgMP80tsnwakW4J8QFALtuIlJa7S7ZpykjH2BJ8Yvce6
         MGsGNeUHOz72jjAhiLPIHXlDVoZDVKAiAJ28mMI+sHtF3UtVdPYnJkgrquJunjdTWJ
         DQVcLzGh6ZmQ5LNudd6IV7efZ/nywJ6jPnN97FEj/Q6gHniXve/StBORKgm0hX9I/t
         JPRB+ItdDeMM6YRVypmLMCMgdSG0zg7lHDwMgNBVdDYPsJYRZI6OSt9ClAYTf7VSl6
         1WpLHBDueCna3VJCicnXDLl0zR/wuHP6puNe9JfBhhBvW42q3uWA/wd6Zgyk8DsGjm
         P0ApbBdtyiolA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5R915rQ204143;
        Thu, 27 Jun 2019 02:01:05 -0700
Date:   Thu, 27 Jun 2019 02:01:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Xiaoyao Li <tipbot@zytor.com>
Message-ID: <tip-2238246ff8d533a5f2327d1f953375876d8a013c@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, bp@alien8.de,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        xiaoyao.li@linux.intel.com
Reply-To: fenghua.yu@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, xiaoyao.li@linux.intel.com,
          tglx@linutronix.de, hpa@zytor.com, bp@alien8.de
In-Reply-To: <20190627045525.105266-1-xiaoyao.li@linux.intel.com>
References: <20190627045525.105266-1-xiaoyao.li@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Make the GDT 8-byte aligned
Git-Commit-ID: 2238246ff8d533a5f2327d1f953375876d8a013c
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

Commit-ID:  2238246ff8d533a5f2327d1f953375876d8a013c
Gitweb:     https://git.kernel.org/tip/2238246ff8d533a5f2327d1f953375876d8a013c
Author:     Xiaoyao Li <xiaoyao.li@linux.intel.com>
AuthorDate: Thu, 27 Jun 2019 12:55:25 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 27 Jun 2019 10:56:11 +0200

x86/boot: Make the GDT 8-byte aligned

The segment descriptors are loaded with an implicitly LOCK-ed instruction,
which could trigger the split lock #AC exception if the variable is not
properly aligned and crosses a cache line.

Align the GDT properly so the descriptors are all 8 byte aligned.

Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Link: https://lkml.kernel.org/r/20190627045525.105266-1-xiaoyao.li@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fafb75c6c592..6233ae35d0d9 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -659,6 +659,7 @@ no_longmode:
 gdt64:
 	.word	gdt_end - gdt
 	.quad   0
+	.balign	8
 gdt:
 	.word	gdt_end - gdt
 	.long	gdt
