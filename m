Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3541BC10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 01:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA4521850
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 01:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Aio3aG2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfC2Bq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 21:46:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43791 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfC2Bq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 21:46:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id m10so215639plt.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 18:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VzgzzWNoq9p4TB3IZJRABKL2LZC7UeXl+XvGfv80CT8=;
        b=Aio3aG2cgB7tZtGOtkAe/NbydsHtYAN7lC1RlxuL2/dqWfWpwyAE9VfYEbesNRVriz
         tKO9IugMjYYy9jfY3LCYJmTZDBIZWm8ee2okrbnkmqrTePTbq10et5505EkYqCdHZjoR
         DnDMe0++az88ex505AmgoVKz6Em+yLSNGOxztLWQNy9+Lci69jMVaKGV/Tal3MqECCcn
         u8BIfneswcHjx13giUK15TFHD7F6bUTapjszPkbot4Nf2NklXQD6GTGyrSmMPtfmL0WF
         wkf+WmNqrMTGw0it8g1WihmgQ/RsuLB7rDqKetnrvzq9J/8Hbqg4tSap+sjiNvS4myIx
         AmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VzgzzWNoq9p4TB3IZJRABKL2LZC7UeXl+XvGfv80CT8=;
        b=RtWBzB2vcjSk9lCeoNzhApDVkdItrCJC3nmZ9rbk8Uj9a5QDJID9nl5Ji7BQktz4Rw
         vjAEjOl8SWizPBaOAibyj5naWdtZZ7CvRlz7T/1oHUwbOY41Dk/4a2nrmbK8+YQRwEHm
         3VF+agZE/sQl94zjEq5dETiku379gh5Bom09EgyiTxoQD2ydUUpmFIC42FdzGhhJG6AR
         QxOFqtywI1oDbdSjZup+Ih9jPZQ0RkT6AGbnVuQJdr9aIsr/G2J9utt63ScAGauVi6dx
         gruFEDASb3ff+DAfnuXakQhg6qiFDEjM0edRnyKFcdtmfm8Ijn7UJ85NJAGVAcO5tWhA
         UUMw==
X-Gm-Message-State: APjAAAViVpShlOhr/Hq4uxo48pBbHGkP0Aj3zp/orQGJnbTMOE1kWRIx
        HiKwgOVZWZlyB2h8wsrmVrXuHw==
X-Google-Smtp-Source: APXvYqwjvrYiyqCEfcM6paZ+Dc12wH5lDX6zL3geaa2VpbpRrmpbVYQXFoi2bYNZa1zbLPmeSAr+xw==
X-Received: by 2002:a17:902:7242:: with SMTP id c2mr10281569pll.245.1553824018859;
        Thu, 28 Mar 2019 18:46:58 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id l187sm516166pgl.75.2019.03.28.18.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 18:46:57 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: vctrl: Remove unneeded continue statement
Date:   Fri, 29 Mar 2019 09:46:31 +0800
Message-Id: <20190329014631.17999-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/vctrl-regulator.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/regulator/vctrl-regulator.c b/drivers/regulator/vctrl-regulator.c
index 78de002037c7..259864520a06 100644
--- a/drivers/regulator/vctrl-regulator.c
+++ b/drivers/regulator/vctrl-regulator.c
@@ -334,10 +334,8 @@ static int vctrl_init_vtable(struct platform_device *pdev)
 		ctrl_uV = regulator_list_voltage(ctrl_reg, i);
 
 		if (ctrl_uV < vrange_ctrl->min_uV ||
-		    ctrl_uV > vrange_ctrl->max_uV) {
+		    ctrl_uV > vrange_ctrl->max_uV)
 			rdesc->n_voltages--;
-			continue;
-		}
 	}
 
 	if (rdesc->n_voltages == 0) {
-- 
2.17.1

