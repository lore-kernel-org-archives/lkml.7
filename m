Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0EDC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EEE208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 09:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfD0JUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 05:20:18 -0400
Received: from www.osadl.org ([62.245.132.105]:46497 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfD0JUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 05:20:18 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3R9K4GY028122;
        Sat, 27 Apr 2019 11:20:04 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matt Sickler <Matt.Sickler@daktronics.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH RFC V2] staging: kpc2000: use int for wait_for_completion_interruptible
Date:   Sat, 27 Apr 2019 11:14:34 +0200
Message-Id: <1556356474-8575-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

weit_for_completion_interruptible returns in (0 on completion and 
-ERESTARTSYS on interruption) - so use an int not long for API conformance
and simplify the logic here a bit: need not check explicitly for == 0 as
this is either -ERESTARTSYS or 0.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located with experimental API conformance checking cocci script

V2: kbuild reported a missing closing comment - seems that I managed
    send out the the initial version before compile testing/checkpatching
    sorry for the noise.

Not sure if making such point-wise fixes makes much sense - this driver has
a number of issues both style-wise and API compliance wise.

Note that kpc_dma_transfer() returns int not long - currently rv (long) is
being returned in most places (some places do return int) - so the return
handling here is a bit inconsistent.

Patch was compile-tested with: x86_64_defconfig + KPC2000=y, KPC2000_DMA=y
(with a number of unrelated sparse warnings about non-declared symbols, and
 smatch warnings about overflowing constants as well as coccicheck warning
 about usless casting)

Patch is against 5.1-rc6 (localversion-next is next-20190426)

 drivers/staging/kpc2000/kpc_dma/fileops.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 5741d2b..66f0d5a 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -38,6 +38,7 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
 {
 	unsigned int i = 0;
 	long rv = 0;
+	int ret = 0;
 	struct kpc_dma_device *ldev;
 	struct aio_cb_data *acd;
 	DECLARE_COMPLETION_ONSTACK(done);
@@ -180,16 +181,17 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
 	
 	// If this is a synchronous kiocb, we need to put the calling process to sleep until the transfer is complete
 	if (kcb == NULL || is_sync_kiocb(kcb)){
-		rv = wait_for_completion_interruptible(&done);
-		// If the user aborted (rv == -ERESTARTSYS), we're no longer responsible for cleaning up the acd
-		if (rv == -ERESTARTSYS){
+		ret = wait_for_completion_interruptible(&done);
+		/* If the user aborted (ret == -ERESTARTSYS), we're
+		 * no longer responsible for cleaning up the acd
+		 */
+		if (ret) {
 			acd->cpl = NULL;
-		}
-		if (rv == 0){
-			rv = acd->len;
+		} else {
+			ret = acd->len;
 			kfree(acd);
 		}
-		return rv;
+		return ret;
 	}
 	
 	return -EIOCBQUEUED;
-- 
2.1.4

