Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE45C33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA27D215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaKzgkEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgAFBR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:17:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39691 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgAFBRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:17:25 -0500
Received: by mail-lj1-f193.google.com with SMTP id l2so49273106lja.6;
        Sun, 05 Jan 2020 17:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iSzNtTGK3mbZvFsWdibdEoWrg4nzIZ5PMxmWTFl+mGA=;
        b=KaKzgkEls3Ub0KNMTwRBoR6uaqurUZoOaqFBhHrePHMddJXQgaCgyJnsj89WRoCPVX
         EoWPL8gGVOUNIHWstRHJOCH8slaN49O2t1BHTHcA64Inn/p3lDEPCVEfVPpHkXKVRRnm
         +GhT+CkSRgaWacjajq6/4E925STgFpfPppgxZhfaDBvVcubiS04IFmUavfUu3pE+IptK
         hGPOCtFD++31X+D4N9pOYhw7pc3Nw0h6YFflsLL6Z60LUWeZ3GkpSCaNZJv6uQUWyj7E
         utIOAjjogLKdG3Uu0ySh0KNr7t04ZHCmcIm8DE83uyfVKz+Z78EkDaCRvPvqno7FsOlZ
         ahCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSzNtTGK3mbZvFsWdibdEoWrg4nzIZ5PMxmWTFl+mGA=;
        b=s2WTQkvIi6V6SpfYXwuCjS+MinsvzmLlkxcpGWUml78jFyouH43a8SrQukQNzMWUsN
         YBPly5S6sZtE6Iq1RLMfjuV5IDAk5TUi1uArgn8IB0Zyzbc8viVbb8AfNytx3LKk/yw1
         Efh/H78C05m7oYtbx02ejHfw9OPed2X8KfynFST52Sxzf3fv0aqj/ZBHkIv9gFY9zYHa
         hyc0QiSWh16HK84UalQZ6wyBxGUCFtTBS7d66PyUEmrareqndA0Fm3yReGa2zoglCObF
         RTfaIevQN6PGEN3DEvw9As+alfs9yAbYBqo4U8nzBYfHh54Qqwc43+LMMcG/1ut5kkpF
         Relw==
X-Gm-Message-State: APjAAAXMr6Y5KEfPO02K13PKArM6LWweunTEIredeyOqrHBDpdoirVKS
        96wyYZzEexESLxAxSxy8RhE=
X-Google-Smtp-Source: APXvYqzMh1fPD9g7/PzVh/6onR/0T6+9Ig+O1p3KQe3gjPBddSbrMPe7jZQ9lYUna4DgYRGugJqc4A==
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr58672337ljq.109.1578273443275;
        Sun, 05 Jan 2020 17:17:23 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y14sm28353271ljk.46.2020.01.05.17.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:17:22 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/13] dmaengine: tegra-apb: Implement synchronization callback
Date:   Mon,  6 Jan 2020 04:16:57 +0300
Message-Id: <20200106011708.7463-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106011708.7463-1-digetx@gmail.com>
References: <20200106011708.7463-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISR tasklet could be kept scheduled after DMA transfer termination,
let's add synchronization callback which blocks until tasklet is finished.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 319f31d27014..664e9c5df3ba 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -798,6 +798,13 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 	return 0;
 }
 
+static void tegra_dma_synchronize(struct dma_chan *dc)
+{
+	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
+
+	tasklet_kill(&tdc->tasklet);
+}
+
 static unsigned int tegra_dma_sg_bytes_xferred(struct tegra_dma_channel *tdc,
 					       struct tegra_dma_sg_req *sg_req)
 {
@@ -1506,6 +1513,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	tdma->dma_dev.device_config = tegra_dma_slave_config;
 	tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
+	tdma->dma_dev.device_synchronize = tegra_dma_synchronize;
 	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
 	tdma->dma_dev.device_issue_pending = tegra_dma_issue_pending;
 
-- 
2.24.0

