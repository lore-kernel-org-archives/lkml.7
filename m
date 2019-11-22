Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAE7C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E9E2071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574453368;
	bh=Dvd17sN9aKtG3WDYVBtYh+HeEMUwJ3hipC55jNi6qBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Afqdp+na+U4c7llxKxWbT3L3sMa3DNRBSX8tbkqatSx8wSOaEqrjTN5/sHTRFZtFa
	 ZUxkywEwaPAVhB5tNutSzAEV9VK1RvGzq7wRctiJ+Ub6/Q2OjHkf+6Reen3r5gQvcx
	 uRb432vANEdFKdFyjmesmtux8lO5TB9gOAThMhcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfKVUJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbfKVUJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:09:23 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 438402070E;
        Fri, 22 Nov 2019 20:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574453363;
        bh=Dvd17sN9aKtG3WDYVBtYh+HeEMUwJ3hipC55jNi6qBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mG6KoUt4L/RNymmjDaeJHrvG8+kzFySvErqhsboZFRI3tUMmhSD0969niKGARYKa2
         c0jeZ29pWiSrR50IQ2hrTfzU2oECLvzkBfF1n26yZ+WVCUoMWSVnU0eXPYVEkdawpE
         waNaodEt78IsNaJZuJ1i07dwHJLurkcdninAbWds=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Ramon Pantin <pantin@google.com>
Subject: [PATCH 2/2] f2fs: stop GC when the victim becomes fully valid
Date:   Fri, 22 Nov 2019 12:09:20 -0800
Message-Id: <20191122200920.83941-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20191122200920.83941-1-jaegeuk@kernel.org>
References: <20191122200920.83941-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must stop GC, once the segment becomes fully valid. Otherwise, it can
produce another dirty segments by moving valid blocks in the segment partially.

Ramon hit no free segment panic sometimes and saw this case happens when
validating reliable file pinning feature.

Signed-off-by: Ramon Pantin <pantin@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 24a3b6b52210..b3d399623290 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1012,8 +1012,14 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		block_t start_bidx;
 		nid_t nid = le32_to_cpu(entry->nid);
 
-		/* stop BG_GC if there is not enough free sections. */
-		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0))
+		/*
+		 * stop BG_GC if there is not enough free sections.
+		 * Or, stop GC if the segment becomes fully valid caused by
+		 * race condition along with SSR block allocation.
+		 */
+		if ((gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) ||
+				get_valid_blocks(sbi, segno, false) ==
+							sbi->blocks_per_seg)
 			return submitted;
 
 		if (check_valid_map(sbi, segno, off) == 0)
-- 
2.19.0.605.g01d371f741-goog

