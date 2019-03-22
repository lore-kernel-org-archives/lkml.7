Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB3CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED19D20449
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254241;
	bh=cc5J9kK6D/jldqlf6YVjjK2tjW211MhNvw27Yqin7Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fSLOy8uRy/NitafKA424ivL8adXY2u7HBkRL+1y/pIQKMXruABagVQMmrw1496r0X
	 s0RIOsHLaqx1G92MeBFA2Mcn+uImd3iRGcSi3vRXUjPD6CtgMq/OVi13AzIFjrddEI
	 +xeJXJmT8sQc1+mVVG52nCx8I4ZrbjUpfvC0VyzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfCVLaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729672AbfCVLag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:30:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9197E21916;
        Fri, 22 Mar 2019 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254235;
        bh=cc5J9kK6D/jldqlf6YVjjK2tjW211MhNvw27Yqin7Lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ab/VLpyQ45p0sLc1DPlMTPm2rsXH310XenQUNj2a2tR5q1eltuzXhvRr28cwt8k5B
         umG7mhnnbenJgQpq6D2CiJG/uxvf4DaDWY3bYYvCX2LbrtEcBRezvL9dYO1K7Olf/8
         qw4Q2OaJVsKDp2Qdd88FzwOyV8CUDFB5xCNnZjhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 4.4 073/230] applicom: Fix potential Spectre v1 vulnerabilities
Date:   Fri, 22 Mar 2019 12:13:31 +0100
Message-Id: <20190322111241.792717389@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit d7ac3c6ef5d8ce14b6381d52eb7adafdd6c8bb3c upstream.

IndexCard is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/char/applicom.c:418 ac_write() warn: potential spectre issue 'apbs' [r]
drivers/char/applicom.c:728 ac_ioctl() warn: potential spectre issue 'apbs' [r] (local cap)

Fix this by sanitizing IndexCard before using it to index apbs.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://lore.kernel.org/lkml/20180423164740.GY17484@dhcp22.suse.cz/

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/applicom.c |   35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -32,6 +32,7 @@
 #include <linux/wait.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/nospec.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -386,7 +387,11 @@ static ssize_t ac_write(struct file *fil
 	TicCard = st_loc.tic_des_from_pc;	/* tic number to send            */
 	IndexCard = NumCard - 1;
 
-	if((NumCard < 1) || (NumCard > MAX_BOARD) || !apbs[IndexCard].RamIO)
+	if (IndexCard >= MAX_BOARD)
+		return -EINVAL;
+	IndexCard = array_index_nospec(IndexCard, MAX_BOARD);
+
+	if (!apbs[IndexCard].RamIO)
 		return -EINVAL;
 
 #ifdef DEBUG
@@ -697,6 +702,7 @@ static long ac_ioctl(struct file *file,
 	unsigned char IndexCard;
 	void __iomem *pmem;
 	int ret = 0;
+	static int warncount = 10;
 	volatile unsigned char byte_reset_it;
 	struct st_ram_io *adgl;
 	void __user *argp = (void __user *)arg;
@@ -711,16 +717,12 @@ static long ac_ioctl(struct file *file,
 	mutex_lock(&ac_mutex);	
 	IndexCard = adgl->num_card-1;
 	 
-	if(cmd != 6 && ((IndexCard >= MAX_BOARD) || !apbs[IndexCard].RamIO)) {
-		static int warncount = 10;
-		if (warncount) {
-			printk( KERN_WARNING "APPLICOM driver IOCTL, bad board number %d\n",(int)IndexCard+1);
-			warncount--;
-		}
-		kfree(adgl);
-		mutex_unlock(&ac_mutex);
-		return -EINVAL;
-	}
+	if (cmd != 6 && IndexCard >= MAX_BOARD)
+		goto err;
+	IndexCard = array_index_nospec(IndexCard, MAX_BOARD);
+
+	if (cmd != 6 && !apbs[IndexCard].RamIO)
+		goto err;
 
 	switch (cmd) {
 		
@@ -838,5 +840,16 @@ static long ac_ioctl(struct file *file,
 	kfree(adgl);
 	mutex_unlock(&ac_mutex);
 	return 0;
+
+err:
+	if (warncount) {
+		pr_warn("APPLICOM driver IOCTL, bad board number %d\n",
+			(int)IndexCard + 1);
+		warncount--;
+	}
+	kfree(adgl);
+	mutex_unlock(&ac_mutex);
+	return -EINVAL;
+
 }
 


