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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53507C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C332070C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLB7WEzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbfHFIAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:00:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46488 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbfHFIAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:00:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3so3944103pgt.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 01:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aV69onuQcwDqEYz62/w3oHFd2R0PARV3h+ba+PwsLJU=;
        b=TLB7WEzMV1FG9qsC+tFG0uVO2zJplwy4NMtcXZmIe83n8bPedvYIg0kRV+0BKaC2/W
         qA1bhXaKHBsjod4hTqmfQwF/lUsR277uCh8BUc5BQAE/w4nKQrmd9u5fBIRR3tWkijJN
         P5PrCFxtrlEUtjIManUEPXxHYB6fAs1VwWq1OkSVqmhXQKqSYhkRRd1j5LGp6QOrTvkB
         sGzDPsINgXkaDyPTnVx/qVsPefVhLgtJSuNlRD6IbkGv6hdmE3xmprXG4kWR5dvjsvc6
         Zcxp+1RmUOKxSrb97ji+pRTFedoopdRumI6BPcbOWQ/ZBZwy1O8iwqkQ+sCrr5SwppNd
         dRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aV69onuQcwDqEYz62/w3oHFd2R0PARV3h+ba+PwsLJU=;
        b=RQXcyye7nR43N3syo1+9nuejIy/q/DLv5bs1HiXpiclmB8mHeLGiMPuBn8NdeCFj7j
         ng1zFx5aFRaRKiUq5HAo6vztF3eC0ygZ0H2KBTnRx0QsztM9UMGK/EA0ZrcdUjzR2CdX
         BPzimLJvdTCY2t/3jbgWRfT7Qp07GXeHnDd4yxV4fnx9kYRibyeaMD5yGbM9m5YWjnhw
         YuQjDEo81xNU2hm8XtBnIFAAMeFj5IdC1AGIS2p7FKE/OZD95SRtn0XU0KjEJA2R2itp
         fe0C6NTvfLrmq4q8I4LhWwLtvplPVrs0vu+xfJWUpIpnO7bqpETbroRUiag5QiigO0km
         TBhw==
X-Gm-Message-State: APjAAAUqh5Phv3Ro/0ctkADeu5e9HAkAaqtzpD4alUa0qs54Er8/4sJN
        kMUiIyOc//6mpa9xwJ1Tig==
X-Google-Smtp-Source: APXvYqzcRDSMRahvNSlA2NE7YehHcCK+DdqZfd9iDDVrttQjMFGM+2BAVpZ47/jY+R7q00gXTs3ESQ==
X-Received: by 2002:a62:be04:: with SMTP id l4mr2260030pff.77.1565078433810;
        Tue, 06 Aug 2019 01:00:33 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p7sm96840679pfp.131.2019.08.06.01.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 01:00:33 -0700 (PDT)
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
Subject: [PATCH 1/3] mm/migrate: clean up useless code in migrate_vma_collect_pmd()
Date:   Tue,  6 Aug 2019 16:00:09 +0800
Message-Id: <1565078411-27082-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 mm/migrate.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8992741..c2ec614 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2230,7 +2230,6 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		if (pte_none(pte)) {
 			mpfn = MIGRATE_PFN_MIGRATE;
 			migrate->cpages++;
-			pfn = 0;
 			goto next;
 		}
 
@@ -2255,7 +2254,6 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			if (is_zero_pfn(pfn)) {
 				mpfn = MIGRATE_PFN_MIGRATE;
 				migrate->cpages++;
-				pfn = 0;
 				goto next;
 			}
 			page = vm_normal_page(migrate->vma, addr, pte);
@@ -2265,10 +2263,9 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 		/* FIXME support THP */
 		if (!page || !page->mapping || PageTransCompound(page)) {
-			mpfn = pfn = 0;
+			mpfn = 0;
 			goto next;
 		}
-		pfn = page_to_pfn(page);
 
 		/*
 		 * By getting a reference on the page we pin it and that blocks
-- 
2.7.5

