Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBB6C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8862087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="P8BZuNbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfEFKtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:49:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44882 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfEFKtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:49:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so2160363plj.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BRC3Z3+UxcLDFwyiUMPxf4Qer+1eOXAYqQrSL6zMVrc=;
        b=P8BZuNbzW6NxX/w1mub6qkbcIgZKE08lp7r2HwhPmLvc2eHKVVsvY9aALR3r+SJDxR
         3GzD3TqYIgVv74EvjLjuR0WOfZ+RYFDEZs1YGYqFk7pw9wVcNOE4iK6wr4izhdDknx/1
         WFcXo6aai/nlS4FLPaDPGgtIqy1k3wc9YfSDKoQl5QCLoLNlx71/VyKKaJzjr50oBPV9
         c0pXgfklT4MbACS7chlFLjwdGwrrMXVP/6F3R4vX08BxmnsGMr/qL7VOkEmKNudpo9XM
         F5eJDuPCjNXYVp2Nxs48DuD5qZb7DeNIfYypFYLhwXybkiMhiB++QlKWAGvnzjPbbl3g
         h2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BRC3Z3+UxcLDFwyiUMPxf4Qer+1eOXAYqQrSL6zMVrc=;
        b=lA4XDi7ol/SUKIUmmEr+ssUkXscz25NrnF/H/ThgdY+rZvZL8PFnhyg5397m8iFyrZ
         I9ZLBQLHoIzkFGOtz5imMGm9IDKgYUwGytTtxz2YrjbzHyUPFsnndwtDFbCr16l7PlEC
         1W06Itb0AId+MMCN3gtax3i3o5CVn/6eN6hA54DLXiA4TlXHXSM1AXMxQl/xBpSdUp7a
         NWGJKpebID7WHCsY2NiI6bVfFhri56ATKeBUsKAE0B9iZQZWcnlpsMsGR+G9YUHlduRj
         Xt4r/E1MOdBLNTL/8q0Rk+AIaKZHv+KbJo4kDW8//xED+SASk7JZ4/vwOo+39H4YH3Mq
         K1lg==
X-Gm-Message-State: APjAAAXEEH8jQ0LX4UdcFZU/SxhUidMuZdhqKA/l5aE4fMiE/fjgY1LG
        UgjcPZFfVu5KQ8dboCIfv9Hrgw==
X-Google-Smtp-Source: APXvYqwXKlvXYBYhWYyONyfIJ8A2MOOKh40u2Bmp1IQvp2bhgWtuZDxtb1uAg+BW4JM6GkBoXY1tIQ==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr32159119plb.202.1557139746900;
        Mon, 06 May 2019 03:49:06 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id p67sm21662257pfi.123.2019.05.06.03.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 03:49:06 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        palmer@sifive.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, mark.rutland@arm.com, robh+dt@kernel.org,
        sachin.ghadi@sifive.com, afd@ti.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v3 0/2] L2 cache controller support for SiFive FU540
Date:   Mon,  6 May 2019 16:18:38 +0530
Message-Id: <1557139720-12384-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds an L2 cache controller driver with DT documentation
for SiFive FU540-C000.

These two patches were initially part of the patch series:
'L2 cache controller and EDAC support for SiFive SoCs'
https://lkml.org/lkml/2019/4/15/320
In order to merge L2 cache controller driver without any dependency on EDAC,
the L2 cache controller patches are re-posted separately in this series.

The patchset is based on Linux 5.1-rc2 and tested on HiFive Unleashed
board with additional board related patches needed for testing can be
found at dev/yashs/L2_cache_controller branch of:
https://github.com/yashshah7/riscv-linux.git

Changes since v2
- Add a header file to expose Macros and extern functions
- Remove all single line functions

Changes since v1
- Mention the valid values for cache properties in DT documentation
- Remove the unnecessary property 'reg-names'
- Add "cache" to supported compatible string property
- Remove conditional checks from debugfs functions in sifive_l2_cache.c

Yash Shah (2):
  RISC-V: Add DT documentation for SiFive L2 Cache Controller
  RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive
    SoCs

 .../devicetree/bindings/riscv/sifive-l2-cache.txt  |  51 ++++++
 arch/riscv/include/asm/sifive_l2_cache.h           |  16 ++
 arch/riscv/mm/Makefile                             |   1 +
 arch/riscv/mm/sifive_l2_cache.c                    | 175 +++++++++++++++++++++
 4 files changed, 243 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
 create mode 100644 arch/riscv/include/asm/sifive_l2_cache.h
 create mode 100644 arch/riscv/mm/sifive_l2_cache.c

-- 
1.9.1

