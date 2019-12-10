Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2C0C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 23:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CC420838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 23:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh+f0Rsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfLJXf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 18:35:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35483 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfLJXfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 18:35:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so22040943wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 15:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0AbeKPvputP0xfRxnZJSwgiY+uW70IA/d2ji/wViVTY=;
        b=Zh+f0RshI4RE2pJIb0dWo5JI2bI2b2fH2FCW8o8Jon4Efb4BPKHxohC5VFUN3YJMtn
         u+EAUGXIW+j4U4lNYtKn4yMkaG+mB/YK7beB6COSfoS1HeS/+DJb6uaDuJm7LOkl7067
         tCmuOpB6QnUIZMFbvq1p1oYzvw20u01vOcRUDqtsFKSYURoAfB+lQz9CRpDcFhIxJVBT
         vP3MYgYT+Z63v0+LCSLrqPxG5woVPdSfC25IgTTgbO1gtrljhMaoMKGvOVU2IzP17A0D
         vaixSLO5cOwSDuxO/rb0CiJYa8G6RBwyA/1nAUV3gMEAQu7HMuBQ7FN9hfgR8J+txshk
         PqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0AbeKPvputP0xfRxnZJSwgiY+uW70IA/d2ji/wViVTY=;
        b=pcjtlxHvlLfqdcfPeTsR6uae3UfRX/aq9xnFLS2u1ZFvKS3LfCyjY10TE5zzp+tpjB
         rTIUGDDij88llqhxTdSCxZLdznhLutMrq2Zwq610sYk7ae1dpjxrwh9U+7BvUPQ/OHGw
         haBlF6zbp6PdBuB1vxdn0H4Qud8OcBCBqVIYdwNc7lj11PAz8wD8Wh2AME2LXVzBAn/T
         Cslh7VCT6+XDbKPn3F5pHKGThdVQKEp4MGoFxNf4Qbo1J6avNvosMLFsoW5aGcDtLf8L
         jiEPBbJUyt/EbCxWH5lXHWMzuS2ynia72oTfCYF4H5TshgHRg6qT+i8929B5GtJMBAbj
         cLQA==
X-Gm-Message-State: APjAAAXFkivOkr6WqX9iTfJBXAREhoxOC7zNyhkdb4qybzUtkVtZCmBn
        ToA9f0cItkYF7QGtcaEs4JY=
X-Google-Smtp-Source: APXvYqyKbyikos4S3uOhLBceay26ubCp5ltWoiUqgKrmVRP4FNig87kIVi6vDTVlQkNOKMn1nBZ/4g==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr133901wrx.288.1576020923297;
        Tue, 10 Dec 2019 15:35:23 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm59478wro.88.2019.12.10.15.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 15:35:22 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] soc: bcm: brcmstb: biuctrl: Update layout for A72 on 7211
Date:   Tue, 10 Dec 2019 15:30:42 -0800
Message-Id: <20191210233043.15193-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210233043.15193-1-f.fainelli@gmail.com>
References: <20191210233043.15193-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BIUCTRL layout is a little different on 7211 which is equipped with
a Cortex-A72, account for those register offset differences. We will
match 7211 specifically in a subsequent commit.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index 978cf52be664..d766577bc5d4 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -76,6 +76,12 @@ static const int b53_cpubiuctrl_regs[] = {
 	[CPU_WRITEBACK_CTRL_REG] = 0x22c,
 };
 
+static const int a72_cpubiuctrl_regs[] = {
+	[CPU_CREDIT_REG] = 0x18,
+	[CPU_MCP_FLOW_REG] = 0x1c,
+	[CPU_WRITEBACK_CTRL_REG] = 0x20,
+};
+
 #define NUM_CPU_BIUCTRL_REGS	3
 
 static int __init mcp_write_pairing_set(void)
@@ -183,6 +189,8 @@ static int __init setup_hifcpubiuctrl_regs(struct device_node *np)
 		cpubiuctrl_regs = b15_cpubiuctrl_regs;
 	else if (of_device_is_compatible(cpu_dn, "brcm,brahma-b53"))
 		cpubiuctrl_regs = b53_cpubiuctrl_regs;
+	else if (of_device_is_compatible(cpu_dn, "arm,cortex-a72"))
+		cpubiuctrl_regs = a72_cpubiuctrl_regs;
 	else {
 		pr_err("unsupported CPU\n");
 		ret = -EINVAL;
-- 
2.17.1

