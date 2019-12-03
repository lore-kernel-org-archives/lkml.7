Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AF8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D802080A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqbReJki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfLCU14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:27:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34929 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfLCU14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:27:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so5486113wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 12:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QA6N7ZZcbmK8/a59EgCuBTRkEVqdTx5F9l4vgf5SIAE=;
        b=iqbReJkif4rmiO17LjWyIiQlsRR+YKdoKyUcsImbQoY1qxYlcR/xn7t6ZMP8ZTX5XP
         YzBl0yEeIeZB5QjWGDiJZiklZ4+CR7rVGQzTX283K/rKsY12MW/sKz00Y5GZG8OrMwyw
         k/0aMiBkQJt8O17PZ9WcDSw2evEXbqRocbh0o2J2DYASPtpGqWOtMJfT2jf6+bnwPzGM
         lRUbXZ8NxgzyiOw/i5+brLzjLb/XYkXHMnt5/+Rmn/sWLiF0eywLhHyCm/OpOmuXnoFW
         L45+wjH7EvtAS58E9x3eZfGNAsiwVvZMtzDO48aj/iz2etcqi1/ezemrHtLb4UNi68o4
         ts2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QA6N7ZZcbmK8/a59EgCuBTRkEVqdTx5F9l4vgf5SIAE=;
        b=ifX8gmVMGge+hYof8/bWWSdeS7KhXzQ/BzufMd4/E457EAdW35JuY4mIVNsPCjcrnL
         HVXDi4xDISjXKz1yM/lzaR/A9Z9H36iSQKBFj8vcohBMi6pJMN4anP4Vfhslc9NHN06M
         ZPG4I0nbQxRBHay5sHDUAOhaVi/haP9Q+aFtpZvku5JWM9Bdhv7XdvY2F84h6biI76u0
         9SKYvBpYq8JWAfxAsG7heHf7xqsiIgCq+voZhZDASbq3vJJpvFzBETqGkjmaQAG7wcDE
         Dq69zbqZwjeyoJGHqXkQ3KQ2HNf5Qk+aMInzsEYygSOXZHnS2p3CGesmSR0LXYxeEZPQ
         KFiQ==
X-Gm-Message-State: APjAAAVGTq/o3qjSDzj1Ze3C6P9R0ew8NLYN8ai6V6qQXJ1bdUU+5UJd
        +STE7mVxzpbGvGP4TpwU0WnDNoUtTtg=
X-Google-Smtp-Source: APXvYqz+KBOCFuHHTV6IPNG0FoTL7bVS0hI56S+m6ry55qdXekRfxkSB2xM8yizjKwZNMvQ/1jZzVA==
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr7396518wrm.345.1575404873554;
        Tue, 03 Dec 2019 12:27:53 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 5sm5000176wrh.5.2019.12.03.12.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 12:27:52 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: rate limit error msg on waiting for CS
Date:   Tue,  3 Dec 2019 22:27:50 +0200
Message-Id: <20191203202750.9498-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case a user submits a CS, and the submission fails, and the user doesn't
check the return value and instead use the error return value as a valid
sequence number of a CS and ask to wait on it, the driver will print an
error and return an error code for that wait.

The real problem happens if now the user ignores the error of the wait, and
try to wait again and again. This can lead to a flood of error messages
from the driver and even soft lockup event.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 5 +++--
 drivers/misc/habanalabs/context.c            | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 8850f475a413..0bf08678431b 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -824,8 +824,9 @@ int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	memset(args, 0, sizeof(*args));
 
 	if (rc < 0) {
-		dev_err(hdev->dev, "Error %ld on waiting for CS handle %llu\n",
-			rc, seq);
+		dev_err_ratelimited(hdev->dev,
+				"Error %ld on waiting for CS handle %llu\n",
+				rc, seq);
 		if (rc == -ERESTARTSYS) {
 			args->out.status = HL_WAIT_CS_STATUS_INTERRUPTED;
 			rc = -EINTR;
diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index 17db7b3dfb4c..2df6fb87e7ff 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -176,7 +176,7 @@ struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
 	spin_lock(&ctx->cs_lock);
 
 	if (seq >= ctx->cs_sequence) {
-		dev_notice(hdev->dev,
+		dev_notice_ratelimited(hdev->dev,
 			"Can't wait on seq %llu because current CS is at seq %llu\n",
 			seq, ctx->cs_sequence);
 		spin_unlock(&ctx->cs_lock);
-- 
2.17.1

