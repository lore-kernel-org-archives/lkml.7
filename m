Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0CAC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532382339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ld9hkTWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfH2KTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:19:46 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:36142 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbfH2KTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:19:40 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 24BAAC0392;
        Thu, 29 Aug 2019 10:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567073980; bh=QDbC66s0MbpPHltxDTwd7lR7K6eOPJkK1UO9tfAzUE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Ld9hkTWWxN/DsnaOXBnAvHG4pNKtD5vOcsH6ELjzWOfgOAz4grSJ/ttRqRJ0fyQmM
         qJiBDB/OnkbEYoPqchH52tQp22bk11Xz/L15yp52udkSUzkkYY2NOyOckVF8psRH7k
         iTYaN6b7wfakoUXrMhDIQlHReNwGgCk8iwqgRE24TDCb/uLqmd66hkJY7URkbaWon1
         EBy7kzZGCLB/x2FAYUoCT44pRpKKFfPr/bb06wvcLT4TRp56V4KMSzicktNeHQPRAW
         ykfP5SGXZR0vQQRH5sM+QvwVbSC9fyfbrZtxQL1cs9kUVbvj8lvfLDP/jF+w0D8hLP
         BzGmWo2a/Mebw==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 52DA3A0064;
        Thu, 29 Aug 2019 10:19:38 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 3759A3B646;
        Thu, 29 Aug 2019 12:19:38 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i3c@lists.infradead.org
Cc:     bbrezillon@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Joao.Pinto@synopsys.com, Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH 2/4] i3c: master: Check if devices have i3c_dev_boardinfo on i3c_master_add_i3c_dev_locked()
Date:   Thu, 29 Aug 2019 12:19:33 +0200
Message-Id: <3e21481ddf53ea58f5899df6ec542b79b8cbcd68.1567071213.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1567071213.git.vitor.soares@synopsys.com>
References: <cover.1567071213.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1567071213.git.vitor.soares@synopsys.com>
References: <cover.1567071213.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I3C devices described in DT might not be attached to the master which
doesn't allow to assign a specific dynamic address.

This patch check if a device has i3c_dev_boardinfo and add it to
i3c_dev_desc structure. In this conditions, the framework will try to
assign the i3c_dev_boardinfo->init_dyn_addr even if stactic address = 0.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/i3c/master.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 4d29e1f..85fbda6 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1795,6 +1795,23 @@ i3c_master_search_i3c_dev_duplicate(struct i3c_dev_desc *refdev)
 	return NULL;
 }
 
+static struct i3c_dev_boardinfo *
+i3c_master_search_i3c_boardinfo(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+	struct i3c_dev_boardinfo *boardinfo;
+
+	if (dev->boardinfo)
+		return NULL;
+
+	list_for_each_entry(boardinfo, &master->boardinfo.i3c, node) {
+		if (dev->info.pid == boardinfo->pid)
+			return boardinfo;
+	}
+
+	return NULL;
+}
+
 /**
  * i3c_master_add_i3c_dev_locked() - add an I3C slave to the bus
  * @master: master used to send frames on the bus
@@ -1816,6 +1833,7 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 {
 	struct i3c_device_info info = { .dyn_addr = addr };
 	struct i3c_dev_desc *newdev, *olddev;
+	struct i3c_dev_boardinfo *boardinfo;
 	u8 old_dyn_addr = addr, expected_dyn_addr;
 	struct i3c_ibi_setup ibireq = { };
 	bool enable_ibi = false;
@@ -1875,6 +1893,10 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 	if (ret)
 		goto err_detach_dev;
 
+	boardinfo = i3c_master_search_i3c_boardinfo(newdev);
+	if (boardinfo)
+		newdev->boardinfo = boardinfo;
+
 	/*
 	 * Depending on our previous state, the expected dynamic address might
 	 * differ:
-- 
2.7.4

