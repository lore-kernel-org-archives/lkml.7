Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76EDC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB4F2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sTV8gSN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfDPOxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:53:02 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:42819 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbfDPOxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:53:02 -0400
Received: by mail-pl1-f201.google.com with SMTP id g92so13547777plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vNJUA8SSMnoLgMtfgc/egpvj+rAfXWp04WsgX1vfNb4=;
        b=sTV8gSN3EHcxYQHdPyar5VZrCAyWGwSOkiNmyc83wx5IFxydmIzCx9uN8EeVt4+PF8
         nLOJuHI9wJSKP+jEdIRprVxKRhhI+KvE4GQ14rgc2B/tRgFarecVocrUMkLKRE0iPbBF
         tsOT24sQoz4jf1C91aKy0fmqIan6rLAQt7mg48lqPz9v1j1arVrnwi7sKyg57KuNtG9W
         m0vyPw0GiuULdrYpWHJ7H+lvzk9d4YmcrOwy9r1M63nLvReeiJ8UgGzfKszRyi3QbTF+
         krlC6wqTMQ0m+jUYXEM5/NfcGvaHbyfR5VcEZ0TxhQwpDbYvnrwXb7pa03BNs27O++Mx
         ggTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vNJUA8SSMnoLgMtfgc/egpvj+rAfXWp04WsgX1vfNb4=;
        b=BpYEXzMFvAuNbJHy1CLfsFET0VrJz2hiaxKNzI/Li15so0I2c5nlfoju1WQ4VaxbVE
         G2pRuRxP4YxBncsR+uahlHPBKx6rchFOWIq8Zl1LryScYWY8bqpOz8o9r0aBfEdftQyy
         MNiSOWuIJSpWBP/nPMr55a1261TT0vQ2hScno3Cr4oOey1ge+zP5cY0cGRiysw4J6khG
         eipqQgpViUy7H557p046p8zrlLz1gT1t+wCsSZ1FmLeZmynJJpSNrwI9vujL4EnUlqOc
         9NSpbMk3RgylPQCk5EM3fptAD3/DRNEOrjdGmGmzp33qyjkXMYsa4NYkSndz/Wl/DLg/
         zv3g==
X-Gm-Message-State: APjAAAVAesb+RyYiFd3zY9bkdQfkzl/GuI6N6ZS15kVGEg/KQSthblnO
        tVISpO8t6M/XTBOZm0TrXJqMuZv3K5e0
X-Google-Smtp-Source: APXvYqybJAogexZ4npak5ErqgvOdwLSrvgAo8apVujcYqfeq5ZKuCz1mJkIRnb+D1Atn1tBfLXwR0vC6pFOA
X-Received: by 2002:a17:902:7c97:: with SMTP id y23mr3215377pll.79.1555426381189;
 Tue, 16 Apr 2019 07:53:01 -0700 (PDT)
Date:   Tue, 16 Apr 2019 07:52:57 -0700
Message-Id: <20190416145257.101945-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] dt-bindings: Add vendor prefix for intersil
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     treding@nvidia.com, khilman@baylibre.com,
        manivannan.sadhasivam@linaro.org, heiko@sntech.de,
        martin.blumenstingl@googlemail.com, johan@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for intersil, known as Intersil, a subsidiary of
Renesas Electronic Corporation.

Signed-off-by: Patrick Venture <venture@google.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8162b0eb4b50..ffc69a8bedaf 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -191,6 +191,7 @@ innolux	Innolux Corporation
 inside-secure	INSIDE Secure
 intel	Intel Corporation
 intercontrol	Inter Control Group
+intersil	Intersil
 invensense	InvenSense Inc.
 inversepath	Inverse Path
 iom	Iomega Corporation
-- 
2.21.0.392.gf8f6787159e-goog

