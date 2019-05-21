Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4243FC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B462217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558461990;
	bh=LrTl2rHkLKG/Z0EywGv7rApN2wATqjxr8QL5bVuf8yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JPY6YLClLaunyTS132y0GkSm9BbiwFn/QKfSDJh4Vr103u3f31upFHYoJg6VzljyO
	 9jjkLqwJR+wXlAln3YINFH41l07XJL1TmuhKPWViBVB55i/j/9+tVh8fPgAZzbgIpz
	 oW4LKHM8KXxHXEZNthq9katszy3Y61rD7p/fqtPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfEUSG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 14:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbfEUSG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:06:28 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA036217D9;
        Tue, 21 May 2019 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558461987;
        bh=LrTl2rHkLKG/Z0EywGv7rApN2wATqjxr8QL5bVuf8yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hb5uSo+BF8rXr2ggilNGd0Jh7cMrqh0GnNCsrlzqJ0Ey9vlqXBEJmkJH2ysmT5uex
         3qQ2ZwwTaqavcn9GWwPU+Q2K7l2pl7XzELj6a1nUDNkSB4yD7rhFdU5GO2bgbRy+bb
         H30N2LdMhfMTz7QnywXiVCTPXiYbqlh3oL2Omet0=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: allow ssr block allocation during checkpoint=disable period
Date:   Tue, 21 May 2019 11:06:25 -0700
Message-Id: <20190521180625.10562-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20190521180625.10562-1-jaegeuk@kernel.org>
References: <20190521180625.10562-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to use ssr during checkpoint is disabled.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 963fb4571fd9..1e029da26053 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -387,7 +387,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 			goto next;
 		/* Don't touch checkpointed data */
 		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
-					get_ckpt_valid_blocks(sbi, segno)))
+					get_ckpt_valid_blocks(sbi, segno) &&
+					p.alloc_mode != SSR))
 			goto next;
 		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
 			goto next;
-- 
2.19.0.605.g01d371f741-goog

