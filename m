Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8715C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04CD20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfCDUAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:00:48 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:37263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDUAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:00:48 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M6UVr-1gu34r0Gef-006t1z; Mon, 04 Mar 2019 21:00:32 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hmm: fix unused variable warnings
Date:   Mon,  4 Mar 2019 21:00:10 +0100
Message-Id: <20190304200026.1140281-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oWsSM4Y3uyql69Hm+fLCuZ/Z86r27PiGHo7NAGMIgk4M3l90Nmy
 ydt8NvS6JaKV9VYNJVXLvscG9GMvo8XEdiR6O3sbiNSD7GDDpU1tE+T8tlNO8zQbwDD+k8E
 frU6qfqluZQZsGnwrwDOxAonBEvSxyVOmY9fmDQpIhagAGKEhh7UwYeUUNj89pMMdI1vMmz
 cLJYkuRg8vUOAfTEjf+Bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LbCpmeYVQ1U=:XVRFS0l/dUFasWwUJgPIv1
 ToRudy+Iv+x7SApootlGef3ekqNy0FBxNQSrUS1m6HtV3vIVDE0SbbhpiTagwLoHowEOHWP/m
 pVsKzk9glXiv1wz8HBLU4ZIlonYcgQVnj5t+r/UYnxvG7BzVx7BLPSiEnq2UtCoxSgKm+9qNv
 VnuIIEZa6CV0WcjB2rJt3spS0GGwNYzY6CVvGKcDDS60UijVm9H1wWFUODOTAg/bdXp69StXl
 UvSk71BoH2XAVeQnHrZr5PL+hgOnmgjiZe/uuhasbIShcQwCObHpfOMDy3eSzmF8gWJMzH8Yo
 C5gRjXpqguAj/FJlY3J2OxCdYCZ660/Zp6fwaQkIQH5HumHTfM370DD3QbmszKGsWgJizbRTR
 ue9xQ+RiNntu+g+b8M07hhiZlGzH5XIkX4GOvHofQ9F4RauryZW4E4STvAoiAjpomwZSihthp
 5BbMWf34FGrKLMxAoidOLEVcRHkAqXHShXSZgOxGE5zd9Bjjx6IYXNuPU0dVqPSRTeYsfAx1j
 IMNEkTyMStC/EjzZrwCAOaWTf1cRT310OcHuj54g5YWs4SluXcRpjkXSrdljhWXKZsngfVHOX
 cfZVguTufmuAci5UNUwE2yFHGqSgulN2amAO2G1Jpjjn+xbvqspz9nQo1JDGlo9OjJNGyJqPR
 agdR/bQiwx1bTK6np7azeryTDA/FLrKJDmFlfvkkOgbSGFVnXyFO9dyV8e+/1BiA/lFPPddLZ
 4a91sSb12qpjgIIN5rgqj85y93y31rlswfP48w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_HUGETLB_PAGE is disabled, the only use of the variable 'h'
is compiled out, and the compiler thinks it is unnecessary:

mm/hmm.c: In function 'hmm_range_snapshot':
mm/hmm.c:1015:19: error: unused variable 'h' [-Werror=unused-variable]
    struct hstate *h = hstate_vma(vma);

Rephrase the code to avoid the temporary variable instead, so the
compiler stops warning.

Fixes: 5409a90d4212 ("mm/hmm: support hugetlbfs (snapshotting, faulting and DMA mapping)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/hmm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 3c9781037918..c4beb1628cad 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1012,9 +1012,8 @@ long hmm_range_snapshot(struct hmm_range *range)
 			return -EFAULT;
 
 		if (is_vm_hugetlb_page(vma)) {
-			struct hstate *h = hstate_vma(vma);
-
-			if (huge_page_shift(h) != range->page_shift &&
+			if (range->page_shift !=
+				huge_page_shift(hstate_vma(vma)) &&
 			    range->page_shift != PAGE_SHIFT)
 				return -EINVAL;
 		} else {
@@ -1115,9 +1114,8 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 			return -EFAULT;
 
 		if (is_vm_hugetlb_page(vma)) {
-			struct hstate *h = hstate_vma(vma);
-
-			if (huge_page_shift(h) != range->page_shift &&
+			if (range->page_shift !=
+				huge_page_shift(hstate_vma(vma)) &&
 			    range->page_shift != PAGE_SHIFT)
 				return -EINVAL;
 		} else {
-- 
2.20.0

