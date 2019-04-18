Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A394C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1274421872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610998;
	bh=dvRYEgICU7B9lvD98/PMOD4n2rvOT2dfBGAP+bmKAY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e1wAaA5q3kjMfPG2mYA8BI5FXv/ablydS9j8Ol1V94of56Pn4++SltBznUemXK+P8
	 iM+H4uCFHpFHO3wxNU80yZWFC0h54xtLSCXKz3HACAjMARWCt0VAUl4qWdG8SHQuXN
	 7Iktu+uZeVyVSK7EEKVlQ8e8mWiylFHZZgIjSiTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404042AbfDRSJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403986AbfDRSJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:09:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40923206B6;
        Thu, 18 Apr 2019 18:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610992;
        bh=dvRYEgICU7B9lvD98/PMOD4n2rvOT2dfBGAP+bmKAY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sK5zBVXArCQIojSDG6uzRfcQMt+Nbjr3ffqOhNkgusddMaIP4z5jZV951uQHMmyEX
         bS028yyXSxrICqpQTzLI1uLTCCsgDBJu1JynGlXeYfW+wOjsqnsEjfdV59vXAWAoYs
         6gTX685UDwdY5NGaDeDndXR6lKLeg269KWtrO1u8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 18/93] paride/pf: cleanup queues when detection fails
Date:   Thu, 18 Apr 2019 19:56:56 +0200
Message-Id: <20190418160438.663257972@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6ce59025f1182125e75c8d121daf44056b65dd1f ]

The driver allocates queues for all the units it potentially
supports. But if we fail to detect any drives, then we fail
loading the module without cleaning up those queues. This is
now evident with the switch to blk-mq, though the bug has
been there forever as far as I can tell.

Also fix cleanup through regular module exit.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/paride/pf.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index e92e7a8eeeb2..103b617cdc31 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -761,8 +761,12 @@ static int pf_detect(void)
 		return 0;
 
 	printk("%s: No ATAPI disk detected\n", name);
-	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++)
+	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
+		blk_cleanup_queue(pf->disk->queue);
+		pf->disk->queue = NULL;
+		blk_mq_free_tag_set(&pf->tag_set);
 		put_disk(pf->disk);
+	}
 	pi_unregister_driver(par_drv);
 	return -1;
 }
@@ -1047,13 +1051,15 @@ static void __exit pf_exit(void)
 	int unit;
 	unregister_blkdev(major, name);
 	for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
-		if (!pf->present)
-			continue;
-		del_gendisk(pf->disk);
+		if (pf->present)
+			del_gendisk(pf->disk);
+
 		blk_cleanup_queue(pf->disk->queue);
 		blk_mq_free_tag_set(&pf->tag_set);
 		put_disk(pf->disk);
-		pi_release(pf->pi);
+
+		if (pf->present)
+			pi_release(pf->pi);
 	}
 }
 
-- 
2.19.1



