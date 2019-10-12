Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A94C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 07:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EEA2053B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 07:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfJLHA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 03:00:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfJLHA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 03:00:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E397310CC1E3;
        Sat, 12 Oct 2019 07:00:57 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-172.phx2.redhat.com [10.3.117.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF0712619E;
        Sat, 12 Oct 2019 07:00:54 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Mike Travis <mike.travis@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Scott Wood <swood@redhat.com>
Subject: [PATCH] x86/smp: Enforce limit of 512 cpus with MAXSMP and no CPUMASK_OFFSTACK
Date:   Sat, 12 Oct 2019 02:00:54 -0500
Message-Id: <20191012070054.28657-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Sat, 12 Oct 2019 07:00:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The help text of NR_CPUS says that the maximum number of cpus supported
without CPUMASK_OFFSTACK is 512.  However, NR_CPUS_RANGE_END allows this
limit to be bypassed by MAXSMP even if CPUMASK_OFFSTACK is not set.

This scenario can currently only happen in the RT tree, since it
has "select CPUMASK_OFFSTACK if !PREEMPT_RT_FULL" in MAXSMP.  However,
even if we ignore the RT tree, checking for MAXSMP in addition to
CPUMASK_OFFSTACK is redundant.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 arch/x86/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d6e1faa28c58..2b526e101dc9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1000,8 +1000,8 @@ config NR_CPUS_RANGE_END
 config NR_CPUS_RANGE_END
 	int
 	depends on X86_64
-	default 8192 if  SMP && ( MAXSMP ||  CPUMASK_OFFSTACK)
-	default  512 if  SMP && (!MAXSMP && !CPUMASK_OFFSTACK)
+	default 8192 if  SMP && CPUMASK_OFFSTACK
+	default  512 if  SMP && !CPUMASK_OFFSTACK
 	default    1 if !SMP
 
 config NR_CPUS_DEFAULT
-- 
2.20.1

