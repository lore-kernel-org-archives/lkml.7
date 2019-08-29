Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA330C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6F320674
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqZSmeLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfH2LOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:14:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35526 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfH2LOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:14:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so3421266wmg.0;
        Thu, 29 Aug 2019 04:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JD+FPst1Rc2Zts2/SszFlnm8yp7vNf5nv1OwzcG2Ea4=;
        b=oqZSmeLw/EC3Wd0txJnCJRoJzOmmCY56LdWnG2oKlSLUljtbZSUQpyV71svWYX9r4a
         nHrLUveNwTmd16rB8M0PNaaiHRW9/d9Jzb+ru281rX04x3PB0KLs6Bxo9dZhgg3PBQFW
         umAZcpfdKECX/Caf4nntQFZS79CEf3J/8mswG+70D4oIMuQx8+TODriRJQp7/uBp+oU5
         YIObXT9Hj6in32E9rNwbWdIBzc4LDYhJhYYXS/l+iGNtrtqtMpUu2iJVEpFcGHwVmcvO
         WGWAc/knxRIl1thWtrjKuOJ1V9Y4XxiGwiQTYNaoVFkMGCE0Z/PiqW4tcKI0ZlzxpjIS
         qzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JD+FPst1Rc2Zts2/SszFlnm8yp7vNf5nv1OwzcG2Ea4=;
        b=LAyFiVvM91FV3zjC0zzQBME4wyCCJJF98/gNvip+epxFAAO9DET/8xCOKZOJN0XGfI
         ePtTfJvdTSml+ia+Zh/8UbIYJK8R5EVoirukVzVgiERunahgVlhaVATyO+vwX+CZBna4
         X9i9O4Iv1MMAUOhc28wH81oSoEfkE60/fWdx5rojTMhvCnfMwxFx3wUIvU2sMml2uWp+
         YsoD0w5H3R8hwfUU0/vWfXAwIuzKglivFeLoVe+B2Vn9xhDYcLKzVvH/d43dTe6Im0gZ
         ha7pqNWC8HX+91adV9eQprjucdhVK9YV6LcYTKwN+t0p94zgEjYGQ2hlmFlYON6HFx+d
         1llQ==
X-Gm-Message-State: APjAAAWroUR++SNsXsLh7XbKgcfDuWQGMKB7PoIpW9LWK7zCX8AY7mAO
        /zqtH//WpnTVZU6hjswEDuo=
X-Google-Smtp-Source: APXvYqzcmuDvPpuvAAO8pn2NqELxI3Y0KBVVxn316XZ2m3inkhdiVtyJlblr8PnZhlxEiSikUNWvPg==
X-Received: by 2002:a1c:ca09:: with SMTP id a9mr10586744wmg.43.1567077249051;
        Thu, 29 Aug 2019 04:14:09 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id l62sm3469749wml.13.2019.08.29.04.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 04:14:08 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iommu: Support reserved-memory regions
Date:   Thu, 29 Aug 2019 13:14:05 +0200
Message-Id: <20190829111407.17191-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

These two patches implement support for retrieving a list of reserved
regions for a device from its device tree node. These regions are
described by the reserved-memory bindings:

	Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt

These reserved memory regions will be used to establish 1:1 mappings.
One case where this is useful is when the Linux kernel wants to take
over the display controller configuration from a bootloader. In order
to ensure that the display controller can keep scanning out from the
framebuffer allocated by the bootloader without faulting after the
IOMMU has been enabled, a 1:1 mapping needs to be established.

Thierry

Thierry Reding (2):
  iommu: Implement of_iommu_get_resv_regions()
  iommu: dma: Use of_iommu_get_resv_regions()

 drivers/iommu/dma-iommu.c |  3 +++
 drivers/iommu/of_iommu.c  | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/of_iommu.h  |  8 ++++++++
 3 files changed, 50 insertions(+)

-- 
2.22.0

