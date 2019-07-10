Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33179C74A23
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8962064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfGJOKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:10:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50632 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfGJOKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:10:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so2499686wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 07:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TY7yY/Is1vsoNm98cSnkNJrjSVQKwiCCI3+J5kse7IA=;
        b=ruxCm5woU8gpAbi9vBWzm9CN0HuvcUR11/k11TOblNunYgbdcuIYMdwmiOGKTMhJsU
         cuH0Wp95fKG6TI/CfrWUvdomNQ+P/2ih5SgQYmxrP+WuFMbwBsJRRZcCzrtsc8z7ryJK
         d9ZMqZkYKT8vPupDZIr++4DY8B07MV1qNnLlouDJNzI27JBFBLk0u7PlnIWP4Bf72aQ5
         tCfpqL+/LZpdYsub9SOji/Srv+4omJfE+Ny1A95l8IF4/JpsIvm/qkcLgOAhC5KdTSJV
         8cHOejD9QoGIB00OPx2r7iZHCkfk4UhSyjC8+6+kYDZzJBnTpVmcIZccrsy3oTVBKWG6
         RTHg==
X-Gm-Message-State: APjAAAWTw7OueTPeBlSC7WaC3eY+4CIFn9W1Vnv9WD8fu7kO3zYMtqbz
        Fn9PENiTvahG5K13Kip7M7U=
X-Google-Smtp-Source: APXvYqwpYawV7a4WTLPXAorYW3M6lrhk3kn3yQGP3ACjJl/TL2X4QkY/thdNTJS6Tpzo45XQaURDEw==
X-Received: by 2002:a05:600c:2245:: with SMTP id a5mr5603409wmm.121.1562767836208;
        Wed, 10 Jul 2019 07:10:36 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id v5sm2733206wre.50.2019.07.10.07.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 07:10:35 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Arun KS <arunks@codeaurora.org>
Cc:     Denis Efremov <efremov@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: remove the exporting of totalram_pages
Date:   Wed, 10 Jul 2019 17:10:31 +0300
Message-Id: <20190710141031.15642-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously totalram_pages was the global variable. Currently,
totalram_pages is the static inline function from the include/linux/mm.h
However, the function is also marked as EXPORT_SYMBOL, which is at best
an odd combination. Because there is no point for the static inline
function from a public header to be exported, this commit removes the
EXPORT_SYMBOL() marking. It will be still possible to use the function in
modules because all the symbols it depends on are exported.

Fixes: ca79b0c211af6 ("mm: convert totalram_pages and totalhigh_pages variables to atomic")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8e3bc949ebcc..060303496094 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -224,8 +224,6 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES] = {
 	[ZONE_MOVABLE] = 0,
 };
 
-EXPORT_SYMBOL(totalram_pages);
-
 static char * const zone_names[MAX_NR_ZONES] = {
 #ifdef CONFIG_ZONE_DMA
 	 "DMA",
-- 
2.21.0

