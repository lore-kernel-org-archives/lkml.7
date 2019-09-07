Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DD2C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 08:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FAC208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 08:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567844028;
	bh=mafzhMPZiGWkW1SiBA8276/Vtqm3xN/GmkS2BBdN6Ig=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=nWYRIDA3jCiA7N8lgMcBU4cs8biVCkgbCG6NQDvJX58StGe/kUp+m52aA9/k6b6ot
	 sloYqhxqpTizaCIi9gAv8EOgLv8Y5JphTfew+3D+NmCFepYvMpcPLoEjwkPomIubjy
	 GxpTyG44nPVmr70h4LUmI/tgVKppm1KGyGaPcjSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbfIGINp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 04:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfIGINp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 04:13:45 -0400
Received: from localhost (unknown [223.226.124.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0C2E208C3;
        Sat,  7 Sep 2019 08:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567844024;
        bh=mafzhMPZiGWkW1SiBA8276/Vtqm3xN/GmkS2BBdN6Ig=;
        h=Date:From:To:Cc:Subject:From;
        b=KB03eYeDvaxU+Me6/wa2AU7K9BUABrwYNk7bY1FRTbLN/Czwrm+ZAM7AUlMmwNHFq
         905pl8Nw6WiuqP+aybBaD7CkspJVeOiteiMarC7JPRWS5DYDKpb70QOMLoIvV6CrIK
         sT0ArO8IW/hxqi59ChT1Psofs0mXeMaxlX4Yqc3I=
Date:   Sat, 7 Sep 2019 13:42:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmaengine late fixes for 5.3
Message-ID: <20190907081234.GJ2672@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heya Linus,

I would like you to pull for couple of simple dmaengine driver fixes we
got in last few days.

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.3

for you to fetch changes up to cf24aac38698bfa1d021afd3883df3c4c65143a4:

  dmaengine: rcar-dmac: Fix DMACHCLR handling if iommu is mapped (2019-09-04 11:35:58 +0530)

----------------------------------------------------------------
dmaengine late fixes for 5.3

Some late fixes for drivers:
 - memory leak in ti crossbar dma driver
 - cleanup of omap dma probe
 - Fix for link list configuration in sprd dma driver
 - Handling fixed for DMACHCLR if iommu is mapped in rcar dma

----------------------------------------------------------------
Baolin Wang (1):
      dmaengine: sprd: Fix the DMA link-list configuration

Wenwen Wang (2):
      dmaengine: ti: dma-crossbar: Fix a memory leak bug
      dmaengine: ti: omap-dma: Add cleanup in omap_dma_probe()

Yoshihiro Shimoda (1):
      dmaengine: rcar-dmac: Fix DMACHCLR handling if iommu is mapped

 drivers/dma/sh/rcar-dmac.c    | 28 +++++++++++++++++++---------
 drivers/dma/sprd-dma.c        | 10 ++++++++--
 drivers/dma/ti/dma-crossbar.c |  4 +++-
 drivers/dma/ti/omap-dma.c     |  4 +++-
 4 files changed, 33 insertions(+), 13 deletions(-)

Thanks
-- 
~Vinod
