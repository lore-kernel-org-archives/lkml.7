Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E64C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6F52186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610620;
	bh=dKIUYD5nGgM+AEYzLF8yYHMJMuL3OK8eEvwzbHma4i4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l58e7csCl2LIpY0ase4ztcftXm5eyUUQCo+KsbO6pVj2rht+eUxz6ycnj2lLxUCcK
	 lEv76XPz3W6Qd+jhl4zTGTp/s1AJ7mmUtG+0BhLWJ7Wm9vyHAYTRZyjbjiCWOfla2J
	 Yp9dr7pr5PQJz6e0EppksY8qwcnhzW08hEsxt5Io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390544AbfDRSDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390952AbfDRSDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:03:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B678217FA;
        Thu, 18 Apr 2019 18:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610613;
        bh=dKIUYD5nGgM+AEYzLF8yYHMJMuL3OK8eEvwzbHma4i4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hbfBo6YdxtCIMLiEWSeyT5CE6Pdzd7ayOyBYu5eEiI8L+DteMU08H8K61oouDKfTe
         BkPkJjKcSPYcf4tgJTwdB2nw5ao129S+AhGhegfhan204RqsmzhwPfumuaneZFJCd5
         akl3t7mVrVayd1emwu9VHdDVtqAEGGLgw3Pilyq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 18/92] x86/mm: Dont leak kernel addresses
Date:   Thu, 18 Apr 2019 19:56:36 +0200
Message-Id: <20190418160431.923452817@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a3151724437f54076cc10bc02b1c4f0003ae36cd ]

Since commit:

  ad67b74d2469d9b8 ("printk: hash addresses printed with %p")

at boot "____ptrval____" is printed instead of actual addresses:

    found SMP MP-table at [mem 0x000f5cc0-0x000f5ccf] mapped at [(____ptrval____)]

Instead of changing the print to "%px", and leaking a kernel addresses,
just remove the print completely, like in:

  071929dbdd865f77 ("arm64: Stop printing the virtual memory layout").

Signed-off-by: Matteo Croce <mcroce@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/mpparse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index bc6bc6689e68..1c52acaa5bec 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -596,8 +596,8 @@ static int __init smp_scan_config(unsigned long base, unsigned long length)
 			mpf_base = base;
 			mpf_found = true;
 
-			pr_info("found SMP MP-table at [mem %#010lx-%#010lx] mapped at [%p]\n",
-				base, base + sizeof(*mpf) - 1, mpf);
+			pr_info("found SMP MP-table at [mem %#010lx-%#010lx]\n",
+				base, base + sizeof(*mpf) - 1);
 
 			memblock_reserve(base, sizeof(*mpf));
 			if (mpf->physptr)
-- 
2.19.1



