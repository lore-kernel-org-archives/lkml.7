Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465ABC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD2B20640
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9fbGkuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfIQTIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 15:08:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35636 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfIQTIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 15:08:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so4371001wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 12:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iakGb8fcaKyls8cLwViMwI4gvabiv22sCfSHAxpJhuQ=;
        b=t9fbGkuNijyWrxHyrR8wSBaZCwXYTgltsfCZmRZPqEq0OYZhRPlGk7Q433KNOgxpV7
         Q1QDeK5m4UuGJFbWBp6HTs3WbHokrrFhF+oJ+i25heIU25lkreVcmbCZAD+C0e8/H0ms
         nv70M//MvimfBdJ3J9Q7TZ1ipConjjaqzZne6swtvdMYPbJTQN+SVlX712HbT8MEDP6i
         f3tL1BCr/5Uci2Gch63+TQGmB7BMCfv2WCcZZuQxvWp6jbO0kNleL7P4f/ALXH/Uj3BI
         K88ROR5t6fkb76IWmJo9JijGSCe+cLf+gLKI+5CPC5LdOpIn1fwcAcifpE9f6BHmsIfK
         Y7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iakGb8fcaKyls8cLwViMwI4gvabiv22sCfSHAxpJhuQ=;
        b=YBaKIpIdbyJtumRfGVdNeThsP2c9ZB3joMJyBuI8wmrfKd1iXryh7k5Pewfrt0SqgS
         iu8OYEHhjDwivkVs8jGKdLZENj1SndckyGz26XUGYG4FoJbwmjxyZIvked6vcbgE/+00
         15Vn/BPRrAivH7zwOCkNysNjjXQakSWl224O7WdU8T8ccdlXBGiMa+oXJ9Qx4aCQ4IyN
         Vr1mxmEaQaNESoOy13Zp3S04Ihs4UmFyQ4ftaxRW+YrwSiiWIuQO6FUiB6i2cRJkD7ll
         HzLMKowKdS+L+WwXfkZ9+1lMfBDi61qxa4yiUt9fWYUK36xKeQtcpChZAHsn6ogkBoUK
         Qy7Q==
X-Gm-Message-State: APjAAAW78N+/x5RXxZUMJFCDwJ6jG7wGzp9MeDNLmcNzzDrlAewG1p1Y
        iBrHMw7dWsXST5AugN4LcVU=
X-Google-Smtp-Source: APXvYqwdCBNIeffNEt4sDyHbA4WBH3kDH+qyEAstvKK+sdHbfEH07qfeHKUWFTk/ZJ8KTY1AZSmChA==
X-Received: by 2002:adf:f287:: with SMTP id k7mr137955wro.206.1568747288125;
        Tue, 17 Sep 2019 12:08:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:63dd:3520:a916:ae4b])
        by smtp.gmail.com with ESMTPSA id s13sm1688518wmc.28.2019.09.17.12.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 12:08:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: exfat: add missing SPDX line to Kconfig
Date:   Tue, 17 Sep 2019 21:07:55 +0200
Message-Id: <20190917190755.21723-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX identifier to Kconfig.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/exfat/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/exfat/Kconfig b/drivers/staging/exfat/Kconfig
index 290dbfc7ace1..59e07afe249c 100644
--- a/drivers/staging/exfat/Kconfig
+++ b/drivers/staging/exfat/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config EXFAT_FS
 	tristate "exFAT fs support"
 	depends on BLOCK
-- 
2.23.0

