Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FF0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 20:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDC9206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 20:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2Jg/CqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfHYUGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 16:06:30 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:45829 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbfHYUGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 16:06:30 -0400
Received: by mail-vk1-f201.google.com with SMTP id c65so6663931vkg.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+zhJzMhw6LdP2t6/07CSEKMx7kRxH5t+tfZUooODa+g=;
        b=L2Jg/CqWUEmpIPG5COD9iu+asYhkTPlrV1Q3nfbiS5JqpeyeQnVPxOO004YatNuXGf
         IgNfpUj++zV6+P/wRxIyR8YTZkOnyFOrRMiBK/iWdspcpYQ/KE4jfczN2CAXOjsbjxp2
         KPBOK4JZFlOEwrkTbfaA8vlJYhSeHMgy2NOHcKNcm5bQITXTprbs+teNnc1K0gCWygv6
         s6XrXKTToFH57nXNdsBmUAjL+pLjKWkLeb7k6wwPsyxyge0vVicDVzpevV7DEKKozbmn
         xtZw/n1Y4ugLmDh16MnQjI7OxbqpgUvVEaHzjTfD3yzx7ZEP3Z9QdMfPWp4m1yHVEr7o
         m/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+zhJzMhw6LdP2t6/07CSEKMx7kRxH5t+tfZUooODa+g=;
        b=ePO9WHUZ2VPHeC+woF7jUYMMVfaDBdAXjujsgR7qBXNu9sKWJZsnmMSlhDE5d+5hWe
         miECC5Iwx9C3EHsZ7XmaBue/AnHumKsm6uj5tU68ORODPiv8Z9XujsmHvZP224MFxOeN
         +5ufXyLgZXXtCBJQbBIQpqJh2z+q8BGWbzHjngMSaY8EunIEtikqhLeIJEhWjPN+/QzL
         +jMc9iEFu1FVklP6bNa2hqGRDWMwj6FffKJ7qtMy9qCZ4m6CmykKvnvMY4aO7bd8y3S8
         18Lry6Xh3g/xPN2dQD1G1rV29y0v8LGr4cph5YnneR5GxU3/LAfN2xCubMICT0Cy8VqS
         b23A==
X-Gm-Message-State: APjAAAXS2gSD+w6uFspu/xxkh1/+vrijFVNNnDwWdiK+ibLvNbmcKxQc
        bOHaoUatVOuibivJAC0XcS/CUM4yfiA=
X-Google-Smtp-Source: APXvYqwCbijI/fQz4VN4t/HjzBu52ybOI+J9R6kFb3HnnUqczko0IsLssuLE/txa+OJ4ol1ptVGpIhwCSCw=
X-Received: by 2002:a67:bb18:: with SMTP id m24mr8073907vsn.201.1566763588690;
 Sun, 25 Aug 2019 13:06:28 -0700 (PDT)
Date:   Sun, 25 Aug 2019 14:06:21 -0600
Message-Id: <20190825200621.211494-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH] mm: replace is_zero_pfn with is_huge_zero_pmd for thp
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?=" <jglisse@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For hugely mapped thp, we use is_huge_zero_pmd() to check if it's
zero page or not.

We do fill ptes with my_zero_pfn() when we split zero thp pmd, but
 this is not what we have in vm_normal_page_pmd().
pmd_trans_huge_lock() makes sure of it.

This is a trivial fix for /proc/pid/numa_maps, and AFAIK nobody
complains about it.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index e2bb51b6242e..ea3c74855b23 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -654,7 +654,7 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	if (pmd_devmap(pmd))
 		return NULL;
-	if (is_zero_pfn(pfn))
+	if (is_huge_zero_pmd(pmd))
 		return NULL;
 	if (unlikely(pfn > highest_memmap_pfn))
 		return NULL;
-- 
2.23.0.187.g17f5b7556c-goog

