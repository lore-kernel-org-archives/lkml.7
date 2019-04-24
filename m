Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D59BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D732D218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127527;
	bh=/G0vb4A5Q71a4zRgFzkbBxTKokwHMraLe66ZGwZsqkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WQYCqgdXaFq+egthRqQWoQke+Jt1KzsROlB86rzSYENnYtZJ/eDV0EhjIClupJbSo
	 4b0gcPj5oVUuTCTtjCWPMiegcYz5H74ffVPVsoHI2ubp2SsxAN2XMilVX5xX/o3q/g
	 lwPGPA9DCXdhn3iy2XHwB8RnBou1O4OC/jn+RBig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392460AbfDXRip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392434AbfDXRii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:38:38 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E77A3218B0;
        Wed, 24 Apr 2019 17:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127518;
        bh=/G0vb4A5Q71a4zRgFzkbBxTKokwHMraLe66ZGwZsqkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zbag18Z6McmkGE89GVk88683xkWDuhuGebfbuBUPbGjb5+g/zPWfz+zFwcAaq+ZTI
         LD9y+O3pL/WMX6kPUHDllkjoo2LDWumnRKwGg/6t1MnCegcXffVFIaOrTbgJYjK9th
         1mBTecAvm0px11HcjZcaAtnS6f9wzw4930fXcaU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Boris Brezillon <bbrezillon@kernel.org>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 5.0 078/115] i3c: dw: Fix dw_i3c_master_disable controller by using correct mask
Date:   Wed, 24 Apr 2019 19:10:14 +0200
Message-Id: <20190424170929.567788687@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitor Soares <vitor.soares@synopsys.com>

commit 907621e94d49b85cd76f13110eceb940a182c69e upstream.

The controller was being disabled incorrectly. The correct way is to clear
the DEV_CTRL_ENABLE bit.

Fix this by clearing this bit.

Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: <stable@vger.kernel.org>
Fixes: 1dd728f5d4d4 ("i3c: master: Add driver for Synopsys DesignWare IP")
Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i3c/master/dw-i3c-master.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -300,7 +300,7 @@ to_dw_i3c_master(struct i3c_master_contr
 
 static void dw_i3c_master_disable(struct dw_i3c_master *master)
 {
-	writel(readl(master->regs + DEVICE_CTRL) & DEV_CTRL_ENABLE,
+	writel(readl(master->regs + DEVICE_CTRL) & ~DEV_CTRL_ENABLE,
 	       master->regs + DEVICE_CTRL);
 }
 


