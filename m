Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3589CC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0389820657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mWanSoeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfFQNUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:20:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33566 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQNUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:20:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id x2so10646394qtr.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 06:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WxySO7RavF5zKMyjv/ZaNC+WOWObSuSTRMAxWTHSvk8=;
        b=mWanSoeKZy4yF6NDlcrcGKEXWiXQ/nNABojBc9NmRQLyOxGN+dfp6x98NxigKwj4A1
         0TbLG+zYbbzxQ9VsYrkBavXogdkcX6lH1Q2hGSSD1xPLqrb3OEfaPzOgWOuZwF838FIM
         abzv0h0l/nIAiwtlY+xCaD6+GIdpUj1xNWcH9XHJ285eeYs/KxtJFGcAtFZTcN83DFe2
         OS0m58Pyl5UPRnWJZRdZlEZbD1QXl6SfEcziIPoJYPWq1xYE3vprBROYORWK14gLD1Gh
         ySE/+Wx36zotGAUWWc2tV8iUfDd8G8nNTDA3sCmBlr0f6FRrRl1WRUUwh6stUCakMUvG
         9mgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WxySO7RavF5zKMyjv/ZaNC+WOWObSuSTRMAxWTHSvk8=;
        b=HBdrM83xTxE0gmv9YlUWftSFExwYyiavlV1cPlw6ziHH3fRJ8xmlSbnjn0CxQGfDzw
         InbIliqCymcHK8axA3IC4jPIP6rC72DMzgQUNXEz24xUvsjFSXXoxL0iwsU5GoH6fahH
         0S476zG9pRamUlG4JSnd/232hya2VTZrq/Wj0ZLtpv2mzo3I8ZJqMJ/IdVe+t2s0YxRa
         9Pip1JZIkrpw5UvEadMrfxUvFvvWqAMjCDks5ARXCkd9lLgRO+zqctZqnhNch49M8eTB
         iCIOo9yqYNjx6y5wD/UUqjleMQao5aLmbjv9dXBC6EB3KI8JsY+J20RDtVz0Y87El+Mf
         PsiQ==
X-Gm-Message-State: APjAAAX1gKxISXR96qi9LHRCWIb5AZq/0u+9QxOlyiLdQSzNAI6TR6IQ
        MIKHvjn3xl5393+3vjjge4xeOw==
X-Google-Smtp-Source: APXvYqx8nwAh/ef1Z7S6mpaIuw+uQGeTu/VellQt7Hwdg7+ajM7LdXfG3blR+hAVljz5qh/x3jNcpw==
X-Received: by 2002:a0c:b0c6:: with SMTP id p6mr20449953qvc.225.1560777636216;
        Mon, 17 Jun 2019 06:20:36 -0700 (PDT)
Received: from ovpn-120-145.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t80sm5767002qka.87.2019.06.17.06.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jun 2019 06:20:35 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     dwmw2@infradead.org, eric.auger@redhat.com,
        baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] iommu/intel: remove an unused variable "length"
Date:   Mon, 17 Jun 2019 09:20:27 -0400
Message-Id: <20190617132027.1960-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit "iommu/vt-d: Duplicate iommu_resv_region objects
per device list" [1] left out an unused variable,

drivers/iommu/intel-iommu.c: In function 'dmar_parse_one_rmrr':
drivers/iommu/intel-iommu.c:4014:9: warning: variable 'length' set but
not used [-Wunused-but-set-variable]

[1] https://lore.kernel.org/patchwork/patch/1083073/

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 478ac186570b..d86d4ee5cc78 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4011,7 +4011,6 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 {
 	struct acpi_dmar_reserved_memory *rmrr;
 	struct dmar_rmrr_unit *rmrru;
-	size_t length;
 
 	rmrru = kzalloc(sizeof(*rmrru), GFP_KERNEL);
 	if (!rmrru)
@@ -4022,8 +4021,6 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 	rmrru->base_address = rmrr->base_address;
 	rmrru->end_address = rmrr->end_address;
 
-	length = rmrr->end_address - rmrr->base_address + 1;
-
 	rmrru->devices = dmar_alloc_dev_scope((void *)(rmrr + 1),
 				((void *)rmrr) + rmrr->header.length,
 				&rmrru->devices_cnt);
-- 
2.20.1 (Apple Git-117)

