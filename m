Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BA6CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 05:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7027E2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 05:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vC9Ql59H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfJaFEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 01:04:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39846 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfJaFEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 01:04:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id p12so3144772pgn.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 22:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q8TzIHOB34wunGGFvG3qDuYMqHP3uwgf9+UhSlvIUAw=;
        b=vC9Ql59HkHjZBIv0+Qrdcm4yjn9AbvOeO/5G+LtGu77Ij7J+/0Y6NSrfvvb0M7qLW2
         59zp1ZanJkN4gd26qrkXRwhXi/R5sRDYyyAdT0/Mlqh5cqfkBfvx80uc8R0T+1EJnaP5
         i4IT8PkUo88AygfTJ9Ydtj4UEfDWRaTNlvrzmuAhJlQWnWmcI/CV5rVO+4c9DehHT7bW
         bbb/T2faM6X2+WJcZK0grS3ipFHNv3gVZAz5yRuqvxmv+aBRZcjP8q0VutnKxlswwjmS
         Ib9uoNxzw1ER1bpXnCfco36fRlFEqrbeCYaPud7bWbMzHnbwNi4f4xZlb7Rd2ayFXBYH
         6qOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q8TzIHOB34wunGGFvG3qDuYMqHP3uwgf9+UhSlvIUAw=;
        b=qGtD7D5oCm08L+rqR5k3qCXLSNaOR0ITR1qjs/jJs9eeFTm1D0BcOvLfVO6oVP5ekh
         QN7S7VzxyFNpISw5z17ZQvaI8py3vlgXpnMEGirxxPhQ5XX8stxWitAbfwbe/Wk83My4
         sLD4vPcoiJxv+WjP5lKSR6r5EvtevIXg/OvZZGSV9QSHOKP5ppAtHiFvJJTi6hkc+wK/
         Nhik1sMiEbgx30qTA4S9qartPxp4nRM6BGiq3++NrXcXmLNetGBTbve+s6UY4kTUNmY/
         TIy8ZB1ElsNmAzyrtyN41QEZUG5cxNaNN/auWnuk6hivgok5iFh0G5ZPZvZZt4we9EpW
         Wq5A==
X-Gm-Message-State: APjAAAWBvk48nS7p175y/bvAbNa+EF7FamaRrLt7tRH/CrJMr/7cwqXk
        oQuqxDVI5qDhAa+Jt8cmJWM=
X-Google-Smtp-Source: APXvYqzhfX06D2X9smqNQnw7ToE/n97hSatioUOx52Ftu/g4VKY4Zq57v2uLymMAP/fVh+iD1BOG6g==
X-Received: by 2002:a63:3d03:: with SMTP id k3mr3880999pga.375.1572498253048;
        Wed, 30 Oct 2019 22:04:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-48-141-28.hsd1.ca.comcast.net. [73.48.141.28])
        by smtp.googlemail.com with ESMTPSA id d16sm1899658pfo.75.2019.10.30.22.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 22:04:12 -0700 (PDT)
From:   Charles Machalow <csm10495@gmail.com>
To:     linux-nvme@lists.infradead.org
Cc:     csm10495@gmail.com, marta.rybczynska@kalray.eu,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: change nvme_passthru_cmd64's result field.
Date:   Wed, 30 Oct 2019 22:03:38 -0700
Message-Id: <20191031050338.12700-1-csm10495@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing nvme_passthru_cmd64's result field to be backwards compatible
with the nvme_passthru_cmd/nvme_admin_cmd struct in terms of the result
field. With this change the first 32 bits of result in either case
point to CQE DW0. This allows userspace tools to use the new structure
when using the old ADMIN/IO_CMD ioctls or new ADMIN/IO_CMD64 ioctls.

Signed-off-by: Charles Machalow <csm10495@gmail.com>
---
 drivers/nvme/host/core.c        | 4 ++--
 include/uapi/linux/nvme_ioctl.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7ba09dc..74a7cc2dd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1453,11 +1453,11 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
 			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata_len,
-			0, &cmd.result, timeout);
+			0, (u64 *)&cmd.result, timeout);
 	nvme_passthru_end(ctrl, effects);
 
 	if (status >= 0) {
-		if (put_user(cmd.result, &ucmd->result))
+		if (put_user(*(u64 *)&cmd.result, (u64 *)&ucmd->result))
 			return -EFAULT;
 	}
 
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index e168dc59e..4cb07bd6d 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -63,7 +63,7 @@ struct nvme_passthru_cmd64 {
 	__u32	cdw14;
 	__u32	cdw15;
 	__u32	timeout_ms;
-	__u64	result;
+	__u32	result[2];
 };
 
 #define nvme_admin_cmd nvme_passthru_cmd
-- 
2.17.1

