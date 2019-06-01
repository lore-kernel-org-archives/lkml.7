Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770F5C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5086B2238C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395044;
	bh=Jt7V68HZiWXTwbMN1VICdRfxSL5xySYNAxl4eFdrVlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gwKdLO1nOpUbN0KN0gcJbH9YMooUFYLaLvDJBfDzxlLhzJONdkWV0NrsYYqlz1R5F
	 tzkfANY+6psBFqHiWO3PS+jO+HFcWkHzF2LTrJwoG+TuwO4Zl9ZV1vFmXFIDSdOAX8
	 mNuKAMaxCIy36vmdgVso8Q2IQ/fSHR+xYorn7FGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfFANRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbfFANRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:17:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B4132725B;
        Sat,  1 Jun 2019 13:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395038;
        bh=Jt7V68HZiWXTwbMN1VICdRfxSL5xySYNAxl4eFdrVlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEcQjyjMTafUVkUJtoC2ywncRgBfpBy+Y4++RYRM5Fys7WbR8OXQyHEUS+hUv9WNw
         Zv2shBFQdclcLt+BGP2rgH6VUry4iM4/Lj+nI9GZHCZ0a4rCOduBsm9NcrrnWFzHev
         RnLE5w4ovvYcTEvVm268N9MBEO68x9De77dfMfrE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <liu.song.a23@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 5.1 009/186] mm/mprotect.c: fix compilation warning because of unused 'mm' variable
Date:   Sat,  1 Jun 2019 09:13:45 -0400
Message-Id: <20190601131653.24205-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601131653.24205-1-sashal@kernel.org>
References: <20190601131653.24205-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

[ Upstream commit 94393c78964c432917014e3a456fa15c3e78f741 ]

Since 0cbe3e26abe0 ("mm: update ptep_modify_prot_start/commit to take
vm_area_struct as arg") the only place that uses the local 'mm' variable
in change_pte_range() is the call to set_pte_at().

Many architectures define set_pte_at() as macro that does not use the 'mm'
parameter, which generates the following compilation warning:

 CC      mm/mprotect.o
mm/mprotect.c: In function 'change_pte_range':
mm/mprotect.c:42:20: warning: unused variable 'mm' [-Wunused-variable]
  struct mm_struct *mm = vma->vm_mm;
                    ^~

Fix it by passing vma->mm to set_pte_at() and dropping the local 'mm'
variable in change_pte_range().

[liu.song.a23@gmail.com: fix missed conversions]
  Link: http://lkml.kernel.org/r/CAPhsuW6wcQgYLHNdBdw6m0YiR4RWsS4XzfpSKU7wBLLeOCTbpw@mail.gmail.comLink: http://lkml.kernel.org/r/1557305432-4940-1-git-send-email-rppt@linux.ibm.com
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Song Liu <liu.song.a23@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mprotect.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 028c724dcb1ae..ab40f3d04aa37 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -39,7 +39,6 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		int dirty_accountable, int prot_numa)
 {
-	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
 	unsigned long pages = 0;
@@ -136,7 +135,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				newpte = swp_entry_to_pte(entry);
 				if (pte_swp_soft_dirty(oldpte))
 					newpte = pte_swp_mksoft_dirty(newpte);
-				set_pte_at(mm, addr, pte, newpte);
+				set_pte_at(vma->vm_mm, addr, pte, newpte);
 
 				pages++;
 			}
@@ -150,7 +149,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				 */
 				make_device_private_entry_read(&entry);
 				newpte = swp_entry_to_pte(entry);
-				set_pte_at(mm, addr, pte, newpte);
+				set_pte_at(vma->vm_mm, addr, pte, newpte);
 
 				pages++;
 			}
-- 
2.20.1

