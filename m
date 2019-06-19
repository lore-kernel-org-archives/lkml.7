Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C29C31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6908214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="M7B34DN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfFSSgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:36:54 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:58612 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbfFSSgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:36:49 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 91AA7C0CAF;
        Wed, 19 Jun 2019 18:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560969408; bh=wuJso1hif5l+TevIvXSskXT7xugWbLyyyXYKC8aX+1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=M7B34DN6cpwZaD9kNltLdZxt93WgCPJrq5KPIU7CkwC0Pd6auNAse1s0zDm5K1Fh4
         xNrPKE6DMP4NFsCrAuKUcTTAMxznXl8lwK/u/BgafjlaaqFEDdT8eLfQrWGWxLBy1p
         /JjPtp6LPF5cQNEpkVbkOoLR0dOiUmxmuEgzu4EZo1DwjmDfvI73v58o48SXWasqDt
         qUMwxF+YgHygoCPMMYvb9FzcF+gTE1MST4bOjc/I689Z8ZohrPEWokZ92V+GIjNWD4
         k+c6iy4geXZgarVdWzX+wQiBOeNujoZYenADu3qEraBN1i+ffxY6L8UZ+4eoxEWtx2
         +LBA0tjkwzXTQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 11BA5A0064;
        Wed, 19 Jun 2019 18:36:45 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id B39D83F21A;
        Wed, 19 Jun 2019 20:36:45 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-i3c@lists.infradead.org, Joao.Pinto@synopsys.com
Cc:     Vitor Soares <Vitor.Soares@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] i3c: dw: add limited bus mode support
Date:   Wed, 19 Jun 2019 20:36:33 +0200
Message-Id: <10b810c9afa9f06515b52a8fd580720f239e0a99.1560968688.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1560968688.git.vitor.soares@synopsys.com>
References: <cover.1560968688.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1560968688.git.vitor.soares@synopsys.com>
References: <cover.1560968688.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add limited bus mode support for DesignWare i3c master

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
Changes in v4:
  None

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

