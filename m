Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30926C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A4922353
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgQR+qcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390210AbfGWN04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:26:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39090 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbfGWN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:26:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so15159163pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 06:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hgu5qjFhmazmMbubW4moD18H6id0kW8fsRyGvNDOd1g=;
        b=GgQR+qccw6P9XFNdlnoBLTB0RMc7OC4KTTPYp6WUMNZHeaIDaEZrhSnPMQgizoqiYp
         W3rOMjh23ll7qpXuP8n51Jpou4jE9RzZxKABOr0FhIyTs3ZNe7EhvaEohaA2wz/D6lrA
         RFh8YVNcpDv1WmeeYuF1arv3j+dEqvrfmWDwTlZz2MFtwUHfrrKSezOXTqUAvAKyq2NK
         77PT0+x8eH/ci9wxLYZUCjjvinTatlXEZo/F2zU5YLk0Y4D9xEbVr2iwbmiUHofNUDm5
         ZG+EjLOIF/bhFe9zJobQBdk0zfuOZLQUGiZDCiBbL7GX7xLQ/SAHdljSEddsZQgwNlcY
         lVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hgu5qjFhmazmMbubW4moD18H6id0kW8fsRyGvNDOd1g=;
        b=BJgmhqc3qTjvoqA/Huzl0TCsFLblz3Zb/GH8BeGoBTM3PuPgPUm7jceq6lSpvTxuIj
         mykZKCGDoZlnnXEU/Erzskh8fVg0DbJnKBxEJHVtIvU9uOLMHGXX2q220L9za53CkfGW
         iS/+UcY+fAEntwHltb1JGsSLtSLACgilldXb41Y6vXFJdesHU8XrDiYTZ94tQxElx33e
         aV2e0rJHVJavUOrx1mIyccv1lyqQqh6R7+WBfG19K3T0Guk+bbnTI7HYyvnxhPNWbLJ8
         9zxnVdBJmJOLgKMIJbcNns2Js4W4M1HUd4vi64u8IiUHjMo0XEJi+oqgNBpQdVxbCDRe
         IwsA==
X-Gm-Message-State: APjAAAUzfx/azpUUT95wyv11+oNHO3dRFpJmpPMlH6ifyGAkc9CP03aG
        B5C1UQcE/z3YhzM5HxXWGhZ7me21
X-Google-Smtp-Source: APXvYqyfQJcNueBeNincKJFFxcRwtRZ4eSa/GTKG9w0PhEehBLJv3Eqd1giDOGwYUQ/hbKMfj+hUFw==
X-Received: by 2002:a63:3d8f:: with SMTP id k137mr77400277pga.337.1563888415706;
        Tue, 23 Jul 2019 06:26:55 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id o14sm88152136pfh.153.2019.07.23.06.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 06:26:55 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] x86: Fix possible null-pointer dereferences in untrack_pfn()
Date:   Tue, 23 Jul 2019 21:26:48 +0800
Message-Id: <20190723132648.25853-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In untrack_pfn(), there is an if statement on line 1058 to check whether
vma is NULL:
    if (vma && !(vma->vm_flags & VM_PAT))

When vma is NULL, vma is used on line 1064:
    if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr))
and line 1069:
    size = vma->vm_end - vma->vm_start;

Thus, possible null-pointer dereferences may occur.

To fix these possible bugs, vma is checked on line 1063.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 arch/x86/mm/pat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index d9fbd4f69920..717456e7745e 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -1060,7 +1060,7 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 
 	/* free the chunk starting from pfn or the whole chunk */
 	paddr = (resource_size_t)pfn << PAGE_SHIFT;
-	if (!paddr && !size) {
+	if (vma && !paddr && !size) {
 		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
 			WARN_ON_ONCE(1);
 			return;
-- 
2.17.0

