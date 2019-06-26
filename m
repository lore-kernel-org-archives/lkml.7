Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5040AC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274BC217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520800;
	bh=6dWU0dNv9cYf+yPMs3W3XUy0ihTiE85lp1iKoVZoxn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=noB4Z36p/G5IwD/U/d7RlMpr5iKYgaPEaj35F4ZieTcWxqQh/vOUtqDE7YIsNb+Ww
	 9Fj/cOt2U1/a0i770bRNG/F0wOBET1doPXgv20/hJDQajXBTRmeV3VPBS242CVR17M
	 77+9Gr0gkAqZY300XEmnlCKs4GvnHBQWnh08dLcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfFZDqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbfFZDqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:46:37 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-82.mobile.att.net [107.77.172.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20FF7208CB;
        Wed, 26 Jun 2019 03:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520796;
        bh=6dWU0dNv9cYf+yPMs3W3XUy0ihTiE85lp1iKoVZoxn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MjTBTwPXskrnUj7eqa3LdcHIaQRzIHGii9RFD/cg5l19l4WqC1hpOj8gbYUJZC0vK
         u93ZCujT4smTzV8SKGtlUBzyo7QqhzXZKWsXzZltDjN9YEZ0G4KENvMhVi352IqLiU
         qlFqtyjQcV4dLOqbfl4eyYqpBhC1KTFdmJh8Vggc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     swkhack <swkhack@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.9 11/11] mm/mlock.c: change count_mm_mlocked_page_nr return type
Date:   Tue, 25 Jun 2019 23:46:01 -0400
Message-Id: <20190626034602.24367-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034602.24367-1-sashal@kernel.org>
References: <20190626034602.24367-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: swkhack <swkhack@gmail.com>

[ Upstream commit 0874bb49bb21bf24deda853e8bf61b8325e24bcb ]

On a 64-bit machine the value of "vma->vm_end - vma->vm_start" may be
negative when using 32 bit ints and the "count >> PAGE_SHIFT"'s result
will be wrong.  So change the local variable and return value to
unsigned long to fix the problem.

Link: http://lkml.kernel.org/r/20190513023701.83056-1-swkhack@gmail.com
Fixes: 0cf2f6f6dc60 ("mm: mlock: check against vma for actual mlock() size")
Signed-off-by: swkhack <swkhack@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mlock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index f0505692a5f4..3e7fe404bfb8 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -630,11 +630,11 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
  * is also counted.
  * Return value: previously mlocked page counts
  */
-static int count_mm_mlocked_page_nr(struct mm_struct *mm,
+static unsigned long count_mm_mlocked_page_nr(struct mm_struct *mm,
 		unsigned long start, size_t len)
 {
 	struct vm_area_struct *vma;
-	int count = 0;
+	unsigned long count = 0;
 
 	if (mm == NULL)
 		mm = current->mm;
-- 
2.20.1

