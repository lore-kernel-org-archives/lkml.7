Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3293BC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C73F20692
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgAGVlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:41:02 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:57283 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAGVlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:41:01 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mv2tE-1jfX9141SK-00r2Gc; Tue, 07 Jan 2020 22:40:44 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kallsyms: work around bogus -Wrestrict warning
Date:   Tue,  7 Jan 2020 22:40:26 +0100
Message-Id: <20200107214042.855757-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:er0ptZhopvfL2NIlxM83qCH35WTiK4cGzgln+YcSox8wtWd7joJ
 uLjHXAB0J5qZttC1MLq9B7oa6Yjofsy3ByAp+mB61I7QozAvFbKsGf9tcihOdarnyNSIQnd
 e7obKQCvB6WxAMjlGRokP56X5rI9wtcnXQetEeXh4tn10bpmTgOG2tNXP8c8FAygOOCndzL
 XG9/NFh1rMy7SoFccQhNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:95iM3CDAKJc=:DhVoV/96suw5Jhfukzbigq
 XU1S87FrLwn9uZ860fhwNmFVAGRC4gXq/a6akws5CXNCml5vePwWj3kaEA104hotoUEjQuDtB
 nHXpUZjP0JbYxVV/bvDzVDqakX2lCUbG+y54CYKFhlKVS+Lvvbw3G3R3a5GK3BmedPt74kZRq
 2jVcYu6WfpYWUCOaTENSsmrDyh6z7bs13XpfL0TiBf2rQ/Cz530skVi5Y1xqJquZJZ5FlQeGx
 uorQjnw/59Z8vg+vprqp+Ugw/9xuTgVTf/QdL4vnGOAgKT9MvbGs6mZxeANP00RWIHdz7PWxN
 jIhNS7AlNMzdsh/t1U6GjHEO+FnXUIStkV8JABQWaAS8Sal6fDezSx4sJGuwZoGXI3FEGQE9Q
 EWfx5uKLHhp08fa8lc21BbS/ysaCwyx4DxtSeqPSXgFaHyiMVNa4deXUyvtfE0wHgq5lCFlsz
 pQIp8ApTRZgEBVjXf4Qb/ufqBM2y6QyZYuxzKpjRHjeWX1lMypT4pJUWHDyyyBx/G7tzlzHwx
 73EMU0o/tbb2iodj7oQG5U6QJGePMl453+BYtKqXluR/UVdkDm1SwJU1FkbPxc6Kj1SWbwGAg
 UxLTmn+vxQH8n0OriSqbCoA9st2TFf814Sn7vZ8XZT1P2BwIIwRIRmrPVngU01+L8P77lHObT
 Mgc07Fywws5h9L+uf7pG0z8e3V7QEiIAXBGh2lRABmLBTuANKL+D4G0EGMs/WVXWF6eIOsodJ
 5iiN4Gu/+6WsdyNZdAWGO/INbd2S4BVOIdC+6oczdvj2aE3RiULOwL1ApnZFK8UVEIL60V9wq
 iFbMRmAJKvSW29xBAP9yhOdhCmstJ9czchd6cPQTxo34PWzgkBVjnuRJR98R9q8veg/JuBg7t
 bLWRbtqIQDCDK7WOsqUA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -O3 produces some really odd warnings for this file:

kernel/kallsyms.c: In function 'sprint_symbol':
kernel/kallsyms.c:369:3: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
   strcpy(buffer, name);
   ^~~~~~~~~~~~~~~~~~~~
kernel/kallsyms.c: In function 'sprint_symbol_no_offset':
kernel/kallsyms.c:369:3: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
   strcpy(buffer, name);
   ^~~~~~~~~~~~~~~~~~~~
kernel/kallsyms.c: In function 'sprint_backtrace':
kernel/kallsyms.c:369:3: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
   strcpy(buffer, name);
   ^~~~~~~~~~~~~~~~~~~~

This obviously cannot be since it is preceded by an 'if (name != buffer)'
check.

Using sprintf() instead of strcpy() is a bit wasteful but is
the best workaround I could come up with.

Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index d812b90f4c86..726b8eeb223e 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -366,7 +366,7 @@ static int __sprint_symbol(char *buffer, unsigned long address,
 		return sprintf(buffer, "0x%lx", address - symbol_offset);
 
 	if (name != buffer)
-		strcpy(buffer, name);
+		sprintf(buffer, "%s", name);
 	len = strlen(buffer);
 	offset -= symbol_offset;
 
-- 
2.20.0

