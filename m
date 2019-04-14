Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D889C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB65E20896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=laposte.net header.i=@laposte.net header.b="aaY/K67G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfDNPhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 11:37:46 -0400
Received: from smtpoutz25.laposte.net ([194.117.213.100]:40354 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726055AbfDNPhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 11:37:46 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout013 (Postfix) with ESMTP id 6BEA9104C9A
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 17:37:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1555256262; bh=jh1V8UyFe8tdXrJ7fpE/gJzJL+vUc6uuMp5C3FJLHa0=;
        h=From:To:Cc:Subject:Date;
        b=aaY/K67G/bfp2z6B5Xq/mq5S5mz5MhnuADs9E612H2BPC3w+TwPQizFsVCgzIbpe5
         DDfpLo4cNEgNWVViEQlbaNjvY4MaTbPiB8QvaezjJBLuZJ1ig/oISWuJl2f7FddgEj
         k1f9TeWn0Hm9tLFZwiW5/8+EMGHZIl4jgqYuLKHkiJGC7NKPTmOA7fUiq1lSGjvs7Q
         BRc1znplPL37CJosxpL1rJ8WLMsrY/hA1uIVLxKRUoMrLfKOl6w9F5SfhsHdznMGbt
         RqQhYU/PndqIZDjqy0TOaxUkJRoQaOqcorPwpn6QIikwj04W1oEi16UD6EwWa3fJoD
         dzyhQmyJRxr3Q==
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout013 (Postfix) with ESMTP id 5C472104E81
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 17:37:42 +0200 (CEST)
Received: from lpn-prd-vrin003 (lpn-prd-vrin003.prosodie [10.128.63.4])
        by lpn-prd-vrout013 (Postfix) with ESMTP id 5266A104C9A
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 17:37:42 +0200 (CEST)
Received: from lpn-prd-vrin003 (localhost [127.0.0.1])
        by lpn-prd-vrin003 (Postfix) with ESMTP id 419484A6C6E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 17:37:42 +0200 (CEST)
Received: from romuald.bergerie (rqp06-1-88-178-86-202.fbx.proxad.net [88.178.86.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by lpn-prd-vrin003 (Postfix) with ESMTPSA id 1772A4A698E;
        Sun, 14 Apr 2019 17:37:41 +0200 (CEST)
Received: from radicelle.bergerie (radicelle.bergerie [192.168.124.12])
        by romuald.bergerie (Postfix) with ESMTPS id 412C62E857DC;
        Sun, 14 Apr 2019 17:37:41 +0200 (CEST)
Received: from vincent by radicelle.bergerie with local (Exim 4.92)
        (envelope-from <vincent@radicelle.bergerie>)
        id 1hFhCP-0001WH-3A; Sun, 14 Apr 2019 17:37:41 +0200
From:   =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
To:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging: android: vsoc: fix copy_from_user overrun
Date:   Sun, 14 Apr 2019 17:37:26 +0200
Message-Id: <20190414153726.25362-1-vincent.stehle@laposte.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-VR-FullState: 0
X-VR-Score: -100
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgeduuddrvdejgdelgecutefuodetggdotefrodftvfcurfhrohhf
X-VR-Cause-2: ihhlvgemucfntefrqffuvffgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhs
X-VR-Cause-3: ucdlqddutddtmdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeggihhn
X-VR-Cause-4: tggvnhhtucfuthgvhhhlrocuoehvihhntggvnhhtrdhsthgvhhhlvgeslhgrphhoshhtvgdrnhgvtheq
X-VR-Cause-5: necukfhppeekkedrudejkedrkeeirddvtddvnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhi
X-VR-Cause-6: nhgvthepkeekrddujeekrdekiedrvddtvddphhgvlhhopehrohhmuhgrlhgurdgsvghrghgvrhhivgdp
X-VR-Cause-7: mhgrihhlfhhrohhmpehvihhntggvnhhtrdhsthgvhhhlvgeslhgrphhoshhtvgdrnhgvthdprhgtphht
X-VR-Cause-8: thhopeguvghvvghlsegurhhivhgvrhguvghvrdhoshhuohhslhdrohhrghdprhgtphhtthhopehvihhn
X-VR-Cause-9: tggvnhhtrdhsthgvhhhlvgeslhgrphhoshhtvgdrnhgvthdprhgtphhtthhopehgrhgvghhkhheslhhi
X-VR-Cause-10: nhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
X-VR-Cause-11: vghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-VR-AvState: No
X-VR-State: 0
X-VR-State: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `np->permission' structure is smaller than the `np' structure but
sizeof(*np) worth of data is copied in there. Fix the size passed to
copy_from_user() to avoid overrun.

Fixes: 3d2ec9dcd5539d42 ("staging: Android: Add 'vsoc' driver for cuttlefish.")
Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/android/vsoc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 8a75bd27c4133..00a1ec7b91549 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -259,7 +259,8 @@ do_create_fd_scoped_permission(struct vsoc_device_region *region_p,
 	atomic_t *owner_ptr = NULL;
 	struct vsoc_device_region *managed_region_p;
 
-	if (copy_from_user(&np->permission, &arg->perm, sizeof(*np)) ||
+	if (copy_from_user(&np->permission,
+			   &arg->perm, sizeof(np->permission)) ||
 	    copy_from_user(&managed_fd,
 			   &arg->managed_region_fd, sizeof(managed_fd))) {
 		return -EFAULT;
-- 
2.20.1

