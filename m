Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4D3C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4472089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zK6YC8uR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389650AbfIIJI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:08:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39406 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389597AbfIIJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:08:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id q12so13704245wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 02:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+4BP5T9F1nQ04WHnHdo2p8zuW4F9kfRfYy2Oe7UAEX0=;
        b=zK6YC8uR+gx2gtTbPZfrQvjTvhixWiVL06+lDRgRpep0OWa0qLpWHztn4WRtplHEyU
         dQOdL99eUOl5HZrIxKhvz8dfoCAlkABvDPcWGJE4uSy83Zzmn2NfKPYVslAzh+QfpUWo
         ybimlvKx5VDA92w9wUl/peF69vLGiurOdeQZruQLOv3G8a2aBXlxYz3yJueWUCk8pfF2
         Fthtj+0kBNhsE8S2dvO2H6qCN7GXHeb46x6it+GSFJAJRgl25vEPcmAeyi6H913Yb/tY
         DggHN5cjUxx6A+/nup96gQwTecH8lo3M6h8gbAJqjOac7MddbSYz9kNPcQ/LDv3A14BP
         DNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+4BP5T9F1nQ04WHnHdo2p8zuW4F9kfRfYy2Oe7UAEX0=;
        b=RC51lR2PC6xgkcOl/+zmgsVz9g8FvYsY0wFhlZH0WyhKtSih6PpNluZlDYwKlhifo+
         8295JASD7t7IWVdKZU0BWlv/MqUe+ETGaoS5QQ9aQW72B1m98Oe3oYwA6gcAOn+n/mLO
         Zsy/y12ac9OWjIiWQ+P9PxJzi5P71ZZBUuZTBNLZie2oeotwKJNe23mz3kfWD+EByOut
         3uR872SKwLhYfV1cGUp0XSUmxY6ElvoF/R4mNEL4+cgqBAG9nEbafgB8yjC6K0Easesz
         zbLYPDJ+dy5xTg+QbepfNux1amBbxy6kTf9UhKya+9r3w07zLmCRbofZ7xwYKj0KfYNH
         kZ6g==
X-Gm-Message-State: APjAAAUbNPPzs/jdgGhs3QAiY2HRwmVWdtwb36XMfjchurZBDxBDadXs
        T5K0Lmyza3bDTz4fSC8WbUb4DA==
X-Google-Smtp-Source: APXvYqy4be4Dr2Cov1HiM8TXxugAZyZo8P+mQ23GodeQvo7+IfiZG3JqP+j/0SxUZhFRj9JeyQm2fA==
X-Received: by 2002:a05:600c:228a:: with SMTP id 10mr18757070wmf.62.1568020134357;
        Mon, 09 Sep 2019 02:08:54 -0700 (PDT)
Received: from localhost.localdomain (69.red-83-35-113.dynamicip.rima-tde.net. [83.35.113.69])
        by smtp.gmail.com with ESMTPSA id o12sm14734488wmh.43.2019.09.09.02.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Sep 2019 02:08:53 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, agross@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, sboyd@kernel.org
Subject: [PATCH v2] mailbox: qcom-apcs: fix max_register value
Date:   Mon,  9 Sep 2019 11:08:50 +0200
Message-Id: <20190909090850.10822-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mailbox length is 0x1000 hence the max_register value is 0xFFC.

Fixes: c6a8b171ca8e ("mailbox: qcom: Convert APCS IPC driver to use
regmap")
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---

 v2: added Fixes tag
 
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 705e17a5479c..e5d6b1b70441 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -28,7 +28,7 @@ static const struct regmap_config apcs_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.max_register = 0x1000,
+	.max_register = 0xFFC,
 	.fast_io = true,
 };
 
-- 
2.23.0

