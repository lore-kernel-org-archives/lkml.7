Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0808C352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741D9217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e+HGGBCB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GT/WkbGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfIZWsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 18:48:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37552 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfIZWsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 18:48:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 370F660BF5; Thu, 26 Sep 2019 22:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569538102;
        bh=g3A8dwd0zmZ7Slh7dbZkQRsQqjR2/quJV4fThwUAG1E=;
        h=From:To:Cc:Subject:Date:From;
        b=e+HGGBCBDggjT9Mfko2DHSpSSmoa1eB3BGF6q7CaSUiZi+ADcK67SG5YfrB1powy9
         6D4Ka6EizAgaa6CorP7wJza2JDbZrdN5mtTerZb8aEzYJY4Hdwyq/VYJcaQ3b/KNZj
         msXY3HKnQxCnlIitUga+7Ml0Pn+fVMnGrxRif0xg=
Received: from cgoldswo-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EB297602CC;
        Thu, 26 Sep 2019 22:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569538100;
        bh=g3A8dwd0zmZ7Slh7dbZkQRsQqjR2/quJV4fThwUAG1E=;
        h=From:To:Cc:Subject:Date:From;
        b=GT/WkbGHtUFFaDmFFpQmgp8CpFnzZuVFRZgJlAUX+oQ1nnaqaMMQmVuXdumuTcPj8
         lyFeATj2IjJ8V8wpCX3xy76P3TOKjpf2vIg6OPP3hGYC4pNAbZQPggI669cbNq4eHW
         l2q/3R+aBG0oCXE7dtfBj7ux9UFapx0FA6hA0Hyw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB297602CC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cgoldswo@codeaurora.org
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Chris Goldsworthy <cgoldswo@codeaurora.org>,
        devicetree@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] of: reserved_mem: add missing of_node_put() for proper ref-counting
Date:   Thu, 26 Sep 2019 15:48:12 -0700
Message-Id: <1569538092-16913-1-git-send-email-cgoldswo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d698a388146c ("of: reserved-memory: ignore disabled memory-region
nodes") added an early return in of_reserved_mem_device_init_by_idx(), but
didn't call of_node_put() on a device_node whose ref-count was incremented
in the call to of_parse_phandle() preceding the early exit.

Fixes: d698a388146c ("of: reserved-memory: ignore disabled memory-region nodes")
Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/of/of_reserved_mem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 7989703..6bd610e 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -324,8 +324,10 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 	if (!target)
 		return -ENODEV;
 
-	if (!of_device_is_available(target))
+	if (!of_device_is_available(target)) {
+		of_node_put(target);
 		return 0;
+	}
 
 	rmem = __find_rmem(target);
 	of_node_put(target);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

