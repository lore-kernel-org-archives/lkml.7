Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F09ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6F521479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfJGOup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:50:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44496 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbfJGOtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:43 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUKJ-0006AI-PV; Mon, 07 Oct 2019 16:49:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 70AA21C032F;
        Mon,  7 Oct 2019 16:49:31 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:31 -0000
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Account for UV Hubless in is_uvX_hub Ops
Cc:     Mike Travis <mike.travis@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190910145840.294981941@stormcage.eag.rdlabs.hpecorp.net>
References: <20190910145840.294981941@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Message-ID: <157045977140.9978.3708665984961827038.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     4fb7d08707565d27ec84a364d011043ade8c38b4
Gitweb:        https://git.kernel.org/tip/4fb7d08707565d27ec84a364d011043ade8c38b4
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Tue, 10 Sep 2019 09:58:47 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 07 Oct 2019 13:42:11 +02:00

x86/platform/uv: Account for UV Hubless in is_uvX_hub Ops

The references in the is_uvX_hub() function uses the hub_info pointer
which will be NULL when the system is hubless.  This change avoids
that NULL dereference.  It is also an optimization in performance.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Hedi Berriche <hedi.berriche@hpe.com>
Cc: Justin Ernst <justin.ernst@hpe.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190910145840.294981941@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/uv/uv_hub.h | 61 ++++++++++---------------------
 1 file changed, 20 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 44cf6d6..950cd13 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -19,6 +19,7 @@
 #include <linux/topology.h>
 #include <asm/types.h>
 #include <asm/percpu.h>
+#include <asm/uv/uv.h>
 #include <asm/uv/uv_mmrs.h>
 #include <asm/uv/bios.h>
 #include <asm/irq_vectors.h>
@@ -243,83 +244,61 @@ static inline int uv_hub_info_check(int version)
 #define UV4_HUB_REVISION_BASE		7
 #define UV4A_HUB_REVISION_BASE		8	/* UV4 (fixed) rev 2 */
 
-#ifdef	UV1_HUB_IS_SUPPORTED
+/* WARNING: UVx_HUB_IS_SUPPORTED defines are deprecated and will be removed */
 static inline int is_uv1_hub(void)
 {
-	return uv_hub_info->hub_revision < UV2_HUB_REVISION_BASE;
-}
+#ifdef	UV1_HUB_IS_SUPPORTED
+	return is_uv_hubbed(uv(1));
 #else
-static inline int is_uv1_hub(void)
-{
 	return 0;
-}
 #endif
+}
 
-#ifdef	UV2_HUB_IS_SUPPORTED
 static inline int is_uv2_hub(void)
 {
-	return ((uv_hub_info->hub_revision >= UV2_HUB_REVISION_BASE) &&
-		(uv_hub_info->hub_revision < UV3_HUB_REVISION_BASE));
-}
+#ifdef	UV2_HUB_IS_SUPPORTED
+	return is_uv_hubbed(uv(2));
 #else
-static inline int is_uv2_hub(void)
-{
 	return 0;
-}
 #endif
+}
 
-#ifdef	UV3_HUB_IS_SUPPORTED
 static inline int is_uv3_hub(void)
 {
-	return ((uv_hub_info->hub_revision >= UV3_HUB_REVISION_BASE) &&
-		(uv_hub_info->hub_revision < UV4_HUB_REVISION_BASE));
-}
+#ifdef	UV3_HUB_IS_SUPPORTED
+	return is_uv_hubbed(uv(3));
 #else
-static inline int is_uv3_hub(void)
-{
 	return 0;
-}
 #endif
+}
 
 /* First test "is UV4A", then "is UV4" */
-#ifdef	UV4A_HUB_IS_SUPPORTED
-static inline int is_uv4a_hub(void)
-{
-	return (uv_hub_info->hub_revision >= UV4A_HUB_REVISION_BASE);
-}
-#else
 static inline int is_uv4a_hub(void)
 {
+#ifdef	UV4A_HUB_IS_SUPPORTED
+	if (is_uv_hubbed(uv(4)))
+		return (uv_hub_info->hub_revision == UV4A_HUB_REVISION_BASE);
+#endif
 	return 0;
 }
-#endif
 
-#ifdef	UV4_HUB_IS_SUPPORTED
 static inline int is_uv4_hub(void)
 {
-	return uv_hub_info->hub_revision >= UV4_HUB_REVISION_BASE;
-}
+#ifdef	UV4_HUB_IS_SUPPORTED
+	return is_uv_hubbed(uv(4));
 #else
-static inline int is_uv4_hub(void)
-{
 	return 0;
-}
 #endif
+}
 
 static inline int is_uvx_hub(void)
 {
-	if (uv_hub_info->hub_revision >= UV2_HUB_REVISION_BASE)
-		return uv_hub_info->hub_revision;
-
-	return 0;
+	return (is_uv_hubbed(-2) >= uv(2));
 }
 
 static inline int is_uv_hub(void)
 {
-#ifdef	UV1_HUB_IS_SUPPORTED
-	return uv_hub_info->hub_revision;
-#endif
-	return is_uvx_hub();
+	return is_uv1_hub() || is_uvx_hub();
 }
 
 union uvh_apicid {
