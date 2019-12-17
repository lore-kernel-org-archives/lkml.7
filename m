Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EF7C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321F6218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="JMRMfVjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfLQT0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:26:54 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:41442 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfLQT0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:26:53 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47cp6j0M2Xz9vpbW
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 19:26:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oefFbZIGSUvx for <linux-kernel@vger.kernel.org>;
        Tue, 17 Dec 2019 13:26:52 -0600 (CST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47cp6h6Q0Lz9vpZx
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 13:26:52 -0600 (CST)
Received: by mail-yb1-f198.google.com with SMTP id v186so10084154ybc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 11:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RTtM8DgoTYeomLpAB4HP6QUtZc/12vcFjV+hqAPb2JA=;
        b=JMRMfVjdaC3RYJNHwnXub+ZSawvRo+0REws/XPzbXdE15VrnCgJHhpm2yilPHn9sRu
         zuRYmp8T+/ZKT+7RcoW0zzy+IGmNBLi9nWg/iV5w+/iyl/E/ksnxD8lQ9P9V7qoR/Pq7
         icvO6xv3kPqaptf9FBx6+BKBpP4Sm09WGi3ongTQZdqtSbICpjK/8SP6IeCpMQFAFD9V
         eOxs9CWJmHHKO9gfSA+0LwjLxX+E784sq+mm3cxIeA0US7GRxEHxKNsQlS/8SswVY7E8
         uWJaHdqJDH75PWdrLMlpaNXeMb1ljZxByamn9DVUHGqIulL+D0G0XTahjxGkYurn5Cjo
         m+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RTtM8DgoTYeomLpAB4HP6QUtZc/12vcFjV+hqAPb2JA=;
        b=OkiFL4eGbV6o86HZLwIv5Sh+vP39rwBtcPwYqU/p97Db4FYdQXDBlv0Q7eFBtn560Q
         A0g13e/KCOUxFI8gOanT4XOJOM3OR7VBnSkpsqvT1vBtFDxFaFESd8uwh2azibwfMGbp
         0jGC50ZNHQIzqDcFnDHtobaBIDMLEZf5snihEvupZfMsxqD47GKzz0Jmpeo3AzyhsASS
         zvclz3pQWWfOs7U0+hDC4SmYWwWuUZzwVFdbOirGoM5svLH8UKWKk8kjBe/r51GxXk7h
         H+/IjQ2hsg6EJdUa0gROWVRQecO0LHUV9FzSq8NtFc4RdxttYFvADr9hsHz/hUZv+VRg
         2/Fg==
X-Gm-Message-State: APjAAAWeUJCLH67ng+8Ct6NzDa8dScfM3kUs1Y6JIphqYZERhgBN8fPY
        DTJ1p3wZo9unycHP5AgtwqX1iYGuIrXpkQnL16zoKoeTHQjyR+gWm+XltHzcFaVBuf5mxRRj4H0
        09LyVomsUJ14NTOrOqXqV/hn4lxCG
X-Received: by 2002:a81:8785:: with SMTP id x127mr151813ywf.455.1576610812346;
        Tue, 17 Dec 2019 11:26:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgHpky9NVFPlztSbQ7vnaNKGoWCoY5ZJfFY1EWtEFon5WLK7ZI2IrVnQNR9SnF12NFAuyBng==
X-Received: by 2002:a81:8785:: with SMTP id x127mr151793ywf.455.1576610812101;
        Tue, 17 Dec 2019 11:26:52 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id i127sm10126017ywe.65.2019.12.17.11.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 11:26:51 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: RDMA/srpt: Fix incorrect pointer dereference
Date:   Tue, 17 Dec 2019 13:26:49 -0600
Message-Id: <20191217192649.24212-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In srpt_queue_response(), the rdma channel ch is first
dereferenced and then checked for NULL. This renders the
assertion ineffective. This patch removes the assertion and
avoids potential NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 23c782e3d49a..bbc6729c81c0 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2803,15 +2803,17 @@ static void srpt_queue_response(struct se_cmd *cmd)
 	struct srpt_send_ioctx *ioctx =
 		container_of(cmd, struct srpt_send_ioctx, cmd);
 	struct srpt_rdma_ch *ch = ioctx->ch;
-	struct srpt_device *sdev = ch->sport->sdev;
 	struct ib_send_wr send_wr, *first_wr = &send_wr;
-	struct ib_sge sge;
 	enum srpt_command_state state;
+	struct srpt_device *sdev;
 	int resp_len, ret, i;
+	struct ib_sge sge;
 	u8 srp_tm_status;
 
-	BUG_ON(!ch);
+	if (WARN_ON(!ch))
+		return;
 
+	sdev = ch->sport->sdev;
 	state = ioctx->state;
 	switch (state) {
 	case SRPT_STATE_NEW:
-- 
2.20.1

