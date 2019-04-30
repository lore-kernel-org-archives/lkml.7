Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF25C04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832FB21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625162;
	bh=A4XMC9p/3HF6St1IjCxVuL4dvn3duw+BucvGvAO14To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EFkN0c67FjgqDhil82RIwVlLmkgExBHIMDyuUislDmkFCEO5cDRcxz09YjSA1ZwPS
	 vJHYOVVdAsv3oPyRC40Lii79EwEuzaBn3kbtY1EQuKYGsdi5WONlOpqC3k3u07Mnhw
	 GcEbzE14rDMSF+rNZWMOuO0rLgUwEECgzWnUv73I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbfD3Lva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731389AbfD3LvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:51:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 821382054F;
        Tue, 30 Apr 2019 11:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556625085;
        bh=A4XMC9p/3HF6St1IjCxVuL4dvn3duw+BucvGvAO14To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m20tBmGciFAYxVVd4KXbm2Ug+sKiBTpS0F4+M0Sk+0xf59RtFsuPQwRcyhEAjgmmP
         /gfXBaaAPXW+NeSK03cF7q5M6anJltxaasVVIXaAfbqPE3L1ZO+fixiA6aF9kH0mJY
         WWi2jxTxZjDEZUifzwLhAfXjLcHCUUrgDHrJV2Jw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 84/89] mlxsw: pci: Reincrease PCI reset timeout
Date:   Tue, 30 Apr 2019 13:39:15 +0200
Message-Id: <20190430113613.736927302@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 1ab3030193d25878b3b1409060e1e0a879800c95 ]

During driver initialization the driver sends a reset to the device and
waits for the firmware to signal that it is ready to continue.

Commit d2f372ba0914 ("mlxsw: pci: Increase PCI SW reset timeout")
increased the timeout to 13 seconds due to longer PHY calibration in
Spectrum-2 compared to Spectrum-1.

Recently it became apparent that this timeout is too short and therefore
this patch increases it again to a safer limit that will be reduced in
the future.

Fixes: c3ab435466d5 ("mlxsw: spectrum: Extend to support Spectrum-2 ASIC")
Fixes: d2f372ba0914 ("mlxsw: pci: Increase PCI SW reset timeout")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
@@ -27,7 +27,7 @@
 
 #define MLXSW_PCI_SW_RESET			0xF0010
 #define MLXSW_PCI_SW_RESET_RST_BIT		BIT(0)
-#define MLXSW_PCI_SW_RESET_TIMEOUT_MSECS	13000
+#define MLXSW_PCI_SW_RESET_TIMEOUT_MSECS	20000
 #define MLXSW_PCI_SW_RESET_WAIT_MSECS		100
 #define MLXSW_PCI_FW_READY			0xA1844
 #define MLXSW_PCI_FW_READY_MASK			0xFFFF


