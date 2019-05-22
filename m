Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFF1C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7DE2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Kf+vIzAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfEVKrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:47:21 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15508 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfEVKrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:47:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce528b80000>; Wed, 22 May 2019 03:47:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 22 May 2019 03:47:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 22 May 2019 03:47:19 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 May
 2019 10:47:18 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 22 May 2019 10:47:19 +0000
Received: from puneets-dt1.nvidia.com (Not Verified[10.24.229.31]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce528b40001>; Wed, 22 May 2019 03:47:18 -0700
From:   Puneet Saxena <puneets@nvidia.com>
To:     <robh+dt@kernel.org>, <pantelis.antoniou@konsulko.com>,
        <frowand.list@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <vdumpa@nvidia.com>, <snikam@nvidia.com>,
        <jonathanh@nvidia.com>, Puneet Saxena <puneets@nvidia.com>
Subject: [PATCH] ignore disabled memory-region nodes
Date:   Wed, 22 May 2019 16:17:10 +0530
Message-ID: <1558522031-549-1-git-send-email-puneets@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558522040; bh=cC9Pildjkan4wUsPw2Vmk31xAPZILgJT7kB9V5IdJ64=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=Kf+vIzAUdZuqfK3Hsr8YRO97C0wB8RnbF7rcd6IhGsXF1b9kiUZfufGiGNBsnYCni
         OAPPclCHCka9yITPMJZr0rp89lGxG8x/DgnZ/Gi0kIzeyA+jdfoUwqeKcgaWSQcijn
         UPvxbD3dYoIW32bVQSAcCXBXCITQ6KCCVdqN/hP4J497O5ef2PPuXh+wakJNpkfyFL
         AuW5lNGEj1WEtQ3Dj5RZpqKwKTQmXLnX16h5ugQifXmYsTSWhSbX9jYev+U6ka7F71
         ehwY2Ny+uyKtMM3fNIYNBMhNC15ZbkJjneWKI+E0MByt7eKShhX9sCTm4c/L7zSh4Z
         BALut4Sf5ocXg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While parsing "memory-region" node lists if a node is
"disabled", parsing halts. Therefore the nodes whose
"status" is "okay" or "ok" are not parsed.

The change ignores disabled nodes in the memory-region
nodes list and returns 0 to continue parsing next nodes.

---
v2:
* Fixed typo in commit message.
* Used of_device_is_available to check device is disabled/enabled.

Krishna Reddy (1):
  of: reserved-memory: ignore disabled memory-region nodes

 drivers/of/of_reserved_mem.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.7.4

