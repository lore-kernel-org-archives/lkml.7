Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F00C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FFE2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X7ZzQJG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfG2Fdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 01:33:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37350 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfG2Fdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 01:33:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so16880459pgd.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 22:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DPXHy1a69mKAzAt5eK/5mGSu5mMYfcr+qJqjDh7NSaQ=;
        b=X7ZzQJG0cNXQD6YQsemOKW/jT5dXIqlD5c4Jcz7JtWEhIqBe209fc02CAGpqr+SYx0
         gHPYOCrdYg3Ro7wBapt85n2eL90PlzXxI3QY75kWqphNBvBEhfTaqOY9NODoZZKpkG2h
         jgrZXO+DLTuPGvJ9LjyhDaLG7s2coSQiQVGuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DPXHy1a69mKAzAt5eK/5mGSu5mMYfcr+qJqjDh7NSaQ=;
        b=DuGSM4zdKiWfsLd4GJ7suzwvddTRbE6ZqqEAco/63CIWwaphJdxylr6c+PJYvlgpHm
         OxCMbSjI2hrGRat2GijnoyDQgBwUC0ncO/Ct3LqIStQozaZoWFDeZu7dTSx4jB/CLFNo
         LoW1BQmkDqjxs0gJWw2j3qNe3IdIV88gNw8y5TEXWJfoYdwcvZxPfM6UdD8mdHiXU+eW
         SDsNyXftcH3x/6MO5jslqqeKK7Yd4oVjyPxtqVXIPthhnoi9u/E9e/cDN3cIXDAcARkh
         sLQGlV85vD75tfZICeYGobc4lrhxA/3tQdx95IHE3RPY5GQjgWr1SQFSPBEucYueljGw
         azEQ==
X-Gm-Message-State: APjAAAW0AkrOlHCpbFWntLwvqkpUHiNPdD/ObFEN/zFa5lA6PqAYoxli
        fvTRQXd6/z2uqdtKcga5qigc9Q==
X-Google-Smtp-Source: APXvYqygDVAWdgpICHSE02DV6msSDKrPaHx2VAR3/vrWfQrTSpR/C3whA4rXoQaV+tRhbTuC/OWZhg==
X-Received: by 2002:a17:90a:1d8:: with SMTP id 24mr111974489pjd.70.1564378433305;
        Sun, 28 Jul 2019 22:33:53 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id z4sm93792810pfg.166.2019.07.28.22.33.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 22:33:52 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v2 0/2] drm/mediatek: make imported PRIME buffers contiguous
Date:   Mon, 29 Jul 2019 14:33:33 +0900
Message-Id: <20190729053335.251379-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default DMA segment size was used when importing PRIME buffers,
which resulted in a chance of them not being contiguous in the virtual
IO space of the device and mtk_gem_prime_import_sg_table() complaining
that the SG table was not contiguous as it expects.

This series fixes this issue by

1) Using the correct DMA device when importing PRIME buffers,
2) Setting a more suitable DMA segment size on the DMA device than the
default 64KB.

Changes since v1:
- Split into two patches,
- Fixed an error path that would have returned 0.

Alexandre Courbot (2):
  drm/mediatek: use correct device to import PRIME buffers
  drm/mediatek: set DMA max segment size

 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 49 ++++++++++++++++++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.h |  2 ++
 2 files changed, 48 insertions(+), 3 deletions(-)

-- 
2.22.0.709.g102302147b-goog

