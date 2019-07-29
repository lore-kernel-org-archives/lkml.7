Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DB3C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573562075C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3Ym0l93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfG2KGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:06:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44978 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2KGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:06:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so27998819pgl.11;
        Mon, 29 Jul 2019 03:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hlsQgLiK4mBtl4yaP1HBcLTCJDJdOymPRcLvjAE6BgQ=;
        b=I3Ym0l931f2XVno6amrYtpkEgN9rPCrT8gEBrq4un0JzC9nfz6a9V1hDyvZAOmQlmC
         Bk2sQYzNYWC48ED8wjazgev1fNjhkO7Ra40fzGFAaioIawjR3KYZb+axtZy7aAmArEjg
         cv6ifkmA/5vLUaiajusSqQIjUtCkeCJ7Vv2ZPUuvSvvvZIfBO53zK3l3UpEHXGTneC9Z
         O3Ez+WmDqiUdtyj+XMsq4OW1bMe8lrJfpGvRnCHDWpSqCezvhIgrjKutxkkak7fV+hqa
         h403occQihPbYltZqwjW0wmedPMDPrsEJrv3dOl+wrechsSEt6E/vCpuIsCtXO1y5NJC
         VH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hlsQgLiK4mBtl4yaP1HBcLTCJDJdOymPRcLvjAE6BgQ=;
        b=Unrmu5E+4xIArLP1336oRIohUtlWuwTw84XDoYdsjFa10udm66WFI7OakZ760yOhGv
         M77Xe+AqTLgKkQvXuh2/pmTw6C5mURde2Y4AfYTNog4LgxcKBHdmq4G1mM7ESP4r+N+u
         GcW04QU4cv7cCYQ516/sc6GQF6Up3QLbzUBhbmCVtBGeBaX8u7AF/esdVqFI4jafjU+8
         ptvGONCBwRAP+XwwGrf2cesr5cp/r+DSgaUW7wUAAZCF6yFbHIO3GCG8JbjzkE/CPzei
         Pj+pIGq1UdH3XfU9732ZmN9RFrx2MCo0X9ICSzTUgGnyId05RYARQ79bIR6qI3nWB+0l
         gZsA==
X-Gm-Message-State: APjAAAXBy5ejaHHa+S6pWOOf1xgZwT9en8VQsCKdp1kpLl5eZxtg/1/A
        ngKh6iABAI0Yk4IZuE16iI4=
X-Google-Smtp-Source: APXvYqx7lxguiiieHl+MyyTsyEDCStzzHHKLL4xEhm0gyHR3N/To+eJ9t1zl+wr97q3CKXnKTdZJWg==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr109888947pjz.140.1564394761032;
        Mon, 29 Jul 2019 03:06:01 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id bo20sm45654982pjb.23.2019.07.29.03.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 03:06:00 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: storage: sddr55: Fix a possible null-pointer dereference in sddr55_transport()
Date:   Mon, 29 Jul 2019 18:05:55 +0800
Message-Id: <20190729100555.2081-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sddr55_transport(), there is an if statement on line 836 to check
whether info->lba_to_pba is NULL:
    if (info->lba_to_pba == NULL || ...)

When info->lba_to_pba is NULL, it is used on line 948:
    pba = info->lba_to_pba[lba];

Thus, a possible null-pointer dereference may occur.

To fix this bug, info->lba_to_pba is checked before being used.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/storage/sddr55.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
index b8527c55335b..50afc39aa21d 100644
--- a/drivers/usb/storage/sddr55.c
+++ b/drivers/usb/storage/sddr55.c
@@ -945,7 +945,8 @@ static int sddr55_transport(struct scsi_cmnd *srb, struct us_data *us)
 			return USB_STOR_TRANSPORT_FAILED;
 		}
 
-		pba = info->lba_to_pba[lba];
+		if (info->lba_to_pba)
+			pba = info->lba_to_pba[lba];
 
 		if (srb->cmnd[0] == WRITE_10) {
 			usb_stor_dbg(us, "WRITE_10: write block %04X (LBA %04X) page %01X pages %d\n",
-- 
2.17.0

