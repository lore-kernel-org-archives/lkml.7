Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0B2C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137C320883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yd0uX1TQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbfFYR7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:59:54 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:38690 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731612AbfFYR7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:59:54 -0400
Received: by mail-lj1-f180.google.com with SMTP id r9so17163615ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=I7X4utygXdOG9w4oLjZZ8/mhD8999uyd81mBBAgzC04=;
        b=yd0uX1TQsAWm4JKPpCXjtciIuy/iaEG2YZ4ZPYUvtv4LQddYOWX7paK5dAhexUplkr
         cs4pm7l0GxvE7eIDFX2BoITaWLvV7rjLmVgEIEYOpDiW82TJMiRoBMO6FfJ/JgF4gAeI
         BCBw/k6ZK50foR2nKfWsyeZfIJYOeAMpIYIl7K7qpCawuhYc0yrSM9aIdZSYhivz9hrk
         j2C5q383rKCw64XlP1/E6MQ7Kk78OP2VVJJfFim1/1RNq+LjjktQXney5kdreY7+gSos
         KRFZqa/O9BvBoRk8iXrB64nzQ2yIMY3jw+shgG3Oibs8BNFEU1nne6e7OfA6x86kYm2g
         IvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I7X4utygXdOG9w4oLjZZ8/mhD8999uyd81mBBAgzC04=;
        b=DJkb9M5spbdl7SewvXRLzFmeTW2aQJAJA+WtmoG9GT/Npgpl+5ZXRADplwS6zTRdPF
         2Fn1Nv9fEEa451GZpMVUzsvqspXIo+FTKzowUyW2fcjvxv7dZExZf9QM1hgMTIXtmWBy
         lCIw5HHpeYP4NVnOwHMiZVYSSPQE0AD9wDUNhQRlgxBGlIOw3Kl6cpxqoiiwZKxK2tis
         r7E7Wsia7u+h65qn2CyuUtORSwlwWL5/1jVj0tA7kGK8/XUF/y3kTm7jvBQw8xkkE889
         gaiGgTqWfwVjrbl0eyhjhlj9arCs+CX5UcYaQVO1z7voHHwo+kZkyICfDkqppZyjvSkM
         cYxA==
X-Gm-Message-State: APjAAAXOQfPTqz7LpjuZX2g1IZtlywJY9JQEzz87Zse5ZblAb4T+ZSkP
        Si13Yw4GxjtbOHWASkL749RqdA==
X-Google-Smtp-Source: APXvYqyfCIyQyeeBYb250pntUMLm6VEcI/1tMPrFswVnazXzb3yJ6Pq6tHJ0NZPPiLAPLBENWDPLQQ==
X-Received: by 2002:a2e:9643:: with SMTP id z3mr6291791ljh.43.1561485592212;
        Tue, 25 Jun 2019 10:59:52 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id g76sm2367597lje.43.2019.06.25.10.59.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 10:59:51 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com, hawk@kernel.org,
        brouer@redhat.com, saeedm@mellanox.com, leon@kernel.org
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 net-next 0/4]  net: ethernet: ti: cpsw: Add XDP support
Date:   Tue, 25 Jun 2019 20:59:44 +0300
Message-Id: <20190625175948.24771-1-ivan.khoronzhuk@linaro.org>
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

Link on previous v3:
https://lkml.org/lkml/2019/6/5/446

Also regular tests with iperf2 were done in order to verify impact on
regular netstack performance, compared with base commit:
https://pastebin.com/JSMT0iZ4

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

Ivan Khoronzhuk (4):
  net: core: page_pool: add user cnt preventing pool deletion
  net: ethernet: ti: davinci_cpdma: add dma mapped submit
  net: ethernet: ti: davinci_cpdma: return handler status
  net: ethernet: ti: cpsw: add XDP support

 .../net/ethernet/mellanox/mlx5/core/en_main.c |   8 +-
 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/cpsw.c                | 536 ++++++++++++++++--
 drivers/net/ethernet/ti/cpsw_ethtool.c        |  25 +-
 drivers/net/ethernet/ti/cpsw_priv.h           |   9 +-
 drivers/net/ethernet/ti/davinci_cpdma.c       | 123 +++-
 drivers/net/ethernet/ti/davinci_cpdma.h       |   8 +-
 drivers/net/ethernet/ti/davinci_emac.c        |  18 +-
 include/net/page_pool.h                       |   7 +
 net/core/page_pool.c                          |   7 +
 net/core/xdp.c                                |   3 +
 11 files changed, 640 insertions(+), 105 deletions(-)

-- 
2.17.1

