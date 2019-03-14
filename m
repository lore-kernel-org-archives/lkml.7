Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6A8C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F46A2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="hqsk+Qyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfCNFx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:53:57 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:39214 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfCNFx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:53:56 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 9E26DCF4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 05:53:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RpA_tA4Cxxj0 for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 00:53:55 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 6B98BC57
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:53:55 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id h3so3705929itb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 22:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=U5xe+ZNIoomORM44VhJ6h/t+96Zp9y2ll4mNH/I7bNM=;
        b=hqsk+Qyri/w0znrxhTycWtcryqKrGafoZlaMdJTsZkS7m3fS1dy8hhYw1CoTK3LuNH
         bVa8L0InYqqtH/cCZEZV0CzNDqqFRdBCvcgONBqvnxTh7DpNQEbGIs4sjJLMG80YqgZR
         xzxUNVbIPmGemQ6IyGXmqbz5rxD4rlLc0l0oK7Y+2t6KsNW0zj4bvOEAsIP0nkvv26/U
         lF24eMF4RiuNd/MzcV++nWbOfNFmAaYbdjjnB+MDYsfcM+XeqBD1MWaccw6yyWarjUzC
         cOwe6oeaVobrCjxP8QvJSCcyOfyeHRj8qh4NMb43BlMCZGRmkoR4fbz25OuPgY9N9Fqe
         BiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U5xe+ZNIoomORM44VhJ6h/t+96Zp9y2ll4mNH/I7bNM=;
        b=I+7CYaSppdN172R/8ZLFRtMNM5l53MuCz7/X9U3/l/EfXz1DRGTLchjyE+Zog9gCYw
         NNAB0J9bFrmZRoLc1zROL0SBw0Yf5rCVQgh5ksqC9ghaRKtgM5NHoaOfy/fgydAuw/VV
         ihzzldq2QtbpFNidDd+/7xftV3PZ2DCLGmVcnYV3/IJUZ7TZyLdFfZki8AQV+d58QA+N
         9njx6ApgWVXR7L0qiJ3toQmYARcI7HnSbVPOYH0ZG7iI67qoApcklPjerS18NHFm55bq
         q8eOvjkh5GcWK3Ohu7ECgCrwYIwZie6Fd40r4RpRK5qNTdBB8OuFr1ja6i0ayFaTYp9j
         oBWQ==
X-Gm-Message-State: APjAAAUOOqifL3M2xz7ZxINNw9rreo6ys8AVuHPaHcAsa3M64/EviLxH
        +ME+n0Z/48WID2xUBNLRKpaxrXhmKJFyAcNNwvqLDGNZ8NxGeBqtWGz/I4VzoN+zcoqP5jpHisc
        yRglVwUQ7YYcoPETRsw4LfYl7E9rT
X-Received: by 2002:a5d:85d9:: with SMTP id e25mr27941319ios.31.1552542834726;
        Wed, 13 Mar 2019 22:53:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzbLe0k3h9XwmTY3VTxCLfT6cz8tFtTA2VufmXaUn3c6ZwXH8hDJbvXMUwaO7Ma7TBayKBhHA==
X-Received: by 2002:a5d:85d9:: with SMTP id e25mr27941306ios.31.1552542834490;
        Wed, 13 Mar 2019 22:53:54 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id z132sm671474itb.1.2019.03.13.22.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 22:53:53 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci: pci-tegra: fix a potential NULL pointer dereference
Date:   Thu, 14 Mar 2019 00:53:47 -0500
Message-Id: <20190314055347.3519-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case __get_free_pages fails and returns NULL, the fix returns
-ENOMEM and releases resources to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/pci/controller/pci-tegra.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index f4f53d092e00..0bdc6ee904f3 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1550,6 +1550,12 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 
 	/* setup AFI/FPCI range */
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
+	if (!msi->pages) {
+		dev_err(dev, "failed to get free pages\n");
+		err = -ENOMEM;
+		goto err;
+	}
+
 	msi->phys = virt_to_phys((void *)msi->pages);
 	host->msi = &msi->chip;
 
-- 
2.17.1

