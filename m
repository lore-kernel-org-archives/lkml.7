Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C693C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC6E21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255015;
	bh=Ke1W6Yq8bPu84guyC6B27aWhWK98Z8mT8zdvqDm9L4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LIU9WVigt0eB/cN3qD8PBcgwwkUVgMdPoaa0V7CBLOdI3b85VLa3Kv/08Nuh082mj
	 SDF7lBMD7csXH1IKTydHv7Q8S6QymrdDFuxE3mLl0aRh5G9S3pxMc3qIRmogDrBCrK
	 x4J+oBwQl8DqhHASLoabDaSu6f3GVr6ic53NSzx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbfCVLne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731299AbfCVLnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:43:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D850A218B0;
        Fri, 22 Mar 2019 11:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255010;
        bh=Ke1W6Yq8bPu84guyC6B27aWhWK98Z8mT8zdvqDm9L4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZMk9z4kQvMCQ0tpwHGt+xIk9oLiYU9i9ag4gvzR+jYxqoD+QofizEbTdNhgN6ul5m
         6WsnMoEs2abIvu62RleAJqfDsEsfksDYCJIZS6D7AgTSbvRaButecBsz1R6Qi3jHGl
         VRt5f6MF19D+zRp/tzOduPk0JuBLAmBtGxyXoxh4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoph Anton Mitterer <calestyo@scientia.net>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 061/118] scsi: sd: Optimal I/O size should be a multiple of physical block size
Date:   Fri, 22 Mar 2019 12:15:33 +0100
Message-Id: <20190322111220.986801756@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin K. Petersen <martin.petersen@oracle.com>

commit a83da8a4509d3ebfe03bb7fffce022e4d5d4764f upstream.

It was reported that some devices report an OPTIMAL TRANSFER LENGTH of
0xFFFF blocks. That looks bogus, especially for a device with a
4096-byte physical block size.

Ignore OPTIMAL TRANSFER LENGTH if it is not a multiple of the device's
reported physical block size.

To make the sanity checking conditionals more readable--and to
facilitate printing warnings--relocate the checking to a helper
function. No functional change aside from the printks.

Cc: <stable@vger.kernel.org>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199759
Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd.c |   59 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 9 deletions(-)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2834,6 +2834,55 @@ static void sd_read_write_same(struct sc
 		sdkp->ws10 = 1;
 }
 
+/*
+ * Determine the device's preferred I/O size for reads and writes
+ * unless the reported value is unreasonably small, large, not a
+ * multiple of the physical block size, or simply garbage.
+ */
+static bool sd_validate_opt_xfer_size(struct scsi_disk *sdkp,
+				      unsigned int dev_max)
+{
+	struct scsi_device *sdp = sdkp->device;
+	unsigned int opt_xfer_bytes =
+		logical_to_bytes(sdp, sdkp->opt_xfer_blocks);
+
+	if (sdkp->opt_xfer_blocks > dev_max) {
+		sd_first_printk(KERN_WARNING, sdkp,
+				"Optimal transfer size %u logical blocks " \
+				"> dev_max (%u logical blocks)\n",
+				sdkp->opt_xfer_blocks, dev_max);
+		return false;
+	}
+
+	if (sdkp->opt_xfer_blocks > SD_DEF_XFER_BLOCKS) {
+		sd_first_printk(KERN_WARNING, sdkp,
+				"Optimal transfer size %u logical blocks " \
+				"> sd driver limit (%u logical blocks)\n",
+				sdkp->opt_xfer_blocks, SD_DEF_XFER_BLOCKS);
+		return false;
+	}
+
+	if (opt_xfer_bytes < PAGE_SIZE) {
+		sd_first_printk(KERN_WARNING, sdkp,
+				"Optimal transfer size %u bytes < " \
+				"PAGE_SIZE (%u bytes)\n",
+				opt_xfer_bytes, (unsigned int)PAGE_SIZE);
+		return false;
+	}
+
+	if (opt_xfer_bytes & (sdkp->physical_block_size - 1)) {
+		sd_first_printk(KERN_WARNING, sdkp,
+				"Optimal transfer size %u bytes not a " \
+				"multiple of physical block size (%u bytes)\n",
+				opt_xfer_bytes, sdkp->physical_block_size);
+		return false;
+	}
+
+	sd_first_printk(KERN_INFO, sdkp, "Optimal transfer size %u bytes\n",
+			opt_xfer_bytes);
+	return true;
+}
+
 /**
  *	sd_revalidate_disk - called the first time a new disk is seen,
  *	performs disk spin up, read_capacity, etc.
@@ -2898,15 +2947,7 @@ static int sd_revalidate_disk(struct gen
 	dev_max = min_not_zero(dev_max, sdkp->max_xfer_blocks);
 	q->limits.max_dev_sectors = logical_to_sectors(sdp, dev_max);
 
-	/*
-	 * Determine the device's preferred I/O size for reads and writes
-	 * unless the reported value is unreasonably small, large, or
-	 * garbage.
-	 */
-	if (sdkp->opt_xfer_blocks &&
-	    sdkp->opt_xfer_blocks <= dev_max &&
-	    sdkp->opt_xfer_blocks <= SD_DEF_XFER_BLOCKS &&
-	    logical_to_bytes(sdp, sdkp->opt_xfer_blocks) >= PAGE_SIZE) {
+	if (sd_validate_opt_xfer_size(sdkp, dev_max)) {
 		q->limits.io_opt = logical_to_bytes(sdp, sdkp->opt_xfer_blocks);
 		rw_max = logical_to_sectors(sdp, sdkp->opt_xfer_blocks);
 	} else


