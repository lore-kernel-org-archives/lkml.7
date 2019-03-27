Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953CBC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611F12082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+/gcZFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfC0UlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:41:24 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:53459 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfC0UlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:41:23 -0400
Received: by mail-qt1-f201.google.com with SMTP id 18so18145555qtw.20
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 13:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=d+4bMZ8rHzHoWjvzHcDD/tEn1xANDbLdCbbEdrq508Q=;
        b=u+/gcZFOBRAyKJbEKf7DD4d1TebCZNGNPGFRBc1APR6r2d8gLHkPv7OfRxLn9EuhgX
         TMucWAtP+qQ2EgecTigArAMFMg5LMdiE41SDRnSMXEfqihHW7wqQBg3j+59nhQUaL9MU
         bKc1joU9KQg3gL+rasSnEbsHQQqCX+KaV8EtzJwjW8LYsdmOtM/033zQsvQvO09wY602
         8hubny29J6WF06R+7myO6fwzDAxD3OHubGuP/jbgVOAGBLOOzloCk7gNlDsmtoKT5ILA
         OYK5VonJzeOtV/TH077c25T2SDixr9qw14cXN/+HKZ3lDeJiU43yp1LZBNm7Cvepn+Iw
         5aOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=d+4bMZ8rHzHoWjvzHcDD/tEn1xANDbLdCbbEdrq508Q=;
        b=OEK/NCONUo9baWtXckERH2CsPjAkZ5HeaB+SBpESFRN0elNgFILgQ/wZ/H5N+NWcfJ
         Fk+lFjihI0QE9eVMyglujmpCl/WCwtSG/bflniMit6nHwsgFkeCmJwz6qCKwRFmCn0Ja
         89M4aBF+Bpc2g1ZteG/HRC50BxJxI2ughRIcrDxuCBGEZ89vzWyMfs2gDtLOnQs4T5DJ
         1yH+rB7QK7QBpP27Tsu5tHmf62BbkNCHDxezfGOGk0s3E/dX1JWu11fydDdB3OXult+F
         L4JauPton/nnqGhHLM25puXl6sJ1irQbJNlFPGrMpOcLY6lxAi9VUcEf/L6xykJ0SFKC
         AwCw==
X-Gm-Message-State: APjAAAVYIF0i4ku4NPYCWR6fAtX75KavMKHcDDKMudBtTl6WUl7uIXjL
        oQLDFv+sArBp2xzaQewIHufi/+qACQ==
X-Google-Smtp-Source: APXvYqxr9sciDPMxjao/0JCNJ9Oxnjqdq+XBKJ4UWjQC34cagq02mzGT4V+V4jMPzz0o/xmi+24YP8Gj6A==
X-Received: by 2002:ac8:22b3:: with SMTP id f48mr1929258qta.38.1553719282754;
 Wed, 27 Mar 2019 13:41:22 -0700 (PDT)
Date:   Wed, 27 Mar 2019 21:41:17 +0100
Message-Id: <20190327204117.35215-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] mm: fix vm_fault_t cast in VM_FAULT_GET_HINDEX()
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, jannh@google.com
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Symmetrically to VM_FAULT_SET_HINDEX(), we need a force-cast in
VM_FAULT_GET_HINDEX() to tell sparse that this is intentional.

Sparse complains about the current code when building a kernel with
CONFIG_MEMORY_FAILURE:

arch/x86/mm/fault.c:1058:53: warning: restricted vm_fault_t degrades to
integer

Fixes: 3d3539018d2c ("mm: create the new vm_fault_t type")
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/mm_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7eade9132f02..4ef4bbe78a1d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -671,7 +671,7 @@ enum vm_fault_reason {
 
 /* Encode hstate index for a hwpoisoned large page */
 #define VM_FAULT_SET_HINDEX(x) ((__force vm_fault_t)((x) << 16))
-#define VM_FAULT_GET_HINDEX(x) (((x) >> 16) & 0xf)
+#define VM_FAULT_GET_HINDEX(x) (((__force unsigned int)(x) >> 16) & 0xf)
 
 #define VM_FAULT_ERROR (VM_FAULT_OOM | VM_FAULT_SIGBUS |	\
 			VM_FAULT_SIGSEGV | VM_FAULT_HWPOISON |	\
-- 
2.21.0.392.gf8f6787159e-goog

