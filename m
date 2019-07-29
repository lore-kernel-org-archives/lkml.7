Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92099C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6681B21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429333;
	bh=rWYz9xo/WKu8NOvHjnTN4kXmB1g94dKxuNB+LbsP418=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Au4vzChoM6sMZdsgvfWNyludiRlxvCNCUMeizLZeWKSP/5eKeW6PESIr/zBb1wCbo
	 gAvcQJMQiJiZFXz5yW7NamuMSLSN27OtOhMSMCSECWGSCn/yLP/gr1/I4QpcMlC4/6
	 Va53tVjMzx8rxp0vtJ58Ws7I6p+o+v/PVO2W1Sbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389475AbfG2TmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389458AbfG2TmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:42:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6834A2054F;
        Mon, 29 Jul 2019 19:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429328;
        bh=rWYz9xo/WKu8NOvHjnTN4kXmB1g94dKxuNB+LbsP418=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1KE82p25n4v6t66ORLfIJd+baxdno4ip9yyXUitlUJMWvSHb0buq8IkpuLVjyoKzE
         8VUGHeNO8+8lPZQbHiazn0l5OAvf6B4tKgWuPTdirWI+2KkrcSyuTjdtILBUIFtaU7
         O9cgkUmcZX4knpJDD/UOnnl/sXCVjqFuW59DHKDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 062/113] PCI: mobiveil: Fix PCI base address in MEM/IO outbound windows
Date:   Mon, 29 Jul 2019 21:22:29 +0200
Message-Id: <20190729190710.299999798@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f99536e9d2f55996038158a6559d4254a7cc1693 ]

The outbound memory windows PCI base addresses should be taken
from the 'ranges' property of DT node to setup MEM/IO outbound
windows decoding correctly instead of being hardcoded to zero.

Update the code to retrieve the PCI base address for each range
and use it to program the outbound windows address decoders

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mobiveil.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index a939e8d31735..d9f2d0f2d602 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -559,8 +559,9 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 		if (type) {
 			/* configure outbound translation window */
 			program_ob_windows(pcie, pcie->ob_wins_configured,
-				win->res->start, 0, type,
-				resource_size(win->res));
+					   win->res->start,
+					   win->res->start - win->offset,
+					   type, resource_size(win->res));
 		}
 	}
 
-- 
2.20.1



