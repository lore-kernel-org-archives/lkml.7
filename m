Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F61C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CA721934
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255653;
	bh=UlP1H+u+UWVOtT1krFbs7idNT08YIAoJkuPD4TvVkVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uElo1hvrnaHryNAUheB7c0QZs9Zv5LAz/31DTTGME6xOrzrUTA0UiNv+tCfnTQnCx
	 30a0WFbjiwWY+fWpLjj2E8uynYtqzt0Z9hyxZBNwdt5VPDiH+nCgJD4hek7Hr52I3U
	 m2Hs9RK1G10tZR+Dtydwu8vvenlAtXyIc293rXRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733138AbfCVLyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732470AbfCVLx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:53:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 959A421916;
        Fri, 22 Mar 2019 11:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255638;
        bh=UlP1H+u+UWVOtT1krFbs7idNT08YIAoJkuPD4TvVkVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulbpEu/FNZ5S9cmJCa6DU5DfcSYxcYWX1LvqK1Gi9cCwFs4l6OZtzLYBb8Vs1dT/m
         P+fndAMP7FglR6/G39rVfIjgvVhrmUbhk91d4b3v/CNpxaK/LSbhoVOLbiwwH6vQE9
         +P9pNgEqwX4XIuixRWHtEA1rvtLj64wBv+D8A7eU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 152/183] dm integrity: limit the rate of error messages
Date:   Fri, 22 Mar 2019 12:16:20 +0100
Message-Id: <20190322111252.898595061@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 225557446856448039a9e495da37b72c20071ef2 upstream.

When using dm-integrity underneath md-raid, some tests with raid
auto-correction trigger large amounts of integrity failures - and all
these failures print an error message. These messages can bring the
system to a halt if the system is using serial console.

Fix this by limiting the rate of error messages - it improves the speed
of raid recovery and avoids the hang.

Fixes: 7eada909bfd7a ("dm: add integrity target")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-integrity.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1276,8 +1276,8 @@ again:
 						checksums_ptr - checksums, !dio->write ? TAG_CMP : TAG_WRITE);
 			if (unlikely(r)) {
 				if (r > 0) {
-					DMERR("Checksum failed at sector 0x%llx",
-					      (unsigned long long)(sector - ((r + ic->tag_size - 1) / ic->tag_size)));
+					DMERR_LIMIT("Checksum failed at sector 0x%llx",
+						    (unsigned long long)(sector - ((r + ic->tag_size - 1) / ic->tag_size)));
 					r = -EILSEQ;
 					atomic64_inc(&ic->number_of_mismatches);
 				}
@@ -1469,8 +1469,8 @@ retry_kmap:
 
 					integrity_sector_checksum(ic, logical_sector, mem + bv.bv_offset, checksums_onstack);
 					if (unlikely(memcmp(checksums_onstack, journal_entry_tag(ic, je), ic->tag_size))) {
-						DMERR("Checksum failed when reading from journal, at sector 0x%llx",
-						      (unsigned long long)logical_sector);
+						DMERR_LIMIT("Checksum failed when reading from journal, at sector 0x%llx",
+							    (unsigned long long)logical_sector);
 					}
 				}
 #endif


