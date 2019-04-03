Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FA0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182F720882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ffvuhCdJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDCSbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:31:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44324 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCSbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:31:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id g12so8447920pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVf4in3JXmNx567gxStNdp9FNPkFd0a/1e89LOx4Bw8=;
        b=ffvuhCdJeVi5Hcr30nOuI/XL2EJ7zOoGVKO6NjB5Q74DCDh+O9odW9+1caPOzqAOiL
         ZI29nwONrBiNxhIqdeNPav4wZ4DllHwUHXZU6RtzBdwxnN12xwyl5lKF0yFEIVioq1iR
         +55oht7WeTDet/SlEph3dOPD+GYuPgsPzZEB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVf4in3JXmNx567gxStNdp9FNPkFd0a/1e89LOx4Bw8=;
        b=R6eYe8M475xzGyMnBL5ByIRWJqHqgi27G21DHF41GsRMO1lU2K4LoZyw+bZlpYOM4i
         03pS6XHuLU/0558lkSIQ+L6F2INKRU62pOIzDnYId2ZfyVeUldud5ONYy3yniY8P+xyn
         18Gw9chUR/Whnmkkz8foFKDHFqGAAmhQ+mV7TFyYwVpmM/33539HXitnA6DT+5Bfk7+D
         XVDkSa6xciWeZGHNF2ZrT+7dJkJwJ4QfBcxsKmgJcsOnkd6gQ7Zxl6/xXsc9zvQMVbxo
         CI8li6UdHLhp7oO/5iimz/XrLkEVBSQr2cE7HcamW/P9rP8tAWiKPGh0mYmWdQ3rzYzK
         eLOQ==
X-Gm-Message-State: APjAAAUCTPpqQpuygwHrKxnPXVejufW2Yyl6CTL/oD2efrZsO83vHzqd
        jovn9hpUcGCquLjTmLQTQyfckw==
X-Google-Smtp-Source: APXvYqxm8z1gDVE9xvinbrZeXL6F88s2PMTlltIFzy5zYLoQARv4dCZzRvW+RcuPgtDcPZO6zUanfQ==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr1451171plq.97.1554316260382;
        Wed, 03 Apr 2019 11:31:00 -0700 (PDT)
Received: from egranata0.mtv.corp.google.com ([2620:15c:202:1:e209:54cf:7c16:6776])
        by smtp.gmail.com with ESMTPSA id e13sm29061548pgb.37.2019.04.03.11.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 11:30:59 -0700 (PDT)
From:   egranata@chromium.org
To:     bleung@chromium.org, groeck@chromium.org, gwendal@chromium.org,
        amstan@chromium.org
Cc:     enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        Enrico Granata <egranata@chromium.org>
Subject: [PATCH] mfd: cros_ec: check for NULL transfer function
Date:   Wed,  3 Apr 2019 11:30:48 -0700
Message-Id: <20190403183048.56750-1-egranata@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Granata <egranata@chromium.org>

As new transfer mechanisms are added to the EC codebase, they may
not support v2 of the EC protocol.

If the v3 initial handshake transfer fails, the kernel will try
and call cmd_xfer as a fallback. If v2 is not supported, cmd_xfer
will be NULL, and the code will end up causing a kernel panic.

Add a check for NULL before calling the transfer function, along
with a helpful comment explaining how one might end up in this
situation.

Signed-off-by: Enrico Granata <egranata@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 97a068dff192d..953076ab401aa 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -56,6 +56,16 @@ static int send_command(struct cros_ec_device *ec_dev,
 	else
 		xfer_fxn = ec_dev->cmd_xfer;
 
+	if (xfer_fxn == NULL) {
+		/* This error can happen if a communication error happened and
+		 * the EC is trying to use protocol v2, on an underlying
+		 * communication mechanism that does not support v2.
+		 */
+		dev_err(ec_dev->dev,
+			"missing EC transfer API, cannot send command\n");
+		return -EIO;
+	}
+
 	ret = (*xfer_fxn)(ec_dev, msg);
 	if (msg->result == EC_RES_IN_PROGRESS) {
 		int i;
-- 
2.21.0.392.gf8f6787159e-goog

