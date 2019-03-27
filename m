Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12469C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4A12087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709772;
	bh=b5xJuu4cKmJC0HBUNTG66oXfu8IqPF1/ejzqYlsS8zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rZVFuguNZz4117wjZ3fZftu7NFTgg21zb5NeaOVihCJTN6x19f4NcOlKS+nq9nu0R
	 ab+UZt9qf0/tmM9kA4BmAtsDku349xDvjlOYz+SQ9TI5f9n7ceDkwUS7WoNdviqyMR
	 IRu8TeFgXhDMBS3dl49S63irVLlCaWCzEu2gWN6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbfC0SCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731250AbfC0SCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:02:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C1D22082F;
        Wed, 27 Mar 2019 18:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709768;
        bh=b5xJuu4cKmJC0HBUNTG66oXfu8IqPF1/ejzqYlsS8zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBaKqEmYIAB49HWucvLauhdZFKkmZxCUMrWtfwDMDOxFJzoBdZfIw8b0dcd+4PeQN
         MRR7BLRlpWtTGF878QXdZqfxdmAAlCevJD2dIrvXfgJhC24iDJ2J+HVMr5hOrBeIFN
         AdDzqyK1ed7xLuZY31ZDlguYZEU/7u5i2ALmpRIc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 5.0 030/262] mm/sparse: fix a bad comparison
Date:   Wed, 27 Mar 2019 13:58:05 -0400
Message-Id: <20190327180158.10245-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

[ Upstream commit d778015ac95bc036af73342c878ab19250e01fe1 ]

next_present_section_nr() could only return an unsigned number -1, so
just check it specifically where compilers will convert -1 to unsigned
if needed.

  mm/sparse.c: In function 'sparse_init_nid':
  mm/sparse.c:200:20: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
         ((section_nr >= 0) &&    \
                      ^~
  mm/sparse.c:478:2: note: in expansion of macro
  'for_each_present_section_nr'
    for_each_present_section_nr(pnum_begin, pnum) {
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  mm/sparse.c:200:20: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
         ((section_nr >= 0) &&    \
                      ^~
  mm/sparse.c:497:2: note: in expansion of macro
  'for_each_present_section_nr'
    for_each_present_section_nr(pnum_begin, pnum) {
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  mm/sparse.c: In function 'sparse_init':
  mm/sparse.c:200:20: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
         ((section_nr >= 0) &&    \
                      ^~
  mm/sparse.c:520:2: note: in expansion of macro
  'for_each_present_section_nr'
    for_each_present_section_nr(pnum_begin + 1, pnum_end) {
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Link: http://lkml.kernel.org/r/20190228181839.86504-1-cai@lca.pw
Fixes: c4e1be9ec113 ("mm, sparsemem: break out of loops early")
Signed-off-by: Qian Cai <cai@lca.pw>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 7ea5dc6c6b19..77a0554fa5bd 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -197,7 +197,7 @@ static inline int next_present_section_nr(int section_nr)
 }
 #define for_each_present_section_nr(start, section_nr)		\
 	for (section_nr = next_present_section_nr(start-1);	\
-	     ((section_nr >= 0) &&				\
+	     ((section_nr != -1) &&				\
 	      (section_nr <= __highest_present_section_nr));	\
 	     section_nr = next_present_section_nr(section_nr))
 
-- 
2.19.1

