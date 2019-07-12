Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38230C742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0038921019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="A+b4O8Qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfGLIbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:31:36 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:43113 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfGLIbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1562920295; x=1594456295;
  h=from:to:cc:subject:date:message-id;
  bh=7RsXD6HULg7KmuR9jfshSZipD+W/ZyOPI6VaKM9JmnQ=;
  b=A+b4O8QnNtiOwJmk+KeadD8NlbZMJ8q3LLfjwXanea+KTBM/gV+iaMZE
   XM73yqONfRHp+hyTKOVhD7WKL139h+UzoNlJLXx4JGansJ+NyEvsBj348
   5f9u7OVrpGYGacZQK0ZuYBrF1/56Es+V6i7f/yB6TKvUtNQniT+0KpSHL
   0=;
X-IronPort-AV: E=Sophos;i="5.62,481,1554768000"; 
   d="scan'208";a="810816106"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Jul 2019 08:31:32 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id EA0F5A22CC;
        Fri, 12 Jul 2019 08:31:30 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x6C8VRgS018720;
        Fri, 12 Jul 2019 10:31:27 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x6C8VQCV018713;
        Fri, 12 Jul 2019 10:31:26 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     KarimAllah Ahmed <karahmed@amazon.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] fdt: Properly handle "no-map" field in the memory region
Date:   Fri, 12 Jul 2019 10:31:24 +0200
Message-Id: <1562920284-18638-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the memory region with NOMAP flag instead of completely removing it
from the memory blocks. That makes the FDT handling consistent with the EFI
memory map handling.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 drivers/of/fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index de893c9..77982ae 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1175,7 +1175,7 @@ int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
 					phys_addr_t size, bool nomap)
 {
 	if (nomap)
-		return memblock_remove(base, size);
+		return memblock_mark_nomap(base, size);
 	return memblock_reserve(base, size);
 }
 
-- 
2.7.4

