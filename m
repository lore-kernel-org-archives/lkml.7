Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18ECC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B08206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfD0Pbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:31:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60880 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727028AbfD0PPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:14 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0000zK-DD; Sat, 27 Apr 2019 16:15:10 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004Pe-NP; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Dongsheng Yang" <dongsheng.yang@easystack.cn>,
        "Ilya Dryomov" <idryomov@gmail.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.929247906@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 026/202] rbd: don't return 0 on unmap if
 RBD_DEV_FLAG_REMOVING is set
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

From: Ilya Dryomov <idryomov@gmail.com>

commit 85f5a4d666fd9be73856ed16bb36c5af5b406b29 upstream.

There is a window between when RBD_DEV_FLAG_REMOVING is set and when
the device is removed from rbd_dev_list.  During this window, we set
"already" and return 0.

Returning 0 from write(2) can confuse userspace tools because
0 indicates that nothing was written.  In particular, "rbd unmap"
will retry the write multiple times a second:

  10:28:05.463299 write(4, "0", 1)        = 0
  10:28:05.463509 write(4, "0", 1)        = 0
  10:28:05.463720 write(4, "0", 1)        = 0
  10:28:05.463942 write(4, "0", 1)        = 0
  10:28:05.464155 write(4, "0", 1)        = 0

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Tested-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/block/rbd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -5422,7 +5422,6 @@ static ssize_t do_rbd_remove(struct bus_
 	struct list_head *tmp;
 	int dev_id;
 	unsigned long ul;
-	bool already = false;
 	int ret;
 
 	ret = kstrtoul(buf, 10, &ul);
@@ -5447,13 +5446,13 @@ static ssize_t do_rbd_remove(struct bus_
 		spin_lock_irq(&rbd_dev->lock);
 		if (rbd_dev->open_count)
 			ret = -EBUSY;
-		else
-			already = test_and_set_bit(RBD_DEV_FLAG_REMOVING,
-							&rbd_dev->flags);
+		else if (test_and_set_bit(RBD_DEV_FLAG_REMOVING,
+					  &rbd_dev->flags))
+			ret = -EINPROGRESS;
 		spin_unlock_irq(&rbd_dev->lock);
 	}
 	spin_unlock(&rbd_dev_list_lock);
-	if (ret < 0 || already)
+	if (ret)
 		return ret;
 
 	rbd_dev_header_unwatch_sync(rbd_dev);

