Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A91DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B2E2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554371369;
	bh=aZFXA++Af5ZrQbtZyIfsv0t/GyLwhZMbIT81+uXoFnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fL80g4cvY6QDDCSXz2uX1z74phyTJmcD0Iak4uWHbAuKp8ejE0oW5wTv5qNSm0Eof
	 KWBc4r+3YTmZmBrwfI3nmICNDULLCwHFQSStqTWRVfqtmGgFwZrgWtoBB83qpudqac
	 L+lKVJpvjobdFiCAdlJz8hiSsXMJ2NSapergfBOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfDDI4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:56:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730460AbfDDI4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:56:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9838820693;
        Thu,  4 Apr 2019 08:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368183;
        bh=aZFXA++Af5ZrQbtZyIfsv0t/GyLwhZMbIT81+uXoFnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vL30SNGt9ncFCu0oJxz2DrGO75EggWGH6yRVsOJLT9YcCA4r4xpIAtoCcNfL9ywts
         d3yQdgxlROeEIvm6JLDl0ua125uIJvrAjm7/c33xrSwu0Li5wACfwu+98LuFZg7r5j
         Sc617Wp1L05olaPSCNS9ft/OF4htx60kGuO4ziBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 041/121] scsi: core: replace GFP_ATOMIC with GFP_KERNEL in scsi_scan.c
Date:   Thu,  4 Apr 2019 10:47:09 +0200
Message-Id: <20190404084547.516894531@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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
index 40124648a07b..0b11405bfd7e 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -220,7 +220,7 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
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



