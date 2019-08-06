Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EBBC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2422070C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov06WqFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbfHFIAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:00:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33965 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbfHFIAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:00:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so37557349plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJLvXO26uNAgUTLj60JeKo10xs/5jo+93bjXJtmEioQ=;
        b=Ov06WqFFY5F/mrImBwDzAGW2EMBWCuuAhDL1ZdsHVeP80acUV+W08iVCFtalIXtiqs
         Zb2ePWkpruGrrBPtU/pHKyjQbllrpPlgiUhu7jXat9twql0Kp/09g9hxcrSxf6bpAsKk
         Cb95Vt3v/XsCzvrZo1Ettv33EwB0GMhW3PeHDCdoLR4rQqrEa1uy3+OwC4vl7keb48uh
         gy8GVUJ8aue7XghwW9YnFWsBme4do20rvhV5SARX11rG7UTIpsQNvJ63B8inkppv8xS5
         nCu07LatsWfyhe9v1QL5e59QtWMNu7ENLerKRwFz1MIWpsqbYYDH28du8EGWHcXg1wQk
         299Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJLvXO26uNAgUTLj60JeKo10xs/5jo+93bjXJtmEioQ=;
        b=Zz7lPg5OHNQshhvP+r689Z8FvpQp7kDypJ03yCLA4skFf2epxfCv9BGH+OKxsjZzkq
         CzC2k/Gbw0kZMT09PKaWcj5vWNmDlhjo5ioWSq6tVjP5Lg3f0il+SBbQAfMTnEUC7kTH
         QeL46oSXuew0WR28rjuiBybVPh+LXQp6Y222ZEPTys3O//YBcLns9aeLf2ra69JBS6IE
         dgVTV8tpvA60bwonoNDyU5CCbFmwgVh68NbJy1F4XFKAapfaTW2EAf0ZsQ8MjBbExVHe
         AkWzpS7XzHN9HrDXeE5c3OkdQPdIttJQlX8vFlJrltSLAF9p96f6CGdUGayyHzgkB27N
         jsjw==
X-Gm-Message-State: APjAAAUxsCngJI7u3Rtqp3yv/B+yJFzCx9zIzmEVSOBI1Tx5c714E3KM
        lDSNycfWMyfigcgMMe0rBA==
X-Google-Smtp-Source: APXvYqzCPLsm7dfAooib/V/VTYqbHUQPePIInQAoDof4+Yj607pvI0yjcNDlSnn6Ie1lWQ4lqIBACg==
X-Received: by 2002:a17:902:549:: with SMTP id 67mr1920696plf.86.1565078439075;
        Tue, 06 Aug 2019 01:00:39 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p7sm96840679pfp.131.2019.08.06.01.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 01:00:38 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm/migrate: see hole as invalid source page
Date:   Tue,  6 Aug 2019 16:00:10 +0800
Message-Id: <1565078411-27082-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1565078411-27082-1-git-send-email-kernelfans@gmail.com>
References: <1565078411-27082-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIGRATE_PFN_MIGRATE marks a valid pfn, further more, suitable to migrate.
As for hole, there is no valid pfn, not to mention migration.

Before this patch, hole has already relied on the following code to be
filtered out. Hence it is more reasonable to see hole as invalid source
page.
migrate_vma_prepare()
{
		struct page *page = migrate_pfn_to_page(migrate->src[i]);

		if (!page || (migrate->src[i] & MIGRATE_PFN_MIGRATE))
		     \_ this condition
}

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Jan Kara <jack@suse.cz>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/migrate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c2ec614..832483f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2136,10 +2136,9 @@ static int migrate_vma_collect_hole(unsigned long start,
 	unsigned long addr;
 
 	for (addr = start & PAGE_MASK; addr < end; addr += PAGE_SIZE) {
-		migrate->src[migrate->npages] = MIGRATE_PFN_MIGRATE;
+		migrate->src[migrate->npages] = 0;
 		migrate->dst[migrate->npages] = 0;
 		migrate->npages++;
-		migrate->cpages++;
 	}
 
 	return 0;
@@ -2228,8 +2227,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		pfn = pte_pfn(pte);
 
 		if (pte_none(pte)) {
-			mpfn = MIGRATE_PFN_MIGRATE;
-			migrate->cpages++;
+			mpfn = 0;
 			goto next;
 		}
 
-- 
2.7.5

