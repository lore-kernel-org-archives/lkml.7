Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6985C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE822075D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOYYCAzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgAHKYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:24:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33588 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgAHKYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:24:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so1376844pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 02:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Pwd6pPOfjcWBYssAiTNpLV/0fJ/zD+lixc1xNtJf0dM=;
        b=KOYYCAzGbdAmhqvoEW/wE4aLQ4Fde7v1gbG5YsnKLTapWTB8RfLiauP3P2og7nDG1p
         NqIQKtRHXRS8Y/YqBD8+XL0SptodOtyKaIUOswuCo4KUQ1IYsrphzFGIpFlDC9fOBrJ6
         oJHuplRjqbn1XSdA4IAWKNETBuADlJmBnD6DhYmyl++NMfDDqHMLqfCBNmlkEJKaZPJO
         L4PB5jt/32q0Nh73m3a0P/0qDSkZ34x46Wy5owjYkLY5yb/0dJSMXa0Y+kcJzSXF1Y1D
         uVtSNKu9iH6xM05QCe47bLZ5TtN2LcBriwMCFoC4bZTd7d27zOp6Rny1V57vgkI1SmdE
         tIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pwd6pPOfjcWBYssAiTNpLV/0fJ/zD+lixc1xNtJf0dM=;
        b=QQxxXC/OkToHveKHlrdh/THpZsRATW/O3pq9BS7iRV73AaeO+aR5nykmnI7csixS9/
         Az6fhrU1occ/v7esrDCssB/JYBdGeWH5zPXeIO0/WUtRouhyCkvwex9d+x1lZ2tmijJS
         egmBnKHTZjoA90hO9XBqk4lUeQ2CNOEo76sbWDS2TDtlra36JYzZPhEKIZLmAFZTbSIW
         jro6SjPKQyQ+Fl0qZXEeCXM4eOZfPcVC4OHlJ4JJYJlIWBdw1IpSfLfljhqoPWU1gbyJ
         rmvXMbrCho/9r2VlDJ842SkZmMuA2Wrx3Ar3vHTjG16yHxkhp1p+VTt8mUwbrmky0uSs
         t/KQ==
X-Gm-Message-State: APjAAAXH3mBdawtoLdKEBExjZp7oSThPKMln7tHS8JuVUKxvLwq1Si/A
        YcanLTK0964A1zUqd3ikiZI=
X-Google-Smtp-Source: APXvYqwvzoAamwVJoubFH05zcgHB4geGaEetaFCpGtR6A2CuUJYuQerqEOKLD6qZWM0MhbitTf54NQ==
X-Received: by 2002:aa7:9ec9:: with SMTP id r9mr4213707pfq.85.1578479088546;
        Wed, 08 Jan 2020 02:24:48 -0800 (PST)
Received: from VM_16_2_centos.localdomain ([150.109.63.214])
        by smtp.gmail.com with ESMTPSA id 13sm2986301pfi.78.2020.01.08.02.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 02:24:48 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, aneesh.kumar@linux.ibm.com,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH v2] mm:fix gup_pud_range
Date:   Wed,  8 Jan 2020 18:24:44 +0800
Message-Id: <1578479084-15508-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for not processing for a long time. I met it again.

patch v1   https://lkml.org/lkml/2019/9/20/656

do_machine_check()
  do_memory_failure()
    memory_failure()
      hw_poison_user_mappings()
        try_to_unmap()
          pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));

...and now we have a swap entry that indicates that the page entry
refers to a bad (and poisoned) page of memory, but gup_fast() at this
level of the page table was ignoring swap entries, and incorrectly
assuming that "!pxd_none() == valid and present".

And this was not just a poisoned page problem, but a generaly swap entry
problem. So, any swap entry type (device memory migration, numa migration,
or just regular swapping) could lead to the same problem.

Fix this by checking for pxd_present(), instead of pxd_none().

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 7646bf9..9c41670 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2237,7 +2237,7 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
 		pud_t pud = READ_ONCE(*pudp);
 
 		next = pud_addr_end(addr, end);
-		if (pud_none(pud))
+		if (unlikely(!pud_present(pud)))
 			return 0;
 		if (unlikely(pud_huge(pud))) {
 			if (!gup_huge_pud(pud, pudp, addr, next, flags,
-- 
1.8.3.1

