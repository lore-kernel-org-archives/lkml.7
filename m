Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994B9C06508
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 17:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73788208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 17:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jn5dbha8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfF3RYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 13:24:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34239 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfF3RYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 13:24:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so10668934ljg.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DPwrQFg4SMsQ0Yy8vytLFwgLYycpl+OBmBKTwx8dTWc=;
        b=Jn5dbha8phys6TijaUHIy41CHa5/B3xQc4VSSGASGi7VOd4SHz7clN1hLMUh3dPUYI
         UOB9RFG1eUP93Af+QAaSqU3qKo2/efPk9tZV2eRulM5yn27qlllCAFgtaIzi7ppXkEk1
         Io+x2gb3pbYr7Zck+QzMJ8jwINmy4nW7sYl0PWAwCxRu7uxLZq8Xpb0TzKZwKEfBSwjz
         wH8S9eMaG9CHuJrzF06DgsuaecQGdefZyRTbNoYZJi7QEIdo94KYUIUWj/6Cbrnu/Hlz
         jcMMsJ8KzmT3taHEl6zTIXOEzBCFLc8dQ9rM6rTDWffQH2Ani+0ic7adE63Dgag/pzMa
         d3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DPwrQFg4SMsQ0Yy8vytLFwgLYycpl+OBmBKTwx8dTWc=;
        b=Gr4r6oQom4IDDs9s05xkg0g2xJyM5O9Jk0BnLoZHDE76uxV+K0KFmXXg6f7L1Eds8D
         lTx4XY8MKvb/GtS9ww/cso8PTS1IbzTk5ABidORCTY9Recy5sCV2aAWGJZY4lH3xq++R
         jNKuSfoGtVv7y0RpNcaMRufjUy+9olttRTCioCttrzPRgsABN5AbGyhrYydM8bZQrrqv
         kH2cVOUU2bT/T12L05kk/qRICM/NbVvhJNmrjet/mUeKbxwQRoTbZLTO59xBFwNQeagP
         nQVULi8Bp44Ahn0UhPKuSVznESyzBXxHAOmeunHePLDnhu32A/S9wjwqvIl9ILOa/2lG
         5YxA==
X-Gm-Message-State: APjAAAV/f3G2F/kKbPFtgbx/ivY8VF6cdl2MQalGPxNqzKIBEmO+m6A8
        IVWkoH1svkm28YqeivGSfot4k4s7/ds=
X-Google-Smtp-Source: APXvYqzg00rV2HOfgLqYPrIxuxkj4JtSuEaGuAlRnQ8UUfwPQyN31xUZUHRyb4DtfKm7qcEWHMQ0GA==
X-Received: by 2002:a2e:658e:: with SMTP id e14mr11462808ljf.147.1561915457685;
        Sun, 30 Jun 2019 10:24:17 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id c1sm2273795lfh.13.2019.06.30.10.24.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 10:24:17 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 net-next 0/6] net: ethernet: ti: cpsw: Add XDP support
Date:   Sun, 30 Jun 2019 20:23:42 +0300
Message-Id: <20190630172348.5692-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds XDP support for TI cpsw driver and base it on
page_pool allocator. It was verified on af_xdp socket drop,
af_xdp l2f, ebpf XDP_DROP, XDP_REDIRECT, XDP_PASS, XDP_TX.

It was verified with following configs enabled:
CONFIG_JIT=y
CONFIG_BPFILTER=y
CONFIG_BPF_SYSCALL=y
CONFIG_XDP_SOCKETS=y
CONFIG_BPF_EVENTS=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_BPF_JIT=y
CONFIG_CGROUP_BPF=y

Link on previous v4:
https://lkml.org/lkml/2019/6/25/996

Also regular tests with iperf2 were done in order to verify impact on
regular netstack performance, compared with base commit:
https://pastebin.com/JSMT0iZ4

v4..v5:
- added two plreliminary patches:
  net: ethernet: ti: davinci_cpdma: allow desc split while down
  net: ethernet: ti: cpsw_ethtool: allow res split while down
- added xdp alocator refcnt on xdp level, avoiding page pool refcnt
- moved flush status as separate argument for cpdma_chan_process
- reworked cpsw code according to last changes to allocator
- added missed statistic counter

v3..v4:
- added page pool user counter
- use same pool for ndevs in dual mac
- restructured page pool create/destroy according to the last changes in API

v2..v3:
- each rxq and ndev has its own page pool

v1..v2:
- combined xdp_xmit functions
- used page allocation w/o refcnt juggle
- unmapped page for skb netstack
- moved rxq/page pool allocation to open/close pair
- added several preliminary patches:
  net: page_pool: add helper function to retrieve dma addresses
  net: page_pool: add helper function to unmap dma addresses
  net: ethernet: ti: cpsw: use cpsw as drv data
  net: ethernet: ti: cpsw_ethtool: simplify slave loops


Based on net-next/master

Ivan Khoronzhuk (6):
  xdp: allow same allocator usage
  net: ethernet: ti: davinci_cpdma: add dma mapped submit
  net: ethernet: ti: davinci_cpdma: return handler status
  net: ethernet: ti: davinci_cpdma: allow desc split while down
  net: ethernet: ti: cpsw_ethtool: allow res split while down
  net: ethernet: ti: cpsw: add XDP support

 drivers/net/ethernet/ti/Kconfig         |   1 +
 drivers/net/ethernet/ti/cpsw.c          | 520 +++++++++++++++++++++---
 drivers/net/ethernet/ti/cpsw_ethtool.c  |  78 +++-
 drivers/net/ethernet/ti/cpsw_priv.h     |   9 +-
 drivers/net/ethernet/ti/davinci_cpdma.c | 125 +++++-
 drivers/net/ethernet/ti/davinci_cpdma.h |  11 +-
 drivers/net/ethernet/ti/davinci_emac.c  |  17 +-
 include/net/xdp_priv.h                  |   1 +
 net/core/xdp.c                          |  46 +++
 9 files changed, 701 insertions(+), 107 deletions(-)

-- 
2.17.1

