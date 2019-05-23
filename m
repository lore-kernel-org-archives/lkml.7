Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9859FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F70420863
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639066;
	bh=EjlE2ovGcgePIpb0P9J+WLinGF9krRSoTGEpCVh9Smc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RHUDJqj8i+d4LHOCSgMch7OhaNaZTwOvNNLYnfwFqsxERtI+GgAv9EtQq3+qsJgky
	 Lxfo8thXxy/FMq0ZwoU+Tig3mzM4fc2V8vr9+c/YyTtx1pIK0neyivj3CwnP+dVsE1
	 ifWyYEhIyQjHICNkJBzcDqFjOkMzzUhgLPFc8kFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389469AbfEWTRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389460AbfEWTRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:17:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 306A02133D;
        Thu, 23 May 2019 19:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639056;
        bh=EjlE2ovGcgePIpb0P9J+WLinGF9krRSoTGEpCVh9Smc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vzhu/n4wmViVeSKgzDVZG3lf/j/3AHvmWFX2jbhAlNlb9n/3NBo78DiRosAIGijja
         nXJljYzTa6X+p46WZ7aNvj+tA3pUhZjobMxh3kUKKpUXBgkpREU+2oBV/DMREOaIsb
         dSnVKI8WzkucWM9pqPyC6lpd5HfFivsxaNnleGbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.19 080/114] dm integrity: correctly calculate the size of metadata area
Date:   Thu, 23 May 2019 21:06:19 +0200
Message-Id: <20190523181738.973182902@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 30bba430ddf737978e40561198693ba91386dac1 upstream.

When we use separate devices for data and metadata, dm-integrity would
incorrectly calculate the size of the metadata device as if it had
512-byte block size - and it would refuse activation with larger block
size and smaller metadata device.

Fix this so that it takes actual block size into account, which fixes
the following reported issue:
https://gitlab.com/cryptsetup/cryptsetup/issues/450

Fixes: 356d9d52e122 ("dm integrity: allow separate metadata device")
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-integrity.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2557,7 +2557,7 @@ static int calculate_device_limits(struc
 		if (last_sector < ic->start || last_sector >= ic->meta_device_sectors)
 			return -EINVAL;
 	} else {
-		__u64 meta_size = ic->provided_data_sectors * ic->tag_size;
+		__u64 meta_size = (ic->provided_data_sectors >> ic->sb->log2_sectors_per_block) * ic->tag_size;
 		meta_size = (meta_size + ((1U << (ic->log2_buffer_sectors + SECTOR_SHIFT)) - 1))
 				>> (ic->log2_buffer_sectors + SECTOR_SHIFT);
 		meta_size <<= ic->log2_buffer_sectors;
@@ -3428,7 +3428,7 @@ try_smaller_buffer:
 	DEBUG_print("	journal_sections %u\n", (unsigned)le32_to_cpu(ic->sb->journal_sections));
 	DEBUG_print("	journal_entries %u\n", ic->journal_entries);
 	DEBUG_print("	log2_interleave_sectors %d\n", ic->sb->log2_interleave_sectors);
-	DEBUG_print("	device_sectors 0x%llx\n", (unsigned long long)ic->device_sectors);
+	DEBUG_print("	data_device_sectors 0x%llx\n", (unsigned long long)ic->data_device_sectors);
 	DEBUG_print("	initial_sectors 0x%x\n", ic->initial_sectors);
 	DEBUG_print("	metadata_run 0x%x\n", ic->metadata_run);
 	DEBUG_print("	log2_metadata_run %d\n", ic->log2_metadata_run);


