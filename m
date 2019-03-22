Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCE2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF63D218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257268;
	bh=1VH7qEv41yzatpu4o5ty4k9XOp0v1F9ST4Bq6oCApCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wN/qzOCZLkHt13JTRPWqzr48QUC0Sni+oTO2BWl3Ti+I6S+EJZ1I5bhoVvml7t8VW
	 CpVmUSAdeVteEClzG/2OyfBQWclJKWK8HJd8xc9kKm5iUkzBuBAouwBWGsUy6xGx1n
	 7p/XrJQl4lSQqssLM+FbXVKcyaSwIxSynoVbX/VA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390640AbfCVMVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390307AbfCVMVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:21:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B555A2054F;
        Fri, 22 Mar 2019 12:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257263;
        bh=1VH7qEv41yzatpu4o5ty4k9XOp0v1F9ST4Bq6oCApCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SEybt18mVvISuhEVU8i1gHfHoxkSOxtJL1ysTZozDlbFQvih93Y4FLRF2JnoBw3Oh
         dbT8fGk3zTm/90VrvWps5mS6UKu0E3QwSQyi3t/Zpr9uX90tHbE8+LS+TirULn51ke
         C/Mj3fwji2EO3y8sqcYXsmHXnhxTmyIr6UxQ4BsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.0 179/238] dm integrity: limit the rate of error messages
Date:   Fri, 22 Mar 2019 12:16:38 +0100
Message-Id: <20190322111308.833200350@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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
@@ -1368,8 +1368,8 @@ again:
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
@@ -1561,8 +1561,8 @@ retry_kmap:
 
 					integrity_sector_checksum(ic, logical_sector, mem + bv.bv_offset, checksums_onstack);
 					if (unlikely(memcmp(checksums_onstack, journal_entry_tag(ic, je), ic->tag_size))) {
-						DMERR("Checksum failed when reading from journal, at sector 0x%llx",
-						      (unsigned long long)logical_sector);
+						DMERR_LIMIT("Checksum failed when reading from journal, at sector 0x%llx",
+							    (unsigned long long)logical_sector);
 					}
 				}
 #endif


