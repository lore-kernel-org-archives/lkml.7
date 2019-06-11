Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69A1C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADE6206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LsKUwIpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389585AbfFKOGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:06:51 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:43186 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387637AbfFKOGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:06:51 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 955F2C0F51;
        Tue, 11 Jun 2019 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560262007; bh=vMEPr50pYiB+tqjKzwXZ5iSJP43TFUpQmHn+ZkqTQqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=LsKUwIpu89KGiUrigsB4YtoJon18DD8SBkwfVLIUfdzAap9VT3StDmzmHjsO4VKrE
         OvXpH9yDo7xajpY4esqyciY2KEa3XXuilIa9T8MnP5ts6PWBjyk2xvFIJat57UsLPD
         5s5AvGQacagSSWN5E6gszB4RYnLRdxOZz745GJrGxFqZdV/xentrxQ1M7dWmp9wWUk
         apl3CLCy4UknQLYluQnxY+JAEJTS+YqJRzlByMgjgBi5gUUyDLBwPw07LQpHhQIBJK
         DytAzaQilB0wT/ThR0wEQIYsu6UceCdbsHjTXr2rnc+id2yItCZKsBPGCBoroc+nCw
         uVq6zczR0UYFQ==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 18F25A005C;
        Tue, 11 Jun 2019 14:06:49 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id EBD213F594;
        Tue, 11 Jun 2019 16:06:48 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, Vitor Soares <Vitor.Soares@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] i3c: dw: add limited bus mode support
Date:   Tue, 11 Jun 2019 16:06:45 +0200
Message-Id: <db0bc8a55c7d54d99e36226e34aefdb932c92515.1560261604.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560261604.git.vitor.soares@synopsys.com>
References: <cover.1560261604.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1560261604.git.vitor.soares@synopsys.com>
References: <cover.1560261604.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add limited bus mode support for DesignWare i3c master

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
Changes in v3:
  None

Changes in v2:
  None

 drivers/i3c/master/dw-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 1d83c97..9612d93 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -599,6 +599,7 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 
 	switch (bus->mode) {
 	case I3C_BUS_MODE_MIXED_FAST:
+	case I3C_BUS_MODE_MIXED_LIMITED:
 		ret = dw_i2c_clk_cfg(master);
 		if (ret)
 			return ret;
-- 
2.7.4

