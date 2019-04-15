Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B19C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CB62146E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pVwFM9VK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfDOMPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:15:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40516 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfDOMPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:15:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so8501105pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=t+vSwNzAyzBEoNWHoDlCjFWrl4RmlReONvWp36xHfaU=;
        b=pVwFM9VK51v9RJI/LLamcK3Akejm8iA1s4U95Gr8Epwg0bAtzqW8WBXStbihIyf9dP
         iiiXsKupFcZaNuCDhnmnCZFKLquvkTQBy3tlErCbAjspdV2ZbMtBAWNvWTx2i+HRu0Bw
         bW+exztTygY8H96Hb1eEujA0y8/yFoOcVhUb8HP8PD0+cCMSxAtw6DyObjQjfsddSZjK
         1sakOBEh99JYPZn/wV6Ue5wwBScTje8M6g7wd86fRwGlTrm1TnqAQCQWlBP3Zk3+vb1v
         gtPt6ELVPhHu5ne12rw3S5UfuCpSfJ84D5LeRIz9qzwwEKN4iYDwhbwJcJtdyUIAvT/p
         Hxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t+vSwNzAyzBEoNWHoDlCjFWrl4RmlReONvWp36xHfaU=;
        b=KCWBqGSDBuOm2CSmx7fRXTHxVQrTOJHhgvRNQdxPw2N1HOJxYlEeKW0Vd1lCTz0kkD
         8kugJCWoQ8s5CuRogovNI2pSDm1lAdG9pOhSMzEP6ixSgrvjB2NJbMaTXDC4BTe5P+K2
         mduyDKE3Mo3v+DpOry6VWFomm2Be6UGlSpe/KoW0MHhi2UpB04NYccw8l3DGPXeZIzxS
         w4eVKVUDboyzW66hxEQEVNNrHxlEvmNsEmTxEfWCCys+uN+xNmbGbJTXTsbM3INz2Hbm
         jEDnhrp5wfPclCprWj2rq6qac6r50fat8aPlCIUxZYBpxpJngAJd7hCL9dRY4cth12On
         yV0A==
X-Gm-Message-State: APjAAAUsHG0YcqtKxNQc8xDUNky5kOH75IuIbyHdIfCLO0Y4FGiLHSRO
        w4nv1PQlKiyxCrnjnCJFaTABWw==
X-Google-Smtp-Source: APXvYqwc3LNlpix1JQGclbvEm0ihO6EddmfMqqYVgeImL4wwyDKah6bvEjK+uUZQAzL+8EHaFoc2jg==
X-Received: by 2002:aa7:8494:: with SMTP id u20mr47378388pfn.76.1555330512732;
        Mon, 15 Apr 2019 05:15:12 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 6sm64157155pfj.95.2019.04.15.05.15.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 05:15:11 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     eric.long@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Fix some bugs and add new feature for Spreadtrum DMA engine
Date:   Mon, 15 Apr 2019 20:14:54 +0800
Message-Id: <cover.1555330115.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set fixes some DMA engine bugs and adds interrupt support
for 2-stage transfer.

Baolin Wang (3):
  dmaengine: sprd: Fix the possible crash when getting engine status
  dmaengine: sprd: Add validation of current descriptor in irq handler
  dmaengine: sprd: Add interrupt support for 2-stage transfer

Eric Long (4):
  dmaengine: sprd: Fix the incorrect start for 2-stage destination
    channels
  dmaengine: sprd: Add device validation to support multiple
    controllers
  dmaengine: sprd: Fix block length overflow
  dmaengine: sprd: Fix the right place to configure 2-stage transfer

 drivers/dma/sprd-dma.c |   54 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 11 deletions(-)

-- 
1.7.9.5

