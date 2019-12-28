Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA01C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 19:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBCD2173E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 19:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9q6Ugps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfL1SyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 13:54:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45982 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfL1SyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 13:54:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so16325282pfg.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 10:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UMpegDdh42rzwNWi4a8X/3LZzmdLDgDCJkziq2QANl8=;
        b=e9q6UgpsjC8HSol+91vUSHFa8daBZdwfDH9ZaAV2Jp6qXzLG2sx+VRx0s6GWj8/ADO
         HYGMGVEEMgKjXVJ0AdrCNTV7kiDHSMV8/qNfTrMf+f1GmzI/bebbACkVVz14k/dS82Tj
         IhYUG14vGzbmhUd73o0R7t2I3cX7SSb6YUHbqZWXHxOq+czkfmzq1I5oyVDPuOMeZAGH
         BNf12FdFdPkDC9ndIR7pTNCQhi/8qLU3QlbOmDWLsSv8SgtoSdjB1PW1QYu1oheOMUW4
         Uvi7Rf8iwO7R6LazQsZ6crHj2+WJF4Yxvx/3/uO8zfCmTXvCuMYb4YKWtZlRSvv/i1vm
         coTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UMpegDdh42rzwNWi4a8X/3LZzmdLDgDCJkziq2QANl8=;
        b=i1m80PrbI5NqGjZQslEWiWs/RhLBGigMAEDsSjTsc2WwwC+eIgvuPuQs+8FsK9a7i3
         ZmvQZsekHxPr1afFArZl0sTmG9UcopIVHXO8cROI0Anu5cUgdkrXzztaYpfsTuay1ZKx
         A5TfIKHxJeom7lZpvapKNuZ0i2m1fgM9ImtyhN3IIIpfkMxMLAUfSjzEwSF3QhY2aAZL
         HuiRBmIb7fFu1Cg/hx99b4TcPbSbzy2zFexIE1PgO02sxyE1KYCOeFLvvhaydM3aM9J8
         Veg4hNx5pHTezPd4asM5LXfLmNFIk9ADx1bhbRc53j9yYAGhz+trWL9aji9UKfAht8AS
         l8rQ==
X-Gm-Message-State: APjAAAVgl6Q6LZ5GMxRrwjERVS7dLClil9d3byYPvBJng7Y03v6tskbu
        T9mJBqB92N6DPe5HyJojpDg=
X-Google-Smtp-Source: APXvYqxZdd7bCMqliucX1yrrszuwOT+M4ZDG7SqTzywn9D7Id0OiQSUtwWIlN0/jvmlNbs4Auz2/aQ==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr59963512pgh.96.1577559253330;
        Sat, 28 Dec 2019 10:54:13 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id 80sm37407784pfw.123.2019.12.28.10.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Dec 2019 10:54:12 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     vitor.soares@synopsys.com, bbrezillon@kernel.org, pgaj@cadence.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/2] i3c: master: cdns: convert to devm_platform_ioremap_resource
Date:   Sat, 28 Dec 2019 18:54:06 +0000
Message-Id: <20191228185406.26551-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191228185406.26551-1-tiny.windzz@gmail.com>
References: <20191228185406.26551-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/i3c/master/i3c-master-cdns.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 10db0bf0655a..2fb7ed34f995 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -1524,7 +1524,6 @@ static void cdns_i3c_master_hj(struct work_struct *work)
 static int cdns_i3c_master_probe(struct platform_device *pdev)
 {
 	struct cdns_i3c_master *master;
-	struct resource *res;
 	int ret, irq;
 	u32 val;
 
@@ -1532,8 +1531,7 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	master->regs = devm_ioremap_resource(&pdev->dev, res);
+	master->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(master->regs))
 		return PTR_ERR(master->regs);
 
-- 
2.17.1

