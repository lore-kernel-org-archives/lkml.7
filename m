Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0BDC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B3F206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfD0PcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:32:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60750 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbfD0PPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:12 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2j-0000z8-WD; Sat, 27 Apr 2019 16:15:10 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004PK-K2; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jeff Moyer" <jmoyer@redhat.com>,
        "Artur Paszkiewicz" <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Intel SCU Linux support" <intel-linux-scu@intel.com>,
        "Logan Gunthorpe" <logang@deltatee.com>,
        "Jens Axboe" <axboe@kernel.dk>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.163969774@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 022/202] scsi: isci: initialize shost fully before
 calling scsi_add_host()
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Logan Gunthorpe <logang@deltatee.com>

commit cc29a1b0a3f2597ce887d339222fa85b9307706d upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/isci/init.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -598,6 +598,13 @@ static struct isci_host *isci_host_alloc
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
@@ -685,13 +692,6 @@ static int isci_pci_probe(struct pci_dev
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

