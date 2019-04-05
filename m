Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4871EC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167792146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDEUUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:20:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43519 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfDEUUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:20:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35KJu3k2896106
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 13:19:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35KJukF2896103;
        Fri, 5 Apr 2019 13:19:56 -0700
Date:   Fri, 5 Apr 2019 13:19:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-b569c18434987163a05f05a12cdf6a9975c55ff3@git.kernel.org>
Cc:     bhe@redhat.com, mingo@kernel.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
          bhe@redhat.com, mingo@kernel.org, tglx@linutronix.de,
          hpa@zytor.com
In-Reply-To: <20190308025616.21440-3-bhe@redhat.com>
References: <20190308025616.21440-3-bhe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/KASLR: Reduce randomization granularity for
 5-level paging to 1GB
Git-Commit-ID: b569c18434987163a05f05a12cdf6a9975c55ff3
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

Commit-ID:  b569c18434987163a05f05a12cdf6a9975c55ff3
Gitweb:     https://git.kernel.org/tip/b569c18434987163a05f05a12cdf6a9975c55ff3
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Fri, 8 Mar 2019 10:56:16 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 5 Apr 2019 22:13:52 +0200

x86/mm/KASLR: Reduce randomization granularity for 5-level paging to 1GB

The current randomization granularity of 5-level is 512 GB. The mapping of
the real mode trampoline has been reduced to one PUD entry, so there is no
restriction anymore.

Reduce the granularity to 1GB for 5-level paging mode which allows better
randomization.

[ tglx: Massaged changelog ]

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: dave.hansen@linux.intel.com
Cc: luto@kernel.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: keescook@chromium.org
Cc: thgarnie@google.com
Link: https://lkml.kernel.org/r/20190308025616.21440-3-bhe@redhat.com
---
 arch/x86/mm/kaslr.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 97813751340d..f6ba2791eeb5 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -125,10 +125,7 @@ void __init kernel_randomize_memory(void)
 		 */
 		entropy = remain_entropy / (ARRAY_SIZE(kaslr_regions) - i);
 		prandom_bytes_state(&rand_state, &rand, sizeof(rand));
-		if (pgtable_l5_enabled())
-			entropy = (rand % (entropy + 1)) & P4D_MASK;
-		else
-			entropy = (rand % (entropy + 1)) & PUD_MASK;
+		entropy = (rand % (entropy + 1)) & PUD_MASK;
 		vaddr += entropy;
 		*kaslr_regions[i].base = vaddr;
 
@@ -137,10 +134,7 @@ void __init kernel_randomize_memory(void)
 		 * randomization alignment.
 		 */
 		vaddr += get_padding(&kaslr_regions[i]);
-		if (pgtable_l5_enabled())
-			vaddr = round_up(vaddr + 1, P4D_SIZE);
-		else
-			vaddr = round_up(vaddr + 1, PUD_SIZE);
+		vaddr = round_up(vaddr + 1, PUD_SIZE);
 		remain_entropy -= entropy;
 	}
 }
