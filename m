Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0D6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C643218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368914;
	bh=aK6yfdciN61QV88irDmEzAapsNhXC7Hkq9AoJo99LLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cN0TtNOZkb8hEaNia5ozraeUk1DVOeJRCwbn7V2RIR88UrwiWEwtor0ln0A3wZKfc
	 cQwfBKRkgjk2b6m05/EKsNA9I3ipoolB327E3mfGVpVAbOji0faRMl00VtYP2dYprf
	 /jqeBuDAdgtQhYPSoAcGNU8alPmt5YydouYm7/EQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbfDDJIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732442AbfDDJI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:08:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD24321872;
        Thu,  4 Apr 2019 09:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368909;
        bh=aK6yfdciN61QV88irDmEzAapsNhXC7Hkq9AoJo99LLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/h5b3KvnEyO7NMHb++eTKTAOEtG1uzuMoXv+UhAbFC4GPieQ4ygKBgGlVyvktzQb
         LRs3StOnB2PMjOBD4PtaRbwBlqh11N2OOViGBFTH4BFFz9BL5eZuSdOJV1vim7TRoY
         Gt3LBck5cdkgaWR5UQVN+uqVoPXNxKz7d1ZK51DU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 026/246] mm/sparse: fix a bad comparison
Date:   Thu,  4 Apr 2019 10:45:26 +0200
Message-Id: <20190404084620.034350210@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 4763519d4399..b3771f35a0ed 100644
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



