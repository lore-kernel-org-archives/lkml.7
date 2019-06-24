Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E66C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83790214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ00Q4nD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfFXEVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 00:21:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36188 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfFXEVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 00:21:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id f21so6395324pgi.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 21:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/Vi0SmBJrr/dhcFyf+7ZAHJAQmuruaehm6iOPvzhh0A=;
        b=BZ00Q4nDJWbfG8+WDCxOo9DiaRK/yg6Yn/n2eoMxTA6AukHxBQvZ4+mZP16keQzAgb
         aCsv4jtOVZi0/bgxePIWQmSeq2A2N7zo1ty8lDc6eAOwMd2YYfJY3C/wFotgvEVEmnyB
         8/DgGIGsxZ8kk2ISnWjURBlXhlgWPpfWFRwr5CBk+ma0PfNx6V4v6/c1HQwctUNhXgHF
         YUmoVtW4aH+sw0cJQPaeBP2dq3g1jGkUWlPZRyyZ0z4hMy50mRrR/f/wIEnPmFifV64o
         uq+9VNBHCcsiEIIERe4TC4Kq1oC++FL/XWelwlAX+eliU/V0nipXL02bQBn0VfgV31u3
         5nZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Vi0SmBJrr/dhcFyf+7ZAHJAQmuruaehm6iOPvzhh0A=;
        b=goTNvnyvcOEk3dfSAeKPs5KQ6QXZhZcssFPIWAPkc/yht0XZV8VTHikgZ5hwe6tY7q
         g4WAOdCg38RPQ0qZFd/TmcZ+o42JJbxDs0mmS5fo+rQC5Lw5d6fDKWlct54qU6whz4PO
         oris5s7iR+syvlFnjjuDk+jh7tUb4psAbYXWOiIL6r+Ma6qoaD24B8Y5T96s0RfX/QL8
         Oso2eFn+cl57gE3ls31XiRZzfL5RNg+o3WqgxlWMvsgPsV1dtmUFM2dnicBExNa5re8N
         KAXisjmEqTzW7vBZkPzKfFn1orQm8bp6SknlYLoqqGMo7O1G4pWX/tukb/TP8LY3AwId
         poHQ==
X-Gm-Message-State: APjAAAUFncT0KMuH4pqDcdhLGkXpcig2+kfykahJzqItxSv4fTpbBoBW
        V7+xtVboP785e6GJEBczTaajack=
X-Google-Smtp-Source: APXvYqzk+mEWys6LQTcZ4E5e9NNeshfHFdIyEnJiuucAc3dGIR7ipjsKgsHr3zoJScBJt8PvZYLzhQ==
X-Received: by 2002:a63:8ac3:: with SMTP id y186mr24564759pgd.198.1561350083906;
        Sun, 23 Jun 2019 21:21:23 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w14sm10047181pfn.47.2019.06.23.21.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 21:21:23 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hugetlb: allow gigantic page allocation to migrate away smaller huge page
Date:   Mon, 24 Jun 2019 12:21:08 +0800
Message-Id: <1561350068-8966-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current pfn_range_valid_gigantic() rejects the pud huge page allocation
if there is a pmd huge page inside the candidate range.

But pud huge resource is more rare, which should align on 1GB on x86. It is
worth to allow migrating away pmd huge page to make room for a pud huge
page.

The same logic is applied to pgd and pud huge pages.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
---
 mm/hugetlb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ac843d3..02d1978 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1081,7 +1081,11 @@ static bool pfn_range_valid_gigantic(struct zone *z,
 			unsigned long start_pfn, unsigned long nr_pages)
 {
 	unsigned long i, end_pfn = start_pfn + nr_pages;
-	struct page *page;
+	struct page *page = pfn_to_page(start_pfn);
+
+	if (PageHuge(page))
+		if (compound_order(compound_head(page)) >= nr_pages)
+			return false;
 
 	for (i = start_pfn; i < end_pfn; i++) {
 		if (!pfn_valid(i))
@@ -1098,8 +1102,6 @@ static bool pfn_range_valid_gigantic(struct zone *z,
 		if (page_count(page) > 0)
 			return false;
 
-		if (PageHuge(page))
-			return false;
 	}
 
 	return true;
-- 
2.7.5

