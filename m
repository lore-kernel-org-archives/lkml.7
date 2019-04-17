Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862E7C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3EA20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="izogyHMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbfDQOPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:15:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46547 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfDQOPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:15:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEFHH73934878
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:15:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEFHH73934878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510517;
        bh=cQAQ9MkSVxJpiowc1BjGMeX9ilxmKi+RJV19iI4c2nE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=izogyHMfOkdF7o/GPmjyaMD9RpE1ETR62Rj5Ucn62hp9CAZH407wNj6XNU3gKlgAF
         cBFjIXccaNwtoHkFM0u5DW5aVgkOIwpBiCpOfngPHi6xWn5D2LcGGlkAkx7cr2ut/0
         4YqbKCuAa/zzGQgD/Y511ht78gPWO72C2mS9J/U3mgn1SU5bd7eVskHODtnAaR9qZ1
         7K/DJyRt1SeRs2i/XTn1bkUYyCqxgIFckYVd8mtrSf2i62p3IqjnCDsM2YwaZ0KQkJ
         Suy+x02mEmvDlYGbAMyFOZMLLwqd9pvyCFedrIOMCtlCKoqdU2XvlmpP0DeuFciyWC
         bo9bkWNNPMZCA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEFGXf3934875;
        Wed, 17 Apr 2019 07:15:16 -0700
Date:   Wed, 17 Apr 2019 07:15:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-1bdb67e5aa2d5d43c48cb7d93393fcba276c9e71@git.kernel.org>
Cc:     sean.j.christopherson@intel.com, mingo@redhat.com, x86@kernel.org,
        mingo@kernel.org, bp@suse.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, luto@kernel.org, hpa@zytor.com,
        jpoimboe@redhat.com
Reply-To: mingo@redhat.com, sean.j.christopherson@intel.com, bp@suse.de,
          mingo@kernel.org, x86@kernel.org, luto@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          jpoimboe@redhat.com, hpa@zytor.com
In-Reply-To: <20190414160145.349862042@linutronix.de>
References: <20190414160145.349862042@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/exceptions: Enable IST guard pages
Git-Commit-ID: 1bdb67e5aa2d5d43c48cb7d93393fcba276c9e71
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

Commit-ID:  1bdb67e5aa2d5d43c48cb7d93393fcba276c9e71
Gitweb:     https://git.kernel.org/tip/1bdb67e5aa2d5d43c48cb7d93393fcba276c9e71
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:56 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 15:05:32 +0200

x86/exceptions: Enable IST guard pages

All usage sites which expected that the exception stacks in the CPU entry
area are mapped linearly are fixed up. Enable guard pages between the
IST stacks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160145.349862042@linutronix.de
---
 arch/x86/include/asm/cpu_entry_area.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 310eeb62d418..9c96406e6d2b 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -26,13 +26,9 @@ struct exception_stacks {
 	ESTACKS_MEMBERS(0)
 };
 
-/*
- * The effective cpu entry area mapping with guard pages. Guard size is
- * zero until the code which makes assumptions about linear mappings is
- * cleaned up.
- */
+/* The effective cpu entry area mapping with guard pages. */
 struct cea_exception_stacks {
-	ESTACKS_MEMBERS(0)
+	ESTACKS_MEMBERS(PAGE_SIZE)
 };
 
 /*
