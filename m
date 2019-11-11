Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83C5C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A099E222C1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NZTpU1UE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfKKTBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:01:46 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35138 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbfKKSus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:50:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id s10so8162179plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 10:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cj9EDPrGBtXH1r7z1h31u4mvPDvEY9hEU3TV12jxQYU=;
        b=NZTpU1UE5cacrL70YHIATCygG5yvGdKJ2bJwCakmjoZk2TRDbTo1cq/30lw/WokZaQ
         /5OETKfVamEbRA9JDXpE+Mt13M+pILP/r8uGQ4G8HANMBgeuXIm6lN1tt1cpcnuYg/Mq
         o5LgGSPxa1SSQz2THqJPPxW+uZfkg13VKHhnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cj9EDPrGBtXH1r7z1h31u4mvPDvEY9hEU3TV12jxQYU=;
        b=EbjgzU/Z+qWRiAtZhAt3LlvW3tmPL5Zu7kbmgSCCrYYzeNZbh4wMOcTR8BW7zdNSJQ
         Ti3UYslVrb4XZAIXvWF8qYzzjKRCWKTDtZW1lw+D8s24OCvP5nZlhdBL3PbQ48w/KfJO
         sra1DxDWGjzPoQPzAjXKi4y1qHToLXCxCZy+OdaJpylF1QpfvIClWQlHI2EoRSobSPMe
         1AxynDE4E75+DY7XJ1mVV7KAb28N5FVDi6bEyeBvHP5sTtWhGQLDqbpaqd8AWH1iGHxl
         WTOT/iftMxdgu4/XKF1vRM38A/JkXopySSFQq0QZtxL6h/V4K0xxnpM1f8sK5de4t/ze
         wefw==
X-Gm-Message-State: APjAAAUpyn5nDBCFb1JbwLbTxE50BCduWirm33rLvbfgUZQrauBmypQ9
        hsiSkq7PMOAiBOxgKRzoyKeEmQ==
X-Google-Smtp-Source: APXvYqwuzQklBI9f0cDuhvdBej8tfYIE5uw1h5GVurTSuwRhaOsanFgqLXSpzxDZLahjKU8GxzlXEw==
X-Received: by 2002:a17:902:5acd:: with SMTP id g13mr27808948plm.242.1573498247918;
        Mon, 11 Nov 2019 10:50:47 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v63sm15220971pfb.181.2019.11.11.10.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Nov 2019 10:50:46 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Evan Green <evgreen@chromium.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] loop: Report EOPNOTSUPP properly
Date:   Mon, 11 Nov 2019 10:50:29 -0800
Message-Id: <20191111185030.215451-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191111185030.215451-1-evgreen@chromium.org>
References: <20191111185030.215451-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly plumb out EOPNOTSUPP from loop driver operations, which may
get returned when for instance a discard operation is attempted but not
supported by the underlying block device. Before this change, everything
was reported in the log as an I/O error, which is scary and not
helpful in debugging.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---

Changes in v6:
- Updated tags

Changes in v5: None
Changes in v4: None
Changes in v3:
- Updated tags

Changes in v2:
- Unnested error if statement (Bart)

 drivers/block/loop.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f6f77eaa7217..d749156a3d88 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -458,7 +458,9 @@ static void lo_complete_rq(struct request *rq)
 
 	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
 	    req_op(rq) != REQ_OP_READ) {
-		if (cmd->ret < 0)
+		if (cmd->ret == -EOPNOTSUPP)
+			ret = BLK_STS_NOTSUPP;
+		else if (cmd->ret < 0)
 			ret = BLK_STS_IOERR;
 		goto end_io;
 	}
@@ -1940,7 +1942,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
  failed:
 	/* complete non-aio request */
 	if (!cmd->use_aio || ret) {
-		cmd->ret = ret ? -EIO : 0;
+		if (ret == -EOPNOTSUPP)
+			cmd->ret = ret;
+		else
+			cmd->ret = ret ? -EIO : 0;
 		blk_mq_complete_request(rq);
 	}
 }
-- 
2.21.0

