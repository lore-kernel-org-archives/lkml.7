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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95796C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A5C20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEJdIFpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfG2Ivm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:51:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40192 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfG2Ivm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:51:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so27193130pla.7;
        Mon, 29 Jul 2019 01:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=svoEGIS6JJLnt3fINDHmfTIOc9wsEgzoN9quNg/YowE=;
        b=pEJdIFprQYLCpzmIFeu6lFKku5emKHFUHnPPoYvXzJJLxchnab0QXqj/5Cmb/gkppb
         AfcgRHW++PPG/YjoZwVnc9GWj4O2S3+CxUA3ucVhLzhGMNGNewLtAf3MBJ8ee+X43mpZ
         EM68jx1i9/HlraYGEePCzu8o1Gr4arm63FDqfCZPSlAMHL/PESElkbSn74awmpKmzTAo
         idngfVU4P4OhxgqWlQ2aWYBN9pEuYvvW6Zdxxn+/fDg5bsDkFpEstWMP1+TuupZhBm58
         nKzJZxj2+UUWs+rMb2wQhmO6H+MMG3sLekstjqNS93AGmcBNWG9GxHWZVkEtmRNVjeoC
         qS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=svoEGIS6JJLnt3fINDHmfTIOc9wsEgzoN9quNg/YowE=;
        b=qqvDvQKnUkqTsII8YbDL/Ki1RHBs646G7j4v83wVK85hZ+nIUtwGqdhg8ZBtLfAC64
         NWC+w0294U3DXA8aufwe1VhO5533/ExfJk4LZxIpmefLQQKSJHBUD4sR+AGE1uNx6C08
         lJeUodGyhKPUfMl7FhXUJ7eEJfco8qOd1obw3c6dXrVxbnWOc73WYSg+838+Nurbhv+e
         rk9ivbNaW0tRuziSH9X4+X0g8KNdq7++NG7k5UvYb+pUwp+Sgbeg8YS4Z4LhchVn4aVx
         8JI0MvwYCU7hZ3Xc3Q8clqY+MnJS8+VwLgVb73igjbMEYc519TRkayh5LCRKR+PxoOUm
         zN4A==
X-Gm-Message-State: APjAAAUKXkTo/Hyr4XiBD2cpmSG//+8RhEI9lvoNONKZN4j7uj5ZGAod
        7FwbwXAyeQP1gFD6f47y9Vw=
X-Google-Smtp-Source: APXvYqw7YlTnhq3ZWq3KQ41z1U+W7rgUYsI+svD/LtuWfzhrz4IGzjS6yyoKypNH0fNGUzZ35EVk/Q==
X-Received: by 2002:a17:902:f087:: with SMTP id go7mr108636948plb.330.1564390302027;
        Mon, 29 Jul 2019 01:51:42 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id h6sm57907464pfb.20.2019.07.29.01.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 01:51:41 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, varun@chelsio.com,
        hare@suse.com, osandov@fb.com, jthumshirn@suse.de, axboe@kernel.dk
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] scsi: csiostor: Fix a possible null-pointer dereference in csio_eh_lun_reset_handler()
Date:   Mon, 29 Jul 2019 16:51:35 +0800
Message-Id: <20190729085135.29403-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In csio_eh_lun_reset_handler(), there is an if statement on line 2072 to
check whether rn is NULL:
    if (!rn)

When rn is NULL, it is used on line 2217:
    CSIO_INC_STATS(rn, n_lun_rst_fail);

Thus, a possible null-pointer dereference may occur.

To fix this bug, csio_eh_lun_reset_handler() directly returns FAILED
when rn is NULL.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/scsi/csiostor/csio_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
index 469d0bc9f5fe..c81d743d3544 100644
--- a/drivers/scsi/csiostor/csio_scsi.c
+++ b/drivers/scsi/csiostor/csio_scsi.c
@@ -2070,7 +2070,7 @@ csio_eh_lun_reset_handler(struct scsi_cmnd *cmnd)
 	struct csio_scsi_level_data sld;
 
 	if (!rn)
-		goto fail;
+		return FAILED;
 
 	csio_dbg(hw, "Request to reset LUN:%llu (ssni:0x%x tgtid:%d)\n",
 		      cmnd->device->lun, rn->flowid, rn->scsi_id);
-- 
2.17.0

