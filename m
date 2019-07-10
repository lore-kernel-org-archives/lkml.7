Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAA3C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329C520844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfGJP3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:29:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38814 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfGJP3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:29:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so2718064wmj.3;
        Wed, 10 Jul 2019 08:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OYCkBfE5VzYOraD6A4aTNdxZz8pMoTxJpb4Qn0Coz5Y=;
        b=VEQohiREzx2Qe9kGtKxlzuLl8DqCu5p1lDNNMYQGHer23qOWjf0ahOV5TCjsjQystb
         eZqE5QOHYUXe2M93ITqSTUivT4eCIgK394hWRR7Q7PgOD6/xjEqiFG5ZA7axT+JqhY9u
         Wi99PtksHiUK1vY8mB4uSBhljZTVKbf/kbc8hDr+e15WHQTd4hw93ikjxtyMrky/p7bR
         hAT3Cqa1c3LHSNqSUnWkBRb9xzCiJLz755jJ9/9u+8vsbtaW617BNwktB9Sa3T2e+PAR
         PbWbuqSCx8Tr/qQdT1bMGm25RvPaVZEaftV4siVrDUKqz9ZUPEQqjrl81kOZggMc63hJ
         rQ7w==
X-Gm-Message-State: APjAAAXmm/QQzZzxHf0BDSTfrUmyWBu1P4/fAhKnloedP3c72hraWo9b
        Uf7WL5uDfgwMysWsLiKHC6o=
X-Google-Smtp-Source: APXvYqzw654gnLQ3h8248FiJYECZ4Lf8UQgmXRoXKxJv9+cWo346I606rNIRbNXIiLEQM91cyO+iMQ==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr6142061wmf.7.1562772577140;
        Wed, 10 Jul 2019 08:29:37 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id g11sm2914510wru.24.2019.07.10.08.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 08:29:36 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Chuansheng Liu <chuansheng.liu@intel.com>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ahci: Remove the exporting of ahci_em_messages
Date:   Wed, 10 Jul 2019 18:29:23 +0300
Message-Id: <20190710152923.25562-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable ahci_em_messages is declared static and marked
EXPORT_SYMBOL_GPL, which is at best an odd combination. Because the
variable is not used outside of the drivers/ata/libahci.c file it is
defined in, this commit removes the EXPORT_SYMBOL_GPL() marking.

Fixes: ed08d40cdec4 ("ahci: Changing two module params with static and __read_mostly")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/ata/libahci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index e4c45d3cca79..bff369d9a1a7 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -175,7 +175,6 @@ struct ata_port_operations ahci_pmp_retry_srst_ops = {
 EXPORT_SYMBOL_GPL(ahci_pmp_retry_srst_ops);
 
 static bool ahci_em_messages __read_mostly = true;
-EXPORT_SYMBOL_GPL(ahci_em_messages);
 module_param(ahci_em_messages, bool, 0444);
 /* add other LED protocol types when they become supported */
 MODULE_PARM_DESC(ahci_em_messages,
-- 
2.21.0

