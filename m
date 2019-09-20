Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88881C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD5B2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8TdJ0eZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404456AbfITPvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:51:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45727 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404366AbfITPvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:51:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id u12so3357899pls.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a9/+SgLw8oNthBvjNUOXlSYCITnE6ULq2xe/7PxSFng=;
        b=D8TdJ0eZLo56jrxmPqeHGtDTxK71Db3O3RkprW0rUp5xPNG1+B1eHTeQrRltVckSWF
         VPkTMmwvLB4sRoscbyxgkH7mhbyDf02XNyJVH7OwQVQjhKIYWRBmuLbBJPVpDqVHlcnK
         kIcfXcIoDM9N2LYiP6UNLfIsZDDXywyBoYp3st9tOUZsAuIjfVgk6ohJ/7qF/NQeQHBj
         JrFcbdmG47Optksq/DXrz6iiKDSLFZK9YX62jdj3Hz2oWG9pVLBC4MCABuCz8ScplEAD
         zvUQ42sW+uWHw7zH3RQUNXp33lHi7z1Bpkm+DxB5+GycSt+FegrJD43EHBQfrvJGjhxR
         YT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a9/+SgLw8oNthBvjNUOXlSYCITnE6ULq2xe/7PxSFng=;
        b=hO7YEsBv8BsJybhOxaTiQBS9Yp9VJkuGtW+JR4VOEO5n58cxWmxQG39mGHRDBmuddY
         cWxJ3NMZO1122QjhtFu6/TsuG8rsaM8ul++MZpTwahvH5IIt7xPscalzII3sR5Vb5qi+
         nXjlTvd8XiaYtmQno59VSnAWucubnwmGRI4KIA1Ri0HuUo5WMfO4hW91VybP0uy/BnLA
         84DcG4Gy7nkQf8EN58m6Liw8qY7YmFCRtjEx/1kw2PgbFZR+Z1gJKOQJYBG1RXHt6mXT
         kw1Y6f48/m1TFTHLb9d1jpGj7eNo1XZyPoJ3l5um0dMJd8n30j3mS/+cvl5wlzQ3B8TD
         IzGw==
X-Gm-Message-State: APjAAAVB5KeBerqNFOsmCV8Weuj1wLSnSuwijPyObcBXoceMw5l1dWvb
        c3m0TD73EGod2lIFoLK5Z3Y=
X-Google-Smtp-Source: APXvYqxvndhpCMApsjE1tUfROofkiXe1h+7EpvrbdBEDGEpqdoyzYXhe/1Jhv/MZc5NjEevXWQ/8kg==
X-Received: by 2002:a17:902:b903:: with SMTP id bf3mr18096396plb.1.1568994690390;
        Fri, 20 Sep 2019 08:51:30 -0700 (PDT)
Received: from hqjagain.localdomain ([47.56.172.21])
        by smtp.gmail.com with ESMTPSA id e4sm2422792pff.22.2019.09.20.08.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:51:29 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     akpm@linux-foundation.org
Cc:     ira.weiny@intel.com, jgg@ziepe.ca, dan.j.williams@intel.com,
        rppt@linux.ibm.com, hqjagain@gmail.com, jhubbard@nvidia.com,
        aneesh.kumar@linux.ibm.com, keith.busch@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm:fix gup_pud_range
Date:   Fri, 20 Sep 2019 23:51:24 +0800
Message-Id: <1568994684-1425-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__get_user_pages_fast try to walk the page table but the
hugepage pte is replace by hwpoison swap entry by mca path.
...
[15798.177437] mce: Uncorrected hardware memory error in
				user-access at 224f1761c0
[15798.180171] MCE 0x224f176: Killing pal_main:6784 due to
				hardware memory corruption
[15798.180176] MCE 0x224f176: Killing qemu-system-x86:167336
				due to hardware memory corruption
...
[15798.180206] BUG: unable to handle kernel
[15798.180226] paging request at ffff891200003000
[15798.180236] IP: [<ffffffff8106edae>] gup_pud_range+
				0x13e/0x1e0
...

We need to skip the hwpoison entry in gup_pud_range.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 mm/gup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 98f13ab..6157ed9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2230,6 +2230,8 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
 		next = pud_addr_end(addr, end);
 		if (pud_none(pud))
 			return 0;
+		if (unlikely(!pud_present(pud)))
+			return 0;
 		if (unlikely(pud_huge(pud))) {
 			if (!gup_huge_pud(pud, pudp, addr, next, flags,
 					  pages, nr))
-- 
1.8.3.1

