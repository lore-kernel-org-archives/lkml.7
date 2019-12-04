Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F036C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168E1205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483803;
	bh=dem0dnbBYskFHC39U2QDOwYhTUAtk8tPl+8xAKosFFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vbfoeDRMrDPOTcv7rnOTo0RW4E2rhC9fsP/pAMPs4AeDTibrQWjy8S+AtW4Z4LFgi
	 xUnP4FCAIxshlb192Ea4M9vgcOdVRs2+7q9tWgDgpRgxwdlvkLqb8OHxQYpNzzketF
	 /xb6va/krrkRIRCRuLd7/Adl2fV67XNw7XaYyZqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfLDSEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:04:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729381AbfLDSD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:03:59 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A907206DF;
        Wed,  4 Dec 2019 18:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482638;
        bh=dem0dnbBYskFHC39U2QDOwYhTUAtk8tPl+8xAKosFFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Je30yOkTGJUnH74irlosmbrBVoK5UHM/W6j/mBtf9pqye0P0Z6KXa2yWZFjf56Nkz
         4OI3uOco4AVhS7/nazlsnXnXLDh/ju3U6B/9PTRrPkjygLG2SeP5Z9iJbCmWIBZjeg
         Wkpqer8h3ssUmSfC/4xc6N89QyOHODkx+70hcFhU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Dorminy <jdorminy@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 075/209] dm flakey: Properly corrupt multi-page bios.
Date:   Wed,  4 Dec 2019 18:54:47 +0100
Message-Id: <20191204175326.559704390@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



