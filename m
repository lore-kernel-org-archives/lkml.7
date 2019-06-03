Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DB7C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3FE2792D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="N9Pr2jYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfFCOFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:05:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34836 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfFCOFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:05:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id l128so464292qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nF9cQpios6fXc6OzV7zmvzF2+NBva4iLFuGACokhWRE=;
        b=N9Pr2jYVC3j5RXnC1lhMMCOGdLeidx0t4kajq30mmGwS9UFw32IWw17K5OUeYwy/Z4
         ImpgBtW72k5AIKHNDm3VsibxjC/QObuVKP4jLT3j9hs11/kYKHfQQKCUAYIP91yS7mSc
         cUbs6kRFMGTHe115Nd1uObdfmQzco1YLOfiNKpac64pOTcYtIBoPyMp7s4YVK4pAbMER
         MLt3DIseH7ilx6DjDpc7HXZ8L8Xl6fXTVNH3IbPrm7DGcftz67uPHF/FT2IuvsTYpSdS
         Gz7KAkhG8CHp+NBnRAyGOqHtHEM8qsnegoWqEkNm08xPpmLsdEom8WxE5RQ8FwbtqX/F
         4osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nF9cQpios6fXc6OzV7zmvzF2+NBva4iLFuGACokhWRE=;
        b=oNEB9SumheHQ6wwZzeoTlYOMauqpccmUBjdyxZwhkmq51fbFBW5CYDklAO8ZVUm5V5
         1UQw2ttX9psGnNhlm5NT7xHcCgi3AVC6pr5AFm02uPtpSPLcUi1m8mqzvpTOo296ZV1x
         pLOloQQ2hNXL6D8ntryJGS3tkvztUzhV4AzIe6toLxGk60K6C7Gdmc2QWMlHT9aLOamh
         jYjyb2OcsFI2T561lbe4ok1wBdS1uiMt7mAT9rAcfl8AMLDOzPDRt8le/q1UzT6Mkhe6
         539gqmaKPaMk95m7a2KfIvxjABAl0XsevsoGjTny9HgNO2rhmgxPyayM7lMhY03OUhSY
         nSIg==
X-Gm-Message-State: APjAAAWnlSppFX7Vb+PsN27gwOoJf0WkeUmp+a+CaJy5k0SfUtbwJW4t
        HJJxqoJ213wiKKOdPNSuEV84qQ==
X-Google-Smtp-Source: APXvYqwvA7+/eTZv71B8hBFS5QTuc/mvZOV2BnCVsIwXN90jHz1i5jWNRPBpMFNl755BiaI33dSSGw==
X-Received: by 2002:ae9:d601:: with SMTP id r1mr22357556qkk.231.1559570731086;
        Mon, 03 Jun 2019 07:05:31 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f9sm9310878qkb.97.2019.06.03.07.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 07:05:30 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     baolu.lu@linux.intel.com, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] iommu/intel: silence a variable set but not used
Date:   Mon,  3 Jun 2019 10:05:19 -0400
Message-Id: <1559570719-16285-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit "iommu/vt-d: Probe DMA-capable ACPI name space devices"
introduced a compilation warning due to the "iommu" variable in
for_each_active_iommu() but never used the for each element, i.e,
"drhd->iommu".

drivers/iommu/intel-iommu.c: In function 'probe_acpi_namespace_devices':
drivers/iommu/intel-iommu.c:4639:22: warning: variable 'iommu' set but
not used [-Wunused-but-set-variable]
  struct intel_iommu *iommu;

Silence the warning the same way as in the commit d3ed71e5cc50
("drivers/iommu/intel-iommu.c: fix variable 'iommu' set but not used")

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b431cc6f6ba4..2897354a341a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4636,7 +4636,8 @@ static int __init platform_optin_force_iommu(void)
 static int __init probe_acpi_namespace_devices(void)
 {
 	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
+	/* To avoid a -Wunused-but-set-variable warning. */
+	struct intel_iommu *iommu __maybe_unused;
 	struct device *dev;
 	int i, ret = 0;
 
-- 
1.8.3.1

