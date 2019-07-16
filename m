Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C22DC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90432173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wqGusLJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbfGPVUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:20:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48781 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfGPVUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:20:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6GLJtha1229621
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Jul 2019 14:19:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6GLJtha1229621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563311995;
        bh=kZwr/64WSZaONd6w9ae4EPZGcolw3omtqDm6IpXkvrI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wqGusLJf0Bv4p26jT02rh/g0FRU6dGBkVFMPIP0uopdaGekHfikqOoWwErMaIkciS
         cYbTRd9geUSoTmymFT68Fok54n8RCtYlJ9bMm5uY9W0m2Yi7MJpVr3IqR3+w9LEz8s
         OsVW95zq5u59tV0y2iPIYQ1bB4cc65T54KoC3S1ln3FEQ+zdf1I4NZ5q8b5vygUcjf
         xJPpqKVOQazAFYJNc7LIculjfAYaiV3Jj/Rjsj8cbqjSDVDhikeAlAxJelJsalIlSb
         r+GriudhM1LHpjcA9erOvZjq9ABB6Ot1GMOAy443J4yvvfuQAJUgM3ktGclevmcQLR
         hSAgRvW9NT1Ow==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6GLJsJ41229618;
        Tue, 16 Jul 2019 14:19:54 -0700
Date:   Tue, 16 Jul 2019 14:19:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for David Rientjes <tipbot@zytor.com>
Message-ID: <tip-ffdb07f31252625b7bcbf1f424d7beccff02ba97@git.kernel.org>
Cc:     tglx@linutronix.de, cfir@google.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, rientjes@google.com, hpa@zytor.com
Reply-To: hpa@zytor.com, mingo@kernel.org, cfir@google.com,
          linux-kernel@vger.kernel.org, rientjes@google.com,
          tglx@linutronix.de
In-Reply-To: <alpine.DEB.2.21.1907101318170.197432@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1907101318170.197432@chino.kir.corp.google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Free sme_early_buffer after init
Git-Commit-ID: ffdb07f31252625b7bcbf1f424d7beccff02ba97
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

Commit-ID:  ffdb07f31252625b7bcbf1f424d7beccff02ba97
Gitweb:     https://git.kernel.org/tip/ffdb07f31252625b7bcbf1f424d7beccff02ba97
Author:     David Rientjes <rientjes@google.com>
AuthorDate: Wed, 10 Jul 2019 13:19:35 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 16 Jul 2019 23:13:48 +0200

x86/mm: Free sme_early_buffer after init

The contents of sme_early_buffer should be cleared after
__sme_early_enc_dec() because it is used to move encrypted and decrypted
data, but since __sme_early_enc_dec() is __init this buffer simply can be
freed after init.

This saves a page that is otherwise unreferenced after init.

Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: David Rientjes <rientjes@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1907101318170.197432@chino.kir.corp.google.com

---
 arch/x86/mm/mem_encrypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index e0df96fdfe46..e94e0a62ba92 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -41,7 +41,7 @@ EXPORT_SYMBOL_GPL(sev_enable_key);
 bool sev_enabled __section(.data);
 
 /* Buffer used for early in-place encryption by BSP, no locking needed */
-static char sme_early_buffer[PAGE_SIZE] __aligned(PAGE_SIZE);
+static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
 
 /*
  * This routine does not change the underlying encryption setting of the
