Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F28DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02EE2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eiw7JCwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfB1Iqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:46:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36122 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfB1Iq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:46:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so8057916wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=YNGu42DFbvMJ5IongQ5kFvkOxsADTo/MTw39VNMrzQE=;
        b=Eiw7JCwMjLaWX+nrO0P9sm9/uuQqdmEXUNwvbR3JMs2s1E7sJkRoWmODrg++RV5UGj
         FfT7Iuf9mr4pm/m8ZM9hQx/NjAo/cuVjXWqTN3bmjtCxk9cI6Atr91tuKewjCUQIC5m+
         78vnYNZ/VLWc1K+bdRz9z9g9PvSc+DeD6kWJkxAfwmHCyzhTKh8aKX+wb+rLqC5QUrPs
         j3Y7I8zvgDa9coTvZfrUc1itIIf+vHi6NgZu7716IW30xjEMsTvKgxsKvrmLRAIdb/Rt
         jq6aMcZhzcHPFNoqfaT/ghr+y3r0qkEk6MJxCHZ04iQYt3WcYdKeGpi6NPvKvbjwrHsJ
         VHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=YNGu42DFbvMJ5IongQ5kFvkOxsADTo/MTw39VNMrzQE=;
        b=ul4pvhdBRvn9i7mSR/3bYCrjUjpVPnzJnyYporvNNBRtJy1HNAmslwZAvYRzGMHCUl
         0nQ75PLTfZSlEr4XTPKzyqfX+K9R1w/8GJU/uBofJvqTY4ICx/aLluhISKkVkWPGj0YD
         LzigZu2vxZp0BWN0p0djMezDRGfvVzt5qErFeJHExF9FuWg4yhK1J8CO+cTtWvEkCwwC
         jkj2N82MpsHro2LN9XPXbwpuBdekqmzdunY7YnDyfJBxK9n2GENdHvivN3lZvuLB2DRt
         arrINPtQp/766yazBUXJp8F5K/tIKJFoqFT25HIcmGPIkVFmgLgVLxFzO5vMeIVXczQ2
         Oy3Q==
X-Gm-Message-State: AHQUAuZilschliv9xCRxdKjiyBwv2hrdGqGFSDXklmAbVL8qiIaThMbU
        s7Qe52yhxmBolihXzirtng8=
X-Google-Smtp-Source: AHgI3IabgNHuPOfHJsZsYHW4Y5DEtLygn4g1Zk4nOmyMxrXn4kfbPLm69JENSqy2V5mgqt4RzOjG3A==
X-Received: by 2002:a1c:38b:: with SMTP id 133mr2141452wmd.26.1551343587206;
        Thu, 28 Feb 2019 00:46:27 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h126sm4409305wmf.2.2019.02.28.00.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 00:46:26 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] habanalabs fixes for merge window
Date:   Thu, 28 Feb 2019 10:46:09 +0200
Message-Id: <20190228084624.25288-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This patch-set contains only fixes for H/W, F/W and driver bugs that were
discovered and fixed since v5 of the habanalabs upstream patch-set.

In addition, the patch-set contains fixes to sparse warnings regarding
little-endian to/from cpu conversions (and to other sparse warnings).

Thanks,
Oded

Oded Gabbay (10):
  habanalabs: disable CPU access on timeouts
  habanalabs: fix mmu cache registers init
  habanalabs: fix validation of WREG32 to DMA completion
  habanalabs: set DMA0 completion to SOB 1007
  habanalabs: add comments in uapi/misc/habanalabs.h
  habanalabs: fix memory leak with CBs with unaligned size
  habanalabs: print pointer using %p
  habanalabs: soft-reset device if context-switch fails
  habanalabs: use NULL to initialize array of pointers
  habanalabs: fix little-endian<->cpu conversion warnings

Omer Shpigelman (3):
  habanalabs: add MMU DRAM default page mapping
  habanalabs: extend QMAN0 job timeout
  habanalabs: return correct error code on MMU mapping failure

Tomer Tayar (2):
  habanalabs: Dissociate RAZWI info from event types
  habanalabs: fix little-endian<->cpu conversion warnings

 drivers/misc/habanalabs/command_buffer.c      |   9 +-
 drivers/misc/habanalabs/command_submission.c  |  16 +-
 drivers/misc/habanalabs/debugfs.c             |  21 +-
 drivers/misc/habanalabs/device.c              |   2 +
 drivers/misc/habanalabs/goya/goya.c           | 667 +++++++++---------
 drivers/misc/habanalabs/goya/goyaP.h          |  29 +-
 drivers/misc/habanalabs/habanalabs.h          |  14 +-
 drivers/misc/habanalabs/habanalabs_ioctl.c    |   2 +-
 drivers/misc/habanalabs/hw_queue.c            |  23 +-
 drivers/misc/habanalabs/hwmon.c               |  54 +-
 .../include/goya/asic_reg/goya_regs.h         |   1 +
 .../include/hw_ip/mmu/mmu_general.h           |   1 +
 drivers/misc/habanalabs/irq.c                 |   8 +-
 drivers/misc/habanalabs/memory.c              |  12 +-
 drivers/misc/habanalabs/mmu.c                 | 287 +++++++-
 drivers/misc/habanalabs/sysfs.c               |  29 +-
 include/uapi/misc/habanalabs.h                |  10 +-
 17 files changed, 740 insertions(+), 445 deletions(-)

-- 
2.17.1

