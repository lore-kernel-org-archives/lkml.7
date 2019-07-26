Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B38C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EA722BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564141653;
	bh=53oCpbE/bVMuFrTXrOsJrAAJOxdFj55ptEeL7PFGelE=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=IR2ym5lECS0Vq2O5wlmsgYYX2+wjWJmopRpQRq77uQeS0QUXQpqBLvgNUNQ4pVqJY
	 gjSOR26d86G2tdCQKMBuwCHW8zOWPOUP4R3MJ+YyV446jBPMhA6lmBQyLCoVrGb3fb
	 ppWtwKcUbl2gVu0Hcbmik/iul7gkBY1QuNTNTknA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfGZLrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:47:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfGZLrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D0Qj9dCjSWBikWuVtcrnge2jcaAe2+fe4XkHjYEdnbc=; b=eIb7498wVSBC13/a5vcNoBDFg
        0XDw5M4gw1VwiY23ak5h+nSi2RVm3yHVmWCUKcMKxdQd5viWbDleAA2X2ZKKyiEE5rSYYzLrYc/IB
        Bw7ZZBWHomI1C9PIhwnqEXVUekkk9wDRk3i7lqlxOtE+o/24ZZ/dN1mzlOMWH8iUsc+Hakj31Micu
        EcPBsia0E3Rdc33EoRe0t2baRTtrKgeyBPBkBkqI+p7T6brWqLGgZQC/CyOYTkFZV9NCsq/eB00JR
        bnKmV/qScDA3FwUAg54XJDwTVt3B4bvX3cDvDjXxbRB/cTfo91wFAdnqpQYarSjGNvjr0Ku4/54a1
        yGZkp6opg==;
Received: from [179.95.31.157] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqyh8-0003BV-TI; Fri, 26 Jul 2019 11:47:30 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hqyh6-0000tm-UW; Fri, 26 Jul 2019 08:47:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/7] Fix broken references to files under Documentation/*
Date:   Fri, 26 Jul 2019 08:47:20 -0300
Message-Id: <cover.1564140865.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Solves most of the pending broken references upstream, except for two of
them:

	$ ./scripts/documentation-file-ref-check 
	Documentation/riscv/boot-image-header.txt: Documentation/riscv/booting.txt
	MAINTAINERS: Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt

As written at boot-image-header.txt, it is waiting for the addition of
a future file: 

	"The complete booting guide will be available at
	  Documentation/riscv/booting.txt."

The second is due to this patch, pending to be merged:
	https://lore.kernel.org/patchwork/patch/994210/

I'm not a DT expert, but I can't see any issue with this patch, except
for a missing acked-by a DT maintainer, and a possible conversion to
yaml. IMO, the best fix for this would be to merge the DT patch.

Patch 1 was already submitted before, together with the v1 of
my PDF fix series.

Mauro Carvalho Chehab (7):
  docs: fix broken doc references due to renames
  docs: generic-counter.rst: fix broken references for ABI file
  MAINTAINERS: fix reference to net phy ABI file
  MAINTAINERS: fix a renamed DT reference
  docs: cgroup-v1/blkio-controller.rst: remove a CFQ left over
  docs: zh_CN: howto.rst: fix a broken reference
  docs: dt: fix a sound binding broken reference

 Documentation/RCU/rculist_nulls.txt                |  2 +-
 .../admin-guide/cgroup-v1/blkio-controller.rst     |  6 ------
 .../devicetree/bindings/arm/idle-states.txt        |  2 +-
 .../devicetree/bindings/sound/sun8i-a33-codec.txt  |  2 +-
 Documentation/driver-api/generic-counter.rst       |  4 ++--
 Documentation/locking/spinlocks.rst                |  4 ++--
 Documentation/memory-barriers.txt                  |  2 +-
 .../translations/ko_KR/memory-barriers.txt         |  2 +-
 Documentation/translations/zh_CN/process/howto.rst |  2 +-
 Documentation/watchdog/hpwdt.rst                   |  2 +-
 MAINTAINERS                                        | 14 +++++++-------
 drivers/gpu/drm/drm_modes.c                        |  2 +-
 drivers/i2c/busses/i2c-nvidia-gpu.c                |  2 +-
 drivers/scsi/hpsa.c                                |  4 ++--
 14 files changed, 22 insertions(+), 28 deletions(-)

-- 
2.21.0


