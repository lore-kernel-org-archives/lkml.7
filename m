Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CA5C33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D37215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVo3rH/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgAFBRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:17:24 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47076 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgAFBRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:17:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id m26so46827304ljc.13;
        Sun, 05 Jan 2020 17:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a+fMub9ckge+8BlFpsCQqv6/B7PWQaNgw1pSZyaGfPM=;
        b=sVo3rH/4HIYrSSGax0IIFOTEpbJLAp6CrJJS6D9iVK3peNTpNhdfmiRVcyqyzLkoQk
         zDFgmXduxYZxDhcf7y2hIN51OWQr75QeYn5QZKbI7llbb3HedAGYc5TNxFsy1LgaSLLB
         IwAhKYQvyb1mRA6O6IhLxMR/Hn51jDQ/XSgsOrvZxQMu0sCw1QF8cWh7ZVvVGknOrlWf
         pU1B8b4E00wkuw1PVQJJnrTEyUfxy2+G8hJcKAURc7HSPWRMucZDl3wItyJVkh+92AJk
         revLMEbwe+hu8yOzFzORaXQzfjAP67WmALTqak2rqruKphHaAraX1Oh178KJtyWAl4B9
         sDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a+fMub9ckge+8BlFpsCQqv6/B7PWQaNgw1pSZyaGfPM=;
        b=ozXpcrppxNsygS21Dd7yRiTAJ3JDIfvhK9yNGAOeEJiFa0v7InRSwTE/VxfFQfHpRn
         MtbeXCBbD26dYzN4jzzrMEMOyJ7MlIDwKzJiGDNKS+IVaLK1/1RlHPSVIDLb9KmS9RvE
         +ug62J2sSgPbFiKQy5hvM0uMJZQkbC0GXNd6UgjulgGQz6RV4RIw8hcOPSimTr6Hj572
         EMIIA62fi5wSgndedWkHEdpuFh+lP+MXoyNZEttqvz0/CaIk7yyTGzHc+aKKvrPdgdF2
         7srJnGlLSw7Kh0Kd2leyYG6zAT68O4RF0irCc3VmMyT8DyLvxTl2XXtvv3aafoLiRbNr
         yRgg==
X-Gm-Message-State: APjAAAXCuY6X1JL56PmOEHLp6ydX3AB8BKw4jXpxurHfsUjT1ECodr92
        1HevYRp1xNLfejCARiVbVC0=
X-Google-Smtp-Source: APXvYqz63Zrr92kosfZeqHOzulSIyGehjDzZKjMLbqib996DoN3LJEoDKzS/wNZdwtiSsTF+LDUzTg==
X-Received: by 2002:a2e:9b9a:: with SMTP id z26mr57833426lji.181.1578273441605;
        Sun, 05 Jan 2020 17:17:21 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y14sm28353271ljk.46.2020.01.05.17.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:17:21 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/13] NVIDIA Tegra APB DMA driver fixes and improvements
Date:   Mon,  6 Jan 2020 04:16:55 +0300
Message-Id: <20200106011708.7463-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is series fixes some problems that I spotted recently, secondly the
driver's code gets a cleanup. Please review and apply, thanks in advance!

Changelog:

v3: - In the review comment to v1 Michał Mirosław suggested that "Prevent
      race conditions on channel's freeing" does changes that deserve to
      be separated into two patches. I factored out and improved tasklet
      releasing into this new patch:

        dmaengine: tegra-apb: Clean up tasklet releasing

    - The "Fix use-after-free" patch got an improved commit message.

v2: - I took another look at the driver and spotted few more things that
      could be improved, which resulted in these new patches:

        dmaengine: tegra-apb: Remove runtime PM usage
        dmaengine: tegra-apb: Clean up suspend-resume
        dmaengine: tegra-apb: Add missing of_dma_controller_free
        dmaengine: tegra-apb: Allow to compile as a loadable kernel module
        dmaengine: tegra-apb: Remove MODULE_ALIAS

Dmitry Osipenko (13):
  dmaengine: tegra-apb: Fix use-after-free
  dmaengine: tegra-apb: Implement synchronization callback
  dmaengine: tegra-apb: Prevent race conditions on channel's freeing
  dmaengine: tegra-apb: Clean up tasklet releasing
  dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
  dmaengine: tegra-apb: Use devm_platform_ioremap_resource
  dmaengine: tegra-apb: Use devm_request_irq
  dmaengine: tegra-apb: Fix coding style problems
  dmaengine: tegra-apb: Remove runtime PM usage
  dmaengine: tegra-apb: Clean up suspend-resume
  dmaengine: tegra-apb: Add missing of_dma_controller_free
  dmaengine: tegra-apb: Allow to compile as a loadable kernel module
  dmaengine: tegra-apb: Remove MODULE_ALIAS

 drivers/dma/Kconfig           |   2 +-
 drivers/dma/tegra20-apb-dma.c | 481 ++++++++++++++++------------------
 2 files changed, 220 insertions(+), 263 deletions(-)

-- 
2.24.0

