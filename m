Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D34C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1C12075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371748;
	bh=EM2e833Y6sUqwxYwele9ei5uNFbSpI4AKdyoN+XQLUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fC7kuNyMhF/xIlvDR2AsQVl/0Lc2E6FhlrWqy9Z9HXX1ejUfsCHrbT+NWly9g4Yio
	 jz+ubBigJZPS3l78qNN31I/F7BvnvmpjkEp0GQ3xB89uXrZYNCuJems/ldTc6ALXSd
	 ChAUEavy4Bf6eIXSfr3mvi2iKyZTzaZTRr7Ll2Wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfDDJzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:55:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728211AbfDDIv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:51:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E02A22184B;
        Thu,  4 Apr 2019 08:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367887;
        bh=EM2e833Y6sUqwxYwele9ei5uNFbSpI4AKdyoN+XQLUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slMVm2J+YggQleYn/HacOWYPk+pdlbzCEuMtkmcnjBkysPRXNgK6rD2513J+XOUUZ
         FttJOYcf1W6kRamqPLjh+MZSUCZEZyR8yMA2ttEtclpdxCWsLh15EoVYCLoUY8BAp1
         IQ7erPwyYZGS47mYdrZupW0XTOVvvNHoeUTTIe0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 34/91] scsi: core: replace GFP_ATOMIC with GFP_KERNEL in scsi_scan.c
Date:   Thu,  4 Apr 2019 10:47:18 +0200
Message-Id: <20190404084537.432792145@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
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

[ Upstream commit 1749ef00f7312679f76d5e9104c5d1e22a829038 ]

We had a test-report where, under memory pressure, adding LUNs to the
systems would fail (the tests add LUNs strictly in sequence):

[ 5525.853432] scsi 0:0:1:1088045124: Direct-Access     IBM      2107900          .148 PQ: 0 ANSI: 5
[ 5525.853826] scsi 0:0:1:1088045124: alua: supports implicit TPGS
[ 5525.853830] scsi 0:0:1:1088045124: alua: device naa.6005076303ffd32700000000000044da port group 0 rel port 43
[ 5525.853931] sd 0:0:1:1088045124: Attached scsi generic sg10 type 0
[ 5525.854075] sd 0:0:1:1088045124: [sdk] Disabling DIF Type 1 protection
[ 5525.855495] sd 0:0:1:1088045124: [sdk] 2097152 512-byte logical blocks: (1.07 GB/1.00 GiB)
[ 5525.855606] sd 0:0:1:1088045124: [sdk] Write Protect is off
[ 5525.855609] sd 0:0:1:1088045124: [sdk] Mode Sense: ed 00 00 08
[ 5525.855795] sd 0:0:1:1088045124: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 5525.857838]  sdk: sdk1
[ 5525.859468] sd 0:0:1:1088045124: [sdk] Attached SCSI disk
[ 5525.865073] sd 0:0:1:1088045124: alua: transition timeout set to 60 seconds
[ 5525.865078] sd 0:0:1:1088045124: alua: port group 00 state A preferred supports tolusnA
[ 5526.015070] sd 0:0:1:1088045124: alua: port group 00 state A preferred supports tolusnA
[ 5526.015213] sd 0:0:1:1088045124: alua: port group 00 state A preferred supports tolusnA
[ 5526.587439] scsi_alloc_sdev: Allocation failure during SCSI scanning, some SCSI devices might not be configured
[ 5526.588562] scsi_alloc_sdev: Allocation failure during SCSI scanning, some SCSI devices might not be configured

Looking at the code of scsi_alloc_sdev(), and all the calling contexts,
there seems to be no reason to use GFP_ATMOIC here. All the different
call-contexts use a mutex at some point, and nothing in between that
requires no sleeping, as far as I could see. Additionally, the code that
later allocates the block queue for the device (scsi_mq_alloc_queue())
already uses GFP_KERNEL.

There are similar allocations in two other functions:
scsi_probe_and_add_lun(), and scsi_add_lun(),; that can also be done with
GFP_KERNEL.

Here is the contexts for the three functions so far:

    scsi_alloc_sdev()
        scsi_probe_and_add_lun()
            scsi_sequential_lun_scan()
                __scsi_scan_target()
                    scsi_scan_target()
                        mutex_lock()
                    scsi_scan_channel()
                        scsi_scan_host_selected()
                            mutex_lock()
            scsi_report_lun_scan()
                __scsi_scan_target()
    	            ...
            __scsi_add_device()
                mutex_lock()
            __scsi_scan_target()
                ...
        scsi_report_lun_scan()
            ...
        scsi_get_host_dev()
            mutex_lock()

    scsi_probe_and_add_lun()
        ...

    scsi_add_lun()
        scsi_probe_and_add_lun()
            ...

So replace all these, and give them a bit of a better chance to succeed,
with more chances of reclaim.

Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_scan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 27a6d3c6cb7c..67f6f134abc4 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -219,7 +219,7 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
 
 	sdev = kzalloc(sizeof(*sdev) + shost->transportt->device_size,
-		       GFP_ATOMIC);
+		       GFP_KERNEL);
 	if (!sdev)
 		goto out;
 
@@ -796,7 +796,7 @@ static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
 	 */
 	sdev->inquiry = kmemdup(inq_result,
 				max_t(size_t, sdev->inquiry_len, 36),
-				GFP_ATOMIC);
+				GFP_KERNEL);
 	if (sdev->inquiry == NULL)
 		return SCSI_SCAN_NO_RESPONSE;
 
@@ -1095,7 +1095,7 @@ static int scsi_probe_and_add_lun(struct scsi_target *starget,
 	if (!sdev)
 		goto out;
 
-	result = kmalloc(result_len, GFP_ATOMIC |
+	result = kmalloc(result_len, GFP_KERNEL |
 			((shost->unchecked_isa_dma) ? __GFP_DMA : 0));
 	if (!result)
 		goto out_free_sdev;
-- 
2.19.1



