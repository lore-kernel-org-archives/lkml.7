Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE32DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E072087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wc9PL3IB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfEFH2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:28:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36839 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfEFH2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:28:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id cb4so1999672plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uO8z0Q76r90ztpTNNYiqnBG594TWJeNUgA2Rk2VCNfI=;
        b=wc9PL3IBYBHKoAWxtEj0jE0C4U/0p/5wSuzqodmousiv5aM2dRwn3CMyCqCS2/29Ws
         c3JfmQiXdrAWpHEQyalb1Gpky9RyM4yJ/9lO5Tg/2aiHfoVhCYg34euPc2Mou/5P/0eg
         5MXy1oUUiuMHpxMjgydcS54TfLJIvncbJpz7CzUv9FHc2LYaDOTnt/xpI/HIjyESx4IP
         +YGcBhhsq5gU6M0V1nBS7z+pieA5Mkd6w7GeNJ+HxQ2QwUR/iSdf9STy3vqc8HD8YClO
         lBTRQMh2iDu+WsjIgdqAhgTB0mkdzJh5CA29TD2hChMg50kbS7TmNoa2pyFW63A6Kius
         JrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uO8z0Q76r90ztpTNNYiqnBG594TWJeNUgA2Rk2VCNfI=;
        b=iymNNHXQtWBle1SSbdOwZTsGrBTQppbl5MTTr6BNuSH/hIzpmWfB+q9obfxwyb24mm
         Xb0pAo3JFpcrrLCMhDesLpq0Cz4HqCdCIJIFewO1Cg9Nzqbk/25BteKCpEun6Z0R//o5
         mWouf0Ay9ZruyF/SsE47vUcoRHjoFYr3BdWSRGccG7gmVNAHtVSx7bqAFm6GxlJ8rsHD
         3hrK/89AUje8pY11Q2NE5iXBiXwrLH+iUHoMFWMhL+xbVeLrIAnhIWT3l8pWMHNkTDl7
         QZe27XDKFE4LpQyuXNuRsFNzCXUXrpZhwaEhvG5KVXUSxrOtLP53uNCgwiaYnOJRJb9Z
         krAA==
X-Gm-Message-State: APjAAAXVMuZFXgTK+hCFXi3tLSx/fk5n4YluLAtWScNDH14d45PABsVM
        0YV7UW4K2bTtZMhbITl5g/vta1z2B+RnvQ==
X-Google-Smtp-Source: APXvYqxQA3rQf0P/U8sytSS8uiQkV2XwgMo2mG6tCwPoYvRQAchPZElFMHNUuTpZEiWqGlTb0CsaQw==
X-Received: by 2002:a17:902:1c7:: with SMTP id b65mr29826248plb.2.1557127729646;
        Mon, 06 May 2019 00:28:49 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w38sm21700894pgk.90.2019.05.06.00.28.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 00:28:48 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     eric.long@unisoc.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Fix some bugs and add new feature for Spreadtrum DMA engine
Date:   Mon,  6 May 2019 15:28:27 +0800
Message-Id: <cover.1557127239.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set fixes some DMA engine bugs and adds interrupt support
for 2-stage transfer.

Changes from v1:
 - Improve the commit message for patch 1.
 - Drop patch 4 from the v1 patch set, and I will create another patch
 set to move the fix to the core.

Baolin Wang (3):
  dmaengine: sprd: Fix the possible crash when getting descriptor
    status
  dmaengine: sprd: Add validation of current descriptor in irq handler
  dmaengine: sprd: Add interrupt support for 2-stage transfer

Eric Long (3):
  dmaengine: sprd: Fix the incorrect start for 2-stage destination
    channels
  dmaengine: sprd: Fix block length overflow
  dmaengine: sprd: Fix the right place to configure 2-stage transfer

 drivers/dma/sprd-dma.c |   49 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 11 deletions(-)

-- 
1.7.9.5

