Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BAFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657A120835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGwe8POO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfDXS6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:58:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40211 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfDXS6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:58:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id d46so16882663eda.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t1RAAHlcA9WlVQkWeY+8su0EOUB2rtwpGv97os6o878=;
        b=VGwe8POOaJZaS5MUxV4X30p8W1rXG+sqEkWSFDUA1ScBa9wAtSXblNi4roNLSOM0ZX
         gTdPVGTu8Hp5yJR5qGajobvH41uREcoUb6292cNGPbmsfiUPRlRuGx8iqgVjyxF39jbQ
         l4MshPR+lwQStfEucmWI8uK/vrvVt8L8iF+i98u8ehxPA2NPmjh/JDJrX7muJQ/N7NGC
         BMbFyZwR5KIvPHyUXvyCvrfdDIp5HQCPC1hUymqDTRlS5SF+fjwhA46cOvzdBQ1ZNsXR
         gplcjtoZs4pRXh5J4Hyljp53siLwWaKfJ5k2OG/zfPTLYSTrlS8uYxRg1o5CuKDI0AZb
         DQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t1RAAHlcA9WlVQkWeY+8su0EOUB2rtwpGv97os6o878=;
        b=CfmBzV98NoZn9iG22MFQawE+OUkglyqyPUxWNPjuBz8giD7H5QwuWPno5RzbwBpopO
         f5/7MvLuj/F0XKRbIPD0rNEjPPcuksOvJ6iJPBJsummYOvKgZhB7Yutw21uXQQK9T6j2
         o6faJRk9qhnXj/zcE4D8IphuP28lgO5KaLdfmbRE6i1T5na9zfc/u98uSjUxuKFcDbTN
         18nOsSuaOb5QKexL5je8R1rJ2ze5agRmp1qKjERd+ER7+lzp0X8FtX2NhWQJ7BBghdW9
         v8Sym2RBlplvwefOgHe9Wm7ZIuhao4KA4AeNRpZ61+b3d1xwxySWtF7GYI2jxXaR+FeL
         WFvQ==
X-Gm-Message-State: APjAAAXvt5prbXRAx6uwOO9+6IEMIRTgWwH70G9w5poYKoauJ3iHG6Mo
        Gn681HHEzW9BaPrBcKA4341D9ct5FSY=
X-Google-Smtp-Source: APXvYqwuq9IyhQjKjH4yyFJgyyMQ2cYfzEZP9owqWzLwJt4ozdHvDwxz3R1FdJXpa+k6p9jf7+mjSQ==
X-Received: by 2002:a17:906:eb87:: with SMTP id mh7mr16663018ejb.152.1556132296947;
        Wed, 24 Apr 2019 11:58:16 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id u10sm5471973edj.22.2019.04.24.11.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 11:58:16 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: kpc2000: Use memset to initialize resources
Date:   Wed, 24 Apr 2019 11:57:43 -0700
Message-Id: <20190424185742.7797-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/staging/kpc2000/kpc2000/cell_probe.c:96:38: warning: suggest
braces around initialization of subobject [-Wmissing-braces]
    struct resource  resources[2] = {0};
                                     ^
                                     {}
drivers/staging/kpc2000/kpc2000/cell_probe.c:314:38: warning: suggest
braces around initialization of subobject [-Wmissing-braces]
    struct resource  resources[2] = {0};
                                     ^
                                     {}
2 warnings generated.

One way to fix these warnings is to add additional braces like Clang
suggests; however, there has been a bit of push back from some
maintainers, who just prefer memset as it is unambiguous, doesn't
depend on a particular compiler version, and properly initializes all
subobjects [1][2]. Do that here so there are no more warnings.

[1]: https://lore.kernel.org/lkml/022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com/
[2]: https://lore.kernel.org/lkml/20181128.215241.702406654469517539.davem@davemloft.net/

Link: https://github.com/ClangBuiltLinux/linux/issues/455
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index ad2cc0a3bfa1..13f544f3c0b9 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -93,8 +93,8 @@ void parse_core_table_entry(struct core_table_entry *cte, const u64 read_val, co
 int  probe_core_basic(unsigned int core_num, struct kp2000_device *pcard, char *name, const struct core_table_entry cte)
 {
     struct mfd_cell  cell = {0};
-    struct resource  resources[2] = {0};
-    
+    struct resource  resources[2];
+
     struct kpc_core_device_platdata  core_pdata = {
         .card_id           = pcard->card_id,
         .build_version     = pcard->build_version,
@@ -112,6 +112,8 @@ int  probe_core_basic(unsigned int core_num, struct kp2000_device *pcard, char *
     cell.id = core_num;
     cell.num_resources = 2;
     
+    memset(&resources, 0, sizeof(resources));
+
     resources[0].start = cte.offset;
     resources[0].end   = cte.offset + (cte.length - 1);
     resources[0].flags = IORESOURCE_MEM;
@@ -311,8 +313,8 @@ int  probe_core_uio(unsigned int core_num, struct kp2000_device *pcard, char *na
 static int  create_dma_engine_core(struct kp2000_device *pcard, size_t engine_regs_offset, int engine_num, int irq_num)
 {
     struct mfd_cell  cell = {0};
-    struct resource  resources[2] = {0};
-    
+    struct resource  resources[2];
+
     dev_dbg(&pcard->pdev->dev, "create_dma_core(pcard = [%p], engine_regs_offset = %zx, engine_num = %d)\n", pcard, engine_regs_offset, engine_num);
     
     cell.platform_data = NULL;
@@ -321,6 +323,8 @@ static int  create_dma_engine_core(struct kp2000_device *pcard, size_t engine_re
     cell.name = KP_DRIVER_NAME_DMA_CONTROLLER;
     cell.num_resources = 2;
     
+    memset(&resources, 0, sizeof(resources));
+
     resources[0].start = engine_regs_offset;
     resources[0].end   = engine_regs_offset + (KPC_DMA_ENGINE_SIZE - 1);
     resources[0].flags = IORESOURCE_MEM;
-- 
2.21.0

