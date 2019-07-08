Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E91C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6FD216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Gf61OpwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbfGHRY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:24:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42445 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfGHRY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:24:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so8610581plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CqXD+N8dzmqJ4IWQJGnOizgxv0vvjYnPypNtlkBzoqM=;
        b=Gf61OpwO48cpWHTX4LkTJEBGeQIQgSi9UcozAjDh4tDWAj+i66n7KDrBKf/qvlQQYN
         ASYH3dl2t8+u/9tCEE+Ncxeu2RfPAxTL5EwZHqB0Bf4pZx++FhY9xCISoGnsC0BH5WDf
         ZBUgrVo8nqOk9ONdNgZ0Sb+aysrK2g9jr57AabDv/DgXF6dUkMxkQMrpx9y5l9LKj+ua
         UiLY8C6He34Ew6QlfFnGxu+bNvYaFpO78HznTdHvuiInQX1ECBDYM5VqvHlONReWOGaE
         VF7VPAqfCQ8oiy/f0kCwawTVE5hGh+fKhpsa5tFhBspqcaYVKTNUNxbVp1nfOS0vBVNE
         UPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CqXD+N8dzmqJ4IWQJGnOizgxv0vvjYnPypNtlkBzoqM=;
        b=qVxFHav3p5wUlyaVrt+h7cHzCSJ1X6I7Nx0D9fk6UsKJ9DSp2y2Ja80p9XyXjYO6pD
         LdjaIGlUM6wVcKSsmTsqkF4NdiDof+j5GdB6v39ilawbTg60N2ljD4H/ex/kirnL5KMb
         Hc/xPm/gvdgdaTZkE6NHWK7/JavalefCyJpH3qYBgmEr0Sj7uanoQ+aeu3nWgPidNtcV
         TM3e4DIAH6cIGYAG14HXqGptF9kIj+3B/L+LiU1lLkFWY6AZ0zhkTdQ+Lqa2fWXwfpMo
         JJNuXNPa+rKHE7Smbub4xlAtiab7uoPeqYgbLU8K4ubZ99U5Sw9pJU9Zyl+Rs4fHHloC
         lqyg==
X-Gm-Message-State: APjAAAWg4jKicpujP2RKntqBDLZX7mWpdMCsWb696s3eUFmvft4Zezeh
        Z36Xo9aR01EhJLH0LXX0BhbkIA==
X-Google-Smtp-Source: APXvYqxSuGru2wb/skyPl0wfVNutDrDEL5x8OhsThJM12iXm6SCrxHIoZHkxTZFhxjlivKIsUTP/EQ==
X-Received: by 2002:a17:902:7612:: with SMTP id k18mr18691349pll.48.1562606666267;
        Mon, 08 Jul 2019 10:24:26 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id h21sm15951262pgg.75.2019.07.08.10.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jul 2019 10:24:25 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        palmer@sifive.com, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH] nvme-pci: No IRQ map for read if no read queue allocated
Date:   Mon,  8 Jul 2019 10:24:12 -0700
Message-Id: <1562606652-7618-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

nvme_dev_add() assumes a read queue is always allocated.
That may not be the case on single-interrupt systems for
which pci_assign_irq() would report runtime IRQ mapping
not provided by arch.

This patch makes sure nvme_dev_add() only requests an
IRQ mapping for read queues if at least one read queue
is being allocted.

nvme_pci_map_queues() will later on ignore the unnecessary
mapping request should nvme_dev_add() request such an IRQ
mapping even though no read queues are being allocated.
However, nvme_dev_add() can avoid making the request by
checking the number of read queues without assuming. This
would bring it more in line with nvme_setup_irqs() and
nvme_calc_irq_sets().

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 524d6bd6d095..86262ebe6fff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2263,7 +2263,9 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	if (!dev->ctrl.tagset) {
 		dev->tagset.ops = &nvme_mq_ops;
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
-		dev->tagset.nr_maps = 2; /* default + read */
+		dev->tagset.nr_maps = 1; /* default */
+		if (dev->io_queues[HCTX_TYPE_READ])
+			dev->tagset.nr_maps++;
 		if (dev->io_queues[HCTX_TYPE_POLL])
 			dev->tagset.nr_maps++;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
-- 
2.7.4

