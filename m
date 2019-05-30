Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0182BC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF8325BC5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559227987;
	bh=loxtaV3vpN1GZcin4CrVgRGNdtHrvPKkBB7Yu208iPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jyYTpPPjzTyslD6aOoLc0z1P36WfwAv6tgugje0cn7BR8AY5RHcu+lEXiXBFhsgND
	 RByT6PmJ2wWfEOBgE+PuXqOI1x85/44SzI9OuTX1iScZa7Aa+KgxwaQWZsqULMy1D4
	 PejV2pc3hSpnRIHubc54/dGC11lb0+Ygw0n4EMR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfE3OxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbfE3OxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:53:05 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25BB425BC9;
        Thu, 30 May 2019 14:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559227984;
        bh=loxtaV3vpN1GZcin4CrVgRGNdtHrvPKkBB7Yu208iPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lw0rhC6rewH+XhgZR5YTdVfuGou4v7weJKJZw2g4Ui8O8pzPWo6oXZb6/Oij/V37Q
         6lPmwTrXoEfMyMUle3AawYb3/4zSN1HOr6mQbhP+TNtdhNzmflpQKURbr3jB8Vgf4s
         kNF51wW0UDG4R9Uqca8x9ERXOeq/zIjh2LWUM/54=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/1] fpga: zynqmp-fpga: Correctly handle error pointer
Date:   Thu, 30 May 2019 09:52:59 -0500
Message-Id: <20190530145259.4189-2-atull@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530145259.4189-1-atull@kernel.org>
References: <20190530145259.4189-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>

Fixes the following static checker errors:

drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
error: 'eemi_ops' dereferencing possible ERR_PTR()

drivers/fpga/zynqmp-fpga.c:84 zynqmp_fpga_ops_state()
error: 'eemi_ops' dereferencing possible ERR_PTR()

Note: This does not handle the EPROBE_DEFER value in a
      special manner.

Fixes commit c09f7471127e ("fpga manager: Adding FPGA Manager support for
Xilinx zynqmp")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/zynqmp-fpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index f7cbaadf49ab..b8a88d21d038 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -47,7 +47,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 	char *kbuf;
 	int ret;
 
-	if (!eemi_ops || !eemi_ops->fpga_load)
+	if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_load)
 		return -ENXIO;
 
 	priv = mgr->priv;
@@ -81,7 +81,7 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
 	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 	u32 status;
 
-	if (!eemi_ops || !eemi_ops->fpga_get_status)
+	if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_get_status)
 		return FPGA_MGR_STATE_UNKNOWN;
 
 	eemi_ops->fpga_get_status(&status);
-- 
2.21.0

