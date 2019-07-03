Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B072C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F0B2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 10:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJ4cpywQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfGCKTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 06:19:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43437 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfGCKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 06:19:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id j29so1357350lfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 03:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N64YiOP2YVl5zyPZolUHrk+pThiJwXVkclxV2400gD8=;
        b=LJ4cpywQ/xDEXzvzPx3lv5wTD8nK1FnzRsjS+SpAP/ku9u/Eucxp0IM0ubt0Lf88CD
         n0Wt5pfYPGUdkxsnqzyhixYwadc7A3ZzzFNg94W+ySo4vsGGzR5DunUjXbSE3re5Kb1Y
         Cuh9IpTxCSD1KhslOS9u9hdklo06Zd5y83ViBydoeJcW1t8G06Xs6q3F+8DOc6ewUVvC
         ZM+v/ABR2xPA2s2rpO6fcgIbRu3EQvuYFogMfF4Q67ACp5frmT58cZaylS/a4KrOJwqY
         TaiA4h8PMjtNM2Pjn4vLZ7cWQTL2kRj7dfnenF93TULHMrcSIfbqlBdXw1tcsRRv4m3w
         D8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N64YiOP2YVl5zyPZolUHrk+pThiJwXVkclxV2400gD8=;
        b=L9Rz99fvdPlfijMhK/cmQ1JmeIPcTAHS/u8IEAjCzH6aaXTSueWuMKwM+CPyBV2wfs
         qQmJCxB5zytNxkKEKH1hZsNJ3XvbSMhPdOH6I4tBVu/GMQoRdXNvT9QxaUay3PcGshZF
         Jyo5YLNGhdSvIjLIwSHSi9ctJGKYKaIL4vzvP9Wbb4e+30qPHXl2akG6oE1JbmFCFbr2
         KzZ93WfwL77xLfDnPlnD4LFvUNCqejKjDkRd+1/lUYHjizkvhIV39kUQsPVON4YliXGB
         z8MVbAEML+SjRbbfWGJHTBZkcpgbKKm9iADYWMnZzeYmAsDg4alMT+3/RZrm96Ygj/b2
         zsSg==
X-Gm-Message-State: APjAAAXZ2UejLaP0bqP7wtwewAWzo2HU3bnbktmKySXLSsbqhn80NnBn
        nTQWDWJtAqURR4S7vCLAC3F60w==
X-Google-Smtp-Source: APXvYqzdLBy5TYPMJzQqNxFe8fF++4bQDuW89whZy9M57F++RFeRiQmMpPN71lULn5Cx1d6ruJxhfA==
X-Received: by 2002:a19:f00a:: with SMTP id p10mr5215455lfc.68.1562149147493;
        Wed, 03 Jul 2019 03:19:07 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id i9sm67267lfl.10.2019.07.03.03.19.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 03:19:06 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v6 net-next 0/5] net: ethernet: ti: cpsw: Add XDP support
Date:   Wed,  3 Jul 2019 13:18:58 +0300
Message-Id: <20190703101903.8411-1-ivan.khoronzhuk@linaro.org>
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

Link on previous v5:
https://lkml.org/lkml/2019/6/30/89

Also regular tests with iperf2 were done in order to verify impact on
regular netstack performance, compared with base commit:
https://pastebin.com/JSMT0iZ4

v5..v6:
- do changes that is rx_dev while redirect/flush cycle is kept the same
- dropped net: ethernet: ti: davinci_cpdma: return handler status
- other changes desc in patches

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

Ivan Khoronzhuk (5):
  xdp: allow same allocator usage
  net: ethernet: ti: davinci_cpdma: add dma mapped submit
  net: ethernet: ti: davinci_cpdma: allow desc split while down
  net: ethernet: ti: cpsw_ethtool: allow res split while down
  net: ethernet: ti: cpsw: add XDP support

 drivers/net/ethernet/ti/Kconfig         |   1 +
 drivers/net/ethernet/ti/cpsw.c          | 485 +++++++++++++++++++++---
 drivers/net/ethernet/ti/cpsw_ethtool.c  |  76 +++-
 drivers/net/ethernet/ti/cpsw_priv.h     |   7 +
 drivers/net/ethernet/ti/davinci_cpdma.c |  99 ++++-
 drivers/net/ethernet/ti/davinci_cpdma.h |   7 +-
 include/net/xdp_priv.h                  |   2 +
 net/core/xdp.c                          |  55 +++
 8 files changed, 656 insertions(+), 76 deletions(-)

-- 
2.17.1

