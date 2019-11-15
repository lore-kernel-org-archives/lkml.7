Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B203C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9AC206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKOT0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:26:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44429 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfKOT0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 14:26:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVhEa-0005vE-AJ; Fri, 15 Nov 2019 20:26:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D59811C18CD;
        Fri, 15 Nov 2019 20:26:19 +0100 (CET)
Date:   Fri, 15 Nov 2019 19:26:19 -0000
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Align cpu_caps_cleared and cpu_caps_set to
 unsigned long
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190916223958.27048-2-tony.luck@intel.com>
References: <20190916223958.27048-2-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <157384597983.12247.8995835529288193538.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f6a892ddd53e555362dbf64d31b47fde0f550ec4
Gitweb:        https://git.kernel.org/tip/f6a892ddd53e555362dbf64d31b47fde0f550ec4
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 16 Sep 2019 15:39:56 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 Nov 2019 20:20:32 +01:00

x86/cpu: Align cpu_caps_cleared and cpu_caps_set to unsigned long

cpu_caps_cleared[] and cpu_caps_set[] are arrays of type u32 and therefore
naturally aligned to 4 bytes, which is also unsigned long aligned on
32-bit, but not on 64-bit.

The array pointer is handed into atomic bit operations. If the access not
aligned to unsigned long then the atomic bit operations can end up crossing
a cache line boundary, which causes the CPU to do a full bus lock as it
can't lock both cache lines at once. The bus lock operation is heavy weight
and can cause severe performance degradation.

The upcoming #AC split lock detection mechanism will issue warnings for
this kind of access.

Force the alignment of these arrays to unsigned long. This avoids the
massive code changes which would be required when converting the array data
type to unsigned long.

[ tglx: Rewrote changelog ]

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20190916223958.27048-2-tony.luck@intel.com

---
 arch/x86/kernel/cpu/common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9ae7d1b..1e9430b 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -565,8 +565,9 @@ static const char *table_lookup_model(struct cpuinfo_x86 *c)
 	return NULL;		/* Not found */
 }
 
-__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS];
-__u32 cpu_caps_set[NCAPINTS + NBUGINTS];
+/* Aligned to unsigned long to avoid split lock in atomic bitmap ops */
+__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
+__u32 cpu_caps_set[NCAPINTS + NBUGINTS] __aligned(sizeof(unsigned long));
 
 void load_percpu_segment(int cpu)
 {
