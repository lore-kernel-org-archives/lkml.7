Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EDFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D6B2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411921;
	bh=lVndAb1WEflxztF/xM3t9TYDVAoAJ8+FlZ5cimlWTTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YJLenQz1k7wJuhWi6G8g6N3EFV7cktxN4LpqzVU51TsWQ0Cx9tcR8nNHae8E8vZ8Z
	 QUiRWuqj4mK5AUfDkqpcTrSb7G9JdgKM51DaHxpgQ3eMvR8jrqTi5/E0xIbiO3RnPQ
	 aJxjg01CwBjJR6GUmy3cLJy6Y9nRVz5+hLXpJ9+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfCLRRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:17:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbfCLRQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:01 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BFF62087C;
        Tue, 12 Mar 2019 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410959;
        bh=lVndAb1WEflxztF/xM3t9TYDVAoAJ8+FlZ5cimlWTTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJnsQFo1a5Pb9L+r9dkGon0syyU/dvNfIUpLta0v3ao3KA565Ooae2fW4O9H2nr88
         qdzRrFZwrTY2aMaeBN60jLdrUc14B4/5ZO6zoY4l3/+Nr7PIlrMyaa7m7NodcuFFEg
         AtGhAQ0vwtsAKnjqt3I3RWANgbz1Esa35tubdUxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 4.14 036/135] applicom: Fix potential Spectre v1 vulnerabilities
Date:   Tue, 12 Mar 2019 10:08:03 -0700
Message-Id: <20190312170344.419452865@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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
 #include <linux/uaccess.h>
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
 


