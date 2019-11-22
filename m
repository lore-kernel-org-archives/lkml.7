Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAA9C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A614E2068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403071;
	bh=dem0dnbBYskFHC39U2QDOwYhTUAtk8tPl+8xAKosFFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bop0ilLP2mukYISZPtDNi2mSWkaukUxjXCQ5w1iX0M3jAD/2pjT2xC4S+cEl41OIf
	 25iWwB6bPAm2AI6Xs6PuKfAAEOIxDlKICUv4osXVOXu9bq5+Om/DfdjdlQ70VgxaMB
	 TTWPkGZ5ZV/cxXZgWA+mzRi5kxNTh8S9yLNbaleQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfKVGLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:11:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbfKVF4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:56:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55C572071F;
        Fri, 22 Nov 2019 05:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402197;
        bh=dem0dnbBYskFHC39U2QDOwYhTUAtk8tPl+8xAKosFFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=viFKi+GEQR2mOBNR7SAp6yqh+i2pT1wtOYIAM/vYwocX4pGz8R3kZokIS0009Nqmd
         DLpT7+UhWIIcu5byvQWYcG+6oMau9TSd4a489u2Fzyu3f1KJF3oxcMg7q0lEDGvMvr
         vbrUC8nMpQFTYZmT//Ox8XGwtO7k0qSrJKBVTZak=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sweet Tea <sweettea@redhat.com>,
        John Dorminy <jdorminy@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>, dm-devel@redhat.com
Subject: [PATCH AUTOSEL 4.14 046/127] dm flakey: Properly corrupt multi-page bios.
Date:   Fri, 22 Nov 2019 00:54:24 -0500
Message-Id: <20191122055544.3299-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sweet Tea <sweettea@redhat.com>

[ Upstream commit a00f5276e26636cbf72f24f79831026d2e2868e7 ]

The flakey target is documented to be able to corrupt the Nth byte in
a bio, but does not corrupt byte indices after the first biovec in the
bio. Change the corrupting function to actually corrupt the Nth byte
no matter in which biovec that index falls.

A test device generating two-page bios, atop a flakey device configured
to corrupt a byte index on the second page, verified both the failure
to corrupt before this patch and the expected corruption after this
change.

Signed-off-by: John Dorminy <jdorminy@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-flakey.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index 0c1ef63c3461b..b1b68e01b889c 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -282,20 +282,31 @@ static void flakey_map_bio(struct dm_target *ti, struct bio *bio)
 
 static void corrupt_bio_data(struct bio *bio, struct flakey_c *fc)
 {
-	unsigned bio_bytes = bio_cur_bytes(bio);
-	char *data = bio_data(bio);
+	unsigned int corrupt_bio_byte = fc->corrupt_bio_byte - 1;
+
+	struct bvec_iter iter;
+	struct bio_vec bvec;
+
+	if (!bio_has_data(bio))
+		return;
 
 	/*
-	 * Overwrite the Nth byte of the data returned.
+	 * Overwrite the Nth byte of the bio's data, on whichever page
+	 * it falls.
 	 */
-	if (data && bio_bytes >= fc->corrupt_bio_byte) {
-		data[fc->corrupt_bio_byte - 1] = fc->corrupt_bio_value;
-
-		DMDEBUG("Corrupting data bio=%p by writing %u to byte %u "
-			"(rw=%c bi_opf=%u bi_sector=%llu cur_bytes=%u)\n",
-			bio, fc->corrupt_bio_value, fc->corrupt_bio_byte,
-			(bio_data_dir(bio) == WRITE) ? 'w' : 'r', bio->bi_opf,
-			(unsigned long long)bio->bi_iter.bi_sector, bio_bytes);
+	bio_for_each_segment(bvec, bio, iter) {
+		if (bio_iter_len(bio, iter) > corrupt_bio_byte) {
+			char *segment = (page_address(bio_iter_page(bio, iter))
+					 + bio_iter_offset(bio, iter));
+			segment[corrupt_bio_byte] = fc->corrupt_bio_value;
+			DMDEBUG("Corrupting data bio=%p by writing %u to byte %u "
+				"(rw=%c bi_opf=%u bi_sector=%llu size=%u)\n",
+				bio, fc->corrupt_bio_value, fc->corrupt_bio_byte,
+				(bio_data_dir(bio) == WRITE) ? 'w' : 'r', bio->bi_opf,
+				(unsigned long long)bio->bi_iter.bi_sector, bio->bi_iter.bi_size);
+			break;
+		}
+		corrupt_bio_byte -= bio_iter_len(bio, iter);
 	}
 }
 
-- 
2.20.1

