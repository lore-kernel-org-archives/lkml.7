Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3B7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABDC206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W8/b7Jyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDCWkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:40:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39685 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCWko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:40:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3so186230pga.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVP6KK4OjXux5hqpvy42NojT5xHJgIAc1lrCJ4gRq0E=;
        b=W8/b7JyimuUdXT2KgZvagyosBiJS/i+yJxcZtj/MuMjfHaAAvBmvWzPJBt+Dm5VvEr
         CWo8No3vyyNauMJyQa9UWKTHUD24d/rqgG9Y3bwhRH15mbMY75UV7ioyQD+NYJXx5anV
         L1EwjBpr3Up3BKBIUTznIyldtO8jnJ7eFES90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pVP6KK4OjXux5hqpvy42NojT5xHJgIAc1lrCJ4gRq0E=;
        b=s9jCp6i2JZbFQCayJmbAgJqmVX/J03YQfFDe1s8n9qzcck6BG6pfVSQoA9ajlwPCcO
         rA+sHTD/PLiPFz1jRd1zbyOByBFu93pH6YzK0OhwkgTdQVM5AC91ddCjuNeyv4mkwLVc
         fcEoQvdxw5tyDClGC6s6bBQI91PQewewXiJAKSDN52O2dsiElHwztOzBOfsvLFu9uWUx
         Rw8cHh119GFL5IlMFupmBLNYzePjqH/DHrU6jdTiZtHT3dEaYwuLNL1nfdyR7zh9GSlU
         hXjXQEC0unuH7biXN+QW/FUpLlQFFuP0lISWwoB7ZfnAYKraQJrPIb8xz7aPHzx75gSf
         VasQ==
X-Gm-Message-State: APjAAAVKzXvJEXAEYgRtxz4hHSIL7SwdF5yVymNFv1bvMlf5fTLN5kPB
        xagV+hT2XdtOMGnhcWKdHWhViQ==
X-Google-Smtp-Source: APXvYqxMYppmBUO4uqM2Svn9u/hDDwIRfw9T8EZrM1JiQh4/U8jxTrRkInpWCu9cZzCMTYoYE+4Slg==
X-Received: by 2002:a63:ff26:: with SMTP id k38mr2244073pgi.123.1554331244122;
        Wed, 03 Apr 2019 15:40:44 -0700 (PDT)
Received: from egranata0.mtv.corp.google.com ([2620:15c:202:1:e209:54cf:7c16:6776])
        by smtp.gmail.com with ESMTPSA id y15sm1391212pfo.22.2019.04.03.15.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:40:43 -0700 (PDT)
From:   egranata@chromium.org
To:     groeck@google.com
Cc:     bleung@chromium.org, gwendal@chromium.org, amstan@chromium.org,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        jettrink@google.com, Enrico Granata <egranata@chromium.org>
Subject: [PATCH v2] mfd: cros_ec: check for NULL transfer function
Date:   Wed,  3 Apr 2019 15:40:36 -0700
Message-Id: <20190403224036.203632-1-egranata@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <CABXOdTeE5=iF24+2JxwjvGtVtFmneYJWC4yXgX1Ah4y+=+ecEg@mail.gmail.com>
References: <CABXOdTeE5=iF24+2JxwjvGtVtFmneYJWC4yXgX1Ah4y+=+ecEg@mail.gmail.com>
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
index 97a068dff192d..55691656a3c27 100644
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
+		dev_err_once(ec_dev->dev,
+			"missing EC transfer API, cannot send command\n");
+		return -EIO;
+	}
+
 	ret = (*xfer_fxn)(ec_dev, msg);
 	if (msg->result == EC_RES_IN_PROGRESS) {
 		int i;
-- 
2.21.0.392.gf8f6787159e-goog

