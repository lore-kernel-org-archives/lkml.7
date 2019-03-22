Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4A5C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3768A21873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260564;
	bh=GULG6rCrwifQwFSmQHv4AqvYZowhnTuNMavQj7pZW2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PuHW43zXDw69FKU7NMpqTs8EU6HZ2YIQczG2+Wq/PqSPUKi1hPlowJcUFUyTBCImq
	 wxHqqS5Sr+7TOaRzBC9FP/u0Bi2zR++QQ7rqRKoTK+gm4D0538B7kZ3fA5d27rmOli
	 wJwMctN1A81gQ9ESzmnDGyLO4tjpXyjwFrfyh12U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfCVL11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729006AbfCVL1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:27:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99CEB218A2;
        Fri, 22 Mar 2019 11:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254041;
        bh=GULG6rCrwifQwFSmQHv4AqvYZowhnTuNMavQj7pZW2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjaGluqpfTS3Dg7qGBzZ1/Ert8K0HtdHdAIHY+n0PjXE3rzZNGaGGsEXgdU1qBlHy
         hjmtt/1h5Kz5lgyo2M5vMdPEkyw6XzJc40y8VpIAtc81f2ic9EKKl1G6R4/qNdfq57
         hHbMXemcky+YMEKi6t9DjS53otPBKolDdl+UV8u8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeff Moyer <jmoyer@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 014/230] scsi: isci: initialize shost fully before calling scsi_add_host()
Date:   Fri, 22 Mar 2019 12:12:32 +0100
Message-Id: <20190322111237.734703885@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit cc29a1b0a3f2597ce887d339222fa85b9307706d ]

scsi_mq_setup_tags(), which is called by scsi_add_host(), calculates the
command size to allocate based on the prot_capabilities. In the isci
driver, scsi_host_set_prot() is called after scsi_add_host() so the command
size gets calculated to be smaller than it needs to be.  Eventually,
scsi_mq_init_request() locates the 'prot_sdb' after the command assuming it
was sized correctly and a buffer overrun may occur.

However, seeing blk_mq_alloc_rqs() rounds up to the nearest cache line
size, the mistake can go unnoticed.

The bug was noticed after the struct request size was reduced by commit
9d037ad707ed ("block: remove req->timeout_list")

Which likely reduced the allocated space for the request by an entire cache
line, enough that the overflow could be hit and it caused a panic, on boot,
at:

  RIP: 0010:t10_pi_complete+0x77/0x1c0
  Call Trace:
    <IRQ>
    sd_done+0xf5/0x340
    scsi_finish_command+0xc3/0x120
    blk_done_softirq+0x83/0xb0
    __do_softirq+0xa1/0x2e6
    irq_exit+0xbc/0xd0
    call_function_single_interrupt+0xf/0x20
    </IRQ>

sd_done() would call scsi_prot_sg_count() which reads the number of
entities in 'prot_sdb', but seeing 'prot_sdb' is located after the end of
the allocated space it reads a garbage number and erroneously calls
t10_pi_complete().

To prevent this, the calls to scsi_host_set_prot() are moved into
isci_host_alloc() before the call to scsi_add_host(). Out of caution, also
move the similar call to scsi_host_set_guard().

Fixes: 3d2d75254915 ("[SCSI] isci: T10 DIF support")
Link: http://lkml.kernel.org/r/da851333-eadd-163a-8c78-e1f4ec5ec857@deltatee.com
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Intel SCU Linux support <intel-linux-scu@intel.com>
Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/isci/init.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index 77128d680e3bc..6f38fa1f468a7 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -595,6 +595,13 @@ static struct isci_host *isci_host_alloc(struct pci_dev *pdev, int id)
 	shost->max_lun = ~0;
 	shost->max_cmd_len = MAX_COMMAND_SIZE;
 
+	/* turn on DIF support */
+	scsi_host_set_prot(shost,
+			   SHOST_DIF_TYPE1_PROTECTION |
+			   SHOST_DIF_TYPE2_PROTECTION |
+			   SHOST_DIF_TYPE3_PROTECTION);
+	scsi_host_set_guard(shost, SHOST_DIX_GUARD_CRC);
+
 	err = scsi_add_host(shost, &pdev->dev);
 	if (err)
 		goto err_shost;
@@ -682,13 +689,6 @@ static int isci_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			goto err_host_alloc;
 		}
 		pci_info->hosts[i] = h;
-
-		/* turn on DIF support */
-		scsi_host_set_prot(to_shost(h),
-				   SHOST_DIF_TYPE1_PROTECTION |
-				   SHOST_DIF_TYPE2_PROTECTION |
-				   SHOST_DIF_TYPE3_PROTECTION);
-		scsi_host_set_guard(to_shost(h), SHOST_DIX_GUARD_CRC);
 	}
 
 	err = isci_setup_interrupts(pdev);
-- 
2.19.1



