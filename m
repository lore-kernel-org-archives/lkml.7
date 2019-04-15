Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42065C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D27B218FC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EvNQ28S7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfDOSqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:46:55 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:55714 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbfDOSqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:46:53 -0400
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 62C6910C10F0;
        Mon, 15 Apr 2019 11:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555354013; bh=GEZdOqtDmf3cGDISZQ11mIjshPILmaz5bfyTH6m/G24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=EvNQ28S7Uz9qSFW+hF7CweUHX1h94DCcBrbPqIL6fMGZxszJZFmhfSP1E36tHNcvy
         4ysMGwm4imZhvxej4YLKTOM5NFiKkLkdq6tRujhilDGrrbcl7bD91jJQqp/ysv/Pzv
         Mu7nNaQszluRpFYAUZvEgN2PY0bVcpSDTfmDVn14h8/Rf8qpzcdIYEZ70t5aFfnaEi
         EqXOvhdAdOBiQrRBxxsQhvyPtoBrAua7PQflSJq7qNNB44EJD+p7eS4Awwocxsl9Qq
         7hkOfrlTB9JjAtkYKljUXWjNQ3pB5ABzSUgQgc3dGTFkTwf2Q7CeVRTTWyEalWlyV+
         MN7whTXihhMdA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id 5B2EC5B76;
        Mon, 15 Apr 2019 11:46:52 -0700 (PDT)
From:   Vitor Soares <vitor.soares@synopsys.com>
To:     linux-i3c@lists.infradead.org
Cc:     joao.pinto@synopsys.com, Vitor Soares <vitor.soares@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] i3c: dw: Add limited bus mode support
Date:   Mon, 15 Apr 2019 20:46:43 +0200
Message-Id:
 <8cf1b180c31c5908d667285fa4880167a5e80c8c.1555350118.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1555350118.git.vitor.soares@synopsys.com>
References: <cover.1555350118.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1555350118.git.vitor.soares@synopsys.com>
References: <cover.1555350118.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415184643.Mbb8p0-Ci4mhoAg62hFLazvu5oQTy3vBmbixvBne-ek@z>

This patch add limited bus mode support for DesignWare i3c master

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
 drivers/i3c/master/dw-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 0b01607..4005508 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -650,6 +650,7 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 
 	switch (bus->mode) {
 	case I3C_BUS_MODE_MIXED_FAST:
+	case I3C_BUS_MODE_MIXED_LIMITED:
 		ret = dw_i2c_clk_cfg(master);
 		if (ret)
 			return ret;
-- 
2.7.4

