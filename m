Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C191C606A7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312632063F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 10:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1KSdGBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfGHKoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 06:44:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55521 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbfGHKn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 06:43:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so15236758wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 03:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eujF1oLjze7pb4jIJlX9eMHOqe7uxjlgbIwlUyWR6Rc=;
        b=m1KSdGBdMekRdgFHD2ZIyPqpyLP45HkUC6sYXf9QE9tzqOSeNEPB4mauJVQpxa5rDd
         iiQ8O8koMrPMBXljjU7YSWky/V1GMTLpduoCHG/ACVh1/JPx0ddExD7MvCkpeA1okJJM
         WrRXZVouorSV8upneMnRboD2XlxebmQMII7Ic+7sZjZjCqocWhAph2ITj0eYvXpH133R
         B87/4jh1nBzAkQaF1qMbi3RjaKRxtqncy0lZzU7jX2O8VWbcQR/IcHwIfHpnnRMXHpQK
         EIVJZS31h8bkNVFcxVRpiNEIh86gqSWN/xJ6XqYrQXdoVb02EiM6XjXr9LunXae9Cy9z
         R5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eujF1oLjze7pb4jIJlX9eMHOqe7uxjlgbIwlUyWR6Rc=;
        b=TKHhw2ohibCNnIPtF1NDPbhrubj0AT6IvuD6rPTZPRDnSnoZGFpRPGLtOEoPP+QlM6
         a+KYPCDtcgWYtL42yZBZtDY7H9KN18Br1yWQHs2GzAhTEyioAtaJf8ScA/yo6+1ldTDP
         tHZiJ4c5DOyBWSwhsRj6tPtdMGV2p15wVJknaDJrNLcXVD2wMif8+Q82Sn3E71OCl/KP
         SwkWe2n0sVNjXWDKZzt5j629Kjj9bjLf1lEAGzgZrQLJm2GjH/PxHlBzzEbyrKu7kyoz
         7plPZ82L04zjz0ypxCVIWmugHKjfXZ0zkDbY5GfMJ0QiierWhC+t+k2xDMvFHtHylORq
         ICZA==
X-Gm-Message-State: APjAAAXyP67JFPQvt3zLqvAY8vbjSgN8h3lBzwEh1UeeJb3zfOk8f40d
        MZq9vXm8Uq3xoQ9KQKdqsjbaMcRyDTc=
X-Google-Smtp-Source: APXvYqwxDGUrO1EoWFLCNcHaJa7sC0Cag7oeCFg26y9lcsRJevDTxKJn/LO+6KpSIvzODKfImup8WQ==
X-Received: by 2002:a1c:d10c:: with SMTP id i12mr16433415wmg.152.1562582637791;
        Mon, 08 Jul 2019 03:43:57 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 4sm4914027wro.78.2019.07.08.03.43.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 03:43:57 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: use correct variable to show fd open counter
Date:   Mon,  8 Jul 2019 13:43:55 +0300
Message-Id: <20190708104355.32569-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code checks if the user context pointer is NULL or not to
display the number of open file descriptors of a device. However, that
variable (user_ctx) will eventually go away as the driver will support
multiple processes. Instead, the driver can use the atomic counter of
the open file descriptors which the driver already maintains.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
index 25eb46d29d88..881be19b5fad 100644
--- a/drivers/misc/habanalabs/sysfs.c
+++ b/drivers/misc/habanalabs/sysfs.c
@@ -356,7 +356,7 @@ static ssize_t write_open_cnt_show(struct device *dev,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", hdev->user_ctx ? 1 : 0);
+	return sprintf(buf, "%d\n", atomic_read(&hdev->fd_open_cnt));
 }
 
 static ssize_t soft_reset_cnt_show(struct device *dev,
-- 
2.17.1

