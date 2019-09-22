Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33402C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010FF21BE5
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178157;
	bh=55epLifv/9ypt2pWBrwbCrVU96q+XbcR0MUL9tS6NaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GM82T1ActscXctiPF1RNospDnVEkoFDQ/QOMkN5l9Fr7KZL/7c2W6Fyypg1HjiVL7
	 DMK+QFF7k5PdbT01aLCdvQDwa+ZQlrDk5M0Svwj2Nf8runneiA18KtZ2VH6qW+mujL
	 +ZVpxrdyB/8e/nRMPltR1XSxXIsr0Ckr6RSaBvpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392164AbfIVStQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:49:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391864AbfIVSsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:48:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 345E821479;
        Sun, 22 Sep 2019 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178135;
        bh=55epLifv/9ypt2pWBrwbCrVU96q+XbcR0MUL9tS6NaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tb080fzcea1f3yGtTMjbTNmM6VxTVHTS2d8bqRDtnoikMwPnZLNy9qVTmh3wM7PQ7
         MmywxsbZnmpYkw5cTlBsQrsPjL0Bj9yQnB8d8pyLZphpnFYF3MZjqN+ces/CRbghGA
         WaikZbjJEZzkN/CMLt94Tztev1ZzvMrsaAGumMG0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nigel Croxon <ncroxon@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 186/203] raid5: don't increment read_errors on EILSEQ return
Date:   Sun, 22 Sep 2019 14:43:32 -0400
Message-Id: <20190922184350.30563-186-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nigel Croxon <ncroxon@redhat.com>

[ Upstream commit b76b4715eba0d0ed574f58918b29c1b2f0fa37a8 ]

While MD continues to count read errors returned by the lower layer.
If those errors are -EILSEQ, instead of -EIO, it should NOT increase
the read_errors count.

When RAID6 is set up on dm-integrity target that detects massive
corruption, the leg will be ejected from the array.  Even if the
issue is correctable with a sector re-write and the array has
necessary redundancy to correct it.

The leg is ejected because it runs up the rdev->read_errors beyond
conf->max_nr_stripes.  The return status in dm-drypt when there is
a data integrity error is -EILSEQ (BLK_STS_PROTECTION).

Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid5.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 21514edb2bea3..d574701185db9 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2526,7 +2526,8 @@ static void raid5_end_read_request(struct bio * bi)
 		int set_bad = 0;
 
 		clear_bit(R5_UPTODATE, &sh->dev[i].flags);
-		atomic_inc(&rdev->read_errors);
+		if (!(bi->bi_status == BLK_STS_PROTECTION))
+			atomic_inc(&rdev->read_errors);
 		if (test_bit(R5_ReadRepl, &sh->dev[i].flags))
 			pr_warn_ratelimited(
 				"md/raid:%s: read error on replacement device (sector %llu on %s).\n",
-- 
2.20.1

