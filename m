Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2325CC5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E746320663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB1WGmx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfKFOId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:08:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46901 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfKFOIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:08:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id r18so1506044pgu.13;
        Wed, 06 Nov 2019 06:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xh0YLDess6L96nvkYhuVlivBqcsNSJ5iJO7vqQb2cA8=;
        b=MB1WGmx7LCN3svj1Z32NEMJi+359bYzJH064LJ6eHLnQ5EGZz73rdHSTAmS8xQ/f7k
         hHXH0vlm9SGNPrsvszHnY5l9DNVOqCNOCYD/2BmSijIBSDEsPvO1kwDOOzCflCUtE+C3
         5uWCFCDsGeJ+btYZbhuxZEZGz66MRbWP9PD463v41i9Y1Oi+XQ1otayKg60K6uZh5Gnc
         4DnZXRz5ohRbcR80EUKrbJhjL/yZPXX9+guRIg4XibxuO27z0vcOTmVyl6Kr/4HGMSSS
         /Wpq0gI97R1uFldSR/4Pmm/H3wRa0HUKiXPV/wUp+1WqruYcT72pfSlLfi8NUFXF9/2d
         +GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xh0YLDess6L96nvkYhuVlivBqcsNSJ5iJO7vqQb2cA8=;
        b=LRjnhGEgahrv5euh/a9edodoYAI7+LPT3dxFYmQkDIZNZjB6n2aAwMyM3f9C0F1J85
         d0+Crq20lEdRjupd8Nv6m4XvwKO2FMGuNo92Vb+od+swra5oGbnyF+QMx1HfC0WvCovP
         +Bz19lTbS1wWpq9UAk1fuD4hOQS/HpxB5XM4nFBwPPnoLBrsLVsQAiDuN21fhs2K07e+
         mz9XN1TOe/1ZlMpxkWDBZUUUU+bnk21uXmGNSRbGVCLjWtn5sW+1svuc34j1rpvWB2Lj
         x0l74wjFgr769b5dZRwVdpPIE96QEMVpAyDl9o87/u46kkq2egW1epeNhnwdhn0rJao0
         vv6w==
X-Gm-Message-State: APjAAAWK0/PI3crWjMTn088o/3K3C/nfN0bTQLdb+zFZftNChROYBiWI
        CLi4VX9s0S8ql0pk4aZWgGs=
X-Google-Smtp-Source: APXvYqygIEZIViXKClHYSYmolDRBmW+9kj6CnM/P3+aITpIuH+/hhzB9v23qpqr0AtWRs2EX6QzoUw==
X-Received: by 2002:a17:90a:9201:: with SMTP id m1mr4135941pjo.74.1573049311958;
        Wed, 06 Nov 2019 06:08:31 -0800 (PST)
Received: from localhost.localdomain ([2001:19f0:7001:2668:5400:1ff:fe62:2bbd])
        by smtp.gmail.com with ESMTPSA id a16sm4707345pfc.56.2019.11.06.06.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 06:08:26 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 0/2] mtd: mtk-quadspi: add support for memory-mapped flash reading
Date:   Wed,  6 Nov 2019 22:07:46 +0800
Message-Id: <20191106140748.13100-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for optional memory-mapped flash reading.

BTW: This controller is a ridiculous one which only supports very limited
spi-nor instructions. I can't rework the driver into a spi-mem one because
MTK didn't provide register description in their datasheet and even if they
do provide the documentation, the resulted driver will still be ridiculous
because it'll need to check every supported instructions in support_op and
do execution in one-by-one case in exec_op.

Chuanhong Guo (2):
  mtd: mtk-quadspi: add support for memory-mapped flash reading
  dt-bindings: mtd: mtk-quadspi: update bindings for mmap flash read

 .../devicetree/bindings/mtd/mtk-quadspi.txt   | 21 ++++++++++++++++++-
 drivers/mtd/spi-nor/mtk-quadspi.c             | 11 ++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.21.0

