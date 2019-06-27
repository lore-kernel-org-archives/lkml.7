Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5FCC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53493205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="scEDnD/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfF0HnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:43:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57757 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfF0HnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:43:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5R7h3Od178702
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 00:43:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5R7h3Od178702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561621383;
        bh=1BgDcY6PirBvW6nEzgAwckGnwmQ69f8b7THkexkRR5Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=scEDnD/2Kxdylz1IX0hswroPcaU5ciJ7/n6KQNapNqtc9x9o7JTjDucObX+qHPWSo
         JjmglAjjEaskRWJS7vShg3hQKvnx3HSKcr7ZL3Hi1zQ7oFbRYCBm4V18pLEw5JGR8W
         7sl5CbkGYB7QYOpw43pwVYhcn46XjzkcsE2uA9YbSngai90CXpZ39MFphVaFn9H9HY
         hrJ384McvvGr2NryRD6Y2KLgV2pVE5sq+TpjL2HAv8hz+p+jcsj+65w2HVjHwU2j+7
         jnXmg8HNSnEEGFk9UnaaagtWmAc5LLX3+KS2dPxTvIhkB3mYfSuxcyv80OB/aT/pb3
         hX/MidiT17D8w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5R7h34g178697;
        Thu, 27 Jun 2019 00:43:03 -0700
Date:   Thu, 27 Jun 2019 00:43:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Xiaoyao Li <tipbot@zytor.com>
Message-ID: <tip-1c30fe6cbba6997ae4740bb46910036f8a4a9edb@git.kernel.org>
Cc:     fenghua.yu@intel.com, xiaoyao.li@linux.intel.com,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, bp@alien8.de
Reply-To: bp@alien8.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mingo@kernel.org, tglx@linutronix.de, xiaoyao.li@linux.intel.com,
          fenghua.yu@intel.com
In-Reply-To: <20190627045525.105266-1-xiaoyao.li@linux.intel.com>
References: <20190627045525.105266-1-xiaoyao.li@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Make gdt 8-byte aligned
Git-Commit-ID: 1c30fe6cbba6997ae4740bb46910036f8a4a9edb
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

Commit-ID:  1c30fe6cbba6997ae4740bb46910036f8a4a9edb
Gitweb:     https://git.kernel.org/tip/1c30fe6cbba6997ae4740bb46910036f8a4a9edb
Author:     Xiaoyao Li <xiaoyao.li@linux.intel.com>
AuthorDate: Thu, 27 Jun 2019 12:55:25 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Jun 2019 09:40:41 +0200

x86/boot: Make gdt 8-byte aligned

The segment descriptors are loaded with a implicitly locked instruction,
which could trigger the split lock #AC if the variable is not properly
aligned and crosses a cache line.

Align gdt proper so the descriptors are 8 byte aligned.

Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Link: https://lkml.kernel.org/r/20190627045525.105266-1-xiaoyao.li@linux.intel.com

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
