Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9203AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CBA2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611561;
	bh=qd9iump0SQrd0bM6BCRKUKBYCAYpxefPEQQ/BmPORJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tPHJkI9qUbNQQl7M0uQo2/7TPmvSe7gHTtVHYwPyN+UtNvuVBE4pqcr+ZphQ3/1/9
	 rPOphwlLRDz/CTV//y+8NgDTEkP7KUdMG2So6XDb+k2Nzv3vBxTtRI7cT4WhSIdIH1
	 sA4f6rHaUCOy2Q4S8iZwDqCbv1o7u9jQnMpoZxoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404000AbfDRSTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404005AbfDRSJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:09:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E58BF20675;
        Thu, 18 Apr 2019 18:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610995;
        bh=qd9iump0SQrd0bM6BCRKUKBYCAYpxefPEQQ/BmPORJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T67lxVDhwfDqwzlhWXvgVVWdpPrNtEy/8v0cWMYVa1+/aaWPnPgEW31Zg4OV2dNTL
         xZgGMs+5K11DBY6NbyEAuT1RI86OO+fK7IOJC5Z5NdPpq4rnZOjIP4Ve+hSYoNMSqa
         ckDngl/O277nq0riF2xL4ipreFgELJlsbHu0zVPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 19/93] paride/pcd: cleanup queues when detection fails
Date:   Thu, 18 Apr 2019 19:56:57 +0200
Message-Id: <20190418160438.746819159@linuxfoundation.org>
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

[ Upstream commit 81b74ac68c28fddb3589ad5d4d5e587baf4bb781 ]

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
 drivers/block/paride/pcd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 96670eefaeb2..377a694dc228 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -749,8 +749,12 @@ static int pcd_detect(void)
 		return 0;
 
 	printk("%s: No CD-ROM drive found\n", name);
-	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++)
+	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
+		blk_cleanup_queue(cd->disk->queue);
+		cd->disk->queue = NULL;
+		blk_mq_free_tag_set(&cd->tag_set);
 		put_disk(cd->disk);
+	}
 	pi_unregister_driver(par_drv);
 	return -1;
 }
-- 
2.19.1



