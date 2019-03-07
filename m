Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD0BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673AF20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXR7LlF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCGSls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:41:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44247 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCGSls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:41:48 -0500
Received: by mail-ed1-f66.google.com with SMTP id b20so14320160edw.11;
        Thu, 07 Mar 2019 10:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3eGWZ91k0O89tXU3fGBURUnf8Nm4L6rvytseCpGbqT4=;
        b=AXR7LlF+e2FMBRmIm8Vskckt6UiHHa35tDn5uWYi8v4AO5kIjGuAsB13URpSn54YA1
         f2TXSPCx6hpdYQXTSWDALQUqo54xa4aad3xoEeyDB7rHtwusdPPmVZVaTa3BtIeVbFNm
         K1wGOKqq6IpNgzMqthWywPqNLdEpK6tzS6R3AUvkrlWl94Kz1myHycWzUgMFEpn/p1uO
         L2RxzJ+76ApJfKl9sUqqlGR/hVdMENsDTEeI0VZl5GfNslwrX+fICYVFluKdInH5Yile
         WoOJEG5esd1+BiGueEuRcJXQWhVgbetD0fGU1MDvGnYhQyYzhngzapm/SwJyeLeT4k0A
         bK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3eGWZ91k0O89tXU3fGBURUnf8Nm4L6rvytseCpGbqT4=;
        b=t8wNpPogKC2n0fYeua3QsmFAdL/VDKjSarVQNydoU5dV5ajDNaPHWtlp7dPyTtuBlY
         XouAIL2EcvtpH8buET+uC/AuY1jTurY7YKKOlTGl3RAAksgJaVwQvJjE8shJhkqiaoCF
         oUMjwLFyjZLpsGw9klW9rCe+AzO+g4ueh/p0wJ2ld9JoS0xUDalpbKvQXLYjISjhIKq1
         kdXwjb/ub9CsnKvidLkRsXOakw/rnysCtnSicVf/DXZ43XvkdoKsLJOJpF9VKfzdApv/
         AIqZsaPVqOBSkRWcGlGkOGE/F2kSck33NV0aPTZ5SlQswlKK+oDHBcws3MXrodp4+roQ
         /I8Q==
X-Gm-Message-State: APjAAAVGQTxAQsr4Agnu8GAqC/x3LOMoLhnkU3oYbPh6kOqK7vfd2ibf
        KUtKX23GibQyjjtY93oTH1I=
X-Google-Smtp-Source: APXvYqzowx45WsXwJIYTPmJW1snIJjo9ZPNQZtk4FUSw6JuTgIkkwAGhXeS3920MSQHXdDZs9DhGuw==
X-Received: by 2002:a50:978e:: with SMTP id e14mr27926732edb.234.1551984105890;
        Thu, 07 Mar 2019 10:41:45 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id x34sm1555565edm.70.2019.03.07.10.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 10:41:45 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: qla4xxx: Don't call dma_free_coherent without dma_alloc_coherent
Date:   Thu,  7 Mar 2019 11:41:25 -0700
Message-Id: <20190307184125.21419-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/scsi/qla4xxx/ql4_os.c:5915:7: warning: variable 'buf_dma' is
used uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]

buf_dma is initialized by dma_alloc_coherent, which is only called in
the middle conditional statement. Use that same conditional to call
dma_free_coherent so that buf_dma is always initialized when used.

Fixes: 2a991c215978 ("[SCSI] qla4xxx: Boot from SAN support for open-iscsi")
Link: https://github.com/ClangBuiltLinux/linux/issues/391
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/qla4xxx/ql4_os.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 16a18d5d856f..88bb52456efd 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -5982,7 +5982,8 @@ static int get_fw_boot_info(struct scsi_qla_host *ha, uint16_t ddb_index[])
 			  ddb_index[1]));
 
 exit_boot_info_free:
-	dma_free_coherent(&ha->pdev->dev, size, buf, buf_dma);
+	if (is_qla80XX(ha))
+		dma_free_coherent(&ha->pdev->dev, size, buf, buf_dma);
 exit_boot_info:
 	ha->pri_ddb_idx = ddb_index[0];
 	ha->sec_ddb_idx = ddb_index[1];
-- 
2.21.0

