Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFDEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DAA206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfDPMby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:31:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:48499 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfDPMby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:31:54 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mj831-1gbHjU3m3p-00fCGB; Tue, 16 Apr 2019 14:31:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kmemleak: fix unused-function warning
Date:   Tue, 16 Apr 2019 14:31:24 +0200
Message-Id: <20190416123148.3502045-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1EvAL0ojU2Frr4q+8XD0ubRvQzid0tVwlNCSoNZpPcdhs4cXgDa
 er9JnhpiZ6+hzDmyNo90eKhBWtxDpCdIn6jqy4JCU9DrGMckNRieIrMfro3+wbktoidofOa
 2tVttJbXVZWG//pdNS5j3Y633M1A+mZTSjYVaRthJnUD7c0O1yizfkfnXNRSg4ujEr9MH4x
 AyUceR85JAEo3Yda+Rw5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yJV3e/orw2s=:nbtkNbl92Oed8LdUTP7aNQ
 8K1IijsNIuBoy5Titcdi7g2zqv5QUY9rX8tRXQdW8aqtnn15cD1G01zd7WNx3TfDL9xvhfIFG
 1ItPv7GKidKCQgzBFk1xM3iBuN5nIyNOTzla1ypOnT5yGAqFwo2y88e0ZE21QSHMTTuKprRha
 ys0NCnA/4V9Q4fAq0Gdg7oBKDNIvx6FuWon6Zi/XmwyIElCZCoG4DJiEiATKCJB8GzOtgN34m
 r6j48PcG6ZM5h+Xk95gtJhBgOBO/TOsBYZXWH79pFS9v9SWRNHAvCYu26GdxorKhy31maOvff
 954yn9NwEFJfsY1WYLJhfc9YvHYSDT+tidCsA0Z/ZNXVEfR5BGxuZCxzG8sBFdkKhdxDLaHo9
 sW+I/CRJMPxfZmXxYMmvDxNzeNTfnenr+P5xnRYKskXx6f/cdzplWjDgSExfUMqgtcgiYAh1J
 gBTzsKsuuHXqjpcxXOm+yOTP1IZjeL4ZGY2nLzwjztRU5Ywp6PaSc5iql7ZH2l9EKV+olJ7/6
 2b4Iw/mWze/q9s1nJMhy1SBE270oK4ErvsMcyfabDRW/2nN0l8rEom5HVHJ+05QIxKrjCAaux
 qJH6kaXBYfiYJ1DvZIhcprrl+V8ulpOm2ESXBwiFzydWz1Fx0O0Re0wr22N1d6Wq+9zGsYOQP
 7/PyT2MvXJ68UXl+/kCsbT2AYesGM637PGllo2Af6HowfEH6kwoBlchorWR3rD9byv/nWt7Un
 QpjQ4Ok9B5p1irYvm6AhvABLFng+3ZJ9Tn3SFg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only references outside of the #ifdef have been removed,
so now we get a warning in non-SMP configurations:

mm/kmemleak.c:1404:13: error: unused function 'scan_large_block' [-Werror,-Wunused-function]

Add a new #ifdef around it.

Fixes: 298a32b13208 ("kmemleak: powerpc: skip scanning holes in the .bss section")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/kmemleak.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 6c318f5ac234..2e435b8142e5 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1401,6 +1401,7 @@ static void scan_block(void *_start, void *_end,
 /*
  * Scan a large memory block in MAX_SCAN_SIZE chunks to reduce the latency.
  */
+#ifdef CONFIG_SMP
 static void scan_large_block(void *start, void *end)
 {
 	void *next;
@@ -1412,6 +1413,7 @@ static void scan_large_block(void *start, void *end)
 		cond_resched();
 	}
 }
+#endif
 
 /*
  * Scan a memory block corresponding to a kmemleak_object. A condition is
-- 
2.20.0

