Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D77C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E90920675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfCFLB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:01:26 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:47381 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbfCFLB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:01:26 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MRmsE-1gYMov1bac-00TFwb; Wed, 06 Mar 2019 12:01:11 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hmm: fix unused variable warning in hmm_vma_walk_pud
Date:   Wed,  6 Mar 2019 12:00:55 +0100
Message-Id: <20190306110109.2386057-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xtKHG1cotgsAuNU1Bh1vZIBHyo9Waba/hnKI7aokdYdMmG9jdy9
 zH9VdScakVcGI7/TId/fO8MqEKIZf1ch2ZM2GM4nybKMMiz8gwKm7EsFVsbbBRVaxNloebZ
 8afArbe2cCMc7AFVB66+LlGjcdX4fIysCx2jXXnhY2OAN6AQ1w5FNFb5Yg1g1IhLWKStmTo
 DRx0Y565hgf0Y8OO9dBTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yx9f28pAM/I=:LmhQn3gu0AVe24ypm4s4fC
 3gcoRijC1djG5MbSwcAYiYtF0ikuE7r6iiK1WBdlQ/rSYM0xFga6ZfDJzuw6Rx2/uZHfUxNlw
 56K4L/6owPUNVuu96ydKxBLUbJOCorQqgZLWYC+N2uoUChcIStaVVQYglLfeFEwnzgRWdXm3Y
 pWIpI8aX9Hz4D8ZTyRcz+LB3fxsCo229VCooikJ8pWWTei8ytU14DhWXMKEaT6vonU+rx2UTJ
 jfE9tZRCP1xGIxGqi1fubuPe6EEJekUZQpUi8/y/Fn81T3NrTfg159QobxPLgaMbo0sf6N3RR
 WMufqHg2daokoqY6V7GOxSqwrQuHpyClSp1bKiIYk0JhpilPt8Xxzlep04lvdSjYerAWUCt+8
 no+tp3dRMqNY/SJJuZPkJiseV9fhN0bjgYnnG7Q0ZV3HHsZpntL1vtvprfWh/UuQ0QH//l+II
 PLwtCCERbjmqeEODldUOZD/3PPLgktUF53GIv4wZFs1QXZQq/xDwD3H5Krq/1jcM61ZBKd0Kd
 JxZ4nN/1WjqNbyEnv0IAHospjVFWvKKE0girpwEqIfEB+Hq8r+riiLQ5g6Wn/wDTg0k0a5OoA
 7nRkax9tPYEvU83GXsLm5dR+2nuKK/vFg92NSaX4xXgrNpxraWjneQIRfrg+ptz1n9+ZV29/T
 I2tqfSbCee/b8J0+J7dOwmuhp2WfspcBhV+2TH8uWpEsUvnBhTg+rbEAPKPG4HzlyC1DvnwFP
 B6r9w1bPjR8k4VnH1WJutlkZ4QPpyOv4N/w2Xg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_HUGETLB_PAGE, the 'vma' variable is never referenced
on x86, so we get this warning:

mm/hmm.c: In function 'hmm_vma_walk_pud':
mm/hmm.c:764:25: error: unused variable 'vma' [-Werror=unused-variable]

Remove the local variable by open-coding walk-vma in the only
place it is used.

Reported-by: John Hubbard <jhubbard@nvidia.com>
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Fixes: 1bed8a07a556 ("mm/hmm: allow to mirror vma of a file on a DAX backed filesystem")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Andrew, you already took a similar patch from me for a different
warning in the same file. Feel free to fold both patches into
one if you haven't already forwarded the first patch, or leave
them separate. Note that the warnings were introduced by different
patches from the same series originally.
---
 mm/hmm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index c4beb1628cad..c1cbe82d12b5 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -761,7 +761,6 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
-	struct vm_area_struct *vma = walk->vma;
 	unsigned long addr = start, next;
 	pmd_t *pmdp;
 	pud_t pud;
@@ -807,7 +806,7 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 		return 0;
 	}
 
-	split_huge_pud(vma, pudp, addr);
+	split_huge_pud(walk->vma, pudp, addr);
 	if (pud_none(*pudp))
 		goto again;
 
-- 
2.20.0

