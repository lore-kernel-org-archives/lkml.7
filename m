Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01B0C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F1C205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557248598;
	bh=3E48yfIuMb989wSMyEAgJjcy1s9jUqjh3X8BkoivnNA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=q3z01JsCVuR1Y9OZvqz7kgDN5CsRdokuCBPUSUyJiZ+APpGeDetyFv+QB51LoTtB8
	 B2/jEKeG6wiGAY1/Tgt90ZwIw96q178xdEuNHiii5rwgyVLsbccWzw5AUhMHKc+R8Q
	 Lyjyun1ZXPv35CnQp2DBXYQpyCgCheG1B9Mtg06A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfEGRDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:03:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34994 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfEGRDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:03:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so8494389plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZgOuuMrrhj8XAofs6xeZ/fsPkpFUrdc6Z7bFfUFRLkU=;
        b=UjCPb+Kl6rcv6K9jz5eafsxtoQNmNFLmA6vEkjnDgrlBumH1I0DAOD8N6UCXzhUf5a
         /kGsGvctvwXxmNklWyjiHIZEJV68hBQKVMmJ26242tUDnTRteO5iZi7PI4fGD4q/ITJI
         hVeyoTOm+PKTVzfKNB+ZQo7PUyHqW80rhiQtPwdjIsgAKcmzf3wjLX+TPNdLtTSpBwHM
         reM+ChdjbVjWkBs0eqLuQ1EuizUT8CWJJ9oG8CGO5drZdvycAyMazj2vXDXL3tD2hFgg
         QFg/tZqNFPg4DMKc3FszmMeePEeH32FxcuJ6+1xARh7L/hcdk+A1tRAVUy4N91mEcikD
         pidw==
X-Gm-Message-State: APjAAAWanLb3dKHotVU+fAMe9yqFg87+KWKQ74dIG6Yx0nLV1WDsLS9h
        1x9uag42mUPfRhHM6JjLQB34bQ==
X-Google-Smtp-Source: APXvYqwNDn3NrBxsLCzzv0AbtjUL+SxTQfXa4VJ+Fy/gn2Z/CVWh+d8UM3NntMwIqWZ7Z/heKmrJ2Q==
X-Received: by 2002:a17:902:8483:: with SMTP id c3mr39962344plo.19.1557248596403;
        Tue, 07 May 2019 10:03:16 -0700 (PDT)
Received: from localhost ([2601:647:4700:2953:ec49:968:583:9f8])
        by smtp.gmail.com with ESMTPSA id n15sm31360519pfb.111.2019.05.07.10.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:03:15 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     atull@kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        Moritz Fischer <mdf@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] fpga: zynqmp-fpga: Correctly handle error pointer
Date:   Tue,  7 May 2019 10:02:57 -0700
Message-Id: <20190507170257.25451-1-mdf@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following static checker error:

drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
error: 'eemi_ops' dereferencing possible ERR_PTR()

Note: This does not handle the EPROBE_DEFER value in a
      special manner.

Fixes commit c09f7471127e ("fpga manager: Adding FPGA Manager support for
Xilinx zynqmp")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/zynqmp-fpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index f7cbaadf49ab..abcb0b2e75bf 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -47,7 +47,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 	char *kbuf;
 	int ret;
 
-	if (!eemi_ops || !eemi_ops->fpga_load)
+	if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_load)
 		return -ENXIO;
 
 	priv = mgr->priv;
-- 
2.21.0

