Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C221C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B9521473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HkD1qDnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfEVUhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:37:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42575 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbfEVUhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:37:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id j53so4079730qta.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DDEc493zRRlIzxUABdOKVz8yZe5OqF7VHlzAHj5qgck=;
        b=HkD1qDnPggcknOVzuyXItIMGjUV7me9Zi8Vwtpvs+Um5+AFZ9Q1zQ2gPUyHNB7vAgM
         Js8drHBrwL9CchGi9PVmV/G4CGVAfBIkuWEUxvWo3bi5+Td4egvLTrqRKqeNySwHVAzr
         PuVf7clTGSp/Vn5yBjTOCFVWAS2moFTjeF0hQl2MVbbrKINN5stXEScQU2GsAq1PDQ6u
         5WnrsGzxPtBal9RVXslCFrc/3NhG5fCjV3YLlrGTlDFv7kTXxLadoavrU+0wmiKSydgx
         xpQ5XFmJdtp9dqWiMft6z4rd+jYkY3X62rVSZsYBsT7nR5pgQgaDdhUF0aLvay4D8CRT
         qIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DDEc493zRRlIzxUABdOKVz8yZe5OqF7VHlzAHj5qgck=;
        b=B21BnLFJufsSwnjr7GIVF7HAHgrCP7loK0o9ZkoFev8xbRzCmMTewgiN23oqoGlosI
         QpFDINlkvMo3lOiF9LmWZwxdiec1bEp+GXhBLYRKlAgXZz/qR+q1jWQYIX1xtv4iSoE1
         TZmIafOtkIJkk81E4PKy9tHQlFMdOn4VBcbicyE9vp7CMHOhwew7VfOAkZDaFev7D5X+
         bsKY+JAGRnFVX5NMfGXEMsHPwz/eOWn++2A5d3iqK+TEX6s66VTLM/QVaPongldQnPed
         s4Cp/ap55oEuDf5V+g/MlmF+bZfEuw2y/6j9gZF3EMygDoS9tVj7DZUWWQne63O6PgPo
         f5xw==
X-Gm-Message-State: APjAAAXke+VfCK+zGqDWm4nKPsmz/krRQGMnBOHjx5CfXZzdXPbGR0H1
        iEKtujK8RJK5y2bnhBMwWdYjGPsgf2A=
X-Google-Smtp-Source: APXvYqwMYhS0u5PhrONFf+mvi1pBgngqWhuTqFo2JraK7yCZuFqDmAVoYIt4h+YtfkFs6KwzsgZsdw==
X-Received: by 2002:ac8:2617:: with SMTP id u23mr75957842qtu.141.1558557426395;
        Wed, 22 May 2019 13:37:06 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f9sm7013886qkb.97.2019.05.22.13.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 13:37:05 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     jroedel@suse.de, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [RESEND PATCH] iommu/intel: fix variable 'iommu' set but not used
Date:   Wed, 22 May 2019 16:36:26 -0400
Message-Id: <1558557386-17160-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit cf04eee8bf0e ("iommu/vt-d: Include ACPI devices in iommu=pt")
added for_each_active_iommu() in iommu_prepare_static_identity_mapping()
but never used the each element, i.e, "drhd->iommu".

drivers/iommu/intel-iommu.c: In function
'iommu_prepare_static_identity_mapping':
drivers/iommu/intel-iommu.c:3037:22: warning: variable 'iommu' set but
not used [-Wunused-but-set-variable]
  struct intel_iommu *iommu;

Fixed the warning by passing "drhd->iommu" directly to
for_each_active_iommu() which all subsequent self-assignments should be
ignored by a compiler anyway.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a209199f3af6..86e1ddcb4a8e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3034,7 +3034,6 @@ static int __init iommu_prepare_static_identity_mapping(int hw)
 {
 	struct pci_dev *pdev = NULL;
 	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
 	struct device *dev;
 	int i;
 	int ret = 0;
@@ -3045,7 +3044,7 @@ static int __init iommu_prepare_static_identity_mapping(int hw)
 			return ret;
 	}
 
-	for_each_active_iommu(iommu, drhd)
+	for_each_active_iommu(drhd->iommu, drhd)
 		for_each_active_dev_scope(drhd->devices, drhd->devices_cnt, i, dev) {
 			struct acpi_device_physical_node *pn;
 			struct acpi_device *adev;
-- 
1.8.3.1

