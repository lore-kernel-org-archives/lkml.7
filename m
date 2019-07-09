Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EBBC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FBD2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfGIS4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:56:07 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50211 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGIS4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:56:07 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MV6Bs-1ht4UM2gFi-00SAJu; Tue, 09 Jul 2019 20:55:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Mark-PK Tsai <Mark-PK.Tsai@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/sparse.c: mark sparse_buffer_free as __meminit
Date:   Tue,  9 Jul 2019 20:55:07 +0200
Message-Id: <20190709185528.3251709-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dVuJ+e4kut2pBGD0f44Tc4g9wI+Sx6SMYC65vDceSfeBL8Yrh+N
 QNGHbxDD8YGcxeGUylFBPh2+1bqSGZD7fY2xzD4DuBrL6v+lkqQlguvHdgwjCswrVGx0YTH
 Ei8xRNQutUg89MivWr34gzxK4A0qtbmc/bwPqX+Ro6d0AKd1DALUkvtQnCKRHpDo8N4C/cH
 PXTpKClIVFlzJz6klNUKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m6/WP9gsIM8=://qaXXPJjdjdLwFXs/UQEw
 +imM3iOlc931kOkt2KJoAkJMtnNtcB+ECAqcccp5LqSZ3ZDoYw7uVgg/aT3s3kBDKyU4CZ91+
 2Vv8UpHhZZoJXqrINVUJ8Du1cwhPcS4ZsnJ21M5qOYaKY1jkttUcJCkKERpJq1IpUCifqgOze
 mKvXl0BLByMoOsx0q3wapfs4860AqLAaqyz48b9NGKVcne1njGvfLfitEQC5RzGOLwJG9Xe1Z
 F6/zmu4tTBuXiw90z5Ux0bs1+KAkSfgqXDaupSq7BAbQnLVdlXaHNkL9VK/eb4B2ezZ/34NeV
 MiiefBC8t4cjbufi6ryt5N3y2yroSgI2eWwz2FcrpGYb4lsJd5WYCo6AbNqdXnPC+OVUyB6Wc
 MLYwE0vTk91UACyfh2+tle7bfjU3ClroCy9kGhBi+mjWKm1jc58gmuMlR+Jaqwu8TewKdLmQv
 XNl8NaGgSEcGsFWzlV8BcB7MIn7u/tIs0jQ8nDWHyxygclcwEk/Yd4D6V692Om8veoGdlx1gu
 TzYzg9SKzJhRwiPUDRI3k+WyNZWezRG/2qvOpIMDFTUQRLD0ffbTGoTCsNpFnOgp6wVdO5/EA
 lZrmXTsVfpFEaMWIvX8u+xilTzIr8Lr9SdU273CuvBlAMW1Rz5tIwmVLSdqw+JaR3QdVcXSIq
 LBIa5aiZKVRYszZlP3mu3UyXhpUxO3LxicJ+8O6JszIV2dLW1Guy37mq6jWmxne7b4rfIoisw
 2m3oWKIhTpFb0cn56zAlG3ImsCaDSmHu1cS8Dg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling an __init function from a __meminit function is not allowed:

WARNING: vmlinux.o(.meminit.text+0x30ff): Section mismatch in reference from the function sparse_buffer_alloc() to the function .init.text:sparse_buffer_free()
The function __meminit sparse_buffer_alloc() references
a function __init sparse_buffer_free().
If sparse_buffer_free is only used by sparse_buffer_alloc then
annotate sparse_buffer_free with a matching annotation.

Downgrade the annotation to __meminit for both, as they may be
used in the hotplug case.

Fixes: mmotm ("mm/sparse.c: fix memory leak of sparsemap_buf in aliged memory")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 3267c4001c6d..4801d45bd66e 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -470,7 +470,7 @@ struct page __init *__populate_section_memmap(unsigned long pfn,
 static void *sparsemap_buf __meminitdata;
 static void *sparsemap_buf_end __meminitdata;
 
-static inline void __init sparse_buffer_free(unsigned long size)
+static inline void __meminit sparse_buffer_free(unsigned long size)
 {
 	WARN_ON(!sparsemap_buf || size == 0);
 	memblock_free_early(__pa(sparsemap_buf), size);
-- 
2.20.0

