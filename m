Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4017C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D9B20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711796;
	bh=NgvFUcz5LSukjqDzJajH0n4BVFW0v/zEcoEDnKzZJ5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jZEmeR0DcH/b/E9WV8HZj33GuzQOEVASG0la7dg+4Vx7n9cDRIwiEn6qoGpQyDL1r
	 Eb2pjpJQhP+U7R3xKPuLiT/trcDMxQWOQMlAnDg9J+aO8nXKLv1PaA9RvOVe5bsjOl
	 hrP3VgAuTR2UpdKn59B4YMtSoPm1ukA+yQTelycw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391613AbfC0Sgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391132AbfC0SX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:23:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38D0A2082F;
        Wed, 27 Mar 2019 18:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711038;
        bh=NgvFUcz5LSukjqDzJajH0n4BVFW0v/zEcoEDnKzZJ5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMVWpyyRtwEKxeR3ZRCXjToj64TCyf0NkUGn4VhMeiU9FXspV01x9tiQ1jM89SiQq
         /yDRbTlPcRWAfxPVTq7Y6avwg2hf3Jsny3B67LMo19mHQc4/eNm7fiCsl4Wye1W2Om
         52nrMwh+0wk2s/OzogkhSKwRgDUfMZ4PBA2mVvj8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benjamin Block <bblock@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 21/63] scsi: core: replace GFP_ATOMIC with GFP_KERNEL in scsi_scan.c
Date:   Wed, 27 Mar 2019 14:22:41 -0400
Message-Id: <20190327182323.18577-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182323.18577-1-sashal@kernel.org>
References: <20190327182323.18577-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Block <bblock@linux.ibm.com>

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
index 850ddc5fac04..3e2288af56bc 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -217,7 +217,7 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	extern void scsi_requeue_run_queue(struct work_struct *work);
 
 	sdev = kzalloc(sizeof(*sdev) + shost->transportt->device_size,
-		       GFP_ATOMIC);
+		       GFP_KERNEL);
 	if (!sdev)
 		goto out;
 
@@ -791,7 +791,7 @@ static int scsi_add_lun(struct scsi_device *sdev, unsigned char *inq_result,
 	 */
 	sdev->inquiry = kmemdup(inq_result,
 				max_t(size_t, sdev->inquiry_len, 36),
-				GFP_ATOMIC);
+				GFP_KERNEL);
 	if (sdev->inquiry == NULL)
 		return SCSI_SCAN_NO_RESPONSE;
 
@@ -1085,7 +1085,7 @@ static int scsi_probe_and_add_lun(struct scsi_target *starget,
 	if (!sdev)
 		goto out;
 
-	result = kmalloc(result_len, GFP_ATOMIC |
+	result = kmalloc(result_len, GFP_KERNEL |
 			((shost->unchecked_isa_dma) ? __GFP_DMA : 0));
 	if (!result)
 		goto out_free_sdev;
-- 
2.19.1

