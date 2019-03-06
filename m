Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D715FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A436D206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFtAshLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfCFWxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:53:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38824 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfCFWxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:53:09 -0500
Received: by mail-lf1-f68.google.com with SMTP id t2so5590630lff.5;
        Wed, 06 Mar 2019 14:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XbezsKf1c1abu6X5m1VCeQOu7ayNx/+0cEe7Omh89Hg=;
        b=PFtAshLIh7rh6IqtSWdl9anHdxHuSu1rZIz43ADUgkS+KoXjE8lUn57Jv8mFUnyA7z
         iAE3PRnTcVPcA5Gdx+aQTLhETl+FXEx/SDC76UrN6im+RZv5UkYU3xLXkUaC8pxd2L/6
         8lLJJnCM7GHnfT/gwVrSlLHK2ROTD3mNkVwE+l4ajPAAOCyXimcriIVqbEyi/ev655Ur
         fKDAf29uH0+TYlUI+KWwoCFoV8LX3EM/lEYiig0NfWxxPPHFNteRpD73vg1FTKgaQIJR
         lwbX72DMLO8QtB3x+fdZHFLjoLSzScuBlvgNbnR1OnQ8CbCIa2RdI9amv8LtmuFCrWck
         Wnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XbezsKf1c1abu6X5m1VCeQOu7ayNx/+0cEe7Omh89Hg=;
        b=As4gweq1GfvFrXO7nYsyW1oWldvD9qhWHnfoR8M7jn0xCFHL+FKmNiGWW7hUVVYXvu
         7ql7CW+mw6ouPqpKs8S2nJdmvQs0Gsr0yYdG8ckcFyWImDCdsve9BSuC3KEGW1vg03x6
         Anjdi/tF8HQOKYVUIHE05KWiRfbbEfPpLHnwGDtf7ZT2BRR5X3K4fsHg5Aog5N5Y76Rn
         hYuFqvSUm5KiOdHpFTpvB1gJ5ZxwNtGnknMDotfS5T0tqkrllLE9Cl3qYkkCtSdPv8yI
         gUfQ0jHK4VBdkqRQMaBPCFmXxM9yjDJkBPe4JGWqhkw8RWDLtzwjSP35JUuVTiDzo9qe
         9rqg==
X-Gm-Message-State: APjAAAXoFs9zi5xy5zYE2KnKbbh/KWxD3CF8LS4bSPC7LzZRRvqivIqd
        g5ZoPYDaqLce5CrJPG26KYk=
X-Google-Smtp-Source: APXvYqwyO9/jxFsFIXxeBcw4MPgka5jenvurRbpHCNQ4WQDJqlwEvQthwh7D+ZGP9dtNcHQgAFSkZg==
X-Received: by 2002:a19:48cb:: with SMTP id v194mr5377609lfa.166.1551912787131;
        Wed, 06 Mar 2019 14:53:07 -0800 (PST)
Received: from localhost.localdomain (ppp94-29-37-86.pppoe.spdop.ru. [94.29.37.86])
        by smtp.gmail.com with ESMTPSA id x18sm536961ljc.67.2019.03.06.14.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 14:53:06 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] iommu/tegra-smmu: Properly release domain resources
Date:   Thu,  7 Mar 2019 01:50:08 +0300
Message-Id: <20190306225009.3391-3-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190306225009.3391-1-digetx@gmail.com>
References: <20190306225009.3391-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release all memory allocations associated with a released domain and emit
warning if domain is in-use at the time of destruction.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 8d30653cd13a..27b1249f0773 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -327,6 +327,9 @@ static void tegra_smmu_domain_free(struct iommu_domain *domain)
 
 	/* TODO: free page directory and page tables */
 
+	WARN_ON_ONCE(as->use_count);
+	kfree(as->count);
+	kfree(as->pts);
 	kfree(as);
 }
 
-- 
2.20.1

