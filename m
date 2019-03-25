Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04D8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D57120830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHaelfQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbfCYMYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:24:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35218 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730996AbfCYMYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:24:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id t13so7595411lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 05:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7j+8BPXoMPihLCY544pQ1xt1G+5FL9OY5OdeK+UKQqo=;
        b=uHaelfQD8u1oN0zewY1fGZcpPuPDI2iwFXVT9IAZOx1YieeWYWSmT189tXuSc2UzEm
         rG9GBAlNw+dZBMmWlA6L34AHHjxaVsUKS5+u3MtvfLmunhkHaT91B8IHGmst4IYfdXJP
         8Ekb1hXQsh0IR1O2Numc+3GAZMnR15Y+9hE1QDhrz0l9kOryxssPpBWMqa4+z86U2ZPR
         SlwQkXxpQa5JYs47SC6EGDdEAvYiBILpkrK5FkpEX9KATKFw4U8qW2iL58vKAE4E2S7U
         9WWaj+QHQm/vxIJXXHCZYr4tYJ+7EsNJ5T2g58whSd+3zTPj4dmfS+vyJ6hqNHz0c+aI
         RQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7j+8BPXoMPihLCY544pQ1xt1G+5FL9OY5OdeK+UKQqo=;
        b=b9OOX3d3VWKn2sM3riXdzYaVTLLph/TIfwJEt0nKoH/UynhGHR7A573MHMZBeZcRrp
         GWSqZO/ok1YQ2N7lPkfI0jxUgRIe2cklbZ/m0ARciycDHWVRsbEcZRqoXFOwptneGCp0
         vbX/7UoQl5d3R5c6gf2jI+QExOOVWiBS0/oQG7RH03Wjl2gxnERdcKLtGiPWu6PblMxR
         KX7Ui0fS7zwbyot40yWQOKqtrbFSJbbm9ybaeTg0virDytI/th1SYjOusvbn5qYSyOdq
         FI73pvrGoQgJkS3J+/vhWYCucM6NdMi0t0JUTmDLpUdINLOuW0FbNlgbleqCi5bTxLoe
         2Ogw==
X-Gm-Message-State: APjAAAUeBuZ1IDb7zxQctfkJJyhNXDlWDyzeQkjXMBwhouMS2+BjNbX7
        hGjcnPTgIfAUHHftFEgIEP1lNA==
X-Google-Smtp-Source: APXvYqx5GwByg2nPhbvLDRP6+DQNzEnR2WkMHnQC68vcO2qDl1n9Vy830UcD9QlXuvZ8TeZ4RQIV2g==
X-Received: by 2002:a2e:9649:: with SMTP id z9mr7172387ljh.92.1553516690661;
        Mon, 25 Mar 2019 05:24:50 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id t11sm3360718ljj.92.2019.03.25.05.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 05:24:49 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] MAINTAINERS: Add section for MediaTek MMC/SD/SDIO driver
Date:   Mon, 25 Mar 2019 13:24:42 +0100
Message-Id: <20190325122442.30644-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Chaotian Jing <chaotian.jing@mediatek.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f29..b43e563b4c95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9775,6 +9775,12 @@ F:	drivers/media/platform/mtk-vpu/
 F:	Documentation/devicetree/bindings/media/mediatek-vcodec.txt
 F:	Documentation/devicetree/bindings/media/mediatek-vpu.txt
 
+MEDIATEK MMC/SD/SDIO DRIVER
+M:	Chaotian Jing <chaotian.jing@mediatek.com>
+S:	Maintained
+F:	drivers/mmc/host/mtk-sd.c
+F:	Documentation/devicetree/bindings/mmc/mtk-sd.txt
+
 MEDIATEK MT76 WIRELESS LAN DRIVER
 M:	Felix Fietkau <nbd@nbd.name>
 M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
-- 
2.17.1

