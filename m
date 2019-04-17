Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5706AC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274E92064B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zdILDgDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbfDQRuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:50:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35229 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733109AbfDQRuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:50:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id j20so6664473lfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hHpxRlsiI7GvZSM+HkyKQPu0rObcw/POqpTIQVI3tSA=;
        b=zdILDgDtdu3OIxwYRtN2PyPe9WxxvQu1KOtzg7eDwEvm49Z0o+2lnaNEt6ePNo+m2P
         yBFjM6da6vX3QnQsNjic0Hy9FjlWfcXSLo2b5ezAZ+qTrR1qBPTKj/KFPthwGiHOaPJj
         ZCuXA44G0qe10XhjxYfusyxE/4KloUCw2md/Tbs+40RSejCYp1/qKE4YoN0MRm0z6OZM
         JyRFCLFqPQWu/6UYj4cqlyzEx+FdeNvDl6u8OXLe74OVYxd7JOEGRLncU3LpjBhHBI/A
         kG0ulgqeBpsds+pPUwuFimDaYXlK+ssK9o9BjCoI2i68WD+BeghHf2hpTYO5xaW+hGr0
         UUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hHpxRlsiI7GvZSM+HkyKQPu0rObcw/POqpTIQVI3tSA=;
        b=V+S9hX/7o15ILAuAXQh9RgomrIB6NKCeXmrQZvt/e4qwqpP2I5G3Wlp6vtQz5Ab7kG
         /gIzOFAcRNhRpp+Hir+g2HtZ0NY8WfDZcG+PqhC1IieLR7OckcrDxfPx1iYG6SZsv+St
         gLaj7AjhvGyW0q1QTSWC9ZoiOh+xv6qlsSesMivqCxlLKeDcXcrXIubrhxbKuAN1WOA6
         5MwM4408jFrv61kUVp1iTOTKR+C99ugDXn2PG69Of6eyVN2RLt8QXTePv9NpChlOuX4J
         qaqwPIqMBK5icW3vOkH/JCYp/J8jCme2H20qKCqAZT5CuE7Qod7VM2ooNV/Y40hwPauO
         F+MA==
X-Gm-Message-State: APjAAAUZ7T6v/Wpzh9FaBX6eEBR+DlsEoO3k1T+SarTltguNmdIVhR+R
        KtEcmVqySiCmb34cHScXuRj+kK/Rhhk=
X-Google-Smtp-Source: APXvYqwGZJCSP2KnWaR0DY0gMgr0qfCTIsgxfvXg3tn6XB38QGPJOBsF/ekiJFC2GWXznohm9y2jew==
X-Received: by 2002:ac2:554a:: with SMTP id l10mr15734978lfk.45.1555523406673;
        Wed, 17 Apr 2019 10:50:06 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id f4sm11197173ljg.37.2019.04.17.10.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:50:06 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ilias.apalodimas@linaro.org,
        hawk@kernel.org, xdp-newbies@vger.kernel.org, ast@kernel.org,
        aniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH 0/3] net: ethernet: ti: cpsw: Add XDP support
Date:   Wed, 17 Apr 2019 20:49:39 +0300
Message-Id: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is RFC adding XDP support for TI cpsw driver that is
based on page_pool allocator. It was verified with af_xdp sockets
and on xdp drop. For XDP redirect to another interface it's under
verification, still not sure about all cases that should be verified.
Also regular tests with iperf2 were done in order to verify impact on
regular netstack performance, compared with base commit from
net-next/master: 432bc230700f86801cffa5e159e05dea6229f722

It was verified with following configs enabled:
CONFIG_JIT=y
CONFIG_BPFILTER=y
CONFIG_BPF_SYSCALL=y
CONFIG_XDP_SOCKETS=y
CONFIG_BPF_EVENTS=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_BPF_JIT=y
CONFIG_CGROUP_BPF=y

iperf2 UDP RX summary (packet size / Mbps):
+--------------------------------------------------------------+
| pkt_size/rate | 1024 | 1500 | 1470 |  64  | 128  | 512 | 256 |
|---------------+------+------+------+------+------+-----+-----|
| base commit   | 561  | 470  | 796  |  35  | 70.1 | 281 | 140 |
|---------------+------+------+------+------+------+-----+-----|
| XDP patched   | 563  | 455  | 808  |  35  | 70.2 | 282 | 141 |
+--------------------------------------------------------------+

iperf2 UDP TX summary (packet size / Mbps):
+--------------------------------------------------------------+
| pkt_size/rate | 1024 | 1500 | 1470 |  64  | 128  | 512 | 256 |
|---------------+------+------+------+------+------+-----+-----|
| base commit   | 555  | 666  | 736  | 34.5 | 70.3 | 281 | 140 |
|---------------+------+------+------+------+------+-----+-----|
| XDP patched   | 558  | 696  | 759  | 35.2 | 69.2 | 279 | 140 |
+--------------------------------------------------------------+

iperf2 TCP summary (window size / Mbps):
+------------------------------------------------------------+
| window size/rate |  16  |  32  |  64  |  128 |  8   | 256  |
|------------------+------+------+------+------+------+------|
| base commit      | 753  | 887  | 931  | 932  | 676  | 932  |
|------------------+------+------+------+------+------+------|
| XDP patched      | 823  | 888  | 932  | 933  | 669  | 933  |
+------------------------------------------------------------+

For af_xdp socket type verification several generic changes should be added
that can be seen here (rough fixes, for samples related seems like last version
of samples is more integrated with libbpf api, so should be rebased,
witch I will send as RFC separately):
https://github.com/ikhorn/af_xdp_stuff/tree/af_xdp_armv7

Ivan Khoronzhuk (3):
  net: ethernet: ti: davinci_cpdma: add dma mapped submit
  net: ethernet: ti: davinci_cpdma: return handler status
  net: ethernet: ti: cpsw: add XDP support

 drivers/net/ethernet/ti/Kconfig         |   1 +
 drivers/net/ethernet/ti/cpsw.c          | 552 +++++++++++++++++++++---
 drivers/net/ethernet/ti/davinci_cpdma.c | 117 +++--
 drivers/net/ethernet/ti/davinci_cpdma.h |   6 +-
 drivers/net/ethernet/ti/davinci_emac.c  |  18 +-
 5 files changed, 591 insertions(+), 103 deletions(-)

-- 
2.17.1

