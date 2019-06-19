Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D27BC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431C2214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfFSTmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 15:42:33 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.159]:20485 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726230AbfFSTmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 15:42:33 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 80C85400CFFAD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 14:42:32 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id dgTYh0XG6YTGMdgTYhw6Zq; Wed, 19 Jun 2019 14:42:32 -0500
X-Authority-Reason: nr=8
Received: from cablelink-187-160-61-213.pcs.intercable.net ([187.160.61.213]:12106 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hdgTX-000jo6-Cw; Wed, 19 Jun 2019 14:42:31 -0500
Date:   Wed, 19 Jun 2019 14:41:26 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Willem Riede <osst@riede.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     osst-users@lists.sourceforge.net, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] scsi: osst: Use struct_size() in kzalloc()
Message-ID: <20190619194126.GA3069@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.160.61.213
X-Source-L: No
X-Exim-ID: 1hdgTX-000jo6-Cw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-187-160-61-213.pcs.intercable.net (embeddedor) [187.160.61.213]:12106
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct osst_buffer {
  ...
  struct scatterlist sg[1];    /* MUST BE last item                               */
} ;

i = sizeof(struct osst_buffer) + (osst_max_sg_segs - 1) * sizeof(struct scatterlist);
instance = kzalloc(i, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, sg, count), GFP_KERNEL);

Notice that, in this case, variable i is not necessary, hence it
is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/osst.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
index 815bb4097c1b..a11455a7e6bf 100644
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -5307,7 +5307,6 @@ static long osst_compat_ioctl(struct file * file, unsigned int cmd_in, unsigned
 /* Try to allocate a new tape buffer skeleton. Caller must not hold os_scsi_tapes_lock */
 static struct osst_buffer * new_tape_buffer( int from_initialization, int need_dma, int max_sg )
 {
-	int i;
 	gfp_t priority;
 	struct osst_buffer *tb;
 
@@ -5316,8 +5315,7 @@ static struct osst_buffer * new_tape_buffer( int from_initialization, int need_d
 	else
 		priority = GFP_KERNEL;
 
-	i = sizeof(struct osst_buffer) + (osst_max_sg_segs - 1) * sizeof(struct scatterlist);
-	tb = kzalloc(i, priority);
+	tb = kzalloc(struct_size(tb, sg, osst_max_sg_segs - 1), priority);
 	if (!tb) {
 		printk(KERN_NOTICE "osst :I: Can't allocate new tape buffer.\n");
 		return NULL;
-- 
2.21.0

